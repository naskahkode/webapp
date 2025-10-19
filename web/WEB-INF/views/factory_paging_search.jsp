<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Pagination + Search</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (pagination + search)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>

    <form class="row g-2 mt-3" method="get" action="${pageContext.request.contextPath}/factory/paging-search">
        <div class="col-md-4">
            <input type="text" class="form-control" name="q" placeholder="Search by name" value="${q}" />
        </div>
        <div class="col-md-2">
            <select class="form-select" name="size">
                <option value="5" ${size == 5 ? 'selected' : ''}>5</option>
                <option value="10" ${size == 10 ? 'selected' : ''}>10</option>
                <option value="20" ${size == 20 ? 'selected' : ''}>20</option>
            </select>
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" type="submit">Apply</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/factory/paging-search">Reset</a>
        </div>
        <div class="col-md-3 text-end">
            <a class="btn btn-success" href="${pageContext.request.contextPath}/factory/edit?ref=paging-search">Add New</a>
        </div>
    </form>

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
                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/factory/edit?id=${f.id}&ref=paging-search">Edit</a>
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
            <li class="page-item ${page <= 1 ? 'disabled' : ''}">
                <a class="page-link" href="?q=${q}&p=${page-1}&size=${size}">Prev</a>
            </li>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == page ? 'active' : ''}">
                    <a class="page-link" href="?q=${q}&p=${i}&size=${size}">${i}</a>
                </li>
            </c:forEach>
            <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
                <a class="page-link" href="?q=${q}&p=${page+1}&size=${size}">Next</a>
            </li>
        </ul>
    </nav>
</div>
</body>
</html>


