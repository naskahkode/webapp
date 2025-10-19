package com.app.web.controller;

import com.app.dao.CompanyDAO;
import com.app.dao.FactoryDAO;
import com.app.model.Company;
import com.app.model.Factory;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class FactoryController extends HttpServlet {
    private final FactoryDAO factoryDAO = new FactoryDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || "/".equals(path) || "/list".equals(path)) {
            loadList(req);
            req.getRequestDispatcher("/WEB-INF/views/factory_list.jsp").forward(req, resp);
        } else if ("/export".equals(path)) {
            // CSV export
            try {
                java.util.List<com.app.model.Factory> list = factoryDAO.findAll();
                resp.setContentType("text/csv;charset=UTF-8");
                resp.setHeader("Content-Disposition", "attachment; filename=factory.csv");
                java.io.PrintWriter out = resp.getWriter();
                out.println("id,name,company_id");
                for (com.app.model.Factory f : list) {
                    out.println(f.getId() + "," + f.getName().replace(","," ") + "," + f.getCompanyId());
                }
                out.flush();
            } catch (SQLException e) {
                com.app.util.ErrorUtil.attachAndForward(req, resp, e, "Gagal export CSV factory");
            }
        } else if ("/import-export".equals(path)) {
            loadList(req);
            req.getRequestDispatcher("/WEB-INF/views/factory_import_export.jsp").forward(req, resp);
        } else if ("/paging".equals(path)) {
            String pStr = req.getParameter("p");
            String sizeStr = req.getParameter("size");
            int page = 1;
            int size = 10;
            try { if (pStr != null) page = Integer.parseInt(pStr); } catch (NumberFormatException ignored) {}
            try { if (sizeStr != null) size = Integer.parseInt(sizeStr); } catch (NumberFormatException ignored) {}
            if (page < 1) page = 1;
            if (size < 1) size = 10;
            int offset = (page - 1) * size;
            try {
                int total = factoryDAO.countAll();
                int totalPages = (int) Math.ceil((double) total / (double) size);
                if (totalPages == 0) totalPages = 1;
                if (page > totalPages) page = totalPages;
                req.setAttribute("factories", factoryDAO.findPage(offset, size));
                req.setAttribute("page", page);
                req.setAttribute("size", size);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("total", total);
                req.setAttribute("companies", companyDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/factory_paging.jsp").forward(req, resp);
            } catch (SQLException e) {
                com.app.util.ErrorUtil.attachAndForward(req, resp, e, "Gagal memuat halaman pagination factory");
            }
        } else if ("/search".equals(path)) {
            String q = req.getParameter("q");
            if (q == null) q = "";
            try {
                req.setAttribute("q", q);
                req.setAttribute("factories", q.isEmpty() ? factoryDAO.findAll() : factoryDAO.searchByNameLike(q));
                req.setAttribute("companies", companyDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/factory_search.jsp").forward(req, resp);
            } catch (SQLException e) {
                com.app.util.ErrorUtil.attachAndForward(req, resp, e, "Gagal melakukan pencarian factory");
            }
        } else if ("/paging-search".equals(path)) {
            String q = req.getParameter("q");
            if (q == null) q = "";
            String pStr = req.getParameter("p");
            String sizeStr = req.getParameter("size");
            int page = 1;
            int size = 10;
            try { if (pStr != null) page = Integer.parseInt(pStr); } catch (NumberFormatException ignored) {}
            try { if (sizeStr != null) size = Integer.parseInt(sizeStr); } catch (NumberFormatException ignored) {}
            if (page < 1) page = 1;
            if (size < 1) size = 10;
            int offset = (page - 1) * size;
            try {
                int total = q.isEmpty() ? factoryDAO.countAll() : factoryDAO.countByNameLike(q);
                int totalPages = (int) Math.ceil((double) total / (double) size);
                if (totalPages == 0) totalPages = 1;
                if (page > totalPages) page = totalPages;
                req.setAttribute("q", q);
                req.setAttribute("page", page);
                req.setAttribute("size", size);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("total", total);
                req.setAttribute("factories", q.isEmpty() ? factoryDAO.findPage(offset, size) : factoryDAO.findPageByNameLike(q, offset, size));
                req.setAttribute("companies", companyDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/factory_paging_search.jsp").forward(req, resp);
            } catch (SQLException e) {
                com.app.util.ErrorUtil.attachAndForward(req, resp, e, "Gagal memuat halaman pagination+search factory");
            }
        } else if ("/newpage".equals(path)) {
            loadList(req);
            req.getRequestDispatcher("/WEB-INF/views/factory_newpage.jsp").forward(req, resp);
        } else if ("/modal".equals(path)) {
            loadList(req);
            req.getRequestDispatcher("/WEB-INF/views/factory_modal.jsp").forward(req, resp);
        } else if ("/sort".equals(path)) {
            // Check if it's a DataTables AJAX request
            if (req.getParameter("draw") != null) {
                try {
                    // Parse DataTables parameters
                    int draw = Integer.parseInt(req.getParameter("draw"));
                    int start = Integer.parseInt(req.getParameter("start"));
                    int length = Integer.parseInt(req.getParameter("length"));
                    // If length is -1, it means "All", so get total count
                    if (length == -1) {
                        length = factoryDAO.countAll();
                    }
                    String searchValue = req.getParameter("search[value]");
                    String orderColumn = req.getParameter("order[0][column]");
                    String orderDir = req.getParameter("order[0][dir]");
                    
                    // Get column name from column index
                    String[] columns = {"id", "code", "name", "company_id"};
                    String orderBy = "id"; // default order
                    
                    if (orderColumn != null && !orderColumn.isEmpty()) {
                        int colIndex = Integer.parseInt(orderColumn);
                        if (colIndex >= 0 && colIndex < columns.length) {
                            orderBy = columns[colIndex];
                        }
                    }
                    
                    boolean isAsc = orderDir == null || "asc".equalsIgnoreCase(orderDir);
                    
                    // Get total records count
                    int totalRecords = factoryDAO.countAll();
                    
                    // Get filtered records
                    List<Factory> factories;
                    int filteredRecords;
                    
                    if (searchValue != null && !searchValue.isEmpty()) {
                        factories = factoryDAO.findPageByNameLike(searchValue, start, length);
                        filteredRecords = factoryDAO.countByNameLike(searchValue);
                    } else {
                        factories = factoryDAO.findPageSorted(start, length, orderBy, isAsc);
                        filteredRecords = totalRecords;
                    }
                    
                    // Build JSON response
                    StringBuilder json = new StringBuilder();
                    json.append("{");
                    json.append("\"draw\": ").append(draw).append(",");
                    json.append("\"recordsTotal\": ").append(totalRecords).append(",");
                    json.append("\"recordsFiltered\": ").append(filteredRecords).append(",");
                    json.append("\"data\": [");
                    
                    for (int i = 0; i < factories.size(); i++) {
                        Factory f = factories.get(i);
                        if (i > 0) json.append(",");
                        json.append("[");
                        json.append("\"").append(f.getId()).append("\",");
                        json.append("\"").append(f.getCode()).append("\",");
                        json.append("\"").append(f.getName()).append("\",");
                        // Get company name
                        String companyName = "Unknown";
                        try {
                            Company company = companyDAO.findById(f.getCompanyId());
                            if (company != null) {
                                companyName = company.getName();
                            }
                        } catch (SQLException e) {
                            // Keep default "Unknown" if error
                        }
                        json.append("\"").append(companyName).append("\",");
                        json.append("\"<button class='btn btn-sm btn-outline-primary' onclick='editFactory(")
                            .append(f.getId()).append(",\\\"").append(f.getCode()).append("\\\",\\\"")
                            .append(f.getName()).append("\\\",").append(f.getCompanyId())
                            .append(")' data-bs-toggle='modal' data-bs-target='#factoryModal'>Edit</button> ")
                            .append("<button class='btn btn-sm btn-outline-danger' onclick='deleteFactory(")
                            .append(f.getId()).append(")'>Delete</button>\"");
                        json.append("]");
                    }
                    
                    json.append("]}");
                    
                    resp.setContentType("application/json");
                    resp.getWriter().write(json.toString());
                    return;
                } catch (Exception e) {
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
                    return;
                }
            }
            
            try {
                req.setAttribute("companies", companyDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/factory_sort.jsp").forward(req, resp);
            } catch (SQLException e) {
                com.app.util.ErrorUtil.attachAndForward(req, resp, e, "Gagal memuat sorting factory");
            }
        } else if ("/add".equals(path)) {
            loadList(req);
            req.getRequestDispatcher("/WEB-INF/views/factory_form.jsp").forward(req, resp);
        } else if (path.startsWith("/edit/")) {
            String idStr = path.substring(6); // Remove "/edit/"
            try {
                Factory f = factoryDAO.findById(Long.parseLong(idStr));
                req.setAttribute("factory", f);
                loadList(req);
                req.getRequestDispatcher("/WEB-INF/views/factory_form.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else if (path.startsWith("/delete/")) {
            String idStr = path.substring(8); // Remove "/delete/"
            if (idStr != null) {
                try {
                    factoryDAO.delete(Long.parseLong(idStr));
                    com.app.util.Flash.success(req, "Factory berhasil dihapus");
                    resp.sendRedirect(req.getContextPath() + "/factory");
                } catch (SQLException e) {
                    com.app.util.Flash.error(req, "Gagal menghapus factory: " + e.getMessage());
                    resp.sendRedirect(req.getContextPath() + "/factory");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/factory");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/add".equals(path)) {
            String code = req.getParameter("code");
            String name = req.getParameter("name");
            long companyId = Long.parseLong(req.getParameter("companyId"));
            try {
                factoryDAO.insert(new Factory(null, code, name, companyId));
                com.app.util.Flash.success(req, "Factory berhasil dibuat");
                String ref = req.getParameter("ref");
                String redirect = "/factory";
                if (ref != null && !ref.isEmpty()) redirect = "/factory/" + ref;
                resp.sendRedirect(req.getContextPath() + redirect);
            } catch (SQLException e) {
                com.app.util.Flash.error(req, "Gagal menyimpan factory: " + e.getMessage());
                String ref = req.getParameter("ref");
                String redirect = "/factory";
                if (ref != null && !ref.isEmpty()) redirect = "/factory/" + ref;
                resp.sendRedirect(req.getContextPath() + redirect);
            }
        } else if (path != null && path.startsWith("/edit/")) {
            String idStr = path.substring(6); // Remove "/edit/"
            String code = req.getParameter("code");
            String name = req.getParameter("name");
            long companyId = Long.parseLong(req.getParameter("companyId"));
            try {
                factoryDAO.update(new Factory(Long.parseLong(idStr), code, name, companyId));
                com.app.util.Flash.success(req, "Factory berhasil diperbarui");
                String ref = req.getParameter("ref");
                String redirect = "/factory";
                if (ref != null && !ref.isEmpty()) redirect = "/factory/" + ref;
                resp.sendRedirect(req.getContextPath() + redirect);
            } catch (SQLException e) {
                com.app.util.Flash.error(req, "Gagal memperbarui factory: " + e.getMessage());
                String ref = req.getParameter("ref");
                String redirect = "/factory";
                if (ref != null && !ref.isEmpty()) redirect = "/factory/" + ref;
                resp.sendRedirect(req.getContextPath() + redirect);
            }
        } 
        
//        else if ("/import".equals(path)) {
//            // Simple CSV import via textarea or raw body (name,company_id per line)
//            String csv = req.getParameter("csv");
//            if (csv == null) csv = "";
//            int success = 0;
//            int failed = 0;
//            java.util.List<String> errors = new java.util.ArrayList<String>();
//            String[] lines = csv.split("\r?\n");
//            for (String line : lines) {
//                String trimmed = line.trim();
//                if (trimmed.isEmpty()) continue;
//                String[] parts = trimmed.split(",");
//                if (parts.length < 2) {
//                    failed++;
//                    errors.add("Format salah: " + trimmed);
//                    continue;
//                }
//                String name = parts[0].trim();
//                String companyIdStr = parts[1].trim();
//                try {
//                    long companyId = Long.parseLong(companyIdStr);
//                    factoryDAO.insert(new Factory(null, name, companyId));
//                    success++;
//                } catch (Exception e) {
//                    failed++;
//                    errors.add("Gagal baris: " + trimmed + " => " + e.getMessage());
//                }
//            }
//            com.app.util.Flash.success(req, "Import selesai. Sukses: " + success + ", Gagal: " + failed);
//            if (!errors.isEmpty()) {
//                com.app.util.Flash.error(req, String.join(" | ", errors));
//            }
//            resp.sendRedirect(req.getContextPath() + "/factory/import-export");
//        } else {
//            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
//        }
    }

    private void loadList(HttpServletRequest req) throws ServletException {
        try {
            List<Factory> factories = factoryDAO.findAll();
            List<Company> companies = companyDAO.findAll();
            req.setAttribute("factories", factories);
            req.setAttribute("companies", companies);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
