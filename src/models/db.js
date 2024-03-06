const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'baoleme',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

connection.connect((err) => {
  if (err) {
    console.error('数据库连接失败：' + err.stack);
    return;
  }
  console.log('已连接到数据库');
});

function query(sql, values, callback) {
  return connection.query(sql, values, callback);
}
async function getOrderDetailsFromDatabase(orderId) {
  const query = 'SELECT * FROM order_details WHERE order_id = ?';
  const [orderDetails] = await connection.promise().query(query, [orderId]);
  return orderDetails;
}

module.exports = {
  connection,
  getOrderDetailsFromDatabase,
  query,
};