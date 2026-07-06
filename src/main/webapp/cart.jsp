<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="/login.jsp" />
</c:if>

<!-- 直接从 session 获取购物车数据 -->
<c:set var="cartItems" value="${sessionScope.cartItems}" />


<%-- 计算总件数与总价 --%>
<c:set var="totalCount" value="0" />
<c:set var="totalPrice" value="0" />
<c:forEach var="item" items="${cartItems}">
    <c:if test="${not empty item.product}">
        <c:set var="totalCount" value="${totalCount + item.quantity}" />
        <c:set var="totalPrice" value="${totalPrice + item.product.price * item.quantity}" />
    </c:if>
</c:forEach>

<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>购物车 - 苗木网</title>
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
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-12px); }
            to   { opacity: 1; transform: translateX(0); }
        }
        .animate-slide-in {
            animation: slideIn 0.35s ease-out both;
        }
        /* 数字输入框去除箭头 */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button { -webkit-appearance: none; margin: 0; }
        input[type=number] { -moz-appearance: textfield; }
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
            <nav class="flex gap-2 sm:ml-auto">
                <a href="${pageContext.request.contextPath}/index.jsp"
                   class="px-4 py-2 rounded-lg text-sm text-teal-400 hover:text-teal-100
                          hover:bg-teal-800/50 transition-all duration-200">首页</a>
                <a href="${pageContext.request.contextPath}/CartViewServlet"
                   class="px-4 py-2 rounded-lg text-sm text-teal-100 bg-teal-800/60
                          border border-teal-700/50 font-medium">
                    <i class="fa-solid fa-cart-shopping mr-1"></i>购物车</a>
                <a href="${pageContext.request.contextPath}/MyOrdersServlet"
                   class="px-4 py-2 rounded-lg text-sm text-teal-400 hover:text-teal-100
                          hover:bg-teal-800/50 transition-all duration-200">我的订单</a>
            </nav>
        </div>
    </header>

    <%-- ==================== 面包屑 ==================== --%>
    <div class="max-w-7xl mx-auto px-4 pt-6">
        <div class="flex items-center gap-2 text-sm text-teal-500">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="hover:text-teal-300 transition-colors">首页</a>
            <i class="fa-solid fa-chevron-right text-[10px] text-teal-700"></i>
            <span class="text-teal-300">购物车</span>
        </div>
    </div>

    <%-- ==================== 主内容 ==================== --%>
    <main class="max-w-7xl mx-auto px-4 py-6 space-y-6">

        <%-- 页面标题 --%>
        <div class="animate-fade-up" style="animation-delay:0.05s">
            <div class="flex items-center gap-3">
                <div class="w-1 h-7 bg-teal-400 rounded-full"></div>
                <h1 class="text-xl font-bold text-teal-100">我的购物车</h1>
                <c:if test="${not empty cartItems}">
                    <span class="bg-teal-800/60 text-teal-300 text-xs font-medium px-2.5 py-1 rounded-full
                                 border border-teal-700/50">
                        ${fn:length(cartItems)} 种
                    </span>
                </c:if>
            </div>
            <p class="text-sm text-teal-500 mt-1 ml-4">
                共 ${totalCount} 件商品，合计
                <span class="text-orange-400 font-bold">
                    ¥<fmt:formatNumber value="${totalPrice}" pattern="#,##0.00" />
                </span>
            </p>
        </div>

        <c:choose>

            <%-- ========== 空购物车 ========== --%>
            <c:when test="${empty cartItems}">
                <div class="animate-fade-up flex flex-col items-center justify-center py-24 text-center"
                     style="animation-delay:0.15s">
                    <div class="text-6xl mb-4 opacity-30">🛒</div>
                    <h3 class="text-lg font-medium text-teal-300 mb-2">购物车空空如也</h3>
                    <p class="text-teal-500 text-sm mb-6">快去挑选心仪的苗木吧</p>
                    <a href="${pageContext.request.contextPath}/index.jsp"
                       class="inline-flex items-center gap-2 bg-teal-600 hover:bg-teal-500
                              text-white px-8 py-3 rounded-xl text-sm font-bold
                              shadow-lg shadow-teal-600/20 hover:shadow-teal-500/30
                              transition-all duration-200">
                        <i class="fa-solid fa-seedling"></i>去逛逛
                    </a>
                </div>
            </c:when>

            <%-- ========== 有商品 ========== --%>
            <c:otherwise>

                <div class="flex flex-col lg:flex-row gap-6 animate-fade-up" style="animation-delay:0.1s">

                                        <%-- ====== 左：商品列表 ====== --%>
                    <div class="flex-1 space-y-3">

                        <%-- 操作栏 --%>
                        <div class="flex items-center justify-between mb-1">
                            <div class="flex items-center gap-3">
                                <label class="flex items-center gap-2 text-sm text-teal-400 cursor-pointer">
                                    <input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)" 
                                           class="w-4 h-4 rounded border-teal-600 bg-teal-900 text-teal-500 focus:ring-teal-500">
                                    全选
                                </label>
                                <span class="text-sm text-teal-500">
                                    <i class="fa-solid fa-box-open mr-1"></i>共 ${totalCount} 件
                                </span>
                            </div>
                            <div class="flex gap-4">
                                <button type="submit" form="cartForm" name="action" value="batchRemove"
                                        onclick="return confirm('确定删除选中的商品吗？')"
                                        class="text-teal-400 hover:text-red-400 text-sm transition-colors">
                                    <i class="fa-regular fa-trash-can mr-1"></i>批量删除
                                </button>
                                <a href="${pageContext.request.contextPath}/CartViewServlet?action=clear" onclick="return confirm('确定清空购物车吗？')"
                                    class="text-teal-500 hover:text-red-400 text-sm transition-colors">
                                    <i class="fa-regular fa-trash-can mr-1"></i>清空购物车
                                </a>
                            </div>
                        </div>

                        <%-- 购物车表单 --%>
                        <form id="cartForm" action="${pageContext.request.contextPath}/CartViewServlet" method="post">
                            <%-- 表头（桌面端） --%>
                            <div class="hidden sm:grid grid-cols-12 gap-4 px-5 py-2.5
                                        bg-teal-900/50 rounded-lg text-xs text-teal-500 font-medium
                                        border border-teal-800/40">
                                <span class="col-span-1">选择</span>
                                <span class="col-span-4">商品信息</span>
                                <span class="col-span-2 text-center">单价</span>
                                <span class="col-span-2 text-center">数量</span>
                                <span class="col-span-2 text-right">小计</span>
                                <span class="col-span-1 text-right">操作</span>
                            </div>

                            <%-- 商品行 --%>
                            <c:forEach var="item" items="${cartItems}" varStatus="st">
                                    <div class="animate-slide-in"
                                        style="animation-delay:${st.index * 0.05}s">
                                        <div class="hidden sm:grid grid-cols-12 gap-4 items-center px-5 py-4
                                                    bg-teal-900/30 border border-teal-800/30 rounded-xl
                                                    hover:bg-teal-900/50 hover:border-teal-700/40
                                                    transition-all duration-200">
                                            
                                            <%-- 复选框 --%>
                                            <div class="col-span-1">
                                                <input type="checkbox" name="selectedIds" value="${item.product.id}" 
                                                    class="item-checkbox w-4 h-4 rounded border-teal-600 bg-teal-900 text-teal-500 focus:ring-teal-500">
                                            </div>

                                            <%-- 商品信息 --%>
                                            <div class="col-span-4 flex items-center gap-4 min-w-0">
                                                <a href="${pageContext.request.contextPath}/ProductDetailServlet?pId=${item.product.id}"
                                                class="shrink-0">
                                                    <img src="${pageContext.request.contextPath}/assets/images/${item.product.img}" alt="${item.product.name}"
                                                        class="w-16 h-16 object-cover rounded-lg border border-teal-800/50
                                                                hover:border-teal-600/50 transition-colors" />
                                                </a>
                                                <a href="${pageContext.request.contextPath}/ProductDetailServlet?pId=${item.product.id}"
                                                class="text-sm font-medium text-teal-100 hover:text-teal-300
                                                        transition-colors truncate">
                                                    ${item.product.name}
                                                </a>
                                            </div>
                                            <%-- 单价 --%>
                                            <div class="col-span-2 text-center">
                                                <span class="text-sm text-teal-300">
                                                    ¥<fmt:formatNumber value="${item.product.price}" pattern="#,##0.00" />
                                                </span>
                                            </div>
                                            <%-- 数量 --%>
                                                <div class="col-span-2 flex justify-center">
                                                    <div class="flex items-center gap-0 bg-teal-950/60 rounded-lg border border-teal-800/50">
                                                        <input id="qty-${item.product.id}" type="number" value="${item.quantity}" min="1" readonly class="w-14 h-7 text-center bg-transparent text-teal-100
                                                                text-xs font-medium border-x border-teal-800/50 cursor-not-allowed" />
                                                    </div>
                                                </div>
                                            <%-- 小计 --%>
                                            <div class="col-span-2 text-right">
                                                <span id="sub-${item.product.id}"
                                                    class="text-sm font-bold text-orange-400">
                                                    ¥<fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0.00" />
                                                </span>
                                            </div>
                                            <%-- 删除 --%>
                                            <div class="col-span-1 text-right">
                                                <a href="${pageContext.request.contextPath}/CartViewServlet?action=remove&pId=${item.product.id}"
                                                onclick="return confirm('确定移除该商品？')"
                                                class="text-teal-600 hover:text-red-400 transition-colors duration-200"
                                                title="移除">
                                                    <i class="fa-regular fa-trash-can"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                            </c:forEach>
                        </form><%-- /cart-form --%>

                    </div><%-- /cart-left --%>


                    <%-- ====== 右：订单汇总 ====== --%>
                    <aside class="lg:w-80 shrink-0">
                        <div class="bg-teal-900/50 border border-teal-800/40 rounded-xl p-6
                                    lg:sticky lg:top-16 space-y-5">
                            <h2 class="text-base font-bold text-teal-100 flex items-center gap-2">
                                <i class="fa-solid fa-receipt text-teal-400"></i>订单汇总
                            </h2>

                            <div class="space-y-3 text-sm">
                                <div class="flex justify-between text-teal-400">
                                    <span>商品合计</span>
                                    <span>¥<fmt:formatNumber value="${totalPrice}" pattern="#,##0.00" /></span>
                                </div>
                                <div class="flex justify-between text-teal-400">
                                    <span>运费</span>
                                    <span class="text-teal-500">免运费</span>
                                </div>
                                <div class="border-t border-teal-800/50 pt-3 flex justify-between items-baseline">
                                    <span class="text-teal-300 font-medium">应付合计</span>
                                    <span id="totalDisplay"
                                          class="text-xl font-black text-orange-400">
                                        ¥<fmt:formatNumber value="${totalPrice}" pattern="#,##0.00" />
                                    </span>
                                </div>
                            </div>

                            <form method="post" action="${pageContext.request.contextPath}/CheckoutServlet">
                                <input type="hidden" name="action" value="placeOrder">
                                <button type="submit"
                                        class="w-full bg-orange-500 hover:bg-orange-400 active:bg-orange-600
                                               text-white font-bold py-3.5 rounded-xl text-sm
                                               shadow-lg shadow-orange-500/20 hover:shadow-orange-400/30
                                               transition-all duration-200 flex items-center justify-center gap-2">
                                    <i class="fa-solid fa-credit-card"></i>立即结算
                                </button>
                            </form>

                            <a href="${pageContext.request.contextPath}/index.jsp"
                               class="block text-center text-sm text-teal-500 hover:text-teal-300
                                      transition-colors duration-200 py-2">
                                <i class="fa-solid fa-arrow-left mr-1"></i>继续购物
                            </a>
                        </div>
                    </aside>

                </div><%-- /cart-layout --%>

            </c:otherwise>

        </c:choose>

    </main>

    <%-- ==================== 页脚 ==================== --%>
    <footer class="border-t border-teal-800/40 mt-12">
        <div class="max-w-7xl mx-auto px-4 py-8 text-center text-sm text-teal-600">
            <p><i class="fa-solid fa-seedling mr-1"></i>苗木网 &copy; 2026</p>
        </div>
    </footer>

    <script>
        const SERVLET_CART_VIEW = "${pageContext.request.contextPath}/CartViewServlet";
        // 新增这一行：在浏览器控制台打印路径
        console.log("当前的请求路径是:", SERVLET_CART_VIEW);

        // 全选/反选逻辑
            function toggleSelectAll(source) {
                const checkboxes = document.querySelectorAll('.item-checkbox');
                checkboxes.forEach(cb => cb.checked = source.checked);
            }

    </script>

</body>
</html>
