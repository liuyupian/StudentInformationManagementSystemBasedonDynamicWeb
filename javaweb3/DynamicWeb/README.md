


# 阅读前请注意！！！！！数据为作者本人数据，上传仓库纯属瞎玩，若有侵权违者必究
# 作者邮箱 yige.ss@foxmail.com




# 学生信息管理系统 - 实验3

基于JSP和Servlet技术的动态Web应用程序，实现了用户登录、学生信息管理等功能。

## 项目结构

```
DynamicWeb/
├── src/main/
│   ├── java/com/lyp/dynamicweb/
│   │   ├── LoginServlet.java          # 登录处理
│   │   ├── LogoutServlet.java         # 退出处理
│   │   ├── StudentServlet.java        # 学生信息管理
│   │   ├── CharacterEncodingFilter.java # 字符编码过滤器
│   │   └── AuthenticationFilter.java  # 身份验证过滤器
│   └── webapp/
│       ├── WEB-INF/web.xml           # Web应用配置
│       ├── css/                      # 样式文件
│       ├── js/                       # JavaScript文件
│       ├── img/                      # 图片资源
│       ├── login.jsp                 # 登录页面
│       ├── index.jsp                 # 主页面
│       └── list.jsp                  # 学生列表页面
└── pom.xml                           # Maven配置
```

## 功能特性

### 1. 用户登录系统
- **登录验证**: 用户名/密码验证
- **Session管理**: 30分钟会话超时
- **Cookie记住密码**: 可选择记住登录信息7天
- **自动登录**: 支持Cookie自动填充

### 2. 学生信息管理
- **增加学生**: 添加新的学生信息
- **修改学生**: 编辑现有学生信息
- **删除学生**: 删除选中的学生
- **搜索功能**: 按姓名或学号搜索

### 3. 过滤器功能
- **字符编码过滤器**: 统一设置UTF-8编码
- **身份验证过滤器**: 检查用户登录状态

## 技术栈

- **后端**: Java Servlet, JSP
- **前端**: HTML5, CSS3, JavaScript
- **服务器**: Tomcat 10+
- **构建工具**: Maven
- **JDK版本**: Java 11+

## 使用说明

### 1. 环境要求
- JDK 11或更高版本
- Apache Tomcat 10或更高版本
- Maven 3.6+

### 2. 部署步骤

1. **编译项目**
   ```bash
   mvn clean compile
   ```

2. **打包WAR文件**
   ```bash
   mvn package
   ```

3. **部署到Tomcat**
   - 将生成的WAR文件复制到Tomcat的webapps目录
   - 启动Tomcat服务器

4. **访问应用**
   - 打开浏览器访问: `http://localhost:8080/DynamicWeb`
   - 系统会自动跳转到登录页面

### 3. 登录信息
- **用户名**: admin
- **密码**: 123456

### 4. 主要功能操作

#### 登录
1. 在登录页面输入用户名和密码
2. 可选择"记住密码"功能
3. 点击登录按钮

#### 学生管理
1. 登录后进入主界面
2. 点击"新增"按钮添加学生
3. 选择学生卡片后点击"修改"或"删除"
4. 使用搜索框查找特定学生

#### 退出系统
1. 点击右上角"退出"按钮
2. 系统会清除Session并跳转到登录页面

## 实验要求实现情况

### ✅ 已完成功能

1. **JSP页面转换**
   - ✅ 将实验2的HTML页面转换为JSP页面
   - ✅ 实现动态内容显示

2. **用户登录功能**
   - ✅ 创建美观的登录界面
   - ✅ 实现用户名密码验证
   - ✅ Session管理和超时处理
   - ✅ Cookie记住密码功能

3. **Servlet开发**
   - ✅ LoginServlet处理登录验证
   - ✅ StudentServlet处理学生信息CRUD操作
   - ✅ LogoutServlet处理用户退出

4. **过滤器实现**
   - ✅ CharacterEncodingFilter统一字符编码
   - ✅ AuthenticationFilter身份验证

5. **配置文件**
   - ✅ 完整的web.xml配置
   - ✅ Servlet和过滤器映射

## 项目亮点

1. **现代化UI设计**: 采用渐变背景和卡片式布局
2. **响应式设计**: 支持不同屏幕尺寸
3. **用户体验优化**: 
   - 表单验证和错误提示
   - 加载动画和过渡效果
   - 直观的操作反馈
4. **安全性考虑**:
   - Session管理
   - 路径访问控制
   - XSS防护

## 注意事项

1. **数据存储**: 当前使用内存存储，重启服务器后数据会丢失
2. **密码安全**: 演示项目中Cookie保存明文密码，生产环境应加密处理
3. **浏览器兼容**: 建议使用现代浏览器（Chrome, Firefox, Edge等）

## 开发者信息

- **项目名称**: 学生信息管理系统
- **实验编号**: 实验3 - JSP和Servlet
- **技术栈**: Java Web (JSP + Servlet)
- **开发时间**: 2025年11月
