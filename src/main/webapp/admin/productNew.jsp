<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>增加商品</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700;900&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script language="javascript">
            $(function () {
                $("select#pic").change(function () {
                    var filename = $(this).val();
                    $("#img1").attr('src', '../upload/' + filename);
                });
            });
        </script>
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
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
        
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        
            .animate-fade-up {
                animation: fadeUp 0.5s ease-out both;
            }
        </style>
</head>
<body>
<%@ include file="header.jsp" %>
<table width="100%" height="600px" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td width="200px" valign="top" align="center" bgcolor="#e0e0e0">
            <%@ include file="sidebar.jsp" %>
        </td>
        <td bgcolor="#0e0e00e" valign='top'>
            <p style="color: red">${add_msg}</p>
            
            <form id='form1' name='form1' method='post' action='ProductNewServlet'>
                <h2>增加商品</h2>
                <table border="1" cellpadding="5">
                    <!-- 商品类别 -->
                    <tr>
                        <td>商品类别</td>
                        <td>
                            <select id="category" name="category" required="true">
                                <option value="">请选择...</option>
                                <option value="果树">果树</option>
                                <option value="非果树">非果树</option>
                            </select>
                            <font color="red">*</font>
                         </td>
                    </tr>
                    
                    <!-- 商品名称 -->
                    <tr>
                        <td>商品名称</td>
                        <td>
                            <input name="pName" type="text" id="pName" size="40" required="true"/>
                            <font color="red">*</font>
                         </td>
                    </tr>
                    
                    <!-- 商品价格 -->
                    <tr>
                        <td>商品价格</td>
                        <td>
                            <input name="price" type="text" id="price" size="40" required="true" number="true"/>
                            <font color="red">*</font>
                         </td>
                    </tr>
                    
                    <!-- 发货地 -->
                    <tr>
                        <td>发货地</td>
                        <td>
                            <input name="origin" type="text" id="origin" size="40" required="true" placeholder="例：浙江省嘉兴市"/>
                            <font color="red">*</font>
                         </td>
                    </tr>
                    
                    <!-- 库存数量 -->
                    <tr>
                        <td>库存数量</td>
                        <td>
                            <input name="stock" type="number" id="stock" size="40" value="0"/>
                         </td>
                    </tr>
                    
                    <!-- 商品图片 -->
                    <tr>
                        <td valign='top'>商品图片</td>
                        <td>
                            <select name='pImg' id='pic' required="true">
                                <option value="">请选择图片</option>
                                <c:forEach items="${images}" var="file" varStatus="s">
                                    <option value="${file}">${file}</option>
                                </c:forEach>
                            </select>
                            <font color="red">*</font> <br/>
                            <img id='img1' name='img1' width='100px' height='100px' src='#'/>
                         </td>
                    </tr>
                    
                    <!-- 商品详细描述 -->
                    <tr>
                        <td valign='top'>商品描述</td>
                        <td>
                            <textarea name="description" id="description" rows="10" cols="80" placeholder="可填写：高度、冠幅、年份、养护方法等信息"></textarea>
                         </td>
                    </tr>
                    
                    <!-- 提交按钮 -->
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" name="submit" value="增加商品" onclick="return confirm('确定要增加吗？');"/>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
</body>
</html>