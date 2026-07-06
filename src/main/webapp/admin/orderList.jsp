<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理 - 后台</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        /* 自定义滚动条 */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-thumb { background: #0f766e; border-radius: 3px; }
        ::-webkit-scrollbar-track { background: #f0fdfa; }
    </style>
</head>
<body class="bg-teal-950 text-teal-50 min-h-screen font-sans">

<div class="flex h-screen overflow-hidden">
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
            <div class="max-w-7xl mx-auto">

                <!-- 标题与操作栏 -->
                <div class="flex items-center justify-between mb-8">
                    <div>
                        <h2 class="text-3xl font-bold text-teal-50">订单管理</h2>
                        <p class="text-teal-400 mt-1 text-sm">查看、发货及管理所有用户订单</p>
                    </div>
                </div>

                <!-- 订单列表表格容器 -->
                <div class="bg-teal-900/40 backdrop-blur-sm rounded-xl border border-teal-800/60 shadow-xl overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-teal-900/80 text-teal-300 text-sm uppercase tracking-wider">
                                    <th class="px-6 py-4 font-semibold">订单号</th>
                                    <th class="px-6 py-4 font-semibold">下单时间</th>
                                    <th class="px-6 py-4 font-semibold">收货人</th>
                                    <th class="px-6 py-4 font-semibold">联系电话</th>
                                    <th class="px-6 py-4 font-semibold">总价 (¥)</th>
                                    <th class="px-6 py-4 font-semibold">状态</th>
                                    <th class="px-6 py-4 font-semibold text-center">操作</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-teal-800/60">
                                <c:forEach items="${orders}" var="order">
                                    <tr class="hover:bg-teal-800/40 transition-colors duration-150">
                                        <!-- 订单号 -->
                                        <td class="px-6 py-4 text-sm font-medium text-teal-100">${order.oid}</td>
                                        
                                        <!-- 下单时间 -->
                                        <td class="px-6 py-4 text-sm text-teal-300">
                                            ${order.orderTime}
                                        </td>
                                        
                                        <!-- 收货人 -->
                                        <td class="px-6 py-4 text-sm text-teal-100">${order.receiverName}</td>
                                        
                                        <!-- 电话 -->
                                        <td class="px-6 py-4 text-sm text-teal-100">${order.receiverPhone}</td>
                                        
                                        <!-- 总价 -->
                                        <td class="px-6 py-4 text-sm font-bold text-teal-50">
                                            ¥ ${order.total}
                                        </td>
                                        
                                        <!-- 状态展示 -->
                                        <td class="px-6 py-4 text-sm">
                                            <c:choose>
                                                <c:when test="${order.status == 0}">
                                                    <span class="px-3 py-1 inline-flex items-center rounded-full text-xs font-medium bg-yellow-900/50 text-yellow-300 border border-yellow-700/50">
                                                        <i class="fa-solid fa-clock mr-1"></i> 待付款
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 1}">
                                                    <span class="px-3 py-1 inline-flex items-center rounded-full text-xs font-medium bg-blue-900/50 text-blue-300 border border-blue-700/50">
                                                        <i class="fa-solid fa-box mr-1"></i> 待发货
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 2}">
                                                    <span class="px-3 py-1 inline-flex items-center rounded-full text-xs font-medium bg-purple-900/50 text-purple-300 border border-purple-700/50">
                                                        <i class="fa-solid fa-truck-fast mr-1"></i> 已发货
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 3}">
                                                    <span class="px-3 py-1 inline-flex items-center rounded-full text-xs font-medium bg-green-900/50 text-green-300 border border-green-700/50">
                                                        <i class="fa-solid fa-circle-check mr-1"></i> 已完成
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 inline-flex items-center rounded-full text-xs font-medium bg-red-900/50 text-red-300 border border-red-700/50">
                                                        <i class="fa-solid fa-ban mr-1"></i> 已取消
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <!-- 操作按钮 -->
                                        <td class="px-6 py-4 text-sm text-center">
                                            <div class="flex items-center justify-center gap-3">
                                                
                                                <!-- 发货按钮 (只有待发货状态 status==1 才显示) -->
                                                <c:if test="${order.status == 1}">
                                                    <a href="${pageContext.request.contextPath}/AdminOrderUpdateServlet?oId=${order.oid}&action=ship" 
                                                       class="text-teal-400 hover:text-teal-200 transition-colors duration-200" 
                                                       title="点击发货">
                                                        <i class="fa-solid fa-truck-fast text-lg"></i>
                                                    </a>
                                                </c:if>

                                                <!-- 取消订单按钮 (非取消状态可取消) -->
                                                <c:if test="${order.status != 5}">
                                                    <a href="${pageContext.request.contextPath}/AdminOrderUpdateServlet?oId=${order.oid}&action=status&status=5"
                                                        class="text-yellow-400 hover:text-yellow-200 transition-colors duration-200" title="取消订单"
                                                        onclick="return confirm('确认取消该订单吗？');">
                                                        <i class="fa-solid fa-ban text-lg"></i>
                                                    </a>
                                                </c:if>


                                                <!-- 删除按钮 -->
                                                <a href="${pageContext.request.contextPath}/AdminOrderDeleteServlet?oId=${order.oid}" 
                                                   class="text-red-400 hover:text-red-200 transition-colors duration-200" 
                                                   title="删除订单"
                                                   onclick="return confirm('确认删除该订单及其所有明细吗？此操作不可恢复！');">
                                                    <i class="fa-solid fa-trash-can text-lg"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <!-- 空数据提示 -->
                                <c:if test="${empty orders}">
                                    <tr>
                                        <td colspan="7" class="px-6 py-10 text-center text-teal-500">
                                            <i class="fa-solid fa-folder-open text-4xl mb-3 block"></i>
                                            暂时没有任何订单数据
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

</body>
</html>

