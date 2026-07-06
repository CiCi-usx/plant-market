<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>上传图片 - 管理后台 - 苗木网</title>
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
                            <div class="w-1 h-7 bg-purple-400 rounded-full"></div>
                            <h1 class="text-xl font-bold text-teal-100">上传商品图片</h1>
                        </div>
                        <div class="flex items-center gap-2 text-sm text-teal-500 mt-2 ml-4">
                            <a href="${pageContext.request.contextPath}/admin/index.jsp"
                               class="hover:text-teal-300 transition-colors">管理后台</a>
                            <i class="fa-solid fa-chevron-right text-[10px] text-teal-700"></i>
                            <span class="text-teal-300">上传图片</span>
                        </div>
                    </div>

                    <%-- 主卡片 --%>
                    <div class="animate-fade-up bg-teal-900/40 border border-teal-800/40 rounded-2xl
                                overflow-hidden" style="animation-delay:0.1s">

                        <form action="${pageContext.request.contextPath}/UploadImageServlet"
                              method="post" enctype="multipart/form-data">

                            <%-- 图片简介 --%>
                            <div class="p-6 border-b border-teal-800/40">
                                <label for="desc"
                                       class="block text-sm font-medium text-teal-300 mb-2">
                                    <i class="fa-solid fa-tag mr-1"></i>图片简介
                                </label>
                                <input type="text" name="desc" id="desc" placeholder="例如：红富士苹果苗"
                                       class="w-full bg-teal-950/80 border border-teal-700/50
                                              rounded-xl px-4 py-3 text-sm text-teal-100
                                              placeholder-teal-600
                                              focus:outline-none focus:border-teal-500
                                              focus:ring-2 focus:ring-teal-500/30
                                              transition-all duration-200" />
                            </div>

                            <%-- 文件上传区 --%>
                            <div class="p-6 border-b border-teal-800/40">
                                <label class="block text-sm font-medium text-teal-300 mb-2">
                                    <i class="fa-solid fa-file-image mr-1"></i>选择图片文件
                                </label>
                                <div id="drop-zone"
                                     class="relative w-full aspect-video bg-teal-950/60
                                            border-2 border-dashed border-teal-700/50
                                            rounded-xl flex flex-col items-center justify-center
                                            cursor-pointer hover:border-teal-500/50 hover:bg-teal-950/80
                                            transition-all duration-200 overflow-hidden">
                                    <div id="upload-placeholder" class="text-center">
                                        <i class="fa-solid fa-cloud-arrow-up text-4xl text-teal-700 mb-3"></i>
                                        <p class="text-sm text-teal-500 mb-1">点击选择图片或拖拽到此处</p>
                                        <p class="text-xs text-teal-700">支持 JPG / PNG / GIF 格式</p>
                                    </div>
                                    <img id="upload-preview" src="#"
                                         class="hidden w-full h-full object-contain p-2" />
                                    <input type="file" name="file" id="file" accept="image/*"
                                           class="absolute inset-0 w-full h-full opacity-0 cursor-pointer" />
                                </div>
                                <p id="file-name" class="text-xs text-teal-600 mt-2 truncate"></p>
                            </div>

                            <%-- 提交按钮 --%>
                            <div class="p-6">
                                <button type="submit"
                                        class="w-full bg-teal-600 hover:bg-teal-500 active:bg-teal-700
                                               text-white font-bold py-3.5 rounded-xl text-sm
                                               shadow-lg shadow-teal-600/20 hover:shadow-teal-500/30
                                               transition-all duration-200
                                               flex items-center justify-center gap-2">
                                    <i class="fa-solid fa-cloud-arrow-up"></i>开始上传
                                </button>
                            </div>

                        </form>

                        <%-- 操作反馈 --%>
                        <c:if test="${not empty upload_msg}">
                            <div class="mx-6 mb-6 flex items-center gap-2 bg-blue-900/20 border border-blue-800/30
                                        rounded-lg px-4 py-3 text-sm text-blue-400">
                                <i class="fa-solid fa-circle-info"></i>
                                <span>${upload_msg}</span>
                            </div>
                        </c:if>

                    </div><%-- /主卡片 --%>

                </div>
            </main>

        </div><%-- /右侧主体 --%>

    </div><%-- /整体布局 --%>

    <%-- 文件选择预览逻辑 --%>
    <script>
        const fileInput = document.getElementById('file');
        const preview   = document.getElementById('upload-preview');
        const placeholder = document.getElementById('upload-placeholder');
        const fileNameEl = document.getElementById('file-name');

        fileInput.addEventListener('change', function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.attr ? null : null;
                    preview.src = e.target.result;
                    preview.classList.remove('hidden');
                    placeholder.classList.add('hidden');
                };
                reader.readAsDataURL(file);
                fileNameEl.textContent = '📄 ' + file.name;
            } else {
                preview.src = '#';
                preview.classList.add('hidden');
                placeholder.classList.remove('hidden');
                fileNameEl.textContent = '';
            }
        });
    </script>

</body>
</html>
