<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ page import="com.app.model.User" %>
            <% User user=(User) session.getAttribute("user"); %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Company Management</title>
                    <jsp:include page="./components/_script.jsp" />
                </head>

                <body>
                    <c:import url="./components/_sidebar.jsp" />
                    <main id="content">
                        <c:import url="./components/_header.jsp" />
                        <div class="p-4 md:p-6 xl:p-12">
                            <div class="flex gap-x-10 justify-center">
                                <div class="text-sm xl:block w-full">
                                    <header class="space-y-2 mb-8">
                                        <h1 class="text-3xl font-semibold tracking-tight">
                                            Welcome <%= user !=null ? user.getName() : "" %>
                                        </h1>
                                        <p class="text-muted-foreground">Company Management Dashboard</p>
                                    </header>

                                    <div class="grid gap-4 flex-1">
                                        <div class="card">
                                            <div class="p-4">
                                                <div class="container py-4">
                                                    <jsp:include page="_flash.jsp" />

                                                    <div class="mt-3">
                                                        <button class="btn btn-primary" onclick="openAddDialog()">
                                                            Add New Company
                                                        </button>
                                                    </div>

                                                    <table class="table table-bordered table-striped mt-3">
                                                        <thead>
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Name</th>
                                                                <th>Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${companies}" var="data">
                                                                <tr>
                                                                    <td>${data.id}</td>
                                                                    <td>${data.name}</td>
                                                                    <td>
                                                                        <button type="button"
                                                                            onclick="openEditDialog('${data.id}', '${data.name}')"
                                                                            class="btn-outline">
                                                                            Edit
                                                                        </button>
                                                                        <button type="button"
                                                                            onclick="openDeleteDialog('${data.name}', '${data.id}')"
                                                                            class="btn-destructive">
                                                                            Delete
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <dialog id="deleteDialog" class="dialog">
                                                    <article>
                                                        <header>
                                                            <h2>Are you absolutely sure?</h2>
                                                            <p>This action cannot be undone. This will permanently
                                                                delete
                                                                <strong id="deletedCompanyName"></strong> data.
                                                            </p>
                                                        </header>
                                                        <footer>
                                                            <button type="button" class="btn-outline"
                                                                onclick="closeDeleteDialog()">
                                                                Cancel
                                                            </button>
                                                            <a id="deleteLink" class="btn-destructive">Continue</a>
                                                        </footer>
                                                    </article>
                                                </dialog>

                                                <dialog id="formDialog" class="dialog w-full sm:max-w-[425px]"
                                                    onclick="if (event.target === this) this.close()">
                                                    <article>
                                                        <header>
                                                            <h2 id="formDialogTitle">Create Company</h2>
                                                            <p id="formDialogDescription">
                                                                Enter company details below. Click save when you're
                                                                done.
                                                            </p>
                                                        </header>
                                                        <section>
                                                            <form class="form grid gap-4" id="companyForm"
                                                                method="post">
                                                                <div class="grid gap-3">
                                                                    <label for="name">Company Name</label>
                                                                    <input type="text" name="name" id="name"
                                                                        placeholder="Enter company name" required
                                                                        autofocus />
                                                                </div>
                                                                <footer>
                                                                    <button type="button" class="btn-outline"
                                                                        onclick="closeFormDialog()">
                                                                        Cancel
                                                                    </button>
                                                                    <button type="submit" class="btn-primary">
                                                                        Save Changes
                                                                    </button>
                                                                </footer>
                                                            </form>
                                                        </section>
                                                        <button type="button" class="dialog-close"
                                                            aria-label="Close dialog" onclick="closeFormDialog()">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                                                height="24" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M18 6 6 18" />
                                                                <path d="m6 6 12 12" />
                                                            </svg>
                                                        </button>
                                                    </article>
                                                </dialog>
                                                <script>
                                                    const contextPath = '${pageContext.request.contextPath}';
                                                    function openAddDialog() {
                                                        document.getElementById('formDialogTitle').textContent = 'Create Company';
                                                        document.getElementById('formDialogDescription').textContent =
                                                            'Enter company details below. Click save when you\'re done.';
                                                        document.getElementById('name').value = '';
                                                        document.getElementById('companyForm').action = contextPath + '/company/add';
                                                        document.getElementById('formDialog').showModal();
                                                    }

                                                    function openEditDialog(id, name) {
                                                        document.getElementById('formDialogTitle').textContent = 'Edit Company';
                                                        document.getElementById('name').value = name;
                                                        document.getElementById('companyForm').action = contextPath + '/company/edit/' + id;
                                                        document.getElementById('formDialog').showModal();
                                                    }

                                                    function closeFormDialog() {
                                                        document.getElementById('formDialog').close();
                                                        document.getElementById('name').value = '';
                                                    }

                                                    function openDeleteDialog(name, id) {
                                                        document.getElementById('deletedCompanyName').textContent = name;
                                                        document.getElementById('deleteLink').href = contextPath + '/company/delete/' + id;
                                                        document.getElementById('deleteDialog').showModal();
                                                    }

                                                    function closeDeleteDialog() {
                                                        document.getElementById('deleteDialog').close();
                                                    }
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <jsp:include page="./components/_footer.jsp" />
                    </main>
                </body>

                </html>