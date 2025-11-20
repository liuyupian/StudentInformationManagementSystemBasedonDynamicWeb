<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 学生信息管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 400px;
            max-width: 90%;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-title {
            color: #333;
            font-size: 28px;
            font-weight: 300;
            margin-bottom: 10px;
        }
        
        .login-subtitle {
            color: #666;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .checkbox-group input[type="checkbox"] {
            margin-right: 8px;
        }
        
        .checkbox-group label {
            color: #666;
            font-size: 14px;
            cursor: pointer;
        }
        
        .login-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
        }
        
        .error-message {
            background: #fee;
            color: #c33;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }
        
        .footer-text {
            text-align: center;
            margin-top: 20px;
            color: #999;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1 class="login-title">用户登录</h1>
            <p class="login-subtitle">学生信息管理系统</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message" style="display: block;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="login" method="post" id="loginForm">
            <div class="form-group">
                <label for="username" class="form-label">用户名</label>
                <input type="text" id="username" name="username" class="form-input" 
                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>"
                       placeholder="请输入用户名" required>
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">密码</label>
                <input type="password" id="password" name="password" class="form-input" 
                       placeholder="请输入密码" required>
            </div>
            
            <div class="checkbox-group">
                <input type="checkbox" id="remember" name="remember" value="true">
                <label for="remember">记住密码</label>
            </div>
            
            <button type="submit" class="login-btn">登录</button>
        </form>
        
        <div class="footer-text">
            © 学生信息管理系统 by 232056115李一鹏
        </div>
    </div>

    <script>
        // 页面加载时检查是否有记住的用户名
        window.onload = function() {
            var username = getCookie("rememberedUsername");
            var password = getCookie("rememberedPassword");
            if (username) {
                document.getElementById("username").value = username;
                document.getElementById("remember").checked = true;
            }
            if (password) {
                document.getElementById("password").value = password;
            }
        };
        
        // 获取Cookie的函数
        function getCookie(name) {
            var value = "; " + document.cookie;
            var parts = value.split("; " + name + "=");
            if (parts.length == 2) return parts.pop().split(";").shift();
            return "";
        }
    </script>
</body>
</html>
