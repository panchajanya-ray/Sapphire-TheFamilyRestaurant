package com.restaurantmanagement.model;

import java.sql.Date;
import java.sql.Time;

public class Reservation {
    private int id;
    private String customerName;
    private String phone;
    private Date reservationDate;
    private Time reservationTime;
    private int people;
    private String status;
    private int userId;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Date getReservationDate() { return reservationDate; }
    public void setReservationDate(Date reservationDate) { this.reservationDate = reservationDate; }

    public Time getReservationTime() { return reservationTime; }
    public void setReservationTime(Time reservationTime) { this.reservationTime = reservationTime; }

    public int getPeople() { return people; }
    public void setPeople(int people) { this.people = people; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
