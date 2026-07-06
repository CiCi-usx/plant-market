<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员登录</title>
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

    <!-- 登录主体 -->
    <main class="flex-1 flex items-center justify-center px-4 py-12">
        <div class="w-full max-w-md animate-fade-up">

            <!-- 登录卡片 -->
            <div class="bg-teal-900/50 backdrop-blur-md border border-teal-800/50 rounded-2xl shadow-2xl shadow-teal-950/50 p-8 sm:p-10">

                <!-- 标题 -->
                <div class="text-center mb-8">
                    <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-teal-800/60 border border-teal-700/50 mb-4">
                        <i class="fa-solid fa-user-shield text-teal-400 text-2xl"></i>
                    </div>
                    <h1 class="text-2xl font-bold text-teal-100">管理员登录</h1>
                    <p class="text-teal-500 text-sm mt-1">请输入管理员账号和密码</p>
                </div>

                <!-- 错误提示 -->
                <%
                    String loginMsg = (String) request.getAttribute("login_msg");
                    if (loginMsg != null && !loginMsg.isEmpty()) {
                %>
                <div class="mb-6 bg-red-900/40 border border-red-700/40 rounded-lg px-4 py-3 text-sm text-red-300 flex items-center gap-2">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><%= loginMsg %></span>
                </div>
                <%
                    }
                %>

                <!-- 登录表单 -->
                <form id="login" name="login" method="post"
                      action="${pageContext.request.contextPath}/admin/AdminLoginServlet"
                      class="space-y-5">

                    <!-- 用户名 -->
                    <div>
                        <label for="adminName" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-regular fa-user mr-1.5 text-teal-500"></i>管理员账号 <span style="color: #f87171;">*</span>
                        </label>
                        <input type="text" id="adminName" name="adminName" required
                               value="${cookie.get('adminUname').value}"
                               placeholder="请输入管理员账号"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 密码 -->
                    <div>
                        <label for="adminPwd" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-solid fa-lock mr-1.5 text-teal-500"></i>密码 <span style="color: #f87171;">*</span>
                        </label>
                        <input type="password" id="adminPwd" name="adminPwd" required
                               value="${cookie.adminUpwd.value}"
                               placeholder="请输入密码"
                               class="w-full bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                      text-teal-100 placeholder-teal-600 text-sm
                                      focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                      transition-all duration-200">
                    </div>

                    <!-- 验证码 -->
                    <div>
                        <label for="verificationCode" class="block text-sm font-medium text-teal-300 mb-1.5">
                            <i class="fa-solid fa-shield-halved mr-1.5 text-teal-500"></i>验证码 <span style="color: #f87171;">*</span>
                        </label>
                        <div class="flex gap-3">
                            <input type="text" id="verificationCode" name="verifycode"
                                   class="captcha-input flex-1 bg-teal-950/80 border border-teal-700/60 rounded-lg px-4 py-2.5
                                          text-teal-100 placeholder-teal-600 text-sm
                                          focus:outline-none focus:border-teal-500 focus:ring-2 focus:ring-teal-500/30
                                          transition-all duration-200" 
                                   required placeholder="请输入验证码">
                            <img id="captchaImg" class="captcha-image cursor-pointer border border-teal-700/60 rounded-lg h-[42px] w-28 object-cover"
                                 src="${pageContext.request.contextPath}/CheckCodeServlet"
                                 alt="验证码" title="点击刷新验证码">
                        </div>
                    </div>

                    <!-- 按钮区域 -->
                    <div class="flex gap-3 pt-2">
                        <input type="submit" name="submit" value="立即登录"
                               class="flex-1 bg-teal-600 hover:bg-teal-700 text-white font-semibold py-2.5 px-4 rounded-lg
                                      transition-colors duration-200 cursor-pointer">
                        <input type="reset" name="reset" value="重置信息"
                               class="flex-1 bg-teal-800 hover:bg-teal-900 text-teal-100 font-semibold py-2.5 px-4 rounded-lg
                                      transition-colors duration-200 cursor-pointer border border-teal-700/60">
                    </div>
                </form>

                <!-- 底部链接 -->
                <div class="mt-6 text-center text-sm">
                    <a href="${pageContext.request.contextPath}/register.jsp" 
                       class="text-teal-400 hover:text-teal-200 transition-colors duration-200">
                        <i class="fa-solid fa-user-plus mr-1"></i>普通用户注册
                    </a>
                </div>
            </div>
            
            <!-- 安全提示 -->
            <div class="mt-6 text-center text-xs text-teal-600">
                <p><i class="fa-solid fa-shield-halved mr-1"></i>管理员登录入口</p>
            </div>
        </div>
    </main>

    <script>
        // 验证码刷新
        document.getElementById("captchaImg").addEventListener("click", function() {
            this.src = "${pageContext.request.contextPath}/CheckCodeServlet?time=" + new Date().getTime();
        });
    </script>
</body>
</html>
