<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Factory - Import/Export</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (import/export)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>
    <div class="mt-4">
        <a class="btn btn-success" href="${pageContext.request.contextPath}/factory/export">Export CSV</a>
    </div>
    <div class="mt-4">
        <form method="post" action="${pageContext.request.contextPath}/factory/import">
            <div class="mb-3">
                <label class="form-label">Import CSV (name,company_id per baris)</label>
                <textarea class="form-control" name="csv" rows="8" placeholder="Plant A,1&#10;Plant B,2"></textarea>
            </div>
            <button class="btn btn-primary" type="submit">Import</button>
        </form>
    </div>

    <table class="table table-bordered table-striped mt-4">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Company</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${factories}" var="f">
            <tr>
                <td>${f.id}</td>
                <td>${f.name}</td>
                <td>${f.companyId}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>


