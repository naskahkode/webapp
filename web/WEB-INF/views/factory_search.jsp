<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Search</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (search)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>

    <form class="row g-2 mt-3" method="get" action="${pageContext.request.contextPath}/factory/search">
        <div class="col-md-4">
            <input type="text" class="form-control" name="q" placeholder="Search by name" value="${q}" />
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100" type="submit">Search</button>
        </div>
        <div class="col-md-2">
            <a class="btn btn-outline-secondary w-100" href="${pageContext.request.contextPath}/factory/search">Reset</a>
        </div>
        <div class="col-md-4 text-end">
            <a class="btn btn-success" href="${pageContext.request.contextPath}/factory/edit?ref=search">Add New</a>
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
                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/factory/edit?id=${f.id}&ref=search">Edit</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/factory/delete?id=${f.id}" onclick="return confirm('Delete?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>


