package com.app.dao;

import com.app.model.Factory;
import com.app.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FactoryDAO {
    public List<Factory> findAll() throws SQLException {
        String sql = "SELECT id, code, name, company_id FROM tb_factory ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Factory> list = new ArrayList<>();
            while (rs.next()) {
                Factory f = new Factory(rs.getLong("id"), rs.getString("code"), rs.getString("name"), rs.getLong("company_id"));
                list.add(f);
            }
            return list;
        }
    }

    public List<Factory> findAllSorted(String sortBy, String sortDir) throws SQLException {
        String column = "id";
        if ("name".equalsIgnoreCase(sortBy)) column = "name";
        else if ("company_id".equalsIgnoreCase(sortBy)) column = "company_id";
        String dir = "ASC";
        if ("desc".equalsIgnoreCase(sortDir)) dir = "DESC";
        String sql = "SELECT id, code, name, company_id FROM tb_factory ORDER BY " + column + " " + dir;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Factory> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new Factory(rs.getLong("id"), rs.getString("code"), rs.getString("name"), rs.getLong("company_id")));
            }
            return list;
        }
    }

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(1) AS cnt FROM tb_factory";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("cnt");
            return 0;
        }
    }

    public List<Factory> findPage(int offset, int limit) throws SQLException {
        return findPageSorted(offset, limit, "id", true);
    }

    public List<Factory> findPageSorted(int offset, int limit, String orderBy, boolean isAsc) throws SQLException {
        String column;
        switch (orderBy.toLowerCase()) {
            case "code": column = "code"; break;
            case "name": column = "name"; break;
            case "company_id": column = "company_id"; break;
            default: column = "id"; break;
        }
        
        String sortDir = isAsc ? "ASC" : "DESC";
        String sql = String.format(
            "SELECT id, code, name, company_id FROM (" +
            "  SELECT t.*, ROWNUM rn FROM (SELECT id, code, name, company_id FROM tb_factory ORDER BY %s %s) t WHERE ROWNUM <= ?" +
            ") WHERE rn > ?", column, sortDir);
            
        int upper = offset + limit;
        int lower = offset;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, upper);
            ps.setInt(2, lower);
            try (ResultSet rs = ps.executeQuery()) {
                List<Factory> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new Factory(rs.getLong("id"), rs.getString("code"), rs.getString("name"), rs.getLong("company_id")));
                }
                return list;
            }
        }
    }

    public int countByNameLike(String q) throws SQLException {
        String sql = "SELECT COUNT(1) AS cnt FROM tb_factory WHERE UPPER(name) LIKE UPPER(?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + q + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("cnt");
                return 0;
            }
        }
    }

    public List<Factory> searchByNameLike(String q) throws SQLException {
        String sql = "SELECT id, code, name, company_id FROM tb_factory WHERE UPPER(name) LIKE UPPER(?) OR UPPER(code) LIKE UPPER(?) ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + q + "%");
            ps.setString(2, "%" + q + "%");
            try (ResultSet rs = ps.executeQuery()) {
                List<Factory> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new Factory(rs.getLong("id"), rs.getString("code"), rs.getString("name"), rs.getLong("company_id")));
                }
                return list;
            }
        }
    }

    public List<Factory> findPageByNameLike(String q, int offset, int limit) throws SQLException {
        String inner = "SELECT id, code, name, company_id FROM tb_factory WHERE UPPER(name) LIKE UPPER(?) OR UPPER(code) LIKE UPPER(?) ORDER BY id";
        String sql = "SELECT id, code, name, company_id FROM (SELECT t.*, ROWNUM rn FROM (" + inner + ") t WHERE ROWNUM <= ?) WHERE rn > ?";
        int upper = offset + limit;
        int lower = offset;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + q + "%");
            ps.setString(2, "%" + q + "%");
            ps.setInt(3, upper);
            ps.setInt(4, lower);
            try (ResultSet rs = ps.executeQuery()) {
                List<Factory> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new Factory(rs.getLong("id"), rs.getString("code"), rs.getString("name"), rs.getLong("company_id")));
                }
                return list;
            }
        }
    }

    public Factory findById(long id) throws SQLException {
        String sql = "SELECT id, code, name, company_id FROM tb_factory WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Factory(rs.getLong("id"), rs.getString("code"), rs.getString("name"), rs.getLong("company_id"));
                }
                return null;
            }
        }
    }

    public void insert(Factory f) throws SQLException {
        String sql = "INSERT INTO tb_factory (code, name, company_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getCode());
            ps.setString(2, f.getName());
            ps.setLong(3, f.getCompanyId());
            ps.executeUpdate();
        }
    }

    public void update(Factory f) throws SQLException {
        String sql = "UPDATE tb_factory SET code = ?, name = ?, company_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getCode());
            ps.setString(2, f.getName());
            ps.setLong(3, f.getCompanyId());
            ps.setLong(4, f.getId());
            ps.executeUpdate();
        }
    }

    public void delete(long id) throws SQLException {
        String sql = "DELETE FROM tb_factory WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }
}


