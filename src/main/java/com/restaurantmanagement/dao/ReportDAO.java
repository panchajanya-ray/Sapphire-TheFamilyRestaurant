package com.restaurantmanagement.dao;

import com.restaurantmanagement.util.DBConnection;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class ReportDAO {

    private Map<String, Double> fetchDouble(String sql) {
        Map<String, Double> map = new LinkedHashMap<>();
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery(sql)) {

            while (rs.next()) {
                map.put(rs.getString(1), rs.getDouble(2));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }

    private Map<String, Integer> fetchInt(String sql) {
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection c = DBConnection.getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery(sql)) {

            while (rs.next()) {
                map.put(rs.getString(1), rs.getInt(2));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }

    public Map<String, Double> ordersDay() {
        return fetchDouble(
            "SELECT DATE(order_time), SUM(total_amount) FROM orders GROUP BY DATE(order_time)"
        );
    }

    public Map<String, Double> ordersMonth() {
        return fetchDouble(
            "SELECT DATE_FORMAT(order_time,'%Y-%m'), SUM(total_amount) FROM orders GROUP BY DATE_FORMAT(order_time,'%Y-%m')"
        );
    }

    public Map<String, Double> ordersYear() {
        return fetchDouble(
            "SELECT YEAR(order_time), SUM(total_amount) FROM orders GROUP BY YEAR(order_time)"
        );
    }

    public Map<String, Integer> reservationsDay() {
        return fetchInt(
            "SELECT reservation_date, COUNT(*) FROM reservations GROUP BY reservation_date"
        );
    }

    public Map<String, Integer> reservationsMonth() {
        return fetchInt(
            "SELECT DATE_FORMAT(reservation_date,'%Y-%m'), COUNT(*) FROM reservations GROUP BY DATE_FORMAT(reservation_date,'%Y-%m')"
        );
    }

    public Map<String, Integer> reservationsYear() {
        return fetchInt(
            "SELECT YEAR(reservation_date), COUNT(*) FROM reservations GROUP BY YEAR(reservation_date)"
        );
    }
}
