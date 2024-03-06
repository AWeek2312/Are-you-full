// app.js

const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const loginController = require('./controllers/loginController');
const yourRoutes = require('./routes/routes');

const app = express();

// 使用 body-parser 中间件来解析请求体
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 静态文件目录设置
app.use(express.static(path.join(__dirname, '..', 'public')));

// 使用路由
app.use('/', yourRoutes);

// 登录页面的路由
app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, '..', 'public', 'login.html'));
});

// 登录接口的路由，调用 loginController 中的处理函数
app.post('/login', loginController.loginHandler);

const registerController = require('./controllers/registerController');

// 注册接口的路由，调用 registerController 中的处理函数
app.post('/register', registerController.registerHandler);

// 根路由，返回前端页面
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '..', 'public', 'index.html'));
});

app.use((err, req, res, next) => {
  console.error(err.stack);

  // Ensure JSON response
  res.status(500).json({ error: 'Internal Server Error' });
});


// 服务器监听端口
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
