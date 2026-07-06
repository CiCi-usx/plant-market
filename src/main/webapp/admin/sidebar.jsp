<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Logo 区域 -->
<div class="px-5 py-6 border-b border-teal-800/50">
    <a href="${pageContext.request.contextPath}/admin/index.jsp"
       class="flex items-center gap-2.5 text-xl font-black text-teal-300
              hover:text-teal-200 transition-colors">
        <i class="fa-solid fa-shield-halved text-teal-400 text-lg"></i>
        <span>管理后台</span>
    </a>
    <p class="text-[11px] text-teal-600 mt-1 ml-7">Nursery Admin Panel</p>
</div>

<!-- 导航菜单 -->
<nav class="flex-1 py-4 overflow-y-auto">
    <!-- 在商品管理下方追加 用户管理 -->
    <div class="px-5 mb-2 mt-4">
        <p class="text-[10px] font-bold text-teal-600 uppercase tracking-widest">
            <i class="fa-solid fa-users mr-1"></i>用户管理
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/UserListServlet" class="flex items-center gap-3 px-5 py-2.5 text-sm text-teal-400
                hover:text-teal-100 hover:bg-teal-800/50 transition-all duration-200">
        <i class="fa-solid fa-list-check w-5 text-center text-xs text-teal-500"></i>
        用户列表
    </a>
    <div class="px-5 mb-2">
        <p class="text-[10px] font-bold text-teal-600 uppercase tracking-widest">
            <i class="fa-solid fa-leaf mr-1"></i>商品管理
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/ProductNewServlet"
       class="flex items-center gap-3 px-5 py-2.5 text-sm text-teal-400
              hover:text-teal-100 hover:bg-teal-800/50 transition-all duration-200">
        <i class="fa-solid fa-circle-plus w-5 text-center text-xs text-teal-500"></i>
        新增商品
    </a>
    <a href="${pageContext.request.contextPath}/ProductListServlet"
       class="flex items-center gap-3 px-5 py-2.5 text-sm text-teal-400
              hover:text-teal-100 hover:bg-teal-800/50 transition-all duration-200">
        <i class="fa-solid fa-list-check w-5 text-center text-xs text-teal-500"></i>
        维护商品
    </a>

    <div class="px-5 mt-5 mb-2">
        <p class="text-[10px] font-bold text-teal-600 uppercase tracking-widest">
            <i class="fa-solid fa-truck mr-1"></i>订单管理
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/AdminOrderListServlet" class="flex items-center gap-3 px-5 py-2.5 text-sm text-teal-400
                  hover:text-teal-100 hover:bg-teal-800/50 transition-all duration-200">
        <i class="fa-solid fa-boxes-stacked w-5 text-center text-xs text-teal-500"></i>
        订单查看
    </a>

    <div class="px-5 mt-5 mb-2">
        <p class="text-[10px] font-bold text-teal-600 uppercase tracking-widest">
            <i class="fa-solid fa-image mr-1"></i>上传管理
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/upload.jsp"
       class="flex items-center gap-3 px-5 py-2.5 text-sm text-teal-400
              hover:text-teal-100 hover:bg-teal-800/50 transition-all duration-200">
        <i class="fa-solid fa-cloud-arrow-up w-5 text-center text-xs text-teal-500"></i>
        上传商品图片
    </a>
    <a href="${pageContext.request.contextPath}/admin/deletePic.jsp"
       class="flex items-center gap-3 px-5 py-2.5 text-sm text-teal-400
              hover:text-teal-100 hover:bg-teal-800/50 transition-all duration-200">
        <i class="fa-regular fa-trash-can w-5 text-center text-xs text-teal-500"></i>
        删除商品图片
    </a>
</nav>

<!-- 底部 -->
<div class="px-5 py-4 border-t border-teal-800/50">
    <a href="${pageContext.request.contextPath}/index.jsp"
       class="flex items-center gap-2 text-xs text-teal-600 hover:text-teal-400 transition-colors">
        <i class="fa-solid fa-arrow-left"></i>返回前台首页
    </a>
</div>
