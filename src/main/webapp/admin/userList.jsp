<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 后台</title>
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
        .animate-fade-up { animation: fadeUp 0.4s ease-out both; }
        
        /* 自定义弹窗遮罩与内容动画 */
        .modal-overlay {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            transition: opacity 0.3s;
        }
        .modal-content {
            animation: fadeUp 0.3s ease-out both;
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

        <%--======左侧边栏（固定宽度）======--%>
        <aside class="w-60 shrink-0 bg-teal-900/50 border-r border-teal-800/50
                      flex flex-col fixed top-0 left-0 h-full z-40">
                <%@ include file="sidebar.jsp" %>
        </aside>

        <%--======右侧主体======--%>
        <div class="flex-1 ml-60 flex flex-col min-h-screen">

            <%-- 顶部栏 --%>
            <%@ include file="header.jsp" %>

            <%-- 内容区 --%>
            <main class="flex-1 p-8">
            <div class="max-w-7xl mx-auto">
            
            <!-- 标题与操作栏 -->
            <div class="flex justify-between items-center mb-8 animate-fade-up">
                <h1 class="text-3xl font-black tracking-wide text-teal-300">
                    <i class="fa-solid fa-users-gear mr-3 text-teal-500"></i>用户管理
                </h1>
                <button onclick="openAddModal()" 
                        class="bg-teal-600 hover:bg-teal-500 text-white font-bold py-2.5 px-6 rounded-lg shadow-lg shadow-teal-900/50 transition-all duration-200 flex items-center gap-2">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>新增用户</span>
                </button>
            </div>

            <!-- 数据表格卡片 -->
            <div class="bg-teal-900/70 border border-teal-800/60 rounded-xl shadow-2xl shadow-teal-950/50 overflow-hidden animate-fade-up" style="animation-delay: 0.1s;">
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-teal-950/60 border-b border-teal-800/80 text-teal-400 text-sm uppercase tracking-wider">
                                <th class="py-4 px-6 font-semibold">UID</th>
                                <th class="py-4 px-6 font-semibold">用户名</th>
                                <th class="py-4 px-6 font-semibold">性别</th>
                                <th class="py-4 px-6 font-semibold">邮箱</th>
                                <th class="py-4 px-6 font-semibold">电话</th>
                                <th class="py-4 px-6 font-semibold">地址</th>
                                <th class="py-4 px-6 font-semibold text-center">操作</th>
                            </tr>
                        </thead>
                        <tbody class="text-teal-100 text-sm">
                            <!-- 使用 c:forEach 遍历 request 域中的 users 数据 -->
                            <c:forEach items="${users}" var="user">
                                <tr class="border-b border-teal-800/40 hover:bg-teal-900/40 transition-colors duration-150">
                                    <td class="py-4 px-6 text-teal-300 font-mono">${user.uid}</td>
                                    <td class="py-4 px-6 font-medium">${user.uname}</td>
                                    <td class="py-4 px-6">${user.usex}</td>
                                    <td class="py-4 px-6">${user.uemail}</td>
                                    <td class="py-4 px-6">${user.phone}</td>
                                    <td class="py-4 px-6 max-w-[200px] truncate" title="${user.address}">${user.address}</td>
                                    <td class="py-4 px-6 text-center">
                                        <div class="flex items-center justify-center gap-3">
                                            <!-- 编辑按钮 -->
                                            <button onclick="openEditModal(${user.uid}, '${user.uname}', '${user.usex}', '${user.uemail}', '${user.phone}', '${user.address}')" 
                                                    class="text-teal-400 hover:text-teal-200 transition-colors" title="编辑">
                                                <i class="fa-solid fa-pen-to-square text-lg"></i>
                                            </button>
                                            <!-- 删除按钮 -->
                                            <button onclick="confirmDelete(${user.uid}, '${user.uname}')" 
                                                    class="text-red-400 hover:text-red-300 transition-colors" title="删除">
                                                <i class="fa-solid fa-trash-can text-lg"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="7" class="text-center py-10 text-teal-500">
                                        <i class="fa-regular fa-face-frown mr-2"></i>暂无用户数据
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

<!-- ==================== 新增用户弹窗 ==================== -->
<div id="addModal" class="fixed inset-0 z-50 hidden flex items-center justify-center modal-overlay">
    <div class="bg-teal-900 border border-teal-700 rounded-xl shadow-2xl w-full max-w-md p-8 modal-content relative">
        <button onclick="closeAddModal()" class="absolute top-4 right-4 text-teal-500 hover:text-teal-200 transition-colors">
            <i class="fa-solid fa-xmark text-xl"></i>
        </button>
        <h2 class="text-2xl font-bold text-teal-300 mb-6">
            <i class="fa-solid fa-user-plus mr-2"></i>新增用户
        </h2>
        <form action="${pageContext.request.contextPath}/AddUserServlet" method="post" class="space-y-5">
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">用户名</label>
                <input type="text" name="uname" required
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">密码</label>
                <input type="password" name="upwd" required
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-teal-400 text-sm font-medium mb-1">性别</label>
                    <select name="usex" class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <div>
                    <label class="block text-teal-400 text-sm font-medium mb-1">电话</label>
                    <input type="text" name="phone"
                           class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
                </div>
            </div>
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">邮箱</label>
                <input type="email" name="uemail"
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">地址</label>
                <input type="text" name="address"
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <button type="submit" 
                    class="w-full bg-teal-600 hover:bg-teal-500 text-white font-bold py-3 rounded-lg shadow-lg shadow-teal-900/50 transition-all duration-200 mt-4">
                确认新增
            </button>
        </form>
    </div>
</div>

<!-- ==================== 编辑用户弹窗 ==================== -->
<div id="editModal" class="fixed inset-0 z-50 hidden flex items-center justify-center modal-overlay">
    <div class="bg-teal-900 border border-teal-700 rounded-xl shadow-2xl w-full max-w-md p-8 modal-content relative">
        <button onclick="closeEditModal()" class="absolute top-4 right-4 text-teal-500 hover:text-teal-200 transition-colors">
            <i class="fa-solid fa-xmark text-xl"></i>
        </button>
        <h2 class="text-2xl font-bold text-teal-300 mb-6">
            <i class="fa-solid fa-pen-to-square mr-2"></i>编辑用户
        </h2>
        <form id="editForm" action="${pageContext.request.contextPath}/UpdateUserServlet" method="post" class="space-y-5">
            <!-- 隐藏域：保存要修改的用户的 UID -->
            <input type="hidden" name="uid" id="edit-uid">
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">用户名</label>
                <input type="text" name="uname" id="edit-uname" required
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">新密码 (不修改请留空)</label>
                <input type="password" name="upwd" id="edit-upwd"
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-teal-400 text-sm font-medium mb-1">性别</label>
                    <select name="usex" id="edit-usex" class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <div>
                    <label class="block text-teal-400 text-sm font-medium mb-1">电话</label>
                    <input type="text" name="phone" id="edit-phone"
                           class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
                </div>
            </div>
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">邮箱</label>
                <input type="email" name="uemail" id="edit-uemail"
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <div>
                <label class="block text-teal-400 text-sm font-medium mb-1">地址</label>
                <input type="text" name="address" id="edit-address"
                       class="w-full bg-teal-950/80 border border-teal-700 rounded-lg px-4 py-2.5 text-teal-100 placeholder-teal-600 focus:outline-none focus:border-teal-500 focus:ring-1 focus:ring-teal-500 transition-all">
            </div>
            <button type="submit" 
                    class="w-full bg-teal-600 hover:bg-teal-500 text-white font-bold py-3 rounded-lg shadow-lg shadow-teal-900/50 transition-all duration-200 mt-4">
                保存修改
            </button>
        </form>
    </div>
</div>

<!-- ==================== 删除确认弹窗 ==================== -->
<div id="deleteModal" class="fixed inset-0 z-50 hidden flex items-center justify-center modal-overlay">
    <div class="bg-teal-900 border border-red-800/50 rounded-xl shadow-2xl w-full max-w-sm p-8 modal-content text-center">
        <div class="text-red-400 text-5xl mb-4">
            <i class="fa-solid fa-triangle-exclamation"></i>
        </div>
        <h2 class="text-xl font-bold text-teal-100 mb-2">确认删除用户</h2>
        <p class="text-teal-400 mb-6">您确定要删除用户 <span id="delete-uname" class="text-red-400 font-bold"></span> 吗？此操作不可逆！</p>
        <form id="deleteForm" action="${pageContext.request.contextPath}/DeleteUserServlet" method="get" class="flex gap-4 justify-center">
            <input type="hidden" name="uid" id="delete-uid">
            <button type="button" onclick="closeDeleteModal()" 
                    class="px-5 py-2.5 bg-teal-800 hover:bg-teal-700 text-teal-200 rounded-lg transition-colors font-medium">
                取消
            </button>
            <button type="submit" 
                    class="px-5 py-2.5 bg-red-600 hover:bg-red-500 text-white rounded-lg transition-colors font-medium shadow-lg shadow-red-900/50">
                确认删除
            </button>
        </form>
    </div>
</div>

<!-- ==================== JavaScript 交互逻辑 ==================== -->
<script>
    // --- 新增弹窗控制 ---
    function openAddModal() {
        document.getElementById('addModal').classList.remove('hidden');
    }
    function closeAddModal() {
        document.getElementById('addModal').classList.add('hidden');
    }

    // --- 编辑弹窗控制与数据回显 ---
    function openEditModal(uid, uname, usex, uemail, phone, address) {
        document.getElementById('edit-uid').value = uid;
        document.getElementById('edit-uname').value = uname;
        document.getElementById('edit-upwd').value = ''; // 密码不回显
        document.getElementById('edit-uemail').value = uemail;
        document.getElementById('edit-phone').value = phone;
        document.getElementById('edit-address').value = address;
        
        // 设置性别下拉框的选中状态
        var sexSelect = document.getElementById('edit-usex');
        for (var i = 0; i < sexSelect.options.length; i++) {
            if (sexSelect.options[i].value === usex) {
                sexSelect.options[i].selected = true;
                break;
            }
        }
        
        document.getElementById('editModal').classList.remove('hidden');
    }
    function closeEditModal() {
        document.getElementById('editModal').classList.add('hidden');
    }

    // --- 删除确认弹窗控制 ---
    function confirmDelete(uid, uname) {
        document.getElementById('delete-uid').value = uid;
        document.getElementById('delete-uname').innerText = uname;
        document.getElementById('deleteModal').classList.remove('hidden');
    }
    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    // 点击弹窗外部遮罩层关闭弹窗 (通用逻辑)
    window.onclick = function(event) {
        if (event.target.id === 'addModal') closeAddModal();
        if (event.target.id === 'editModal') closeEditModal();
        if (event.target.id === 'deleteModal') closeDeleteModal();
    }
</script>

</body>
</html>
