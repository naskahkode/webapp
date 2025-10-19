package com.app.dao;

import com.app.model.Company;
import com.app.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {
    public List<Company> findAll() throws SQLException {
        String sql = "SELECT id, name FROM tb_company ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Company> list = new ArrayList<>();
            while (rs.next()) {
                Company c = new Company(rs.getLong("id"),  rs.getString("name") );
                list.add(c);
            }
            return list;
        }
    }

    public List<Company> findAllSorted(String sortBy, String sortDir) throws SQLException {
        String column = "id";
        if ("name".equalsIgnoreCase(sortBy)) column = "name";
        String dir = "ASC";
        if ("desc".equalsIgnoreCase(sortDir)) dir = "DESC";
        String sql = "SELECT id, name FROM tb_company ORDER BY " + column + " " + dir;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Company> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new Company(rs.getLong("id"),  rs.getString("name") ));
            }
            return list;
        }
    }

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(1) AS cnt FROM tb_company";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("cnt");
            return 0;
        }
    }

    public List<Company> findPage(int offset, int limit) throws SQLException {
        return findPageSorted(offset, limit, "id", true);
    }

    public List<Company> findPageSorted(int offset, int limit, String orderBy, boolean isAsc) throws SQLException {
        String column;
        column = switch (orderBy.toLowerCase()) {
            case "name" -> "name";
            default -> "id";
        };
        
        String sortDir = isAsc ? "ASC" : "DESC";
        String sql = String.format(
            "SELECT id, name FROM (" +
            "  SELECT t.*, ROWNUM rn FROM (SELECT id, name  FROM tb_company ORDER BY %s %s) t WHERE ROWNUM <= ?" +
            ") WHERE rn > ?", column, sortDir);
            
        int upper = offset + limit;
        int lower = offset;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, upper);
            ps.setInt(2, lower);
            try (ResultSet rs = ps.executeQuery()) {
                List<Company> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new Company(rs.getLong("id") , rs.getString("name") ));
                }
                return list;
            }
        }
    }

    public int countByNameLike(String q) throws SQLException {
        String sql = "SELECT COUNT(1) AS cnt FROM tb_company WHERE UPPER(name) LIKE UPPER(?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + q + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("cnt");
                return 0;
            }
        }
    }

    public List<Company> searchByNameLike(String q) throws SQLException {
        String sql = "SELECT id,  name FROM tb_company WHERE UPPER(name) LIKE UPPER(?) ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + q + "%");
            try (ResultSet rs = ps.executeQuery()) {
                List<Company> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new Company(rs.getLong("id"), rs.getString("name") ));
                }
                return list;
            }
        }
    }

    public List<Company> findPageByNameLike(String q, int offset, int limit) throws SQLException {
        String inner = "SELECT id, name FROM tb_company WHERE UPPER(name) LIKE UPPER(?) ORDER BY id";
        String sql = "SELECT id, name, FROM (SELECT t.*, ROWNUM rn FROM (" + inner + ") t WHERE ROWNUM <= ?) WHERE rn > ?";
        int upper = offset + limit;
        int lower = offset;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + q + "%");
            ps.setInt(2, upper);
            ps.setInt(3, lower);
            try (ResultSet rs = ps.executeQuery()) {
                List<Company> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new Company(rs.getLong("id"), rs.getString("name")));
                }
                return list;
            }
        }
    }

    public Company findById(long id) throws SQLException {
        String sql = "SELECT id,  name  FROM tb_company WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Company(rs.getLong("id"),   rs.getString("name") );
                }
                return null;
            }
        }
    }

    public void insert(Company c) throws SQLException {
        String sql = "INSERT INTO tb_company (name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.executeUpdate();
        }
    }

  
    public void update(Company c) throws SQLException {
        String sql = "UPDATE tb_company SET name = ?  WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getName());
            ps.setLong(2, c.getId());
            ps.executeUpdate();
        }
    }

    public void delete(long id) throws SQLException {
        String sql = "DELETE FROM tb_company WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }
}


