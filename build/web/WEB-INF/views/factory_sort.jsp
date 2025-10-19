<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Factory - Sort</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css"/>
    
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
</head>
<body>
<div class="container py-4">
    <jsp:include page="_flash.jsp" />
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Factory List (with Sorting)</h3>
        <div>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#factoryModal" onclick="clearForm()">Add New</button>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back</a>
        </div>
    </div>

    <table id="factoryTable" class="table table-striped table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Code</th>
                <th>Name</th>
                <th>Company</th>
                <th>Actions</th>
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
                        <button class="btn btn-sm btn-outline-primary" onclick="editFactory('${f.id}', '${f.code}', '${f.name}', '${f.companyId}')" data-bs-toggle="modal" data-bs-target="#factoryModal">
                            Edit
                        </button>
                        <button class="btn btn-sm btn-outline-danger" onclick="deleteFactory('${f.id}')">
                            Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal for Add/Edit -->
<div class="modal fade" id="factoryModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Add Factory</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="factoryForm" onsubmit="handleSubmit(event)">
                    <input type="hidden" id="factoryId" name="id" value="" />
                    <div class="mb-3">
                        <label class="form-label">Code</label>
                        <input type="text" class="form-control" id="code" name="code" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Company</label>
                        <select class="form-select" id="companyId" name="companyId" required>
                            <option value="">Select Company</option>
                            <c:forEach items="${companies}" var="c">
                                <option value="${c.id}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="document.getElementById('factoryForm').requestSubmit()">Save</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {
    $('#factoryTable').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: '${pageContext.request.contextPath}/factory/sort',
            type: 'GET',
            error: function (xhr, error, thrown) {
                console.error('DataTables error:', error);
                alert('Error loading data. Please try again.');
            }
        },
        dom: '<"top"<"row"<"col-sm-6"l><"col-sm-6"f>>>rt<"bottom"<"row"<"col-sm-6"i><"col-sm-6"p>>>',
        lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
        pageLength: 10,
        order: [[0, 'asc']],
        columns: [
            { data: '0', name: 'id' },
            { data: '1', name: 'code' },
            { data: '2', name: 'name' },
            { data: '3', name: 'company_id' },
            { 
                data: '4',
                name: 'actions',
                orderable: false,
                searchable: false
            }
        ],
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries per page",
            processing: "Loading data...",
            zeroRecords: "No matching records found",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            infoEmpty: "No records available",
            infoFiltered: "(filtered from _MAX_ total records)",
            paginate: {
                first: "First",
                last: "Last",
                next: "Next",
                previous: "Previous"
            }
        }
    });
});

function handleSubmit(event) {
    event.preventDefault();
    const form = document.getElementById('factoryForm');
    const formData = new FormData(form);
    const id = document.getElementById('factoryId').value;
    
    const url = id
        ? '${pageContext.request.contextPath}/factory/edit/' + id
        : '${pageContext.request.contextPath}/factory/add';
    
    fetch(url, {
        method: 'POST',
        body: new URLSearchParams(formData)
    })
    .then(response => {
        if (response.ok) {
            window.location.reload();
        } else {
            alert('Error saving factory');
        }
    })
    .catch(error => {
        alert('Error: ' + error);
    });
}

function editFactory(id, code, name, companyId) {
    document.getElementById('modalTitle').textContent = 'Edit Factory';
    document.getElementById('factoryId').value = id;
    document.getElementById('code').value = code;
    document.getElementById('name').value = name;
    document.getElementById('companyId').value = companyId;
}

function clearForm() {
    document.getElementById('modalTitle').textContent = 'Add Factory';
    document.getElementById('factoryForm').reset();
    document.getElementById('factoryId').value = '';
}

function deleteFactory(id) {
    if (confirm('Are you sure you want to delete this factory?')) {
        fetch('${pageContext.request.contextPath}/factory/delete/' + id)
        .then(response => {
            if (response.ok) {
                $('#factoryTable').DataTable().ajax.reload();
                $('#factoryModal').modal('hide');
            } else {
                alert('Error saving factory');
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