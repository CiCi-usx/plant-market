<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>苗木网 - 注册</title>
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
        .animate-fade-up {
            animation: fadeUp 0.5s ease-out both;
        }
    </style>
</head>

<body class="bg-teal-950 text-teal-50 min-h-screen font-sans flex flex-col">

    <!-- 顶部栏（与 login 一致） -->
    <div class="bg-teal-950/90 backdrop-blur-md border-b border-teal-800/60 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 h-10 flex items-center justify-between text-sm">
            <div class="flex gap-4 ml-auto">
                <a href="${pageContext.request.contextPath}/login.jsp"
                   class="text-teal-400 hover:text-teal-200 transition-colors duration-200">
                    <i class="fa-solid fa-arrow-right-to-bracket mr-1"></i>登录
                </a>
                <a href="${pageContext.request.contextPath}/register.jsp"
                   class="text-teal-200 border-b border-teal-400 pb-0.5 transition-colors duration-200">
                    <i class="fa-regular fa-registered mr-1"></i>注册
                </a>
            </div>
        </div>
    </div>

    <!-- Logo 栏（与 login 一致） -->
    <header class="bg-teal-900/70 backdrop-blur-md border-b border-teal-800/50">
        <div class="max-w-7xl mx-auto px-4 py-4 flex items-center">
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="text-2xl font-black tracking-wide text-teal-300 hover:text-teal-200 transition-colors">
                <i class="fa-solid fa-seedling mr-2 text-teal-400"></i>苗木网
            </a>
        </div>
    </header>

    <!-- 注册主体 -->
    <main class="flex-1 flex items-center justify-center px-4 py-12">
        <div class="w-full max-w-md animate-fade-up">

            <!-- 注册卡片 -->
            <div class="bg-teal-900/50 backdrop-blur-md border border-teal-800/50 rounded-2xl shadow-2xl shadow-teal-950/50 p-8 sm:p-10">

                <!-- 标题 -->
                <div class="text-center mb-8">
                    <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-teal-800/60 border border-teal-700/50 mb-4">
                        <i class="fa-solid fa-user-plus text-teal-400 text-2xl"></i>
                    </div>
                    <h1 class="text-2xl font-bold text-teal-100">创建账号</h1>
                    <p class="text-teal-500 text-sm mt-1">欢迎加入苗木网</p>
                </div>

                <!-- 错误消息 -->
                <c:if test="${not empty errorMsg}">
                    <div class="mb-6 bg-red-900/40 border border-red-700/40 rounded-lg px-4 py-3 text-sm text-red-300 flex items-center gap-2">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span>${errorMsg}</span>
                    </div>
                </c:if>

                <!-- 注册表单 -->
                <form id="register" name="register" method="post" action="${pageContext.request.contextPath}/AddUserServlet"
                      class="space-y-5">

                    <!-- 用户名 -->
                    <div>
                        <label for="uname" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-regular fa-user mr-1.5 text-teal-500"></i>用户名 <span class="text-red-400">*</span>
                        </label>
                        <input name="uname" id="uname" type="text" required maxlength="30"
                               placeholder="请输入用户名"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                        <p class="text-teal-600 text-xs mt-1.5">
                            <i class="fa-solid fa-circle-info mr-1"></i>用户名长度不超过30个字符
                        </p>
                    </div>

                    <!-- 密码 -->
                    <div>
                        <label for="upwd" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-solid fa-lock mr-1.5 text-teal-500"></i>密码 <span class="text-red-400">*</span>
                        </label>
                        <input name="upwd" id="upwd" type="password" required maxlength="50"
                               placeholder="请输入密码"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 确认密码 -->
                    <div>
                        <label for="confirmPwd" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-solid fa-lock mr-1.5 text-teal-500"></i>确认密码 <span class="text-red-400">*</span>
                        </label>
                        <input name="confirmPwd" id="confirmPwd" type="password" required
                               placeholder="请再次输入密码"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 性别 -->
                    <div>
                        <label class="block text-sm font-medium text-teal-300 mb-2">
                            <i class="fa-solid fa-venus-mars mr-1.5 text-teal-500"></i>性别
                        </label>
                        <div class="flex gap-6">
                            <label class="flex items-center gap-2 cursor-pointer group">
                                <input type="radio" name="usex" value="男" checked
                                       class="w-4 h-4 text-teal-500 bg-teal-950/80 border-teal-700/60
                                              focus:ring-teal-500/30 focus:ring-2">
                                <span class="text-sm text-teal-200 group-hover:text-teal-100 transition-colors">男</span>
                            </label>
                            <label class="flex items-center gap-2 cursor-pointer group">
                                <input type="radio" name="usex" value="女"
                                       class="w-4 h-4 text-teal-500 bg-teal-950/80 border-teal-700/60
                                              focus:ring-teal-500/30 focus:ring-2">
                                <span class="text-sm text-teal-200 group-hover:text-teal-100 transition-colors">女</span>
                            </label>
                        </div>
                    </div>

                    <!-- 电子邮箱 -->
                    <div>
                        <label for="uemail" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-regular fa-envelope mr-1.5 text-teal-500"></i>电子邮箱
                        </label>
                        <input name="uemail" id="uemail" type="email" maxlength="50"
                               placeholder="example@domain.com"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 联系电话 -->
                    <div>
                        <label for="phone" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-solid fa-phone mr-1.5 text-teal-500"></i>联系电话
                        </label>
                        <input name="phone" id="phone" type="tel" maxlength="60"
                               placeholder="请输入手机号码"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 联系地址 -->
                    <div>
                        <label for="address" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-solid fa-location-dot mr-1.5 text-teal-500"></i>联系地址
                        </label>
                        <input name="address" id="address" type="text" maxlength="250"
                               placeholder="请输入详细地址"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 按钮区 -->
                    <div class="flex gap-3 pt-2">
                        <button type="submit"
                                class="flex-1 bg-teal-600 hover:bg-teal-500 text-white px-5 py-2.5 rounded-lg text-sm
                                       font-medium transition-colors duration-200
                                       focus:outline-none focus:ring-2 focus:ring-teal-500/30">
                            <i class="fa-solid fa-user-plus mr-1.5"></i>立即注册
                        </button>
                        <button type="reset"
                                class="bg-teal-800/60 hover:bg-teal-700 border border-teal-700/50
                                       text-teal-300 hover:text-teal-100
                                       px-5 py-2.5 rounded-lg text-sm font-medium transition-all duration-200
                                       focus:outline-none focus:ring-2 focus:ring-teal-500/30">
                            <i class="fa-solid fa-rotate-left mr-1.5"></i>重置
                        </button>
                    </div>
                </form>

                <!-- 底部链接 -->
                <div class="mt-6 pt-5 border-t border-teal-800/50 text-center">
                    <span class="text-teal-500 text-sm">已有账号？</span>
                    <a href="${pageContext.request.contextPath}/login.jsp"
                       class="text-teal-400 hover:text-teal-200 text-sm font-medium transition-colors duration-200 ml-1">
                        立即登录 <i class="fa-solid fa-arrow-right ml-0.5 text-xs"></i>
                    </a>
                </div>
            </div>

            <!-- 返回首页 -->
            <div class="text-center mt-6">
                <a href="${pageContext.request.contextPath}/index.jsp"
                   class="text-teal-500 hover:text-teal-300 text-sm transition-colors duration-200">
                    <i class="fa-solid fa-arrow-left mr-1"></i>返回首页
                </a>
            </div>
        </div>
    </main>

    <!-- 页脚 -->
    <footer class="bg-teal-950 border-t border-teal-800/50">
        <div class="max-w-7xl mx-auto px-4 py-6 text-center text-teal-600 text-sm">
            <p><i class="fa-solid fa-seedling mr-1"></i> 苗木网 &copy; 2026</p>
        </div>
    </footer>

</body>

<script>
    // 前端验证密码是否一致
    document.getElementById("register").addEventListener("submit", function(event) {
        var pwd = document.getElementById("upwd").value;
        var confirmPwd = document.getElementById("confirmPwd").value;
        if (pwd !== confirmPwd) {
            event.preventDefault();
            // 用内联提示代替 alert，风格更统一
            var existing = document.getElementById("pwdMismatchMsg");
            if (existing) existing.remove();

            var msg = document.createElement("div");
            msg.id = "pwdMismatchMsg";
            msg.className = "mb-6 bg-red-900/40 border border-red-700/40 rounded-lg px-4 py-3 text-sm text-red-300 flex items-center gap-2";
            msg.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i><span>两次输入的密码不一致！</span>';
            this.insertBefore(msg, this.firstChild);
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    });
</script>

</html>
