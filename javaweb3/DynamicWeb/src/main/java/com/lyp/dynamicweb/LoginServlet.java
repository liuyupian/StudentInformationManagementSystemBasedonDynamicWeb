package com.lyp.dynamicweb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    // 简单的用户验证（实际项目中应该使用数据库）
    private static final String VALID_USERNAME = "admin";
    private static final String VALID_PASSWORD = "123456";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // GET请求重定向到登录页面
        response.sendRedirect("login.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        // 验证用户名和密码
        if (isValidUser(username, password)) {
            // 登录成功
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setMaxInactiveInterval(30 * 60); // 30分钟超时
            
            // 处理记住密码功能
            if ("true".equals(remember)) {
                // 创建Cookie保存用户名和密码（实际项目中不应该保存明文密码）
                Cookie usernameCookie = new Cookie("rememberedUsername", username);
                Cookie passwordCookie = new Cookie("rememberedPassword", password);
                
                // 设置Cookie有效期为7天
                usernameCookie.setMaxAge(7 * 24 * 60 * 60);
                passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                
                // 设置Cookie路径
                usernameCookie.setPath("/");
                passwordCookie.setPath("/");
                
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            } else {
                // 如果不记住密码，删除已存在的Cookie
                Cookie usernameCookie = new Cookie("rememberedUsername", "");
                Cookie passwordCookie = new Cookie("rememberedPassword", "");
                
                usernameCookie.setMaxAge(0);
                passwordCookie.setMaxAge(0);
                usernameCookie.setPath("/");
                passwordCookie.setPath("/");
                
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            }
            
            // 重定向到主页
            response.sendRedirect("index.jsp");
            
        } else {
            // 登录失败
            request.setAttribute("error", "用户名或密码错误！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private boolean isValidUser(String username, String password) {
        // 简单验证逻辑（实际项目中应该查询数据库）
        return VALID_USERNAME.equals(username) && VALID_PASSWORD.equals(password);
    }
}
