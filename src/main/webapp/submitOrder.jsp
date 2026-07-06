<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>苗木网 - 提交订单</title>
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
        input::placeholder {
            color: #2dd4bf;
            opacity: 0.5;
        }
    </style>
</head>

<body class="bg-teal-950 text-teal-50 min-h-screen font-sans">

    <!-- 顶部栏 -->
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

    <!-- Logo + 主导航 -->
    <header class="bg-teal-900/70 backdrop-blur-md border-b border-teal-800/50">
        <div class="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row items-center gap-4">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="text-2xl font-black tracking-wide text-teal-300 hover:text-teal-200 transition-colors shrink-0">
                <i class="fa-solid fa-seedling mr-2 text-teal-400"></i>苗木网
            </a>

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

    <!-- 面包屑 -->
    <nav class="bg-teal-900/40 border-b border-teal-800/40">
        <div class="max-w-7xl mx-auto px-4 flex items-center gap-2 text-sm py-3">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="text-teal-400 hover:text-teal-200 transition-colors">首页</a>
            <i class="fa-solid fa-angle-right text-teal-600 text-xs"></i>
            <a href="${pageContext.request.contextPath}/cart.jsp"
               class="text-teal-400 hover:text-teal-200 transition-colors">购物车</a>
            <i class="fa-solid fa-angle-right text-teal-600 text-xs"></i>
            <span class="text-teal-200 font-medium">提交订单</span>
        </div>
    </nav>

    <!-- 主内容 -->
    <main class="max-w-3xl mx-auto px-4 py-8">

        <section class="animate-fade-up">
            <!-- 标题 -->
            <div class="flex items-center gap-3 mb-6">
                <div class="w-1 h-7 bg-teal-400 rounded-full"></div>
                <h2 class="text-xl font-bold text-teal-100">确认订单信息</h2>
                <i class="fa-solid fa-clipboard-check text-teal-400 text-lg"></i>
            </div>

            <form action="${pageContext.request.contextPath}/OrderSubmitServlet" method="post"
                  class="bg-teal-900/40 border border-teal-800/50 rounded-xl p-6 space-y-6">

                <!-- 收货信息区块 -->
                <div class="space-y-4">
                    <h3 class="text-sm font-bold text-teal-300 flex items-center gap-2 pb-2 border-b border-teal-800/50">
                        <i class="fa-solid fa-location-dot text-teal-400"></i>收货信息
                    </h3>

                    <!-- 收货人姓名 -->
                    <div>
                        <label class="block text-sm text-teal-300 mb-2">
                            <i class="fa-regular fa-user mr-1"></i>收货人姓名
                        </label>
                        <input type="text" name="receiverName" required
                               placeholder="请输入收货人姓名"
                               class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600/60 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 联系电话 -->
                    <div>
                        <label class="block text-sm text-teal-300 mb-2">
                            <i class="fa-solid fa-phone mr-1"></i>联系电话
                        </label>
                        <input type="text" name="receiverPhone" required
                               placeholder="请输入手机号码"
                               pattern="[0-9]{11}"
                               class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600/60 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 详细收货地址 -->
                    <div>
                        <label class="block text-sm text-teal-300 mb-2">
                            <i class="fa-solid fa-map-location-dot mr-1"></i>详细收货地址
                        </label>
                        <input type="text" name="shippingAddress" required
                               placeholder="请输入省市区及详细门牌号"
                               class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600/60 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>
                </div>

                <!-- 订单摘要 -->
                <div class="bg-teal-950/60 border border-teal-800/40 rounded-lg p-4 space-y-2">
                    <div class="flex items-center justify-between text-sm">
                        <span class="text-teal-400"><i class="fa-solid fa-box mr-1"></i>商品件数</span>
                        <span class="text-teal-200">${cartItemCount} 件</span>
                    </div>
                    <div class="flex items-center justify-between text-sm">
                        <span class="text-teal-400"><i class="fa-solid fa-truck mr-1"></i>配送方式</span>
                        <span class="text-teal-200">普通快递（包邮）</span>
                    </div>
                    <div class="border-t border-teal-800/40 pt-2 flex items-center justify-between">
                        <span class="text-teal-300 font-medium">应付总额</span>
                        <span class="text-2xl font-black text-orange-400">¥ ${cartTotal}</span>
                    </div>
                </div>

                <!-- 隐藏域 -->
                <input type="hidden" name="total" value="${cartTotal}">

                <!-- 提交按钮 -->
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/cart.jsp"
                       class="flex-1 text-center bg-teal-800/60 hover:bg-teal-700/60 border border-teal-700/50
                              text-teal-300 hover:text-teal-100
                              px-6 py-3 rounded-lg text-sm font-medium transition-all duration-200">
                        <i class="fa-solid fa-arrow-left mr-1"></i>返回购物车
                    </a>
                    <button type="submit"
                            class="flex-1 bg-teal-600 hover:bg-teal-500 text-white
                                   px-6 py-3 rounded-lg text-sm font-bold transition-all duration-200
                                   shadow-lg shadow-teal-900/50">
                        <i class="fa-solid fa-circle-check mr-2"></i>提交订单
                    </button>
                </div>

            </form>
        </section>

    </main>

    <!-- 底部 -->
    <footer class="border-t border-teal-800/50 mt-12">
        <div class="max-w-7xl mx-auto px-4 py-6 text-center text-sm text-teal-500">
            <p><i class="fa-solid fa-seedling mr-1"></i>苗木网 &copy; 2026 — 让每一棵苗木找到归宿</p>
        </div>
    </footer>

</body>
</html>
