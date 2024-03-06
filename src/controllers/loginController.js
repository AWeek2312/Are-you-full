const express = require('express');
const bodyParser = require('body-parser');

const router = express.Router();

router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());

const db = require('../models/db');

const loginHandler = (req, res) => {
    const { userType, account, password } = req.body;

    let tableName, accountColumnName;
    switch (userType) {
        case 'guest':
            tableName = 'customers';
            accountColumnName = 'contact_number';
            break;
        case 'waiter':
            tableName = 'restaurant_staff';
            accountColumnName = 'contact_number';
            break;
        case 'takeman':
            tableName = 'delivery_staff';
            accountColumnName = 'contact_number';
            break;
        default:
            console.log(userType);
            return res.status(400).json({ error: 'Invalid user type' });
    }

const query = `SELECT * FROM ${tableName} WHERE ${accountColumnName} = ? AND password = ?`;
    db.query(query, [account, password], (err, results) => {
        if (err) {
            console.error('Database query error: ' + err.stack);
            return res.status(500).json({ error: 'Database error' });
        }

        if (results.length === 1) {
            const user = results[0];
            // 用户名和密码正确，可以跳转到首页或者返回用户信息
            res.json({ success: true, user });
        } else {
            // 用户名或密码错误，返回错误信息
            res.status(401).json({ error: 'Invalid credentials' });
        }
    });
};

// 导出 loginHandler
module.exports = {
    loginHandler,
};
