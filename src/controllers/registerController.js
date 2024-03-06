// controllers/registerController.js
const db = require('../models/db');
// 注册处理函数
const registerHandler = async (req, res) => {
    const { name, gender, contact_number, password, role } = req.body;


    try {
        let tableName;

        // 根据身份信息选择要插入的表
        switch (role) {
            case 'guest':
                tableName = 'customers';
                break;
            case 'waiter':
                tableName = 'restaurant_staff';
                break;
            case 'takeman':
                tableName = 'delivery_persons';
                break;
            default:
                return res.status(400).json({ error: '无效的用户身份。' });
        }

        // 插入新用户
        db.query(`INSERT INTO ${tableName} (name, gender, contact_number, password) VALUES (?, ?, ?, ?)`, [name, gender, contact_number, password], (err, results) => {
          if (err) {
            console.error(err);

            if (err.code === 'ER_DUP_ENTRY') {
              // 错误码 'ER_DUP_ENTRY' 表示唯一键冲突，即手机号重复
              return res.status(400).json({ error: '该手机号已经注册过了。' });
            }

            return res.status(500).json({ error: '注册失败，请稍后再试。' });
          }

          // 注册成功，返回成功消息或其他信息
          res.status(200).json({ message: '注册成功！' });
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: '注册失败，请稍后再试。' });
    }
};

module.exports = {
    registerHandler
};
