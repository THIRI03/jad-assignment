/* 
	 * JAD-CA1
	 * Class-DIT/FT/2A/23
	 * Student Name: Thiri Lae Win
	 * Admin No.: P2340739
	 */

package com.cleaningService.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.ResultSet;

import com.cleaningService.model.User;
import com.cleaningService.util.DBConnection; 


public class UserDAO {

    public boolean registerUser(User user) {

        boolean isUserRegistered = false;
        String sql = "INSERT INTO users (name, email, password, phone_number, address, role_id) VALUES (?, ?, ?, ?, ?, ?)";

        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, hashedPassword);
            statement.setInt(4, user.getPhoneNum());
            statement.setString(5, user.getAddress());
            statement.setInt(6, 2);
            
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                isUserRegistered = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isUserRegistered;
    }
    
    public User getUserByEmail(String email, String password) {
    	User user = new User();
    	String sql = "SELECT * FROM users WHERE email=?";
    	
//    	System.out.println(email);
    	
    	try(Connection connection = DBConnection.getConnection()) {
    		PreparedStatement statement = connection.prepareStatement(sql);
    		
    		statement.setString(1,  email);
    		ResultSet resultSet = statement.executeQuery();
    		
    		if(resultSet.next()) {
    			user.setEmail(resultSet.getString("email"));
    			user.setRoleId(resultSet.getInt("role_id"));
    			String storedEmail = user.getEmail();
    			String storedPassword = resultSet.getString("password");
    			
    			if(BCrypt.checkpw(password, storedPassword) && storedEmail.equals(email)) {
    				user.setId(resultSet.getInt("id"));
        			user.setName(resultSet.getString("name"));
        			user.setPhoneNum(resultSet.getInt("phone_number"));
        			user.setAddress(resultSet.getString("address"));
        			        			
    				return user;
    				
    			}
    		}
    	}catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<User> retrieveAllUsers(){
    	List<User> users = new ArrayList<>();
    	String sql = "SELECT * FROM users";
    	
    	try(Connection connection = DBConnection.getConnection()) {
    		PreparedStatement statement = connection.prepareStatement(sql);
    		
    		ResultSet resultSet = statement.executeQuery();
    		
    		while(resultSet.next()) {
    			User user = new User();
    			user.setId(resultSet.getInt("id"));
    			user.setName(resultSet.getString("name"));
    			user.setPhoneNum(resultSet.getInt("phone_number"));
    			user.setAddress(resultSet.getString("address"));
    			
    			user.setEmail(resultSet.getString("email"));
    			user.setRoleId(resultSet.getInt("role_id"));
    			
    			users.add(user);
    		}
    		
    		
    	}catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    	
    }

}
