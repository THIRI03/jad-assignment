
package com.cleanerThirdParty.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cleanerThirdParty.model.Cleaner;
import com.cleanerThirdParty.util.DBConnection;

public class CleanerDAO {

	
	/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
	public Cleaner getCleanerByEmail(String email) {
    	Cleaner cleaner = new Cleaner();
    	String sql = "SELECT * FROM cleaners WHERE email=?";

    	try(Connection connection = DBConnection.getConnection()) {
    		PreparedStatement statement = connection.prepareStatement(sql);

    		statement.setString(1,  email);
    		ResultSet resultSet = statement.executeQuery();

    		if(resultSet.next()) {
    			cleaner.setId(resultSet.getInt("id"));
    			cleaner.setEmail(resultSet.getString("email"));
    			System.out.print(cleaner.getId() + "at dao");
    			return cleaner;
    		}
    	}catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
