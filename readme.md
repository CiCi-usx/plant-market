<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

Notes on class:

付款 收货 评价 管理员发货 导出发票

orderId 作为 数据库 sql 内 的 一个 变量 应该使用 项目 内 代码 生成

订单号可被内部人员解读用户id 下单时间 下单序号

totalPrice可以存储到数据库亦可前端计算

orderDetail table should have foreign key that is orderId and pId. totalPrice may exist because the price of product may change.

--


生成订单功能中必须有事务 作为打分的一个计分点 生成订单 - 获取用户信息 - 向订单表插入1条记录 - 向订单详情表插入1或多条记录 - 删除购物车表中该用户相应的记录 - 结束

Platform TransactionManager tm = new DataSource TransactionManager(JDBCUtils.getDataSource());
TransactionStatus status = tm.getTransaction(null);
try {
catch

roll
--

orderDao.add(order);


Order.sql, OrderDetail.sql has more than Order.sql that is pImg to save image's file name.

OrderDao.java add(Product ..)
OrderService findAll()  OrderServiceImpl addOrder(Orders order, List<Shoppingcart> cartItems) {
orderDao.add(order);
for (Shoppingcart shoppingcart : cartItems) {
	OrderDetails detail = new OrderDetails();
	detail.setOrderId(oder...
	pId
	Number
	totalPrice
	orderDetailDao.add(detail);
}
shoppingcartDao.deleteAll(...

CreateOrderServlet doPost request.setCharacterEncoding("utf-8");
OrdersService = ...
orderId = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
orderId = user.getUname() + "-" + orderId
setOrderId
setOrderDate(new Date())
setStatus
setTotal

对于用户，未付款的订单应该不可付款 未收货的订单可以评价；对于商家，则又是不同的 	 



数据库事务 来实现

===技术栈===
Druid
Spring JdbcTemplate
Jakarta EE
web.annotation and no web.xml and route style is /CartAddServlet
pom.xml and not cp jar files

==== Symbolic Link ====

PS D:\schools\web\exp4> Get-Item -Path ..\tomcat_webapps\ | Select-Object Name, LinkType, Target

Name           LinkType     Target
----           --------     ------
tomcat_webapps SymbolicLink {D:\program files\scoop\apps\tomcat\current\webapps}


PS D:\schools\web\exp4>


=====remained pro===
files\scoop\apps\tomcat\current\bin> netstat -ano
 | findstr :8080
  TCP    [::1]:8080             [::1]:52162            FIN_WAIT_2      17012
  TCP    [::1]:8080             [::1]:60127            FIN_WAIT_2      17012
  TCP    [::1]:52162            [::1]:8080             CLOSE_WAIT      15036
  TCP    [::1]:60127            [::1]:8080             CLOSE_WAIT      15036
PS D:\program files\scoop\apps\tomcat\current\bin>

====kill them===
Stop-Process -Id 17012 -Force
Stop-Process -Id 15036 -Force

====pid 0===
cat\current\bin> netstat -ano | findstr :8080 
  TCP    [::1]:8080             [::1]:52162            TIME_WAIT       0
  TCP    [::1]:8080             [::1]:60127            TIME_WAIT       0
PS D:\program files\scoop\apps\tomcat\current\bin>



```
private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

// 查单个对象
template.queryForObject(sql, new BeanPropertyRowMapper<>(Xxx.class), args...);

// 查列表
template.query(sql, new BeanPropertyRowMapper<>(Xxx.class), args...);

// 增删改
template.update(sql, args...);
```
