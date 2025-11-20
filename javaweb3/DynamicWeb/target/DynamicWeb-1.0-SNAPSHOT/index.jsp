<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <!-- 左侧菜单区域 -->
    <div id="menu-div">
        <!-- Logo区域（头像+姓名） -->
        <div class="logo-div">
            <img src="img/avatar.jpg" alt="个人头像" class="avatar-img"> 
            <span class="user-name"><%= username %></span> 
        </div>
        <!-- 菜单列表 -->
        <div class="menu-ul-div">
            <ul class="first-menu-ul">
                <!-- 一级菜单：信息管理（含二级菜单） -->
                <li class="first-menu-li active">
                    <span class="first-menu-text">信息管理</span>
                    <ul class="second-menu-ul">
                        <li class="second-menu-li active">学生信息管理</li>
                        <li class="second-menu-li">班级信息管理</li>
                        <li class="second-menu-li">宿舍信息管理</li>
                    </ul>
                </li>
                <!-- 一级菜单：事务管理 -->
                <li class="first-menu-li">
                    <span class="first-menu-text">事务管理</span>
                </li>
                <!-- 一级菜单：个人设置 -->
                <li class="first-menu-li">
                    <span class="first-menu-text">个人设置</span>
                </li>
            </ul>
        </div>
    </div>

    <!-- 右侧主体区域 -->
    <div id="body-div">
        <!-- 顶部区域（系统名称+按钮） -->
        <div id="top-div">
            <span class="title-span">学生信息管理系统</span>
            <div class="top-btn-group">
                <!-- 站内信按钮（含数字标注+下拉列表） -->
                <button id="message-btn" type="button" class="top-btn">
                    站内信
                    <span class="message-count">3</span>
                    <!-- 站内信下拉列表 -->
                    <div id="message-list-div">
                        <ul class="message-list-ul">
                            <li class="message-item">
                                <span class="message-sender">张庆</span>
                                <span class="message-time">2025-10-10 14:55:38</span>
                            </li>
                            <li class="message-item">
                                <span class="message-sender">李耀辉</span>
                                <span class="message-time">2025-05-01 08:10:18</span>
                            </li>
                            <li class="message-item">
                                <span class="message-sender">刘德伟</span>
                                <span class="message-time">2025-10-11 10:25:30</span>
                            </li>
                        </ul>
                    </div>
                </button>
                <!-- 退出按钮 -->
                <button id="logout-btn" type="button" class="top-btn">退出</button>
            </div>
        </div>
        <!-- 主体内容（iframe引入学生列表页面） -->
        <div id="main-div">
          <iframe id="main-iframe" src="list.jsp" frameborder="0" title="学生信息列表"></iframe>
        </div>
    </div>

    <script src="js/index.js"></script>
</body>
</html>