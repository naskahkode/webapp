<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="card-title">Terjadi Kesalahan</h5>
            <p class="text-muted">${requestURI}</p>
            <div class="mb-2"><strong>Context:</strong> ${errorMessage}</div>
            <div class="mb-2"><strong>Type:</strong> ${errorType}</div>
            <div class="mb-2"><strong>Detail:</strong> ${errorDetail}</div>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/dashboard">Back</a>
        </div>
    </div>
</div>
</body>
</html>


