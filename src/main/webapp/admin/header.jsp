<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- 顶部栏片段（被 index.jsp 静态包含，不要加 html/head/body 标签） --%>

<!-- 顶栏：左侧面包屑，右侧用户信息 -->
<div class="h-14 px-6 flex items-center justify-between border-b border-teal-800/50
            bg-teal-900/30 backdrop-blur-sm">
    <!-- 左侧 -->
    <div class="flex items-center gap-2 text-sm text-teal-500">
        <i class="fa-solid fa-house text-xs"></i>
        <span>管理员首页</span>
    </div>

    <!-- 右侧用户信息 -->
    <div class="flex items-center gap-4">
        <c:choose>
            <c:when test="${not empty admin}">
                <div class="flex items-center gap-3">
                    <div class="flex items-center gap-2 bg-teal-800/40 border border-teal-700/40
                                rounded-full pl-3 pr-1 py-1">
                        <i class="fa-solid fa-user-shield text-teal-400 text-xs"></i>
                        <span class="text-sm text-teal-200 font-medium">${admin.adminName}</span>
                        <a href="${pageContext.request.contextPath}/admin/AdminLogoutServlet"
                           class="ml-1 bg-teal-700/60 hover:bg-red-900/60 text-teal-300 hover:text-red-300
                                  text-xs px-2.5 py-1 rounded-full transition-all duration-200">
                            退出
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/admin/login.jsp"
                   class="inline-flex items-center gap-1.5 bg-teal-600 hover:bg-teal-500
                          text-white text-sm px-4 py-1.5 rounded-full font-medium
                          transition-colors duration-200">
                    <i class="fa-solid fa-arrow-right-to-bracket text-xs"></i>登录
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
