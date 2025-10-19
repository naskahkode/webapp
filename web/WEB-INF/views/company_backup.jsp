
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Company</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center">
        <h3>Company</h3>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
    </div>
    <div class="row mt-3">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" id="formTitle">Add Company</h5>
                    <form id="companyForm" onsubmit="handleSubmit(event)">
                        <input type="hidden" id="companyId" name="id" value="" />
                        
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name" required />
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-primary" type="submit" id="saveBtn">Save</button>
                            <button class="btn btn-secondary" type="button" id="cancelBtn" onclick="resetForm()" style="display: none;">Cancel</button>
                        </div>
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
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${companies}" var="c">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.name}</td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary" onclick="editCompany('${c.id}', '${c.name}')">Edit</button>
                                <button class="btn btn-sm btn-outline-danger" onclick="deleteCompany('${c.id}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
let isEditing = false;

function handleSubmit(event) {
    event.preventDefault();
    const form = document.getElementById('companyForm');
    const formData = new FormData(form);
    
    const url = '${pageContext.request.contextPath}/company/save';
    
    fetch(url, {
        method: 'POST',
        body: new URLSearchParams(formData)
    })
    .then(response => {
        if (response.ok) {
            window.location.reload(); // Reload to see changes
        } else {
            alert('Error saving company');
        }
    })
    .catch(error => {
        alert('Error: ' + error);
    });
}

function editCompany(id, name) {
    isEditing = true;
    document.getElementById('companyId').value = id;
    document.getElementById('name').value = name;
    document.getElementById('formTitle').textContent = 'Edit Company';
    document.getElementById('saveBtn').textContent = 'Update';
    document.getElementById('cancelBtn').style.display = 'block';
}

function resetForm() {
    isEditing = false;
    document.getElementById('companyForm').reset();
    document.getElementById('companyId').value = '';
    document.getElementById('formTitle').textContent = 'Add Company';
    document.getElementById('saveBtn').textContent = 'Save';
    document.getElementById('cancelBtn').style.display = 'none';
}

function deleteCompany(id) {
    if (confirm('Are you sure you want to delete this company?')) {
        fetch('${pageContext.request.contextPath}/company/delete?id=' + id)
        .then(response => {
            if (response.ok) {
                window.location.reload(); // Reload to see changes
            } else {
                alert('Error deleting company');
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


