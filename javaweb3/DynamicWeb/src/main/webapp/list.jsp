<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // 获取学生列表（从application scope或session中获取）
    List<Map<String, String>> studentList = (List<Map<String, String>>) application.getAttribute("studentList");
    if (studentList == null) {
        studentList = new ArrayList<>();
        // 初始化一些示例数据
        Map<String, String> student1 = new HashMap<>();
        student1.put("id", "232056299");
        student1.put("name", "武林浩");
        student1.put("gender", "男");
        student1.put("department", "计算机工程系");
        student1.put("hobbies", "读书、音乐");
        student1.put("image", "img/1.jpg");
        studentList.add(student1);
        
        Map<String, String> student2 = new HashMap<>();
        student2.put("id", "232056288");
        student2.put("name", "陈平川");
        student2.put("gender", "男");
        student2.put("department", "计算机工程系");
        student2.put("hobbies", "运动、读书");
        student2.put("image", "img/2.jpg");
        studentList.add(student2);
        
        Map<String, String> student3 = new HashMap<>();
        student3.put("id", "232056100");
        student3.put("name", "李帅");
        student3.put("gender", "男");
        student3.put("department", "计算机工程系");
        student3.put("hobbies", "学习、运动");
        student3.put("image", "img/3.jpg");
        studentList.add(student3);
        
        Map<String, String> student4 = new HashMap<>();
        student4.put("id", "2320561284");
        student4.put("name", "马博林");
        student4.put("gender", "男");
        student4.put("department", "计算机工程系");
        student4.put("hobbies", "读书、音乐");
        student4.put("image", "img/5.jpg");
        studentList.add(student4);
        
        Map<String, String> student5 = new HashMap<>();
        student5.put("id", "232056104");
        student5.put("name", "赵柳");
        student5.put("gender", "女");
        student5.put("department", "计算机工程系");
        student5.put("hobbies", "读书、音乐");
        student5.put("image", "img/4.jpg");
        studentList.add(student5);
        
        application.setAttribute("studentList", studentList);
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息列表</title>
    <link rel="stylesheet" href="css/list.css">
</head>
<body>
    <!-- 搜索及操作按钮区域 -->
    <div class="search-btn-group">
        <div class="search-box">
            <input type="text" placeholder="搜索学生信息..." class="search-input">
            <button class="search-btn">搜索</button>
        </div>
        <div class="operate-btn-group">
            <button class="operate-btn add-btn">新增</button>
            <button class="operate-btn delete-btn">删除</button>
            <button class="operate-btn edit-btn">修改</button>
        </div>
    </div>

    <!-- 学生信息卡片列表 -->
    <div class="student-card-container">
        <% for (Map<String, String> student : studentList) { %>
            <div class="student-card <%= "女".equals(student.get("gender")) ? "female" : "male" %>"
                 data-profile="<%= student.get("profile") != null ? student.get("profile") : "" %>"
                 data-homepage="<%= student.get("homepage") != null ? student.get("homepage") : "" %>">
                <div class="card-header">
                    <span class="student-name"><%= student.get("name") %></span>
                    <span class="student-gender"><%= student.get("gender") %></span>
                </div>
                <div class="card-content">
                    <img src="<%= student.get("image") %>" alt="<%= student.get("name") %>" class="student-img">
                    <p class="student-id">学号：<%= student.get("id") %></p>
                    <p class="student-department">院系：<%= student.get("department") %></p>
                    <p class="student-hobby">爱好：<%= student.get("hobbies") %></p>
                </div>
            </div>
        <% } %>
    </div>

    <!-- 弹出表单模态框 -->
    <div id="student-modal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">新增学生信息</h2>
                <button class="modal-close" id="modal-close-btn">×</button>
            </div>
            <form id="student-form" class="student-form">
                <div class="form-group">
                    <label for="student-id">学号：</label>
                    <input type="text" id="student-id" name="student-id" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="student-name">姓名：</label>
                    <input type="text" id="student-name" name="student-name" class="form-input" required>
                </div>
                <div class="form-group">
                    <label>性别：</label>
                    <div class="radio-group">
                        <label class="radio-label">
                            <input type="radio" name="gender" value="男" checked>
                            <span>男</span>
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="gender" value="女">
                            <span>女</span>
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label>兴趣爱好：</label>
                    <div class="checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="hobby" value="音乐">
                            <span>音乐</span>
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="hobby" value="运动">
                            <span>运动</span>
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="hobby" value="读书">
                            <span>读书</span>
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="hobby" value="学习">
                            <span>学习</span>
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="department">所属院系：</label>
                    <select id="department" name="department" class="form-select" required>
                        <option value="无">无</option>
                        <option value="计算机工程系">计算机工程系</option>
                        <option value="机械工程系">机械工程系</option>
                        <option value="电子工程系">电子工程系</option>
                        <option value="化学工程系">化学工程系</option>
                        <option value="经济管理系">经济管理系</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="profile">个人简介：</label>
                    <textarea id="profile" name="profile" class="form-textarea" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <label for="homepage">个人主页：</label>
                    <input type="url" id="homepage" name="homepage" class="form-input" placeholder="个人主页地址">
                </div>
                <div class="form-actions">
                    <button type="button" class="btn-confirm" id="confirm-btn">确定</button>
                    <button type="button" class="btn-reset" id="reset-btn">重置</button>
                </div>
            </form>
        </div>
    </div>

    <script src="js/list.js"></script>
</body>
</html>
