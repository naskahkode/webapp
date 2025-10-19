<%-- Document : dashboard.jsp Created on : 17 Oct 2025, 14.07.27 Author : LRPC-01587 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ page import="com.app.model.User" %>
                <% User user=(User) session.getAttribute("user"); %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>data</title>
                        <jsp:include page="./components/_script.jsp" />
                    </head>

                    <body>
                        <c:import url="./components/_sidebar.jsp" />
                        <main id="content">
                            <c:import url="./components/_header.jsp" />
                            <div class="p-4 md:p-6 xl:p-12">
                                <div class="flex gap-x-10 justify-center">
                                    <div class="  text-sm xl:block w-full">
                                        <header class="space-y-2 mb-8">
                                            <h1 class="text-3xl font-semibold tracking-tight">Welcome <%= user !=null ?
                                                    user.getName() : "" %>
                                            </h1>
                                            <p class="text-muted-foreground">lorem ipsum</p>
                                        </header>
                                        <div class="grid gap-4 flex-1">
                                            <h1>ini secion 1</h1>
                                            <div class="card">
                                                <header>
                                                    <h2>Meeting Notes</h2>
                                                    <p>Transcript from the meeting with the client.</p>
                                                </header>
                                                <section class="text-sm">
                                                    <p>Client requested dashboard redesign with focus on mobile
                                                        responsiveness.</p>
                                                </section>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hidden text-sm xl:block w-full max-w-[200px]">
                                        <h1>ini secion 2</h1>
                                        <div class="card">
                                            <header>
                                                <h2>Meeting Notes</h2>
                                                <p>Transcript from the meeting with the client.</p>
                                            </header>
                                            <section class="text-sm">
                                                <p>Client requested dashboard redesign with focus on mobile
                                                    responsiveness.</p>
                                                <ol class="mt-4 flex list-decimal flex-col gap-2 pl-6">
                                                    <li>New analytics widgets for daily/weekly metrics</li>
                                                    <li>Simplified navigation menu</li>
                                                    <li>Dark mode support</li>
                                                    <li>Timeline: 6 weeks</li>
                                                    <li>Follow-up meeting scheduled for next Tuesday</li>
                                                </ol>
                                            </section>
                                            <footer class="flex items-center">
                                                <div
                                                    class="flex -space-x-2 [&_img]:ring-card [&_img]:ring-2 [&_img]:grayscale [&_img]:size-8 [&_img]:shrink-0 [&_img]:object-cover [&_img]:rounded-full">
                                                    <img alt="@hunvreus" src="https://github.com/hunvreus.png">
                                                    <img alt="@shadcn" src="https://github.com/shadcn.png">
                                                    <img alt="@adamwathan" src="https://github.com/adamwathan.png">
                                                </div>
                                            </footer>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <jsp:include page="./components/_footer.jsp" />
                        </main>
                    </body>

                    </html>