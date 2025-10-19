package com.app.dao;

import com.app.model.Company;
import com.app.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAObackup {
    public List<Company> findAll() throws SQLException {
        String sql = "SELECT id, name FROM tb_company ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<Company> list = new ArrayList<>();
            while (rs.next()) {
                Company c = new Company(rs.getLong("id"), rs.getString("name"));
                list.add(c);
            }
            return list;
        }
    }

    public Company findById(long id) throws SQLException {
        String sql = "SELECT id, name FROM tb_company WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Company(rs.getLong("id"), rs.getString("name"));
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
        String sql = "UPDATE tb_company SET name = ? WHERE id = ?";
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


