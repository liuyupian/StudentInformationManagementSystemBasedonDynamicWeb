package com.lyp.dynamicweb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置响应类型
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 检查用户是否已登录
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            out.println("{\"success\": false, \"message\": \"用户未登录\"}");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addStudent(request, response);
                    break;
                case "update":
                    updateStudent(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                default:
                    out.println("{\"success\": false, \"message\": \"未知操作\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"success\": false, \"message\": \"服务器错误: " + e.getMessage() + "\"}");
        }
    }
    
    private void addStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        PrintWriter out = response.getWriter();
        
        // 获取学生列表
        List<Map<String, String>> studentList = getStudentList(request);
        
        // 获取表单数据
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String gender = request.getParameter("gender");
        String hobbies = request.getParameter("hobbies");
        String department = request.getParameter("department");
        String profile = request.getParameter("profile");
        String homepage = request.getParameter("homepage");
        
        // 验证数据
        if (studentId == null || studentId.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"学号不能为空\"}");
            return;
        }
        
        if (studentName == null || studentName.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"姓名不能为空\"}");
            return;
        }
        
        // 检查学号是否已存在
        for (Map<String, String> student : studentList) {
            if (studentId.equals(student.get("id"))) {
                out.println("{\"success\": false, \"message\": \"学号已存在\"}");
                return;
            }
        }
        
        // 创建新学生
        Map<String, String> newStudent = new HashMap<>();
        newStudent.put("id", studentId);
        newStudent.put("name", studentName);
        newStudent.put("gender", gender != null ? gender : "男");
        newStudent.put("hobbies", hobbies != null ? hobbies.replace(",", "、") : "");
        newStudent.put("department", department != null ? department : "无");
        newStudent.put("profile", profile != null ? profile : "");
        newStudent.put("homepage", homepage != null ? homepage : "");
        newStudent.put("image", getRandomImage());
        
        // 添加到列表
        studentList.add(newStudent);
        
        // 更新application scope
        request.getServletContext().setAttribute("studentList", studentList);
        
        out.println("{\"success\": true, \"message\": \"学生信息添加成功\"}");
    }
    
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        PrintWriter out = response.getWriter();
        
        // 获取学生列表
        List<Map<String, String>> studentList = getStudentList(request);
        
        // 获取表单数据
        String originalId = request.getParameter("originalId");
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String gender = request.getParameter("gender");
        String hobbies = request.getParameter("hobbies");
        String department = request.getParameter("department");
        String profile = request.getParameter("profile");
        String homepage = request.getParameter("homepage");
        
        // 验证数据
        if (originalId == null || originalId.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"原学号不能为空\"}");
            return;
        }
        
        if (studentId == null || studentId.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"学号不能为空\"}");
            return;
        }
        
        if (studentName == null || studentName.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"姓名不能为空\"}");
            return;
        }
        
        // 查找要更新的学生
        Map<String, String> targetStudent = null;
        for (Map<String, String> student : studentList) {
            if (originalId.equals(student.get("id"))) {
                targetStudent = student;
                break;
            }
        }
        
        if (targetStudent == null) {
            out.println("{\"success\": false, \"message\": \"找不到要更新的学生\"}");
            return;
        }
        
        // 如果学号发生变化，检查新学号是否已存在
        if (!originalId.equals(studentId)) {
            for (Map<String, String> student : studentList) {
                if (studentId.equals(student.get("id"))) {
                    out.println("{\"success\": false, \"message\": \"新学号已存在\"}");
                    return;
                }
            }
        }
        
        // 更新学生信息
        targetStudent.put("id", studentId);
        targetStudent.put("name", studentName);
        targetStudent.put("gender", gender != null ? gender : "男");
        targetStudent.put("hobbies", hobbies != null ? hobbies.replace(",", "、") : "");
        targetStudent.put("department", department != null ? department : "无");
        targetStudent.put("profile", profile != null ? profile : "");
        targetStudent.put("homepage", homepage != null ? homepage : "");
        
        // 更新application scope
        request.getServletContext().setAttribute("studentList", studentList);
        
        out.println("{\"success\": true, \"message\": \"学生信息更新成功\"}");
    }
    
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        PrintWriter out = response.getWriter();
        
        // 获取学生列表
        List<Map<String, String>> studentList = getStudentList(request);
        
        String studentId = request.getParameter("studentId");
        
        if (studentId == null || studentId.trim().isEmpty()) {
            out.println("{\"success\": false, \"message\": \"学号不能为空\"}");
            return;
        }
        
        // 查找并删除学生
        boolean found = false;
        Iterator<Map<String, String>> iterator = studentList.iterator();
        while (iterator.hasNext()) {
            Map<String, String> student = iterator.next();
            if (studentId.equals(student.get("id"))) {
                iterator.remove();
                found = true;
                break;
            }
        }
        
        if (!found) {
            out.println("{\"success\": false, \"message\": \"找不到要删除的学生\"}");
            return;
        }
        
        // 更新application scope
        request.getServletContext().setAttribute("studentList", studentList);
        
        out.println("{\"success\": true, \"message\": \"学生信息删除成功\"}");
    }
    
    @SuppressWarnings("unchecked")
    private List<Map<String, String>> getStudentList(HttpServletRequest request) {
        List<Map<String, String>> studentList = 
            (List<Map<String, String>>) request.getServletContext().getAttribute("studentList");
        
        if (studentList == null) {
            studentList = new ArrayList<>();
            request.getServletContext().setAttribute("studentList", studentList);
        }
        
        return studentList;
    }
    
    private String getRandomImage() {
        String[] images = {"img/1.jpg", "img/2.jpg", "img/3.jpg", "img/4.jpg", "img/5.jpg"};
        Random random = new Random();
        return images[random.nextInt(images.length)];
    }
}
