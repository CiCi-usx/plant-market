<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户中心 - 苗木网</title>
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
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-up {
            animation: fadeUp 0.5s ease-out both;
        }
    </style>
</head>

<body class="bg-teal-950 text-teal-50 min-h-screen font-sans flex flex-col">

    <!-- 顶部栏 -->
    <div class="bg-teal-950/90 backdrop-blur-md border-b border-teal-800/60 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 h-10 flex items-center justify-between text-sm">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="text-teal-300">欢迎您，${sessionScope.user.uname}</span>
                    <div class="flex gap-4">
                        <a href="${pageContext.request.contextPath}/userCenter.jsp"
                           class="text-teal-200 border-b border-teal-400 pb-0.5 transition-colors duration-200">
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

    <!-- Logo + 主导航 -->
    <header class="bg-teal-900/70 backdrop-blur-md border-b border-teal-800/50">
        <div class="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row items-center gap-4">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="text-2xl font-black tracking-wide text-teal-300 hover:text-teal-200 transition-colors shrink-0">
                <i class="fa-solid fa-seedling mr-2 text-teal-400"></i>苗木网
            </a>
            <!-- 搜索栏 -->
            <form action="${pageContext.request.contextPath}/ProductSearchServlet" method="get"
                  class="flex flex-1 max-w-xl w-full">
                <input type="text" name="keyword" placeholder="搜索苗木名称..."
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
            <a href="${pageContext.request.contextPath}/cart.jsp"
               class="bg-teal-800/60 hover:bg-teal-700/60 border border-teal-700/50
                      text-teal-300 hover:text-teal-100
                      px-4 py-2 rounded-lg text-sm transition-all duration-200 shrink-0">
                <i class="fa-solid fa-cart-shopping mr-1"></i>购物车
            </a>
        </div>
    </header>

    <!-- 分类导航 -->
    <nav class="bg-teal-900/40 border-b border-teal-800/40">
        <div class="max-w-7xl mx-auto px-4 flex items-center gap-1 overflow-x-auto">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="px-5 py-3 text-sm font-medium text-teal-400 hover:text-teal-200 border-b-2 border-transparent
                      hover:border-teal-600 transition-all duration-200 shrink-0">
                <i class="fa-solid fa-house mr-1"></i>首页
            </a>
            
            <a href="${pageContext.request.contextPath}/ProductListByCategoryServlet?cId=1"
               class="px-5 py-3 text-sm font-medium text-teal-400 hover:text-teal-200 border-b-2 border-transparent
                      hover:border-teal-600 transition-all duration-200 shrink-0">
                <i class="fa-solid fa-apple-whole mr-1"></i>果树苗木
            </a>
            <a href="${pageContext.request.contextPath}/ProductListByCategoryServlet?cId=2"
               class="px-5 py-3 text-sm font-medium text-teal-400 hover:text-teal-200 border-b-2 border-transparent
                      hover:border-teal-600 transition-all duration-200 shrink-0">
                <i class="fa-solid fa-tree mr-1"></i>非果树苗木
            </a>
        </div>
    </nav>

    <!-- 主内容 -->
    <main class="flex-1 max-w-7xl w-full mx-auto px-4 py-8">

        <!-- 页面标题 -->
        <div class="flex items-center gap-3 mb-8 animate-fade-up">
            <div class="w-1 h-7 bg-teal-400 rounded-full"></div>
            <h1 class="text-xl font-bold text-teal-100">我的历史订单</h1>
            <i class="fa-solid fa-receipt text-teal-500"></i>
        </div>

        <c:choose>
            <c:when test="${not empty myOrders}">
                <c:forEach items="${myOrders}" var="order" varStatus="loop">
                    <div class="animate-fade-up" style="animation-delay:${loop.index * 0.08}s">

                        <!-- 订单卡片 -->
                        <div class="bg-teal-900/40 border border-teal-800/50 rounded-xl overflow-hidden mb-6
                                    hover:border-teal-700/70 transition-colors duration-200">

                            <!-- 订单头部：订单号 + 时间 + 状态 -->
                            <div class="bg-teal-900/60 border-b border-teal-800/50 px-5 py-3
                                        flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
                                <div class="text-sm text-teal-300 flex items-center gap-2 flex-wrap">
                                    <i class="fa-solid fa-hashtag text-teal-600 text-xs"></i>
                                    <!-- 属性大小写问题 -->
                                    <span class="font-mono">${order.oid}</span>
                                    <span class="text-teal-600">|</span>
                                    <i class="fa-regular fa-clock text-teal-600 text-xs"></i>
                                    <span class="text-teal-400">${order.orderTime}</span>
                                </div>                                
                                <div class="text-sm font-medium flex items-center gap-1.5">
                                    <c:choose>
                                        <c:when test="${order.status == 0}">
                                            <span class="inline-flex items-center gap-1 text-red-400">
                                                <i class="fa-solid fa-circle text-[6px]"></i>待支付
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 1}">
                                            <span class="inline-flex items-center gap-1 text-amber-400">
                                                <i class="fa-solid fa-circle text-[6px]"></i>待发货
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 2}">
                                            <span class="inline-flex items-center gap-1 text-blue-400">
                                                <i class="fa-solid fa-circle text-[6px]"></i>已发货
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 3}">
                                            <span class="inline-flex items-center gap-1 text-yellow-400">
                                                <i class="fa-solid fa-circle text-[6px]"></i>待评价
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 4}">
                                            <span class="inline-flex items-center gap-1 text-green-400">
                                                <i class="fa-solid fa-circle text-[6px]"></i>已完成
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 5}">
                                            <span class="inline-flex items-center gap-1 text-gray-400">
                                                <i class="fa-solid fa-circle text-[6px]"></i>已取消
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </div>

                            </div>

                            <!-- 配送与溯源信息 -->
                            <div class="mx-5 mt-4 bg-teal-950/60 border-l-4 border-green-600/70 rounded-r-lg px-4 py-3 text-sm">
                                <div class="font-semibold text-teal-200 mb-2 flex items-center gap-1.5">
                                    <i class="fa-solid fa-truck text-green-500"></i>配送信息
                                </div>
                                <div class="text-teal-400 space-y-1">
                                    <div>
                                        <i class="fa-regular fa-user text-teal-600 w-4 text-center mr-1"></i>
                                        <span class="text-teal-500">收货人：</span>${order.receiverName}
                                        <span class="text-teal-600 mx-2">|</span>
                                        <i class="fa-solid fa-phone text-teal-600 w-4 text-center mr-1"></i>
                                        <span class="text-teal-500">电话：</span>${order.receiverPhone}
                                    </div>
                                    <div>
                                        <i class="fa-solid fa-location-dot text-teal-600 w-4 text-center mr-1"></i>
                                        <span class="text-teal-500">收货地址：</span>${order.shippingAddress}
                                    </div>
                                    <c:if test="${order.status >= 2}">
                                        <div class="pt-2 mt-2 border-t border-dashed border-teal-800/60 text-green-400/90">
                                            <i class="fa-solid fa-seedling w-4 text-center mr-1"></i>
                                            <span class="text-green-500">苗木源产地：</span>${order.originAddress}
                                            <span class="text-teal-600 ml-4">
                                                <i class="fa-regular fa-clock mr-1"></i>发货时间：${order.shipTime}
                                            </span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- 底部：合计 + 操作 -->
                            <div class="px-5 py-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                                <div class="text-sm text-teal-300">
                                    合计总金额：
                                    <span class="text-red-400 text-xl font-bold ml-1">￥${order.total}</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <c:choose>
                                        <c:when test="${order.status == 0}">
                                            <a href="${pageContext.request.contextPath}/OrderPayServlet?oid=${order.oid}"
                                                class="bg-red-600/80 hover:bg-red-500 text-white px-4 py-1.5 rounded-lg text-sm font-medium transition-colors duration-200 inline-flex items-center gap-1.5">
                                                <i class="fa-solid fa-credit-card text-xs"></i>立即支付
                                            </a>
                                            <a href="${pageContext.request.contextPath}/OrderCancelServlet?oid=${order.oid}"
                                                onclick="return confirm('确定取消该订单吗？')"
                                                class="text-teal-500 hover:text-teal-300 text-sm transition-colors duration-200 inline-flex items-center gap-1">
                                                <i class="fa-regular fa-trash-can text-xs"></i>取消订单
                                            </a>
                                        </c:when>
                                
                                        <c:when test="${order.status == 1}">
                                            <span class="text-amber-400 text-sm inline-flex items-center gap-1">
                                                <i class="fa-solid fa-hourglass-half text-xs"></i>等待发货与运输
                                            </span>
                                        </c:when>
                                
                                        <c:when test="${order.status == 2}">
                                            <a href="${pageContext.request.contextPath}/OrderConfirmServlet?oid=${order.oid}"
                                                onclick="return confirm('确认已收到货了吗？')"
                                                class="bg-green-600/80 hover:bg-green-500 text-white px-4 py-1.5 rounded-lg text-sm font-medium transition-colors duration-200 inline-flex items-center gap-1.5">
                                                <i class="fa-solid fa-check text-xs"></i>确认收货
                                            </a>
                                        </c:when>
                                
                                        <c:when test="${order.status == 4}">
                                            <span class="text-teal-500 text-sm inline-flex items-center gap-1">
                                                <i class="fa-solid fa-circle-check text-xs"></i>订单已完成
                                            </span>
                                        </c:when>
                                
                                        <c:when test="${order.status == 5}">
                                            <span class="text-gray-400 text-sm inline-flex items-center gap-1">
                                                <i class="fa-solid fa-ban text-xs"></i>订单已取消
                                            </span>
                                        </c:when>
                                
                                        <c:otherwise>
                                            <span class="text-teal-600 text-sm">未知状态</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </div>

                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="animate-fade-up flex flex-col items-center justify-center py-24 text-teal-600">
                    <div class="w-24 h-24 rounded-full bg-teal-900/50 border border-teal-800/50
                                flex items-center justify-center mb-6">
                        <i class="fa-solid fa-box-open text-4xl text-teal-700"></i>
                    </div>
                    <p class="text-lg font-medium text-teal-500 mb-2">暂无订单记录</p>
                    <p class="text-sm text-teal-700 mb-6">快去挑选心仪的苗木吧</p>
                    <a href="${pageContext.request.contextPath}/index.jsp"
                       class="bg-teal-600 hover:bg-teal-500 text-white px-6 py-2.5 rounded-lg text-sm
                              font-medium transition-colors duration-200 inline-flex items-center gap-1.5">
                        <i class="fa-solid fa-seedling"></i>逛逛商城
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <!-- 页脚 -->
    <footer class="bg-teal-950 border-t border-teal-800/50 mt-auto">
        <div class="max-w-7xl mx-auto px-4 py-6 text-center text-teal-600 text-sm">
            <p><i class="fa-solid fa-seedling mr-1"></i> 苗木网 &copy; 2026</p>
        </div>
    </footer>

</body>

</html>
