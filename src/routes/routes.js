// routes.js
const express = require('express');
const router = express.Router();
const loginController = require('../controllers/loginController');
const registerController = require('../controllers/registerController');
const orderController = require('../controllers/orderController');
const dishController = require('../controllers/dishController'); // 引入菜品控制器
const reviewController = require('../controllers/reviewController');
const deliveryController = require('../controllers/deliveryController'); // 引入送餐员控制器

router.post('/login', loginController.loginHandler);
router.post('/register', registerController.registerHandler);
router.get('/getOrders', orderController.getOrders);
router.post('/updateOrderStatus/:orderId/:status', orderController.updateOrderStatus);
router.get('/getOrderDetails/:orderId', orderController.getOrderDetails); //获取订单详情
router.get('/getDishes', dishController.getDishes); // 使用 getDishes 函数
router.delete('/deleteDish/:id', dishController.deleteDish); // 使用 deleteDish 函数
router.post('/updateDish/:id', dishController.updateDish);
router.post('/addDish', dishController.addDish);
router.post('/addReview', reviewController.addReview);

// 新增的路由
router.get('/getRandomDeliveryStaff', deliveryController.getRandomDeliveryStaff);
router.post('/submitOrder', orderController.submitOrder);

module.exports = router;
