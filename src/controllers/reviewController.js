// reviewController.js

// 导入必要的模块
const db = require('../models/db');

// 添加评价
function addReview(req, res) {
  const { orderId, review } = req.body;

  // 检查订单是否已经评价过
  db.query('SELECT * FROM orders WHERE order_id = ?', [orderId], (error, order) => {
    if (error) {
      console.error('Error checking review status:', error);
      return res.status(500).json({ error: '服务器内部错误。' });
    }

    if (order && order.length > 0 && order[0].review) {
      return res.status(400).json({ error: '该订单已经评价过了。' });
    }

    // 更新订单的评价字段
    db.query('UPDATE orders SET review = ? WHERE order_id = ?', [review, orderId], (updateError) => {
      if (updateError) {
        console.error('Error updating review:', updateError);
        return res.status(500).json({ error: '服务器内部错误。' });
      }

      // 返回成功的响应
      res.status(200).json({ message: '评价成功。' });
    });
  });
}

module.exports = { addReview };
