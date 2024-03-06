//orderController.js
// 导入必要的模块
const db = require('../models/db');

const getOrders = (req, res) => {
    // console.log('Request received for getOrders');
    const query = `
        SELECT 
           *
        FROM 
            orders
    `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('数据库查询错误:', err);
            return res.status(500).json({ error: '内部服务器错误', errorMessage: err.message });
        }

        // console.log('Orders fetched successfully:', results);
        res.json({ orders: results });
    });
};



// 更新订单状态、接受时间和完成时间的函数
const updateOrderStatus = (req, res) => {
    const { orderId, status } = req.params;
    const { acceptanceTime, completionTime } = req.body;

    // 确保提供了orderId和status
    if (!orderId || !status) {
        return res.status(400).json({ error: '无效的参数' });
    }

    // 构造更新查询
    let query = `UPDATE orders SET order_status = ?`;

    const params = [status];

    // 如果提供了接受时间，则将其添加到查询中
    if (acceptanceTime) {
        query += `, acceptance_time = ?`;
        params.push(acceptanceTime);
    }

    // 如果提供了完成时间，则将其添加到查询中
    if (completionTime) {
        query += `, completion_time = ?`;
        params.push(completionTime);
    }

    // 添加过滤条件
    query += ` WHERE order_id = ?`;
    params.push(orderId);

    // 执行更新查询
    db.query(query, params, (err, result) => {
        if (err) {
            console.error('数据库查询错误: ' + err.stack);
            return res.status(500).json({ error: '数据库错误' });
        }

        res.json({ success: true });
    });
};

async function getOrderDetails(req, res) {
    const orderId = req.params.orderId;

    try {
        const orderDetails = await db.getOrderDetailsFromDatabase(orderId);
        res.json({ dishes: orderDetails });
    } catch (error) {
        console.error('Error fetching order details:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
}

async function submitOrder(req, res) {
    try {
      const {
        customer_name,
        contact_number,
        address,
        expectation_time,
        order_details
      } = req.body;

      console.log("req.body:", req.body);
      console.log("order_details:",  order_details);

      // 检查购物车是否为空
      if (order_details.length === 0) {
        res.status(400).json({ success: false, message: '购物车为空。' });
        return;
      }
  
      // 检查顾客是否存在
      db.query('SELECT 1 FROM customers WHERE name = ? AND contact_number = ?', [customer_name, contact_number], function (error, customerExists) {
        if (error) {
          console.error('Error checking customer existence:', error);
          res.status(500).json({ success: false, message: '发生错误。请重试。' });
          return;
        }

        if (!customerExists.length) {
          res.status(400).json({ success: false, message: '顾客不存在。' });
          return;
        }

        // 计算订单金额
        const orderAmount = order_details.reduce((total, dish) => total + parseFloat(dish.dish_price), 0);
        console.log("orderAmount", orderAmount);

        // 获取随机的送餐员信息
        db.query('SELECT name FROM delivery_staff ORDER BY RAND() LIMIT 1', function (error, deliveryStaff) {
          if (error) {
            console.error('Error getting random delivery staff:', error);
            res.status(500).json({ success: false, message: '发生错误。请重试。' });
            return;
          }

          const deliveryName = deliveryStaff[0].name;
          console.log("deliveryName:",deliveryName);

          // 插入订单数据
          db.query('INSERT INTO orders SET ?', {
            customer_name,
            delivery_name: deliveryName,
            address,
            contact_number,
            amount: orderAmount,
            order_status: 'Waiting',
            expectation_time
          }, function (error, orderResult) {
            if (error) {
              console.error('Error inserting order data:', error);
              res.status(500).json({ success: false, message: '发生错误。请重试。' });
              return;
            }

            const orderId = orderResult.insertId;
            console.log("orderId:",orderId);

            // 为购物车中的每个菜品插入订单详情
            order_details.forEach(function (dish) {
              // 修改插入订单详情的查询，使用上面生成的 orderId
              db.query('INSERT INTO order_details SET ?', {
                order_id: orderId,
                dish_id: dish.dish_id,
                dish_image_path: dish.dish_image_path,
                dish_name: dish.dish_name
              }, function (error) {
                if (error) {
                  console.error('Error inserting order details:', error);
                  res.status(500).json({ success: false, message: '发生错误。请重试。' });
                }
              });
            });

            res.status(200).json({ success: true, message: '订单提交成功！' });
          });
        });
      });
    } catch (error) {
      console.error('提交订单时发生错误：', error);
      res.status(500).json({ success: false, message: '发生错误。请重试。' });
    }
  }


// 导出模块
module.exports = {
    getOrders,
    updateOrderStatus,
    getOrderDetails,
    submitOrder,
};
