#  Campus Lost & Found Portal

A web application designed for educational campuses to help students, faculty, and staff report lost items and claim found ones. The system features a responsive, modern interface with a comprehensive admin dashboard to verify ownership and manage claims.

---

##  Features

###  User Module
* **User Authentication:** Secure registration and login for students and staff.
* **Report Items:** Report both lost and found items with title, category, description, location, date, and image uploads.
* **Dashboard & My Items:** Users can manage their reported items, view their statuses, and check claim requests.
* **Claim System:** Users can claim found items by submitting detailed proof of ownership.
* **Detailed View:** View detailed item listings with upload images, dates, and locations.

###  Admin Module
* **Admin Authentication:** Secure login for system administrators.
* **Dashboard Stats:** High-level dashboard displaying claims pending, items reported, and category distribution.
* **Claim Management:** Approve or reject claims after verifying proof of ownership submitted by users.
* **Item Moderation:** Delete items or resolve them once successfully claimed.
* **Report Downloads:** Export PDF/Excel summaries of active and resolved items.

---

##  Tech Stack

* **Frontend:** JSP (JavaServer Pages), CSS (Modern Glassmorphic styling), JavaScript
* **Backend:** Java Servlets, JDBC (Java Database Connectivity)
* **Database:** MySQL
* **Build/Server:** Tomcat Server (v9.0+ recommended), Eclipse IDE

---

##  Folder Structure

```text
LostFound/
├── .settings/            # Eclipse IDE project settings
├── build/                # Compiled Java class files
├── src/
│   └── main/
│       ├── java/
│       │   └── com/lostfound/
│       │       ├── dao/       # Data Access Objects (DB query logic)
│       │       ├── model/     # Java Beans / Models (User, Item, Claim, Admin)
│       │       ├── servlet/   # Servlets (Controllers handling HTTP requests)
│       │       └── util/      # Utility classes (DBConnection helper)
│       └── webapp/
│           ├── css/           # Styling files
│           ├── images/
│           │   └── uploads/   # User uploaded images directory
│           ├── js/            # Client-side JavaScript
│           ├── jsp/           # Dynamic JSP pages (Admin and User pages)
│           ├── WEB-INF/       # Web application configuration
│           └── index.jsp      # Main landing page
├── database_setup.sql    # Database schema and seed data
└── .gitignore            # Rules for Git to ignore temporary/compiled files
```

---

##  Setup & Installation

### Prerequisite Software
1. **JDK 8 or higher** (JDK 11+ recommended)
2. **Eclipse IDE for Enterprise Java Developers**
3. **Apache Tomcat Server** (v9.0 or v10.0)
4. **MySQL Server & MySQL Workbench**

### 1. Database Setup
1. Open MySQL Workbench or phpMyAdmin.
2. Run the SQL commands provided in the [database_setup.sql](database_setup.sql) file.
3. This will create the database `lostfound_db` and pre-populate sample data:
   * **Default Admin Username:** `admin`
   * **Default Admin Password:** `admin123`
   * **Sample User Passwords:** `password123`

### 2. Configure Database Connection
1. Open Eclipse and import the project.
2. Navigate to `src/main/java/com/lostfound/util/DBConnection.java`.
3. Modify the database URL, user, and password variables to match your MySQL database setup:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/lostfound_db";
   private static final String USER = "your_mysql_username";
   private static final String PASSWORD = "your_mysql_password";
   ```

### 3. Deploying in Eclipse
1. Right-click the project in Eclipse **Project Explorer**.
2. Select **Run As** > **Run on Server**.
3. Choose your configured **Apache Tomcat Server**.
4. Click **Finish**. The application will launch in your browser at `http://localhost:8080/LostFound/` (or your configured port).
