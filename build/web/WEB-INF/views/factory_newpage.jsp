<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - New Page Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_header.jsp" />
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (new page)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>
    <div class="row mt-3">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Form</h5>
                    <form method="post" action="${pageContext.request.contextPath}/factory${factory != null ? '/edit/'.concat(factory.id) : '/add'}">
                        <input type="hidden" name="ref" value="newpage" />
                        
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" value="${factory.name}" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Company</label>
                            <select class="form-select" name="companyId" required>
                                <c:forEach items="${companies}" var="c">
                                    <option value="${c.id}"><c:out value="${c.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <button class="btn btn-primary" type="submit">Save</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <table class="table table-bordered table-striped">
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
                            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/factory/edit/${f.id}?ref=newpage">Edit</a>
                            <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/factory/delete/${f.id}" onclick="return confirm('Delete?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
// Ensure selected option when editing
(function(){
  var id = '${factory != null ? factory.id : ""}';
  if(id){
    var companyId = '${factory != null ? factory.companyId : ""}';
    if(companyId){
      var sel = document.querySelector('select[name="companyId"]');
      if(sel){ sel.value = companyId; }
    }
  }
})();
</script>
<jsp:include page="_footer.jsp" />
</body>
</html>


