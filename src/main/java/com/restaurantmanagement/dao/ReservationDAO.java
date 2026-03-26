package com.restaurantmanagement.dao;

import com.restaurantmanagement.model.Reservation;
import com.restaurantmanagement.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservations (customer_name, phone, reservation_date, reservation_time, number_of_people, status, user_id) "
                + "VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getPhone());
            ps.setDate(3, r.getReservationDate());
            ps.setTime(4, r.getReservationTime());
            ps.setInt(5, r.getPeople());
            ps.setString(6, r.getStatus());
            ps.setInt(7, r.getUserId());        // FIXED

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public List<Reservation> getByDate(Date date) {
        String sql = "SELECT * FROM reservations WHERE reservation_date = ? ORDER BY reservation_time";
        List<Reservation> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setPhone(rs.getString("phone"));
                r.setReservationDate(rs.getDate("reservation_date"));
                r.setReservationTime(rs.getTime("reservation_time"));
                r.setPeople(rs.getInt("number_of_people"));
                r.setStatus(rs.getString("status"));
                r.setUserId(rs.getInt("user_id"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    public boolean isOwner(int reservationId, int userId) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE id=? AND user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reservationId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public void deleteReservation(int id) {
        String sql = "DELETE FROM reservations WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Reservation> getReservationsByUser(int userId, Date date) {
        String sql = "SELECT * FROM reservations WHERE user_id=? AND reservation_date=? ORDER BY reservation_date DESC, reservation_time DESC";
        List<Reservation> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setPhone(rs.getString("phone"));
                r.setReservationDate(rs.getDate("reservation_date"));
                r.setReservationTime(rs.getTime("reservation_time"));
                r.setPeople(rs.getInt("number_of_people"));
                r.setStatus(rs.getString("status"));
                r.setUserId(rs.getInt("user_id"));
                list.add(r);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

}
