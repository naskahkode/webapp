<%--
   Document   : login.jsp
   Created on : 17 Oct 2025, 13.53.27
   Author     : LRPC-01587
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <c:import url="./components/_script.jsp" />  
    </head>
    <body>
    <body>
        <div style=" display: flex; justify-content: center;  align-items: center;  height: 100vh;  ">
            <div style="max-width: 400px; width: 100%;">
                <div class="container">
                    <div class="card w-full">
                        <header>
                            <h2>Login to your account</h2>
                            <p>Enter your details below to login to your account dd</p>
                        </header>
                        <section> 
                            <form class="form" method="post" action="${pageContext.request.contextPath}/auth/login">
                                <div class="grid gap-2">
                                    <label>Username</label>
                                    <input type="text" name="username" required value="${fn:escapeXml(param.username) != null ? fn:escapeXml(param.username) : (prevUsername != null ? fn:escapeXml(prevUsername) : '')}">
                                </div>
                                <div class="grid gap-2 mt-4">
                                    <div class="flex items-center gap-2">
                                        <label for="demo-card-form-password ">Password</label>
                                    </div>
                                    <input type="password" id="demo-card-form-password" name="password">
                                </div>
                                <footer  class="flex flex-col items-center gap-2 mt-4">
                                    <c:if test="${not empty error}">
                                        <div class="alert-destructive mb-4">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z" /><path d="M12 8v4" /><path d="M12 16h.01" /></svg>
                                            <h2>Warning! ${error}</h2>
                                        </div>
                                    </c:if>
                                    <!--<div class="text-danger mt-2">${error}</div>-->
                                    <button class="btn w-full" type="submit">Login</button>
                                    <p class="mt-4 text-center text-sm">Forgot your password?
                                        <a href="#" class="underline-offset-4 hover:underline">Reset here</a><br>  or Goto 
                                        <a href="${pageContext.request.contextPath}/" class="underline-offset-4 hover:underline">Homepage</a>  
                                    </p>

                                </footer >
                            </form>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </body>
</body>
</html>

