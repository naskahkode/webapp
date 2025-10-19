<%-- WEB-INF/layouts/dashboard.jsp --%>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ page import="com.app.model.User" %>
            <% User user=(User) session.getAttribute("user"); %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>${pageTitle != null ? pageTitle : 'Dashboard'} - Aplikasi</title>
                    <jsp:include page="/WEB-INF/views/components/_script.jsp" />
                </head>

                <body>
                    <main id="content">
                        <div class="p-4 md:p-6 xl:p-12">
                            <div class="max-w-screen-lg mx-auto">
                                <header class="flex flex-col gap-4">
                                    <div class="flex flex-col gap-2">
                                        <h1 class="text-2xl font-bold tracking-tight sm:text-3xl md:text-4xl">All of the
                                            shadcn/ui
                                            magic, none
                                            of the React</h1>
                                        <p class="sm:text-lg text-muted-foreground">A components library built with
                                            Tailwind CSS
                                            that works with
                                            any web stack.</p>
                                    </div>
                                    <div class="flex w-full items-center justify-start gap-2 pt-2">
                                        <% if (user !=null && user.getRoleId() !=null) { %>
                                            <a class="btn-outline"
                                                href="${pageContext.request.contextPath}/dashboard">Goto
                                                Dashboard Page</a>
                                            <% } else { %>
                                                <a class="btn" href="${pageContext.request.contextPath}/auth/login">Goto
                                                    Login
                                                    Page</a>
                                                <% }%>
                                    </div>
                                </header>
                            </div>
                        </div>
                        <div class="p-4 md:p-6 xl:p-12">
                            <jsp:include page="${contentPage}" />
                        </div>
                    </main>
                    <div id="toaster" class="toaster ">
                    </div>
                </body>

                </html>