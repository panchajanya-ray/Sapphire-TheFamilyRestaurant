package com.restaurantmanagement.dao;

import com.restaurantmanagement.model.Order;
import com.restaurantmanagement.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.sql.Timestamp;

public class OrderDAO {

    public int createOrder(Order order) {
        String sql = "INSERT INTO orders(user_id, customer_name, total_amount, status) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getCustomerName());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }

    
    public List<Order> getOrdersByDate(LocalDate date) {

        String sql = """
            SELECT *
            FROM orders
            WHERE order_time >= ?
              AND order_time < ?
            ORDER BY order_time DESC
        """;

        List<Order> list = new ArrayList<>();

        LocalDateTime start = date.atStartOfDay();
        LocalDateTime end = date.plusDays(1).atStartOfDay();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(start));
            ps.setTimestamp(2, Timestamp.valueOf(end));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setCustomerName(rs.getString("customer_name"));
                o.setOrderTime(rs.getTimestamp("order_time"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setPaymentStatus(rs.getString("payment_status"));
                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
    public List<Order> getOrdersByUser(int userId,LocalDate date)
    {
    	//String sql = """SELECT * FROM orders WHERE user_id = ? AND order_time >= ? AND order_time < ? ORDER BY order_time DESC""";
    	String sql = """
                SELECT *
                FROM orders
                WHERE user_id = ?
    			   AND order_time >= ?
                  AND order_time < ? 
                ORDER BY order_time DESC
            """;
    	List<Order> list = new ArrayList<>();
    	LocalDateTime start = date.atStartOfDay();
        LocalDateTime end = date.plusDays(1).atStartOfDay();

        
    	try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

    		ps.setInt(1, userId);
            ps.setTimestamp(2, Timestamp.valueOf(start));
            ps.setTimestamp(3, Timestamp.valueOf(end));
            
    		ResultSet rs = ps.executeQuery();
               while (rs.next()) {
                   Order o = new Order();
                   o.setId(rs.getInt("id"));
                   o.setUserId(rs.getInt("user_id"));
                   o.setCustomerName(rs.getString("customer_name"));
                   o.setOrderTime(rs.getTimestamp("order_time"));
                   o.setTotalAmount(rs.getDouble("total_amount"));
                   o.setStatus(rs.getString("status"));
                   o.setPaymentMethod(rs.getString("payment_method"));
                   o.setPaymentStatus(rs.getString("payment_status"));
                   list.add(o);
               }

           } catch (Exception e) { e.printStackTrace(); }
           return list;
    }
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status=?, payment_status=?, payment_method=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, status);
            ps.setString(3, "counter");
            ps.setInt(4, orderId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updatePayment(int orderId, String method, String status) {
        String sql = "UPDATE orders SET payment_method=?, payment_status=?, status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, method);
            ps.setString(2, status);
            ps.setString(3, status);
            ps.setInt(4, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
