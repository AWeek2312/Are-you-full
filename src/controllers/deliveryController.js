// deliveryController.js
const { yourDatabaseQueryFunction } = require('../models/db'); 

// 获取随机送餐员
async function getRandomDeliveryStaff(req, res) {
  try {
    const query = 'SELECT * FROM delivery_staff ORDER BY RAND() LIMIT 1';
    const [randomStaff] = await yourDatabaseQueryFunction(query);
    res.status(200).json(randomStaff);
  } catch (error) {
    console.error('Error getting random delivery staff:', error);
    res.status(500).json({ error: 'Failed to get random delivery staff.' });
  }
}

module.exports = {
  getRandomDeliveryStaff,
};
