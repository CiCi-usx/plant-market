<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>搜索结果 - 苗木网</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
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
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-up {
            animation: fadeUp 0.5s ease-out both;
        }
    </style>
</head>

<body class="bg-teal-950 text-teal-50 min-h-screen font-sans">

    <%-- ==================== 顶部栏 ==================== --%>
    <div class="bg-teal-950/90 backdrop-blur-md border-b border-teal-800/60 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 h-10 flex items-center justify-between text-sm">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="text-teal-300">欢迎您，${sessionScope.user.uname}</span>
                    <div class="flex gap-4">
                        <a href="${pageContext.request.contextPath}/MyOrdersServlet"
                           class="text-teal-400 hover:text-teal-200 transition-colors duration-200">
                            <i class="fa-regular fa-user mr-1"></i>用户中心
                        </a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet"
                           class="text-teal-400 hover:text-teal-200 transition-colors duration-200">
                            <i class="fa-solid fa-right-from-bracket mr-1"></i>退出
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="flex gap-4 ml-auto">
                        <a href="${pageContext.request.contextPath}/login.jsp"
                           class="text-teal-400 hover:text-teal-200 transition-colors duration-200">
                            <i class="fa-solid fa-arrow-right-to-bracket mr-1"></i>登录
                        </a>
                        <a href="${pageContext.request.contextPath}/register.jsp"
                           class="text-teal-400 hover:text-teal-200 transition-colors duration-200">
                            <i class="fa-regular fa-registered mr-1"></i>注册
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- ==================== Logo + 主导航 ==================== --%>
    <header class="bg-teal-900/70 backdrop-blur-md border-b border-teal-800/50">
        <div class="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row items-center gap-4">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="text-2xl font-black tracking-wide text-teal-300 hover:text-teal-200 transition-colors shrink-0">
                <i class="fa-solid fa-seedling mr-2 text-teal-400"></i>苗木网
            </a>
            <form action="${pageContext.request.contextPath}/ProductSearchServlet" method="get"
                  class="flex flex-1 max-w-xl w-full">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索苗木名称..."
                       class="flex-1 bg-teal-950/80 border border-teal-700 rounded-l-lg px-4 py-2
                              text-teal-100 placeholder-teal-500 text-sm
                              focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                              transition-all duration-200">
                <button type="submit"
                        class="bg-teal-600 hover:bg-teal-500 text-white px-5 py-2 rounded-r-lg text-sm
                               font-medium transition-colors duration-200 shrink-0">
                    <i class="fa-solid fa-magnifying-glass mr-1"></i>搜索
                </button>
            </form>
            <a href="${pageContext.request.contextPath}/CartViewServlet"
               class="bg-teal-800/60 hover:bg-teal-700/60 border border-teal-700/50
                      text-teal-300 hover:text-teal-100
                      px-4 py-2 rounded-lg text-sm transition-all duration-200 shrink-0">
                <i class="fa-solid fa-cart-shopping mr-1"></i>购物车
            </a>
        </div>
    </header>

    <%-- ==================== 分类导航 ==================== --%>
    <nav class="bg-teal-900/40 border-b border-teal-800/40">
        <div class="max-w-7xl mx-auto px-4 flex items-center gap-1 overflow-x-auto">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="px-5 py-3 text-sm font-medium text-teal-400 hover:text-teal-200
                      border-b-2 border-transparent hover:border-teal-600
                      transition-all duration-200 shrink-0">
                首页
            </a>
            <a href="${pageContext.request.contextPath}/ProductListByCategoryServlet?cId=1"
               class="px-5 py-3 text-sm font-medium text-teal-400 hover:text-teal-200
                      border-b-2 border-transparent hover:border-teal-600
                      transition-all duration-200 shrink-0">
                <i class="fa-solid fa-apple-whole mr-1"></i>果树苗木
            </a>
            <a href="${pageContext.request.contextPath}/ProductListByCategoryServlet?cId=2"
               class="px-5 py-3 text-sm font-medium text-teal-400 hover:text-teal-200
                      border-b-2 border-transparent hover:border-teal-600
                      transition-all duration-200 shrink-0">
                <i class="fa-solid fa-tree mr-1"></i>非果树苗木
            </a>
        </div>
    </nav>

    <%-- ==================== 主内容 ==================== --%>
    <main class="max-w-7xl mx-auto px-4 py-8 space-y-8">

        <%-- 标题区 --%>
        <div class="animate-fade-up" style="animation-delay:0.05s">
            <div class="flex items-center gap-3">
                <div class="w-1 h-7 bg-teal-400 rounded-full"></div>
                <h1 class="text-xl font-bold text-teal-100">搜索结果</h1>
                <c:if test="${not empty param.keyword}">
                    <span class="bg-teal-800/60 text-teal-300 text-xs font-medium px-2.5 py-1
                                 rounded-full border border-teal-700/50">
                        "${param.keyword}"
                    </span>
                </c:if>
                <c:if test="${not empty productList}">
                    <span class="bg-teal-800/40 text-teal-400 text-xs px-2.5 py-1 rounded-full">
                        ${productList.size()} 件商品
                    </span>
                </c:if>
            </div>
            <%-- 面包屑 --%>
            <div class="flex items-center gap-2 text-sm text-teal-500 mt-2 ml-4">
                <a href="${pageContext.request.contextPath}/index.jsp"
                   class="hover:text-teal-300 transition-colors">首页</a>
                <i class="fa-solid fa-chevron-right text-[10px] text-teal-700"></i>
                <span class="text-teal-300">搜索结果</span>
            </div>
        </div>

        <c:choose>

            <%-- ========== 无结果 ========== --%>
            <c:when test="${empty productList}">
                <div class="animate-fade-up flex flex-col items-center justify-center py-24 text-center"
                     style="animation-delay:0.15s">
                    <div class="text-6xl mb-4 opacity-30">🔍</div>
                    <h3 class="text-lg font-medium text-teal-300 mb-2">未找到相关商品</h3>
                    <p class="text-teal-500 text-sm mb-6">换个关键词试试，或者浏览全部分类～</p>
                    <div class="flex gap-3">
                        <a href="${pageContext.request.contextPath}/index.jsp"
                           class="inline-flex items-center gap-2 bg-teal-600 hover:bg-teal-500
                                  text-white px-6 py-3 rounded-xl text-sm font-bold
                                  shadow-lg shadow-teal-600/20 hover:shadow-teal-500/30
                                  transition-all duration-200">
                            <i class="fa-solid fa-seedling"></i>返回首页
                        </a>
                        <a href="${pageContext.request.contextPath}/ProductListByCategoryServlet?cId=1"
                           class="inline-flex items-center gap-2 bg-teal-800/60 hover:bg-teal-700/60
                                  border border-teal-700/50 text-teal-300 hover:text-teal-100
                                  px-6 py-3 rounded-xl text-sm font-medium
                                  transition-all duration-200">
                            <i class="fa-solid fa-apple-whole"></i>果树苗木
                        </a>
                        <a href="${pageContext.request.contextPath}/ProductListByCategoryServlet?cId=2"
                           class="inline-flex items-center gap-2 bg-teal-800/60 hover:bg-teal-700/60
                                  border border-teal-700/50 text-teal-300 hover:text-teal-100
                                  px-6 py-3 rounded-xl text-sm font-medium
                                  transition-all duration-200">
                            <i class="fa-solid fa-tree"></i>非果树苗木
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- ========== 有结果 ========== --%>
            <c:otherwise>

                <%-- 商品网格 --%>
                    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
                        <c:forEach var="product" items="${productList}" varStatus="st">
                            <%-- 引入公共卡片组件 --%>
                                <jsp:include page="/snippet/product-card.jsp" />
                        </c:forEach>
                    </div>

            </c:otherwise>

        </c:choose>

    </main>

    <%-- ==================== 页脚 ==================== --%>
    <footer class="border-t border-teal-800/40 mt-12">
        <div class="max-w-7xl mx-auto px-4 py-8 text-center text-sm text-teal-600">
            <p><i class="fa-solid fa-seedling mr-1"></i>苗木网 &copy; 2024</p>
        </div>
    </footer>

</body>
</html>
