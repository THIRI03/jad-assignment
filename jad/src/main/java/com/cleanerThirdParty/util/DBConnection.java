
/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
package com.cleanerThirdParty.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL = "jdbc:postgresql://ep-withered-bonus-a1kbnkvx-pooler.ap-southeast-1.aws.neon.tech/neondb?user=neondb_owner&password=npg_2xnfZgarR5Tu&sslmode=require";
    private static final String USER = "neondb_owner";
    private static final String PASSWORD = "npg_2xnfZgarR5Tu";

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
