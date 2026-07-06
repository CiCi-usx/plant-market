<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- 商品卡片片段组件（供 AJAX 动态加载） --%>
<c:forEach var="product" items="${productList}" varStatus="st">
    <%-- EL 取值去前缀化；链接参数 pId 可根据 Servlet 情况决定是否改为 id --%>
    <a href="${pageContext.request.contextPath}/ProductDetailServlet?pId=${product.id}" 
       class="group bg-teal-900/30 border border-teal-800/30 rounded-xl overflow-hidden hover:bg-teal-900/50 hover:border-teal-700/40 transition-all duration-300">
        
        <%-- 图片区 --%>
        <div class="relative overflow-hidden aspect-square">
            <img src="${pageContext.request.contextPath}/assets/images/${product.img}"
                 alt="${product.name}" 
                 class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
            <c:choose>
                <c:when test="${product.stock <= 0}">
                    <span class="absolute top-2 left-2 bg-red-900/80 text-red-300 text-[10px] font-bold px-2 py-0.5 rounded-full backdrop-blur-sm">        
                        缺货
                    </span>
                </c:when>
                <c:when test="${product.stock <= 10}">
                    <span class="absolute top-2 left-2 bg-orange-900/80 text-orange-300 text-[10px] font-bold px-2 py-0.5 rounded-full backdrop-blur-sm">        
                        仅剩${product.stock}件
                    </span>
                </c:when>
            </c:choose>
        </div>

        <%-- 信息区 --%>
        <div class="p-3 space-y-1.5">
            <h3 class="text-sm font-medium text-teal-100 truncate group-hover:text-teal-300 transition-colors">
                ${product.name}
            </h3>

            <%-- 发货地与销量同行显示 --%>
            <div class="flex items-center justify-between text-[10px] text-teal-600">
                <c:if test="${not empty product.origin}">
                    <span class="flex items-center space-x-0.5">
                        <i class="fa-solid fa-location-dot"></i>
                        <span>${product.origin}</span>
                    </span>
                </c:if>
                <c:if test="${not empty product.sales}">
                    <span>已售 ${product.sales}</span>
                </c:if>
            </div>

            <div class="flex items-baseline justify-between">
                <span class="text-orange-400 font-bold text-base">
                    ¥
                    <fmt:formatNumber value="${product.price}" pattern="#,##0.00" />
                </span>
                <c:if test="${product.stock > 0}">
                    <span class="text-teal-600 group-hover:text-teal-400 transition-colors">
                        <i class="fa-solid fa-cart-plus text-xs"></i>
                    </span>
                </c:if>
            </div>
        </div>
    </a>
</c:forEach>
