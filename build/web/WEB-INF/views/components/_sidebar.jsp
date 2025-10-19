<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<aside id="sidebar" class="sidebar " data-side="left" aria-hidden="false">
    <nav aria-label="Sidebar navigation">
        <header> <a href="${pageContext.request.contextPath}/dashboard" class="btn-ghost p-2 h-12 w-full justify-start">
                <div
                    class="bg-sidebar-primary text-sidebar-primary-foreground flex aspect-square size-8 items-center justify-center rounded-lg">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" class="h-4 w-4">
                        <rect width="256" height="256" fill="none"></rect>
                        <line x1="208" y1="128" x2="128" y2="208" fill="none" stroke="currentColor"
                              stroke-linecap="round" stroke-linejoin="round" stroke-width="32"></line>
                        <line x1="192" y1="40" x2="40" y2="192" fill="none" stroke="currentColor"
                              stroke-linecap="round" stroke-linejoin="round" stroke-width="32"></line>
                    </svg> 
                    <!--<image src="${pageContext.request.contextPath}/images/avatar.png" class="rounded"/>-->
                </div>
                <div class="grid flex-1 text-left text-sm leading-tight">
                    <c:choose>
                        <c:when test="${not empty sessionScope.AUTH_USER}">
                            <span
                                class="truncate font-medium">${fn:escapeXml(sessionScope.AUTH_USER.name)}</span>
                            <span class="truncate text-xs">${fn:escapeXml(sessionScope.AUTH_USER.email)}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="truncate font-medium">@faizalanwar</span>
                            <span class="truncate text-xs">v0.0.1</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </a> </header>
        <section class="scrollbar">
            <div role="group" aria-labelledby="group-label-sidebar-content-1">
                <h3 id="group-label-sidebar-content-1">Getting started</h3>
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML">
                           <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-presentation-icon lucide-presentation"><path d="M2 3h20"/><path d="M21 3v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V3"/><path d="m7 21 5-5 5 5"/></svg>-->
                            <span>Homepage</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/dashboard" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML"> 
                          <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-kanban-icon lucide-square-kanban"><rect width="18" height="18" x="3" y="3" rx="2"/><path d="M8 7v7"/><path d="M12 7v4"/><path d="M16 7v9"/></svg>-->
                          <span>Dashboard</span>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- Sidebar Group -->
            <div role="group" aria-labelledby="group-label-sidebar-content-2">
                <h3 id="group-label-sidebar-content-2">Pages</h3>
                <ul class="nav-list"> 
                    <li>
                        <a href="negara" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML">
                            <span>CRUD ABCD</span>
                        </a>
                    </li> 
                </ul>
            </div>
            <div role="group" aria-labelledby="group-label-sidebar-content-2">
                <h3 id="group-label-sidebar-content-2 mt-4">Administrator</h3>
                <ul class="nav-list">
                    <li>
                        <a href="${pageContext.request.contextPath}/company"  hx-boost="true"  hx-select="#content"  hx-target="#content" hx-swap="outerHTML"
                        >
                            <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-factory-icon lucide-factory"><path d="M12 16h.01"/><path d="M16 16h.01"/><path d="M3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V8.5a.5.5 0 0 0-.769-.422l-4.462 2.844A.5.5 0 0 1 15 10.5v-2a.5.5 0 0 0-.769-.422L9.77 10.922A.5.5 0 0 1 9 10.5V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2z"/><path d="M8 16h.01"/></svg>-->
                            <span>Company</span>
                            <!--<span class="badge-destructive">restricted</span>-->
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/factory" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML"> 
                            <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-building2-icon lucide-building-2"><path d="M10 12h4"/><path d="M10 8h4"/><path d="M14 21v-3a2 2 0 0 0-4 0v3"/><path d="M6 10H4a2 2 0 0 0-2 2v7a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-2"/><path d="M6 21V5a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v16"/></svg>-->
                            <span>Factory</span>
                        </a>
                    </li> 
                    <li>
                        <a href="${pageContext.request.contextPath}/department" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML">
                            <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hotel-icon lucide-hotel"><path d="M10 22v-6.57"/><path d="M12 11h.01"/><path d="M12 7h.01"/><path d="M14 15.43V22"/><path d="M15 16a5 5 0 0 0-6 0"/><path d="M16 11h.01"/><path d="M16 7h.01"/><path d="M8 11h.01"/><path d="M8 7h.01"/><rect x="4" y="2" width="16" height="20" rx="2"/></svg>-->
                            <span>Department</span>
                        </a>
                    </li> 
                    <li>
                        <a href="${pageContext.request.contextPath}/division" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML">
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-blocks-icon lucide-blocks"><path d="M10 22V7a1 1 0 0 0-1-1H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-5a1 1 0 0 0-1-1H2"/><rect x="14" y="2" width="8" height="8" rx="1"/></svg>
                            <span>Division</span>
                        </a>
                    </li> 
                    <li>
                        <a href="${pageContext.request.contextPath}/user" hx-boost="true" hx-select="#content" hx-target="#content"
                           hx-swap="outerHTML">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-users-icon lucide-users"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><path d="M16 3.128a4 4 0 0 1 0 7.744"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><circle cx="9" cy="7" r="4"/></svg>
                            <span>Users</span>
                        </a>
                    </li>
                </ul>
            </div>

        </section>
        <footer>
            <div id="popover-749863" class="popover ">
                <button id="popover-749863-trigger" type="button" aria-expanded="false"
                        aria-controls="popover-749863-popover"
                        class="btn-ghost p-2 h-12 w-full flex items-center justify-start"
                        data-keep-mobile-sidebar-open="">
                    <img src="${pageContext.request.contextPath}/images/avatar.png" alt="Avatar" 
                                                      class="rounded-lg shrink-0 size-8">
                        <div class="grid flex-1 text-left text-sm leading-tight">
                            <c:choose>
                                <c:when test="${not empty sessionScope.AUTH_USER}">
                                    <span
                                        class="truncate font-medium">${fn:escapeXml(sessionScope.AUTH_USER.name)}</span>
                                    <span
                                        class="truncate text-xs">${fn:escapeXml(sessionScope.AUTH_USER.email)}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="truncate font-medium">sdfdsf</span>
                                    <span class="truncate text-xs">@sdf</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                             fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                             stroke-linejoin="round">
                            <path d="m7 15 5 5 5-5" />
                            <path d="m7 9 5-5 5 5" />
                        </svg>
                </button>
                <div id="popover-749863-popover" data-popover aria-hidden="true" data-side="top"
                     class="w-[271px] md:w-[239px]">
                    <div class="grid gap-4">
                        <header class="grid gap-1.5">
                            <h2 class="font-semibold">I hope you like Basecoat...</h2>
                            <p class="text-muted-foreground text-sm">My name is <a
                                    href="https://ronanberder.com" target="_blank">Ronan</a> and I made this
                                (and <a class="underline underline-offset-4" href="https://pagescms.org"
                                        target="_target">other things</a>). If you find it useful, please
                                consider sponsoring me on GitHub or following me on X.</p>
                        </header>
                        <footer class="grid gap-2">
                            <a href="https://github.com/sponsors/hunvreus" class="btn-sm"
                               target="_blank">Sponsor me on GitHub</a>
                            <a href="https://x.com/hunvreus" class="btn-sm-outline" target="_blank">Follow me on
                                X</a>
                                <c:if test="${not empty sessionScope.AUTH_USER}">
                                <a href="${pageContext.request.contextPath}/auth/logout" class="btn-sm btn-ghost"
                                   role="button">Logout</a>
                            </c:if>
                        </footer>
                    </div>
                </div>
            </div>
        </footer>
    </nav>
</aside>