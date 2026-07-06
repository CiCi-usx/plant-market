<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改商品信息</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script language="javascript">
        $(function () {
            // 当切换下拉列表图片时，联动切换预览图
            $("select#pic").change(function () {
                var filename = $(this).val();
                if(filename) {
                    $("#img1").attr('src', '${pageContext.request.contextPath}/assets/images/' + filename);
                } else {
                    $("#img1").attr('src', '#');
                }
            });
        });
    </script>
    <style>
        @keyframes fade-up {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
    
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    
        .animate-fade-up {
            animation: fade-up 0.5s ease-out forwards;
        }
    </style>

</head>
<body class="bg-teal-950 text-teal-50 min-h-screen font-sans">

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
                        <%-- 内容区 --%>
            <main class="flex-1 p-8 bg-gray-50 min-h-screen">
                <div class="max-w-4xl mx-auto animate-fade-up" style="animation-delay:0.1s">
                    
                    <%-- 顶部提示信息 --%>
                    <c:if test="${not empty edit_msg}">
                        <div class="mb-4 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded" role="alert">
                            <p class="font-bold">提示:</p>
                            <p>${edit_msg}</p>
                        </div>
                    </c:if>

                    <div class="bg-white shadow-lg rounded-2xl overflow-hidden border border-gray-100">
                        <div class="bg-gradient-to-r from-teal-800 to-teal-600 p-6">
                            <h2 class="text-2xl font-bold text-white flex items-center">
                                <i class="fa-solid fa-pen-to-square mr-3"></i>修改商品信息
                            </h2>
                            <p class="text-teal-100 text-sm mt-1">请仔细核对并修改以下商品信息</p>
                        </div>

                        <form id="form1" name="form1" method="post" action="${pageContext.request.contextPath}/ProductEditServlet">
                            
                            <!-- 隐藏域：商品ID -->
                            <input type="hidden" name="id" value="${product.id}">


                            <div class="p-6 space-y-6">
                                
                                <%-- 商品类别 --%>
                                <div>
                                    <label for="category" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fa-solid fa-layer-group mr-1 text-teal-600"></i>商品类别 <span class="text-red-500">*</span>
                                    </label>
                                    <select id="category" name="category" required class="w-full bg-white border border-gray-300 text-gray-900 rounded-xl focus:ring-teal-500 focus:border-teal-500 block p-3 transition-all">
                                        <option value="">请选择...</option>
                                        <option value="果树" <c:if test="${product.category == '果树'}">selected</c:if>>果树</option>
                                        <option value="非果树" <c:if test="${product.category == '非果树'}">selected</c:if>>非果树</option>
                                    </select>
                                </div>

                                <%-- 商品名称 & 价格 --%>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <label for="pName" class="block text-sm font-medium text-gray-700 mb-2">
                                            <i class="fa-solid fa-tree mr-1 text-teal-600"></i>商品名称 <span class="text-red-500">*</span>
                                        </label>
                                        <input name="name" type="text" id="pName" required value="${product.name}"
                                               class="w-full bg-white border border-gray-300 rounded-xl p-3 focus:ring-teal-500 focus:border-teal-500 transition-all text-gray-900" />
                                    </div>
                                    <div>
                                        <label for="price" class="block text-sm font-medium text-gray-700 mb-2">
                                            <i class="fa-solid fa-tag mr-1 text-teal-600"></i>商品价格 (¥) <span class="text-red-500">*</span>
                                        </label>
                                        <input name="price" type="number" step="0.01" id="price" required value="${product.price}" 
                                               class="w-full bg-white border border-gray-300 rounded-xl p-3 focus:ring-teal-500 focus:border-teal-500 transition-all text-gray-900" />
                                    </div>
                                </div>

                                <%-- 发货地 & 库存 --%>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <label for="origin" class="block text-sm font-medium text-gray-700 mb-2">
                                            <i class="fa-solid fa-location-dot mr-1 text-teal-600"></i>发货地 <span class="text-red-500">*</span>
                                        </label>
                                        <input name="origin" type="text" id="origin" required placeholder="例：浙江省嘉兴市" value="${product.origin}" 
                                               class="w-full bg-white border border-gray-300 rounded-xl p-3 focus:ring-teal-500 focus:border-teal-500 transition-all text-gray-900" />
                                    </div>
                                    <div>
                                        <label for="stock" class="block text-sm font-medium text-gray-700 mb-2">
                                            <i class="fa-solid fa-boxes-stacked mr-1 text-teal-600"></i>库存数量
                                        </label>
                                        <input name="stock" type="number" id="stock" value="${product.stock}" 
                                               class="w-full bg-white border border-gray-300 rounded-xl p-3 focus:ring-teal-500 focus:border-teal-500 transition-all text-gray-900" />
                                    </div>
                                </div>

                                <%-- 商品图片选择与预览 (保留下拉选择模式) --%>
                                <div class="border-t pt-6">
                                    <label for="pic" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fa-solid fa-image mr-1 text-teal-600"></i>选择商品图片 <span class="text-red-500">*</span>
                                    </label>
                                    <div class="flex flex-col md:flex-row items-start md:items-center gap-6">
                                        <select name="img" id="pic" required class="w-full md:w-1/2 bg-white border border-gray-300 text-gray-900 rounded-xl focus:ring-teal-500 focus:border-teal-500 block p-3 transition-all" onchange="document.getElementById('img1').src='${pageContext.request.contextPath}/upload/' + this.value;">
                                            <option value="">请选择图片...</option>
                                            <c:forEach items="${images}" var="file">
                                                <option value="${file}" <c:if test="${product.img == file}">selected</c:if>>${file}</option>
                                            </c:forEach>
                                        </select>
                                        
                                        <div class="bg-gray-100 rounded-xl p-2 border border-gray-200">
                                            <img id="img1" name="img1" width="100px" height="100px" class="object-cover rounded-lg" 
                                                 src="<c:choose><c:when test='${not empty product.img}'>${pageContext.request.contextPath}/assets/images/${product.img}</c:when><c:otherwise>#</c:otherwise></c:choose>" 
                                                 alt="商品图片预览"/>
                                        </div>
                                    </div>
                                </div>

                                <%-- 富文本编辑器 --%>
                                <div class="border-t pt-6">
                                    <label for="editor" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fa-solid fa-align-left mr-1 text-teal-600"></i>商品描述
                                    </label>
                                    <textarea name="description" id="editor" style="width:100%;height:300px;">${product.description}</textarea>
                                    <p class="text-gray-500 text-sm mt-1"><i class="fa-solid fa-circle-info mr-1"></i>可填写：高度、冠幅、年份、养护方法等信息</p>
                                </div>

                            </div>

                            <%-- 表单提交按钮 --%>
                            <div class="bg-gray-50 px-6 py-4 border-t border-gray-200 flex justify-end">
                                <button type="submit" name="submit" 
                                        onclick="return confirm('确定要保存修改吗？');"
                                        class="inline-flex items-center px-6 py-3 bg-teal-600 border border-transparent rounded-xl font-semibold text-white uppercase tracking-widest hover:bg-teal-700 active:bg-teal-900 focus:outline-none focus:border-teal-900 focus:ring ring-teal-300 disabled:opacity-25 transition ease-in-out duration-150">
                                    <i class="fa-solid fa-floppy-disk mr-2"></i> 保存修改
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>

</body>
</html>
