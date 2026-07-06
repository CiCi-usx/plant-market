<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>商品管理列表</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['"Noto Sans SC"', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <style>
        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
    
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    
        .animate-fade-up {
            animation: fadeUp 0.5s ease-out both;
        }
    </style>
</head>
<body class="bg-teal-950 text-teal-50 min-h-screen font-sans">

    <%-- 未登录检测 --%>
    <c:if test="${empty admin}">
        <c:redirect url="/admin/login.jsp" />
    </c:if>

    <%-- 整体布局：左侧边栏 + 右侧内容 --%>
    <div class="flex min-h-screen">

        <%-- ====== 左侧边栏（固定宽度） ====== --%>
        <aside class="w-60 shrink-0 bg-teal-900/50 border-r border-teal-800/50
                      flex flex-col fixed top-0 left-0 h-full z-40">
            <%@ include file="sidebar.jsp" %>
        </aside>

        <%-- ====== 右侧主体 ====== --%>
        <div class="flex-1 ml-60 flex flex-col min-h-screen">

            <%-- 顶部栏 --%>
            <%@ include file="header.jsp" %>

            <%-- 内容区 --%>
            <main class="flex-1 p-8">
            <h2>商品管理列表</h2>

            <!-- 如果有操作提示信息可以展示出来 -->
            <p style="color: green">${msg}</p>
            <p style="color: red">${error_msg}</p>

            <!-- 商品展示表格 -->
            <table border="1" cellpadding="8" cellspacing="0" width="100%" style="border-collapse: collapse; text-align: center;">
                <thead class="bg-teal-800/80 text-teal-100 backdrop-blur-md">
                    <tr>
                        <th width="8%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">商品ID
                        </th>
                        <th width="12%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">
                            商品类别</th>
                        <th width="20%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">
                            商品名称</th>
                        <th width="10%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">价格
                            (元)</th>
                        <th width="15%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">发货地
                        </th>
                        <th width="10%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">
                            库存数量</th>
                        <th width="12%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">
                            商品图片</th>
                        <th width="13%" class="px-4 py-3 text-sm font-semibold uppercase tracking-wider border-b border-teal-700/50">
                            操作选项</th>
                    </tr>
                </thead>

                <tbody>
                    <!-- 判断集合是否为空 -->
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <!-- 循环遍历 Servlet 传过来的商品列表 -->
                            <c:forEach items="${productList}" var="p">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.category}</td>
                                    <td align="left">${p.name}</td>
                                    <td>
                                        <font color="orange"><b>${p.price}</b></font>
                                    </td>
                                    <td>${p.origin}</td>
                                    <td>${p.stock}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.img}">
                                                <img src="${pageContext.request.contextPath}/assets/images/${p.img}" width="50px"
                                                    height="50px" style="object-fit: cover; border: 1px solid #ccc;" />
                                            </c:when>
                                            <c:otherwise>
                                                <font color="gray">暂无图片</font>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/ProductEditServlet?pId=${p.id}"
                                            style="color: blue; text-decoration: none; font-weight: bold;">
                                            ✏️ 编辑
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="padding: 30px; color: gray;">暂无商品数据，请先添加商品！</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            </main>
        </div>
    </div>
</body>
</html>