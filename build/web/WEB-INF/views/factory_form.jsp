<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Add/Edit</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory Form</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/factory">Back</a>
    </div>
    <div class="row mt-3">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">${factory != null ? 'Edit' : 'Add'} Factory</h5>
                    <form method="post" action="${pageContext.request.contextPath}/factory${factory != null ? '/edit/'.concat(factory.id) : '/add'}">
                        <div class="mb-3">
                            <label class="form-label">Code</label>
                            <input type="text" class="form-control" name="code" value="${factory.code}" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" value="${factory.name}" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Company</label>
                            <select class="form-select" name="companyId" required>
                                <c:forEach items="${companies}" var="c">
                                    <option value="${c.id}" ${c.id == factory.companyId ? 'selected' : ''}><c:out value="${c.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <button class="btn btn-primary" type="submit">Save</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="_footer.jsp" />
</body>
</html>