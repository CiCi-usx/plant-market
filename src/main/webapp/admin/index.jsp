<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员首页 - 苗木网</title>
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

                <%-- 欢迎卡片 --%>
                <div class="animate-fade-up" style="animation-delay:0.1s">
                    <div class="bg-gradient-to-br from-teal-900/60 to-teal-800/30
                                border border-teal-800/40 rounded-2xl p-8 mb-8">
                        <div class="flex items-center gap-4 mb-4">
                            <div class="w-14 h-14 bg-teal-700/40 rounded-2xl flex items-center justify-center
                                        border border-teal-600/30">
                                <i class="fa-solid fa-shield-halved text-2xl text-teal-400"></i>
                            </div>
                            <div>
                                <h1 class="text-2xl font-black text-teal-100">
                                    欢迎回来，${admin.adminName}
                                </h1>
                                <p class="text-sm text-teal-500 mt-0.5">
                                    苗木网管理后台 · 当前时间
                                    <script>document.write(new Date().toLocaleDateString('zh-CN'))</script>
                                </p>
                            </div>
                        </div>
                        <p class="text-teal-400 text-sm leading-relaxed max-w-2xl">
                            您可以在左侧菜单中选择操作。管理商品信息、处理订单发货、上传或删除商品图片。
                        </p>
                    </div>
                </div>

                <%-- 快捷入口卡片 --%>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 animate-fade-up"
                     style="animation-delay:0.2s">

                    <a href="${pageContext.request.contextPath}/ProductNewServlet"
                       class="group bg-teal-900/30 border border-teal-800/30 rounded-xl p-5
                              hover:bg-teal-900/50 hover:border-teal-700/40
                              transition-all duration-300">
                        <div class="w-10 h-10 bg-green-900/40 rounded-lg flex items-center justify-center
                                    mb-3 group-hover:bg-green-800/50 transition-colors">
                            <i class="fa-solid fa-circle-plus text-green-400"></i>
                        </div>
                        <h3 class="text-sm font-bold text-teal-200 group-hover:text-teal-100 transition-colors">
                            新增商品
                        </h3>
                        <p class="text-xs text-teal-600 mt-1">添加新的苗木商品</p>
                    </a>

                    <a href="${pageContext.request.contextPath}/ProductListServlet"
                       class="group bg-teal-900/30 border border-teal-800/30 rounded-xl p-5
                              hover:bg-teal-900/50 hover:border-teal-700/40
                              transition-all duration-300">
                        <div class="w-10 h-10 bg-blue-900/40 rounded-lg flex items-center justify-center
                                    mb-3 group-hover:bg-blue-800/50 transition-colors">
                            <i class="fa-solid fa-list-check text-blue-400"></i>
                        </div>
                        <h3 class="text-sm font-bold text-teal-200 group-hover:text-teal-100 transition-colors">
                            维护商品
                        </h3>
                        <p class="text-xs text-teal-600 mt-1">编辑、下架商品信息</p>
                    </a>

                    <a href="${pageContext.request.contextPath}/AdminOrderMaintServlet"
                       class="group bg-teal-900/30 border border-teal-800/30 rounded-xl p-5
                              hover:bg-teal-900/50 hover:border-teal-700/40
                              transition-all duration-300">
                        <div class="w-10 h-10 bg-orange-900/40 rounded-lg flex items-center justify-center
                                    mb-3 group-hover:bg-orange-800/50 transition-colors">
                            <i class="fa-solid fa-boxes-stacked text-orange-400"></i>
                        </div>
                        <h3 class="text-sm font-bold text-teal-200 group-hover:text-teal-100 transition-colors">
                            订单维护
                        </h3>
                        <p class="text-xs text-teal-600 mt-1">发货与订单管理</p>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/upload.jsp"
                       class="group bg-teal-900/30 border border-teal-800/30 rounded-xl p-5
                              hover:bg-teal-900/50 hover:border-teal-700/40
                              transition-all duration-300">
                        <div class="w-10 h-10 bg-purple-900/40 rounded-lg flex items-center justify-center
                                    mb-3 group-hover:bg-purple-800/50 transition-colors">
                            <i class="fa-solid fa-cloud-arrow-up text-purple-400"></i>
                        </div>
                        <h3 class="text-sm font-bold text-teal-200 group-hover:text-teal-100 transition-colors">
                            上传图片
                        </h3>
                        <p class="text-xs text-teal-600 mt-1">上传商品图片资源</p>
                    </a>

                </div>

            </main>

        </div><%-- /右侧主体 --%>

    </div>
<%-- /整体布局 --%>

</body>
</html>
