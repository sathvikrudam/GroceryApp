package db;

import java.sql.*;

public class DBConnection {

    // Always return a fresh connection
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/grocerydb",
            "root",
            "sathvik1"
        );
    }
}
