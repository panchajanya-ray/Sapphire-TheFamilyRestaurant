package com.restaurantmanagement.dao;

import com.restaurantmanagement.model.MenuItem;
import com.restaurantmanagement.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuItemDAO {

    public boolean addMenuItem(MenuItem item) {
        String sql = "INSERT INTO menu_items(item_name, category, price, description, status) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemName());
            ps.setString(2, item.getCategory());
            ps.setDouble(3, item.getPrice());
            ps.setString(4, item.getDescription());
            ps.setString(5, item.getStatus());
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<MenuItem> getAllItems() {
        String sql = "SELECT * FROM menu_items";
        List<MenuItem> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement()) {

            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                MenuItem m = new MenuItem();
                m.setId(rs.getInt("id"));
                m.setItemName(rs.getString("item_name"));
                m.setCategory(rs.getString("category"));
                m.setPrice(rs.getDouble("price"));
                m.setDescription(rs.getString("description"));
                m.setStatus(rs.getString("status"));
                list.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public List<MenuItem> getAllAvailableItems() {
        String sql = "SELECT * FROM menu_items WHERE status = 'available'";
        List<MenuItem> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement()) {

            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                MenuItem m = new MenuItem();
                m.setId(rs.getInt("id"));
                m.setItemName(rs.getString("item_name"));
                m.setCategory(rs.getString("category"));
                m.setPrice(rs.getDouble("price"));
                m.setDescription(rs.getString("description"));
                m.setStatus(rs.getString("status"));
                list.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE menu_items SET status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
