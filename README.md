# 🍽️ Sapphire: The Family Restaurant

### Restaurant Management System (Java Servlet + JSP)

---

## 📌 Overview

**Sapphire: The Family Restaurant** is a full-stack web-based Restaurant Management System built using **Java Servlets, JSP, JDBC, and MySQL**.

The system allows **Admin, Staff, and Customers** to manage:

* Orders
* Reservations
* Menu
* Payments (UPI + Counter)
* Reports & Analytics

It simulates a **real-world restaurant POS system** with role-based access and payment workflow.

---

## 🚀 Features

### 👤 Role-Based Access

* **Admin**

  * Full system control
  * Menu management
  * Reports dashboard
* **Staff**

  * Manage orders & reservations
* **Customer**

  * Place orders & reservations
  * Limited access (no full data visibility)

---

### 🧾 Order Management

* Create multiple-item orders
* Auto price calculation
* Discount support
* Invoice generation
* Order status tracking

---

### 📅 Reservation System

* Book tables with date & time
* Filter reservations by date
* Cancel reservation (user-specific control)

---

### 💳 Payment System (UPI + Counter)

* **Pay at Counter**

  * Order remains pending
* **UPI Payment**

  * Dynamic QR code generation
  * Payment simulation
  * Success / Failure handling
  * Auto status update

---

### 🧾 Invoice Generation

* Detailed invoice with:

  * Items
  * Quantity
  * Price
  * Discount
  * GST calculation
* Professional UI design

---

### 📊 Reports Dashboard

* Interactive charts using **Chart.js**
* 3 analytics:

  * Orders
  * Reservations
  * Total Sales
* View:

  * Day-wise
  * Month-wise
  * Year-wise

---

### 🎨 UI/UX

* Built with **Tailwind CSS**
* Dark theme with neon accents
* Responsive layout
* Clean dashboard design

---

## 🛠️ Tech Stack

| Layer        | Technology                          |
| ------------ | ----------------------------------- |
| Frontend     | JSP, HTML, Tailwind CSS, JavaScript |
| Backend      | Java Servlets                       |
| Database     | MySQL                               |
| Connectivity | JDBC                                |
| Charts       | Chart.js                            |
| Server       | Apache Tomcat 10                    |

---

## 🗂️ Project Structure

```
JavaProjectSem1/
│
├── src/main/java/
│   ├── controller/
│   │   ├── AdminServlet.java
│   │   ├── CancelReservationServlet.java
│   │   ├── DashboardServlet.java
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── MenuItemStatusServlet.java
│   │   ├── MenuServlet.java
│   │   ├── OrderServlet.java
│   │   ├── OrderStatusServlet.java
│   │   ├── PaymentResultServlet.java
│   │   ├── PaymentServlet.java
│   │   ├── ReportServlet.java
│   │   ├── ReservationServlet.java
│   │   └── SignupServlet.java
│   │
│   ├── dao/
│   │   ├── MenuItemDAO.java
│   │   ├── OrderDAO.java
│   │   ├── OrderItemDAO.java
│   │   ├── ReportDAO.java
│   │   ├── ReservationDAO.java
│   │   └── UserDAO.java
│   │
│   ├── filter/
│   │   ├── AdminFilter.java
│   │   └── AuthFilter.java
│   │
│   ├── model/
│   │   ├── InvoiceItem.java
│   │   ├── MenuItem.java
│   │   ├── Order.java
│   │   ├── OrderItem.java
│   │   ├── Reservation.java
│   │   └── User.java
│   │
│   └── util/
│       └── DBConnection.java
│
├── src/main/webapp/
│   ├── dashboard.java
│   ├── index.jsp
│   |── invoice.jsp
│   |── menu.jsp
│   |── orders.jsp
│   |── paymentStatus.jsp
│   |── reports.jsp
│   |── reservations.jsp
│   |── signup.jsp
│   └── upiPayment.jsp
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone Repository

```
git clone https://github.com/your-username/restaurant-management.git
```

---

### 2️⃣ Database Setup

Create database:

```sql
CREATE DATABASE restaurantmanagement;
USE restaurantmanagement;
```

Import tables (example):

```sql

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    description VARCHAR(255),
    status VARCHAR(50) DEFAULT 'available'
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    customer_name VARCHAR(150),
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'pending',
    payment_method VARCHAR(20),
    ADD payment_status VARCHAR(20) DEFAULT 'pending';
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id)
);

CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    reservation_date DATE NOT NULL,
    reservation_time TIME NOT NULL,
    number_of_people INT NOT NULL,
    status VARCHAR(50) DEFAULT 'confirmed'
);
```

---

### 3️⃣ Configure DB Connection

Edit:

```
DBConnection.java
```

```java
String url = "jdbc:mysql://localhost:3306/restaurant_db";
String user = "your_username";
String password = "your_password";
```

---

### 4️⃣ Run Project

* Deploy on **Apache Tomcat 10**
* Open:

```
http://localhost:8080/JavaProjectSem1
```

---

## 🔄 System Flow

```
Login
 ↓
Dashboard
 ↓
Create Order
 ↓
Generate Invoice
 ↓
Choose Payment
 ↓
UPI / Counter
 ↓
Update Status
 ↓
Reports Dashboard
```

---

## 📸 Screens

* Dashboard
* Orders Page
* Invoice Page
* Payment QR
* Reports


---

## 🧠 Key Concepts Used

* MVC Architecture (Servlet + JSP)
* Session Management
* JDBC CRUD Operations
* Dynamic UI Rendering
* Role-Based Authorization
* Payment Workflow Simulation
* Data Visualization

---

## ⚠️ Limitations

* Payment is simulated (no real gateway)
* No real-time updates
* No external API integration

---

## 🚀 Future Enhancements

* 🔐 Real Payment Gateway (Razorpay/Stripe)
* 📱 Mobile responsive improvements
* 📄 PDF invoice download
* 🔔 Notification system
* 🍳 Kitchen display system
* 📊 Advanced analytics

---

## 👨‍💻 Author

**Panchajanya Ray**

---

## ⭐ Acknowledgement

This project is built for academic learning and demonstrates a real-world restaurant system.

---

## 📜 License

This project is for educational purposes.
