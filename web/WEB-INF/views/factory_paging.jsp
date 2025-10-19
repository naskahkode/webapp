<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Pagination</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (pagination)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>
    <div class="mt-3">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/factory/edit?ref=paging">Add New</a>
    </div>

    <table class="table table-bordered table-striped mt-3">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Company</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${factories}" var="f">
            <tr>
                <td>${f.id}</td>
                <td>${f.name}</td>
                <td>${f.companyId}</td>
                <td>
                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/factory/edit?id=${f.id}&ref=paging">Edit</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/factory/delete?id=${f.id}" onclick="return confirm('Delete?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:set var="page" value="${page}" />
    <c:set var="size" value="${size}" />
    <c:set var="totalPages" value="${totalPages}" />
    <nav>
        <ul class="pagination">
            <li class="page-item ${page <= 1 ? 'disabled' : ''}"><a class="page-link" href="?p=${page-1}&size=${size}">Prev</a></li>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == page ? 'active' : ''}"><a class="page-link" href="?p=${i}&size=${size}">${i}</a></li>
            </c:forEach>
            <li class="page-item ${page >= totalPages ? 'disabled' : ''}"><a class="page-link" href="?p=${page+1}&size=${size}">Next</a></li>
        </ul>
    </nav>
</div>
</body>
</html>


