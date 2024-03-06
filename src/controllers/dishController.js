const db = require('../models/db');
const express = require('express');
const router = express.Router();

// 获取所有菜品的函数
const getDishes = (req, res) => {
  const query = `
      SELECT 
          dish_id,
          dish_name,
          dish_description,
          dish_price,
          dish_sales,
          dish_image_path
      FROM 
          dishes
  `;

  db.query(query, (err, results, fields) => {
    if (err) {
      console.error('数据库查询错误: ' + err.stack);
      return res.status(500).json({ error: '数据库错误' });
    }

    res.json({ dishes: results });
  });
};

const deleteDish = (req, res) => {
  const dishId = req.params.id;

  // 在数据库中删除菜品
  db.query('DELETE FROM dishes WHERE dish_id = ?', [dishId], (err, result) => {
    if (err) {
      console.error('数据库查询错误: ' + err.stack);
      return res.status(500).json({ error: '数据库错误' });
    }

    if (result.affectedRows === 1) {
      console.log(`菜品ID为${dishId}的菜品删除成功`);
      res.status(200).json({ message: '菜品删除成功' });
    } else {
      res.status(404).json({ error: '菜品未找到或删除失败' });
    }
  });
};

const updateDish = async (req, res) => {

  const dishId = req.params.id;
  const { picture, name, desc, price } = req.body;
  try {
    // 更新单个菜品信息
    const updateResult = await db.query(
      'UPDATE dishes SET dish_image_path = ?, dish_name = ?, dish_description = ?, dish_price = ? WHERE dish_id = ?',
      [picture, name, desc, price, dishId]
    );
     
    if (updateResult.affectedRows === 1) {
      res.json({ success: true, message: '菜品更新成功' });
    } else {
      res.status(404).json({ error: '菜品未找到或更新失败' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error', message: error.message });
  }
};

const addDish = (req, res) => {
  const { picture, name, desc, price } = req.body;
  
  // 在数据库中插入新菜品
  db.query(
    'INSERT INTO dishes (dish_image_path, dish_name, dish_description, dish_price) VALUES (?, ?, ?, ?)',
    [picture, name, desc, price],
    (error, results) => {
      if (error) {
        console.error('插入失败：', error);
        return res.status(500).json({ error: '添加失败，请稍后再试。' });
      }

      // 检查是否成功插入
      if (results.affectedRows === 1) {
        // 添加成功，返回成功消息或其他信息
        res.status(200).json({ message: '添加成功！' });
      } else {
        console.error('插入失败：', results);
        res.status(500).json({ error: '添加失败，请稍后再试。' });
      }
    }
  );
};



module.exports = {
  getDishes,
  deleteDish,
  updateDish,
  addDish,
};

