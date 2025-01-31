
//    JAD-CA1
//    Class-DIT/FT/2A/23
//    Student Name: Thiri Lae Win
//    Admin No.: P2340739
package com.cleaningService.util;
import java.sql.*;

public class DBConnection {
	private static final String URL = "jdbc:postgresql://ep-black-sea-a1x1cg6b.ap-southeast-1.aws.neon.tech/jad_assignment?user=neondb_owner&password=nYHFhP9l5UaJ&sslmode=require";
    private static final String USER = "neondb_owner";
    private static final String PASSWORD = "nYHFhP9l5UaJ";

    public static Connection getConnection() throws SQLException {
        try {
            // Load PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    public static void testConnection() {
    	try {
    	    Connection connection = getConnection();
    	    System.out.println("Connection successful: " + connection);
    	} catch (SQLException e) {
    	    System.err.println("Error Code: " + e.getErrorCode());
    	    System.err.println("SQL State: " + e.getSQLState());
    	    e.printStackTrace();
    	}

    }
    
    public static void main(String[] args) {
    	testConnection();
    }

}
