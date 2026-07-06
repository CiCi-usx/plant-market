<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>删除图片 - 管理后台 - 苗木网</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
        .animate-fade-up { animation: fadeUp 0.5s ease-out both; }
    </style>
</head>

<body class="bg-teal-950 text-teal-50 min-h-screen font-sans">

    <%-- ====== 整体布局 ====== --%>
    <div class="flex min-h-screen">

        <%-- 左侧边栏 --%>
        <aside class="w-60 shrink-0 bg-teal-900/50 border-r border-teal-800/50
                      flex flex-col fixed top-0 left-0 h-full z-40">
            <%@ include file="sidebar.jsp" %>
        </aside>

        <%-- 右侧主体 --%>
        <div class="flex-1 ml-60 flex flex-col min-h-screen">

            <%-- 顶部栏 --%>
            <%@ include file="header.jsp" %>

            <%-- 内容区 --%>
            <main class="flex-1 p-8">
                <div class="max-w-3xl mx-auto space-y-6">

                    <%-- 页面标题 --%>
                    <div class="animate-fade-up" style="animation-delay:0.05s">
                        <div class="flex items-center gap-3">
                            <div class="w-1 h-7 bg-red-400 rounded-full"></div>
                            <h1 class="text-xl font-bold text-teal-100">删除商品图片</h1>
                        </div>
                        <div class="flex items-center gap-2 text-sm text-teal-500 mt-2 ml-4">
                            <a href="${pageContext.request.contextPath}/admin/index.jsp"
                               class="hover:text-teal-300 transition-colors">管理后台</a>
                            <i class="fa-solid fa-chevron-right text-[10px] text-teal-700"></i>
                            <span class="text-teal-300">删除图片</span>
                        </div>
                    </div>

                    <%-- 初始化文件列表 --%>
                    <%
                        String pathStr = request.getServletContext().getRealPath("/upload");
                        request.setAttribute("pathStr", pathStr);
                    %>
                    <jsp:useBean id="fileBean" class="domain.Images" scope="page" />
                    <jsp:setProperty name="fileBean" property="path" value="${pathStr}" />

                    <%-- 主卡片 --%>
                    <div class="animate-fade-up bg-teal-900/40 border border-teal-800/40 rounded-2xl
                                overflow-hidden" style="animation-delay:0.1s">

                        <%-- 图片预览区 --%>
                        <div class="p-6 border-b border-teal-800/40">
                            <p class="text-xs text-teal-600 font-bold uppercase tracking-widest mb-3">
                                <i class="fa-solid fa-eye mr-1"></i>图片预览
                            </p>
                            <div id="preview-container"
                                 class="w-full aspect-video bg-teal-950/60 rounded-xl border-2 border-dashed
                                        border-teal-800/50 flex items-center justify-center overflow-hidden">
                                <div id="preview-placeholder" class="text-center">
                                    <i class="fa-regular fa-image text-4xl text-teal-800 mb-2"></i>
                                    <p class="text-sm text-teal-700">请从下方选择图片以预览</p>
                                </div>
                                <img id="img1" name="img1" src="#"
                                     class="hidden w-full h-full object-contain p-2" />
                            </div>
                        </div>

                        <%-- 操作区 --%>
                        <div class="p-6">
                            <form id="form1" name="form1" method="post"
                                  action="${pageContext.request.contextPath}/admin/DeletePicServlet">

                                <%-- 选择图片 --%>
                                <div class="mb-5">
                                    <label for="pic"
                                           class="block text-sm font-medium text-teal-300 mb-2">
                                        <i class="fa-regular fa-folder-open mr-1"></i>选择要删除的图片
                                    </label>
                                    <select name="pic" id="pic"
                                            class="w-full bg-teal-950/80 border border-teal-700/50
                                                   rounded-xl px-4 py-3 text-sm text-teal-100
                                                   focus:outline-none focus:border-teal-500
                                                   focus:ring-2 focus:ring-teal-500/30
                                                   transition-all duration-200 appearance-none
                                                   cursor-pointer">
                                        <option value="">— 请选择图片 —</option>
                                        <c:forEach items="${fileBean.files}" var="file">
                                            <option value="${file}">${file}</option>
                                        </c:forEach>
                                    </select>
                                    <c:if test="${empty fileBean.files}">
                                        <p class="text-xs text-teal-600 mt-2">
                                            <i class="fa-solid fa-circle-info mr-1"></i>当前没有可删除的图片
                                        </p>
                                    </c:if>
                                </div>

                                <%-- 提交按钮 --%>
                                <button type="submit"
                                        class="w-full bg-red-900/60 hover:bg-red-800/60 active:bg-red-900
                                               border border-red-700/50 hover:border-red-600/50
                                               text-red-300 hover:text-red-100 font-bold
                                               py-3 rounded-xl text-sm
                                               transition-all duration-200
                                               flex items-center justify-center gap-2"
                                        onclick="return confirm('确定要删除这张图片吗？此操作不可撤销！');">
                                    <i class="fa-regular fa-trash-can"></i>确认删除
                                </button>
                            </form>

                            <%-- 操作反馈 --%>
                            <c:if test="${not empty delete_msg}">
                                <div class="mt-4 flex items-center gap-2 bg-red-900/20 border border-red-800/30
                                            rounded-lg px-4 py-3 text-sm text-red-400">
                                    <i class="fa-solid fa-circle-exclamation"></i>
                                    <span>${delete_msg}</span>
                                </div>
                            </c:if>
                        </div>

                    </div><%-- /主卡片 --%>

                </div>
            </main>

        </div><%-- /右侧主体 --%>

    </div><%-- /整体布局 --%>

    <%-- 图片预览切换逻辑 --%>
    <script>
        $(function () {
            $("#pic").change(function () {
                var filename = $(this).val();
                if (filename) {
                    $("#img1").attr("src", "${pageContext.request.contextPath}/upload/" + filename)
                             .removeClass("hidden");
                    $("#preview-placeholder").addClass("hidden");
                } else {
                    $("#img1").attr("src", "#").addClass("hidden");
                    $("#preview-placeholder").removeClass("hidden");
                }
            });
        });
    </script>

</body>
</html>
