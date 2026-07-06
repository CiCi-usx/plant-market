<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品详情 - ${product.name}</title>
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

            <a href="${pageContext.request.contextPath}/CartViewServlet"
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
                首页
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

    <!-- 主内容：商品详情 -->
    <main class="max-w-7xl mx-auto px-4 py-8">
        <!-- 面包屑 -->
        <nav class="mb-6 text-sm text-teal-500 animate-fade-up">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="hover:text-teal-300 transition-colors duration-200">首页</a>
            <i class="fa-solid fa-chevron-right mx-2 text-xs text-teal-700"></i>
            <span class="text-teal-300">${product.name}</span>
        </nav>

        <!-- 商品详情卡片 -->
        <div class="animate-fade-up" style="animation-delay:0.1s">
            <div class="bg-teal-900/50 backdrop-blur-sm border border-teal-800/50 rounded-2xl overflow-hidden">
                <div class="flex flex-col lg:flex-row">

                    <!-- 左侧：商品图片 -->
                    <div class="lg:w-1/2 p-6 lg:p-10 flex items-center justify-center bg-teal-950/40">
                        <div class="relative group">
                            <img src="${pageContext.request.contextPath}/assets/images/${product.img}"
                                 alt="${product.name}"
                                 class="w-full max-w-md rounded-xl shadow-2xl shadow-teal-950/80
                                        group-hover:scale-105 transition-transform duration-500" />
                            <div class="absolute inset-0 rounded-xl ring-1 ring-inset ring-teal-700/30"></div>
                        </div>
                    </div>

                    <!-- 右侧：商品信息 -->
                    <div class="lg:w-1/2 p-6 lg:p-10 flex flex-col justify-center space-y-6">

                        <!-- 商品名称 -->
                        <div>
                            <h1 class="text-2xl lg:text-3xl font-bold text-teal-100 leading-tight">
                                ${product.name}
                            </h1>
                        </div>

                        <!-- 价格区 -->
                        <div class="bg-teal-950/60 border border-teal-800/40 rounded-xl p-5 space-y-3">
                            <div class="flex items-baseline gap-2">
                                <span class="text-sm text-teal-500">价格</span>
                                <span class="text-3xl font-black text-orange-400">
                                    <span class="text-lg">￥</span><fmt:formatNumber value="${product.price}" pattern="#,##0.00" />
                                </span>
                            </div>
                        </div>

                        <!-- 信息列表 -->
                        <div class="space-y-3 text-sm">
                            <div class="flex items-center gap-3">
                                <span class="text-teal-500 w-20 shrink-0">
                                    <i class="fa-solid fa-location-dot mr-1"></i>发货地
                                </span>
                                <span class="text-teal-200">${product.origin}</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <span class="text-teal-500 w-20 shrink-0">
                                    <i class="fa-solid fa-warehouse mr-1"></i>库存
                                </span>
                                <span class="${product.stock > 0 ? 'text-teal-200' : 'text-red-400'}">
                                    <c:choose>
                                        <c:when test="${product.stock > 0}">
                                            ${product.stock} 件
                                        </c:when>
                                        <c:otherwise>
                                            暂无库存
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <!-- 描述 -->
                        <div class="border-t border-teal-800/40 pt-4">
                            <h3 class="text-sm font-medium text-teal-400 mb-2">
                                <i class="fa-solid fa-circle-info mr-1"></i>商品描述
                            </h3>
                            <p class="text-teal-300/80 text-sm leading-relaxed">${product.description}</p>
                        </div>

                        <!-- 操作按钮 -->
                        <div class="flex flex-col sm:flex-row gap-3 pt-2">
                            <c:choose>
                                <c:when test="${product.stock > 0}">
                                    <a href="${pageContext.request.contextPath}/CartAddServlet?pId=${product.id}"
                                       class="inline-flex items-center justify-center gap-2
                                              bg-orange-500 hover:bg-orange-400 active:bg-orange-600
                                              text-white font-bold
                                              px-8 py-3.5 rounded-xl text-base
                                              shadow-lg shadow-orange-500/20 hover:shadow-orange-400/30
                                              transition-all duration-200">
                                        <i class="fa-solid fa-cart-plus"></i>加入购物车
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center justify-center gap-2
                                                 bg-teal-800/40 text-teal-600 cursor-not-allowed
                                                 px-8 py-3.5 rounded-xl text-base font-bold">
                                        <i class="fa-solid fa-ban"></i>暂时缺货
                                    </span>
                                </c:otherwise>
                            </c:choose>

                            <a href="javascript:history.back()"
                               class="inline-flex items-center justify-center gap-2
                                      bg-teal-800/60 hover:bg-teal-700/60
                                      border border-teal-700/50
                                      text-teal-300 hover:text-teal-100
                                      px-6 py-3.5 rounded-xl text-sm font-medium
                                      transition-all duration-200">
                                <i class="fa-solid fa-arrow-left"></i>返回
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

                <!-- ====== 评价区域 ====== -->
        <c:choose>
            <%-- 情况1：用户已购买且已收货，显示评价表单 --%>
            <c:when test="${hasReceived}">
                <div class="border-t border-teal-800/40 pt-5 mt-5">
                    <h3 class="text-sm font-medium text-teal-400 mb-3">
                        <i class="fa-solid fa-pen-to-square mr-1"></i>发表评价
                    </h3>
                    <!-- 修改点1：action 改为 ProductDetailServlet -->
                    <form action="${pageContext.request.contextPath}/ProductDetailServlet" method="post" 
                          class="space-y-3">
                        <input type="hidden" name="action" value="addReview" />
                        <input type="hidden" name="pId" value="${product.id}" />
                        
                        <!-- 星级评分 -->
                        <div class="flex items-center gap-2">
                            <span class="text-sm text-teal-500">评分</span>
                            <div class="flex gap-1" id="star-rating">
                                <label class="cursor-pointer text-teal-700 hover:text-orange-400 transition-colors text-xl" data-star="1">
                                    <input type="radio" name="rating" value="1" class="hidden" /><i class="fa-solid fa-star"></i>
                                </label>
                                <label class="cursor-pointer text-teal-700 hover:text-orange-400 transition-colors text-xl" data-star="2">
                                    <input type="radio" name="rating" value="2" class="hidden" /><i class="fa-solid fa-star"></i>
                                </label>
                                <label class="cursor-pointer text-teal-700 hover:text-orange-400 transition-colors text-xl" data-star="3">
                                    <input type="radio" name="rating" value="3" class="hidden" /><i class="fa-solid fa-star"></i>
                                </label>
                                <label class="cursor-pointer text-teal-700 hover:text-orange-400 transition-colors text-xl" data-star="4">
                                    <input type="radio" name="rating" value="4" class="hidden" /><i class="fa-solid fa-star"></i>
                                </label>
                                <label class="cursor-pointer text-teal-700 hover:text-orange-400 transition-colors text-xl" data-star="5">
                                    <input type="radio" name="rating" value="5" class="hidden" checked /><i class="fa-solid fa-star"></i>
                                </label>
                            </div>
                        </div>

                        <!-- 评价内容 -->
                        <textarea name="content" rows="3" required
                                  class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5
                                         text-teal-100 placeholder-teal-600 text-sm resize-none
                                         focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                         transition-all duration-200"
                                  placeholder="分享您对这款苗木的评价..."></textarea>

                        <button type="submit"
                                class="bg-teal-600 hover:bg-teal-500 text-white px-5 py-2 rounded-lg text-sm
                                       font-medium transition-colors duration-200 shadow-md shadow-teal-900/50">
                            <i class="fa-solid fa-paper-plane mr-1"></i>提交评价
                        </button>
                    </form>
                </div>
            </c:when>

            <%-- 情况2：用户未购买或未收货（默认） --%>
            <c:otherwise>
                <div class="bg-teal-950/40 border border-teal-700/30 rounded-xl p-4 mt-4">
                    <div class="flex items-center gap-2 text-teal-500 text-sm">
                        <i class="fa-solid fa-lock"></i>
                        <span>仅购买且已收货的用户可评价此商品</span>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- 修改点2：新增展示评价列表的区域 -->
        <div class="mt-8">
            <h3 class="text-sm font-medium text-teal-400 mb-3">
                <i class="fa-solid fa-comments mr-1"></i>用户评价 (${empty reviewList ? 0 : reviewList.size()})
            </h3>
            
            <c:choose>
                <c:when test="${empty reviewList}">
                    <p class="text-teal-600 text-sm">暂无评价，快来抢沙发吧！</p>
                </c:when>
                <c:otherwise>
                    <div class="space-y-4">
                        <c:forEach items="${reviewList}" var="rv">
                            <div class="bg-teal-950/50 border border-teal-700/30 rounded-lg p-4">
                                <div class="flex items-center justify-between mb-2">
                                    <span class="font-medium text-teal-300">${rv[0]}</span>
                                    <span class="text-orange-400 text-sm">
                                        <c:forEach begin="1" end="${rv[1]}"><i class="fa-solid fa-star"></i></c:forEach>
                                    </span>
                                </div>
                                <p class="text-teal-100 text-sm">${rv[2]}</p>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <!-- ================================ -->

    </main>

    <!-- 页脚 -->
    <footer class="bg-teal-950 border-t border-teal-800/50 mt-12">
        <div class="max-w-7xl mx-auto px-4 py-8 text-center text-teal-600 text-sm">
            <p><i class="fa-solid fa-seedling mr-1"></i> 苗木网 &copy; 2026</p>
        </div>
    </footer>

    <!-- 评分交互脚本 -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const starContainer = document.getElementById('star-rating');
            if (starContainer) {
                const labels = starContainer.querySelectorAll('label');
                updateStars(5); // 默认5星

                labels.forEach(label => {
                    const starVal = parseInt(label.getAttribute('data-star'));
                    label.addEventListener('mouseenter', () => updateStars(starVal));
                    label.addEventListener('mouseleave', () => {
                        const checkedRadio = starContainer.querySelector('input[type="radio"]:checked');
                        const currentVal = checkedRadio ? parseInt(checkedRadio.value) : 0;
                        updateStars(currentVal);
                    });
                });

                function updateStars(val) {
                    labels.forEach(l => {
                        const v = parseInt(l.getAttribute('data-star'));
                        const icon = l.querySelector('i');
                        if (v <= val) {
                            icon.classList.remove('text-teal-700');
                            icon.classList.add('text-orange-400');
                        } else {
                            icon.classList.remove('text-orange-400');
                            icon.classList.add('text-teal-700');
                        }
                    });
                }
            }
        });
    </script>
</body>
</html>
