# 模块变量对照表 (Admin vs User)

用于记录和规范普通用户与管理员在登录、表单提交及 Cookie 读取时的变量名差异。

## 1. 基础配置与交互路由

| 功能模块 | 普通用户 (User) | 管理员 (Admin) | 说明 |
| :--- | :--- | :--- | :--- |
| **页面路径** | `/login.jsp` | `/admin/login.jsp` | 访问根路径不同 |
| **提交 Action** | `${pageContext.request.contextPath}/LoginServlet` | `${pageContext.request.contextPath}/admin/AdminLoginServlet` | 后台处理的 Servlet 路由不同 |
| **验证码路由** | `/CheckCodeServlet` | `/CheckCodeServlet` | 两者共用同一个验证码生成接口 |

---

## 2. 表单请求参数 (Form Name)

| 表单中英文含义 | 普通用户 (User) 字段名 | 管理员 (Admin) 字段名 | 对应 HTML 标签 |
| :--- | :--- | :--- | :--- |
| **用户名** | `name` | `adminName` | `<input type="text">` |
| **密码** | `password` | `adminPwd` | `<input type="password">` |
| **验证码输入** | `verifycode` | `verifycode` | 两者字段名完全一致 |
| **提交按钮** | `submit` | `submit` | |
| **重置按钮** | `reset` | `reset` | |

---

## 3. Cookie 与 域对象变量 (EL Expression)

| 数据含义 | 普通用户 (User) 表达式 | 管理员 (Admin) 表达式 | 备注 |
| :--- | :--- | :--- | :--- |
| **记住的用户名** | `${cookie.get('uname').value}` | `${cookie.get('uname').value}` | 当前逻辑中，两者共用了名为 `uname` 的 Cookie 键 |
| **记住的密码** | `${cookie.upwd.value}` | `${cookie.upwd.value}` | 当前逻辑中，两者共用了名为 `upwd` 的 Cookie 键 |
| **错误提示信息** | `${login_msg}` | `${login_msg}` | 后端 Request/Session 域返回的登录失败提示 |

---

## 4. 开发注意事项 (Tips)

1. **Cookie 命名潜在冲突**：目前 `admin/login.jsp` 和 `login.jsp` 在自动填充时，读取的都是 `cookie.get('uname')` 和 `cookie.upwd`。如果普通用户和管理员在同一台浏览器登录，Cookie 会相互覆盖。*建议后续优化为 `adminUname` 和 `adminUpwd` 以作隔离。*
2. **验证码刷新脚本**：两者的原生 JavaScript 刷新逻辑完全一致，均采用拼接时间戳 `?time=` 的方式防止浏览器缓存。

## 5. 分类概念变量对照表 (Class vs Category vs Category)

为了解决“苗木分类（如：果树/非果树）”在前端、后端、数据库命名不一致的问题，特制定本对照表。开发时请严格遵循各层的变量命名规范。

### 5.1 核心术语定义与辨析
*   **`Class` (关键字)**：Java 语言的保留关键字（如 `public class X`），**绝对不能**用作 Java 变量名、类名或包名。
*   **`Category` (实体类/表名)**：为了规避 `Class` 关键字冲突，系统将“分类”对应的 POJO 实体类命名为 `Category`，其对应的数据库表为 `exp4_class`。
*   **`category` (商品属性)**：在商品表（`exp4_products`）中，直接使用字符串（String）来记录商品的分类名称（例如 `'果树'` 或 `'非果树'`），用作快速筛选的索引。
CategoryService
CategoryServiceImpl

---

### 5.2 各层级变量及字段映射关系

| 业务含义 | 数据库层 (MySQL) | 实体类层 (Domain POJO) | 控制层/网络传输 (Servlet/JSP) | 备注 / 常见坑点 |
| :--- | :--- | :--- | :--- | :--- |
| **分类唯一ID** | `exp4_class.cId`<br>(int, AI) | `Category.cId`<br>(Integer) | `request.getParameter("cId")`<br>`${c.cId}` | 页面传递时注意进行 `Integer.parseInt()` 类型转换。 |
| **分类名称** | `exp4_class.cName`<br>(varchar) | `Category.cName`<br>(String) | `request.getParameter("cName")`<br>`${c.cName}` | 录入和显示时注意 UTF-8 编码，防止页面和数据库出现乱码。 |
| **商品所属分类** | `exp4_products.category`<br>(varchar) | `Product.category`<br>(String) | `request.getParameter("category")`<br>`${p.category}` | **注意**：原旧版代码中曾使用过 `pClassId` 和 `pDescr`。新版结构中已**废弃 `pClassId`**，一律改用 `category` 存放字符串（如 `"果树"`）。 |
| 实体转换/数据拷贝 | BeanUtil.populate(obj, map) | BeanUtil.copyProperties(dest, orig) | 注意：使用反射工具包（如 Apache Commons 或 Hutool）进行对象拷贝时，由于实体类命名为 `Category`，内部反射机制会将 `getClass()` 方法识别为名为 `class` 的只读属性。在遍历属性或组装 Map 时，务必通过 `map.remove("class")` 排除该系统变量，避免引发类型转换异常。 |

---

### 5.3 数据交互全链路示例（以“添加商品”为例）

1. **前端表单 (JSP/HTML)**：

   用户在下拉框中选择分类，对应的表单项为：

```html
<select name="category">
    <option value="果树">果树</option>
    <option value="非果树">非果树</option>
</select>
```

控制层接收 (Servlet)：

```Java
String category = request.getParameter("category"); // 接收到的是字符串 "果树"
Product product = new Product();
product.setCategory(category);
数据访问层持久化 (DAO)：
```

```Java
// 使用的是产品表的 category 字段，而不是 cId 或者是旧版的 pClassId
String sql = "INSERT INTO exp4_products (pName, category, ...) VALUES (?, ?, ...)";
template.update(sql, product.getpName(), product.getCategory(), ...);
```

---

### 5.4 专项开发注意事项 (Crucial Tips)

1. **规避 Java 关键字**：在任何 Java 代码、方法形参、JSTL 表达式中，切勿写出 `Category class = ...`。应统一规范简写为 `Category clz`、`Category classes` 或 `Category myClass`。
2. **历史代码残留清洗（警告）**：在重构旧的 `ProductDaoImpl` 或 `ProductAddServlet` 时，必须将过往的 `product.getpClassId()` 移除。现行数据库 `exp4_products` 表不建立外键关联，而是直接使用 `category`（`varchar`）做冗余存储与索引。
3. **条件查询与分类联动**：若后续业务需要实现“管理后台-分类列表修改”联动“商品表分类同步修改”，