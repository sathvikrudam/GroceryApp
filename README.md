## GroceryApp – JSP-Based Online Grocery Store

## Overview
**GroceryApp** is a simple web-based online grocery shopping system built using **JSP**, **JDBC**, and **MySQL**, designed to demonstrate web technologies for the **Web Technology and Services (WTS)** project.

Users can register, log in, browse products, add them to the cart, and place orders.  
Admins can log in to manage products, view orders, and update inventory.

---

## Features
### User
- Register and log in
- Browse and search for grocery items
- Add items to the cart
- Place orders and view order summaries

### Admin / Seller
- Log in to admin dashboard
- Add, edit, and delete grocery items
- View all orders placed by users

---

## Technologies Used
- **Frontend:** JSP, HTML, CSS
- **Backend:** JSP (Java), JDBC
- **Database:** MySQL
- **Server:** Apache Tomcat

---

## Project Structure

GroceryApp/
├── db/
│ └── DBConnection.java
├── jsp/
│ ├── add_item.jsp
│ ├── admin_dashboard.jsp
│ ├── admin_login.jsp
│ ├── cart.jsp
│ ├── edit_inventory.jsp
│ ├── edit_item.jsp
│ ├── login.jsp
│ ├── order_success.jsp
│ ├── order_summary.jsp
│ ├── register.jsp
│ ├── register_admin.jsp
│ ├── shop.jsp
│ └── view_orders.jsp
├── servlet/
│ ├── AddItemServlet.java
│ ├── AddToCartServlet.java
│ ├── AdminLoginServlet.java
│ ├── AdminLogoutServlet.java
│ ├── DeleteItemServlet.java
│ ├── LoginServlet.java
│ ├── LogoutServlet.java
│ ├── PlaceOrderServlet.java
│ ├── RegisterAdminServlet.java
│ ├── RegisterServlet.java
│ └── UpdateItemServlet.java
├── WEB-INF/
│ └── web.xml
└── .gitignore

---

## Setup Instructions

### 1️⃣ Prerequisites
- Install **Apache Tomcat** (version 9 or above)
- Install **MySQL**
- Java JDK 8+ installed

### 2️⃣ Database Setup
1. Create a database in MySQL:
   ```sql
   CREATE DATABASE grocerydb;
2. Update your DBConnection.java file with your MySQL username, password, and DB name.

### 3️⃣ Deploying the App

Copy the GroceryApp folder to Tomcat’s webapps directory:

/Applications/tomcat/webapps/GroceryApp


Start Tomcat.

Open a browser and go to:

http://localhost:8080/GroceryApp/jsp/login.jsp

---

## Screenshots:

<img width="1470" height="956" alt="login" src="https://github.com/user-attachments/assets/ccdcfbdf-6900-4f5c-a64f-9dd8d1e30727" />
<img width="1470" height="956" alt="seller-registration" src="https://github.com/user-attachments/assets/473e7aab-dc2d-4645-8695-f63cbe8faf1a" />
<img width="1470" height="956" alt="seller-login" src="https://github.com/user-attachments/assets/742ba3d4-6ee3-40fe-9dbe-832d6c14cdb5" />
<img width="1470" height="956" alt="seller-dashboard" src="https://github.com/user-attachments/assets/6cecb798-a6e1-4740-afa4-4cecdd87b721" />
<img width="1470" height="956" alt="seller-add-items" src="https://github.com/user-attachments/assets/6b06795d-f4da-4f02-b778-a1941ee7a4c9" />
<img width="1470" height="956" alt="seller-item-inventory" src="https://github.com/user-attachments/assets/74e296af-5b93-465d-a63c-3aea779e7bb3" />
<img width="1470" height="956" alt="seller-order-tracking" src="https://github.com/user-attachments/assets/6bea0c30-f5f1-4052-b953-73e1f0432ea0" />

<img width="1470" height="956" alt="user-registration" src="https://github.com/user-attachments/assets/b7361af9-4607-461b-975c-439d91a6b5dd" />
<img width="1470" height="956" alt="user-login" src="https://github.com/user-attachments/assets/72f11842-c380-4703-af8b-ede1dd6181a5" />
<img width="1470" height="956" alt="user-purchasing-prod" src="https://github.com/user-attachments/assets/44bfd4d9-1564-4649-a7af-9632a534ae05" />
<img width="1470" height="956" alt="user-cart" src="https://github.com/user-attachments/assets/2d928483-6233-4051-ae5c-535cd3d42b2a" />
<img width="1470" height="956" alt="user-confirm-order" src="https://github.com/user-attachments/assets/588f693e-bb69-4b14-b03b-67be10c82308" />

