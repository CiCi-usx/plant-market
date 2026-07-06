Project

苗木网

==================================================

Technology Stack

Runtime

- JDK 17
- Apache Tomcat 11.0.x

Servlet API

- Jakarta Servlet 6.0

Build Tool

- Maven

Packaging

- war

Deployment Name

- web-exp4

Default URL

- http://localhost:8080/web-exp4/

View Layer

- JSP
- JSTL 3.x

Database

- MySQL 8
- Druid Connection Pool
- Spring JDBC

==================================================

Project Constraints

Web Configuration

使用 web.xml 配置欢迎页面其外采用注解配置：

@WebServlet
@WebFilter

==================================================

Package Structure

src/main/java

dao
dao.impl

service
service.impl

domain

util

web.servlet
web.servlet.filter

==================================================

Layering Rules

Servlet
↓
Service
↓
DAO
↓
Database

==================================================

Web Directory Layout

JSP Pages

位置：

src/main/webapp

主要页面：

index.jsp
login.jsp
register.jsp
cart.jsp
productDetail.jsp
userCenter.jsp

Admin Pages

位置：

src/main/webapp/admin

主要页面：

admin/index.jsp
admin/login.jsp
admin/productList.jsp
admin/productEdit.jsp
admin/productNew.jsp
admin/OrderMaint.jsp

==================================================

Static Resources

位置：

src/main/webapp/assets

典型结构：

assets/css
assets/images

==================================================

Servlet Conventions

路由注解名称就是Servlet类名

==================================================

Encoding Rules

request.setCharacterEncoding("UTF-8");

response.setContentType("text/html;charset=UTF-8");

==================================================