<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Inline</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center">
        <h3>Factory (inline)</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>
    <div class="card mt-3">
        <div class="card-body">
            <form id="factoryForm" onsubmit="handleSubmit(event)">
                <input type="hidden" name="ref" value="inline" />
                <input type="hidden" id="factoryId" name="id" value="" />
                <div class="row g-2 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label">Code</label>
                        <input type="text" class="form-control" id="code" name="code" required />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Company</label>
                        <select class="form-select" id="companyId" name="companyId" required>
                            <c:forEach items="${companies}" var="c">
                                <option value="${c.id}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-primary w-100" type="submit" id="saveBtn">Save</button>
                    </div>
                    <div class="col-md-1">
                        <button class="btn btn-secondary w-100" type="button" onclick="resetForm()">Cancel</button>
                    </div>
                </div>
            </form>
        </div>
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
                    <button class="btn btn-sm btn-outline-primary" onclick="editFactory('${f.id}', '${f.code}', '${f.name}', '${f.companyId}')">Edit</button>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteFactory('${f.id}')">Delete</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
let isEditing = false;

function handleSubmit(event) {
    event.preventDefault();
    const form = document.getElementById('factoryForm');
    const formData = new FormData(form);
    
    const url = isEditing 
        ? '${pageContext.request.contextPath}/factory/edit/' + document.getElementById('factoryId').value
        : '${pageContext.request.contextPath}/factory/add';
    
    fetch(url, {
        method: 'POST',
        body: new URLSearchParams(formData)
    })
    .then(response => {
        if (response.ok) {
            window.location.reload(); // Reload to see changes
        } else {
            alert('Error saving factory');
        }
    })
    .catch(error => {
        alert('Error: ' + error);
    });
}

function editFactory(id, code, name, companyId) {
    isEditing = true;
    document.getElementById('factoryId').value = id;
    document.getElementById('code').value = code;
    document.getElementById('name').value = name;
    document.getElementById('companyId').value = companyId;
    document.getElementById('saveBtn').textContent = 'Update';
}

function resetForm() {
    isEditing = false;
    document.getElementById('factoryForm').reset();
    document.getElementById('factoryId').value = '';
    document.getElementById('saveBtn').textContent = 'Save';
}

function deleteFactory(id) {
    if (confirm('Are you sure you want to delete this factory?')) {
        fetch('${pageContext.request.contextPath}/factory/delete/' + id)
        .then(response => {
            if (response.ok) {
                window.location.reload(); // Reload to see changes
            } else {
                alert('Error deleting factory');
            }
        })
        .catch(error => {
            alert('Error: ' + error);
        });
    }
}
</script>
</body>
</html>


