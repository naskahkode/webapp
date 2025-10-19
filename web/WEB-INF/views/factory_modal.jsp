<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Modal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (modal)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>
    <div class="mt-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#factoryModal" onclick="clearForm()">Add New</button>
    </div>
    <table class="table table-bordered table-striped mt-3">
        <thead>
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Name</th>
            <th>Company</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${factories}" var="f">
            <tr>
                <td>${f.id}</td>
                <td>${f.code}</td>
                <td>${f.name}</td>
                <td>
                    <c:forEach items="${companies}" var="c">
                        <c:if test="${c.id == f.companyId}">${c.name}</c:if>
                    </c:forEach>
                </td>
                <td>
                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#factoryModal" onclick="fillForm('${f.id}','${f.code}','${f.name}','${f.companyId}')">Edit</button>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/factory/delete/${f.id}" onclick="return confirm('Delete?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="factoryModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Factory</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="factoryForm" method="post">
            <input type="hidden" name="ref" value="modal" />
            
            <div class="mb-3">
                <label class="form-label">Code</label>
                <input type="text" class="form-control" name="code" id="code" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" class="form-control" name="name" id="name" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Company</label>
                <select class="form-select" name="companyId" id="companyId" required>
                    <c:forEach items="${companies}" var="c">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>
            </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="submitForm()">Save</button>
      </div>
    </div>
  </div>
</div>

<script>
function submitForm() {
  const form = document.getElementById('factoryForm');
  const name = document.getElementById('name').value;
  const companyId = document.getElementById('companyId').value;
  const isEdit = editingId !== undefined && editingId !== '';
  
  form.action = '${pageContext.request.contextPath}/company' + (isEdit ? '/edit/' + editingId : '/add');
  form.submit();
}

let editingId = '';

function clearForm(){
  editingId = '';
  document.getElementById('code').value = '';
  document.getElementById('name').value = '';
  document.getElementById('companyId').selectedIndex = 0;
}
function fillForm(id, name, code, companyId){
  editingId = id;
  document.getElementById('code').value = code;
  document.getElementById('name').value = name;
  
  // Find and select the company in dropdown
  const companySelect = document.getElementById('companyId');
  for(let i = 0; i < companySelect.options.length; i++) {
    if(companySelect.options[i].value == companyId) {
      companySelect.selectedIndex = i;
      break;
    }
  }
}
</script>
</body>
</html>


