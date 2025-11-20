package com.lyp.dynamicweb;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * 身份验证过滤器
 * 检查用户是否已登录，未登录用户重定向到登录页面
 */
@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    
    // 不需要登录验证的页面和资源
    private static final List<String> EXCLUDED_PATHS = Arrays.asList(
        "/login.jsp",
        "/login",
        "/css/",
        "/js/",
        "/img/",
        ".css",
        ".js",
        ".jpg",
        ".jpeg",
        ".png",
        ".gif",
        ".ico"
    );
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化过滤器
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // 检查是否是不需要验证的路径
        if (isExcludedPath(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        // 检查用户是否已登录
        HttpSession session = httpRequest.getSession(false);
        String username = null;
        if (session != null) {
            username = (String) session.getAttribute("username");
        }
        
        if (username == null) {
            // 用户未登录，重定向到登录页面
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        // 用户已登录，继续执行
        chain.doFilter(request, response);
    }
    
    /**
     * 检查路径是否在排除列表中
     */
    private boolean isExcludedPath(String path) {
        for (String excludedPath : EXCLUDED_PATHS) {
            if (path.equals(excludedPath) || path.startsWith(excludedPath) || path.endsWith(excludedPath)) {
                return true;
            }
        }
        return false;
    }
    
    @Override
    public void destroy() {
        // 清理资源
    }
}
