<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/basecoat-css@0.3.2/dist/basecoat.cdn.min.css">
        <script src="https://cdn.jsdelivr.net/npm/basecoat-css@0.3.2/dist/js/all.min.js" defer></script> -->

        <!-- ini kalo pake toast -->
        <c:if test="${not empty sessionScope.flash_success}">
            <div id="toaster" class="toaster">
                <div class="toast" role="status" aria-atomic="true" aria-hidden="false" data-category="success">
                    <div class="toast-content">
                        <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10" />
                            <path d="m9 12 2 2 4-4" />
                        </svg>
                        <section>
                            <h2>Success</h2>
                            <p>${sessionScope.flash_success}</p>
                            <c:remove var="flash_success" scope="session" />

                        </section>
                        <footer>
                            <button type="button" class="btn" data-toast-action>Dismiss</button>
                        </footer>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- ini kalo alrtt biasa -->
        <c:if test="${not empty sessionScope.flash_error}">
            <div class="alert-destructive">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10" />
                    <line x1="12" x2="12" y1="8" y2="12" />
                    <line x1="12" x2="12.01" y1="16" y2="16" />
                </svg>
                <h2>Something went wrong!</h2>
                <section> ${sessionScope.flash_error} </section>
                <c:remove var="flash_error" scope="session" />
            </div>
        </c:if>