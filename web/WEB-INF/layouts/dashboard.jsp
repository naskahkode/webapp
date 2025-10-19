<%-- WEB-INF/layouts/dashboard.jsp --%>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${pageTitle != null ? pageTitle : 'Dashboard'} - Aplikasi</title>
        <jsp:include page="/WEB-INF/views/components/_script.jsp" />
    </head>

    <body>
        <jsp:include page="/WEB-INF/views/components/_sidebar.jsp" />
        <main id="content">
            <jsp:include page="/WEB-INF/views/components/_header.jsp" />
            <div class="p-4 md:p-6 xl:p-12">
                <jsp:include page="${contentPage}" />
            </div>
        </main>
        <jsp:include page="/WEB-INF/views/components/_footer.jsp" />
        <div id="toaster" class="toaster ">
        </div>
    </body>

    </html>