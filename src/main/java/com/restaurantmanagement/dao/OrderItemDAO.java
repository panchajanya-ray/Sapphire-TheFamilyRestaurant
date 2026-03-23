package com.restaurantmanagement.dao;

import com.restaurantmanagement.model.OrderItem;
import com.restaurantmanagement.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {

    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items(order_id, menu_item_id, quantity, price) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getMenuItemId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<OrderItem> getItemsByOrder(int orderId) {
        String sql = "SELECT * FROM order_items WHERE order_id=?";
        List<OrderItem> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem oi = new OrderItem();
                oi.setId(rs.getInt("id"));
                oi.setOrderId(rs.getInt("order_id"));
                oi.setMenuItemId(rs.getInt("menu_item_id"));
                oi.setQuantity(rs.getInt("quantity"));
                oi.setPrice(rs.getDouble("price"));
                list.add(oi);
            }

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}
