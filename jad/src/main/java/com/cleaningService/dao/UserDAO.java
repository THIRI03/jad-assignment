/*
	 * JAD-CA1
	 * Class-DIT/FT/2A/23
	 * Student Name: Thiri Lae Win
	 * Admin No.: P2340739
	 */

package com.cleaningService.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import com.cleaningService.model.User;
import com.cleaningService.util.DBConnection;


public class UserDAO {

	/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
    public boolean registerUser(User user) {

        boolean isUserRegistered = false;
        String sql = "INSERT INTO users (name, email, password, phone_number, address, postal_code, role_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, hashedPassword);
            statement.setInt(4, user.getPhoneNum());
            statement.setString(5, user.getAddress());
            statement.setInt(6, user.getPostalCode());
            statement.setInt(7, 2);

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

    public User retrieveUserById(int id) {
        User user = new User();

        String sql = "SELECT name, address, postal_code, email, phone_number FROM users WHERE id = ?";
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user.setName(resultSet.getString("name"));
                user.setAddress(resultSet.getString("address"));
                user.setPostalCode(resultSet.getInt("postal_code"));
                user.setEmail(resultSet.getString("email"));
                user.setPhoneNum(resultSet.getInt("phone_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public User retrieveUserPwdById(int id) {
        User user = new User();

        String sql = "SELECT password FROM users WHERE id = ?";
        try (Connection connection = DBConnection.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user.setPassword(resultSet.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // retrieve members only, admin excluded
    public List<User> retrieveAllUsers(){
    	List<User> users = new ArrayList<>();
    	String sql = "SELECT u.id, u.name, u.phone_number, u.address, u.email, u.role_id, "
                + "COALESCE(SUM(b.total_price), 0) AS total_spent "
                + "FROM users u "
                + "LEFT JOIN bookings b ON u.id = b.userid "
                + "WHERE u.role_id != 1 "
                + "GROUP BY u.id "
                + "ORDER BY u.id ASC";
    	try(Connection connection = DBConnection.getConnection()) {
    		PreparedStatement statement = connection.prepareStatement(sql);

    		ResultSet resultSet = statement.executeQuery();

    		while(resultSet.next()) {
    			User user = new User();
    			user.setId(resultSet.getInt("id"));
    			user.setName(resultSet.getString("name"));
    			user.setPhoneNum(resultSet.getInt("phone_number"));
    			user.setAddress(resultSet.getString("address"));
    			user.setTotalSpent(resultSet.getDouble("total_spent"));
    			user.setEmail(resultSet.getString("email"));
    			user.setRoleId(resultSet.getInt("role_id"));

    			users.add(user);
    		}


    	}catch (SQLException e) {
            e.printStackTrace();
        }
        return users;

    }

    public boolean deleteUser(int id) {
    	boolean isDeleted = false;

    	String sql = "DELETE FROM users WHERE id = ?";
    	try(Connection connection = DBConnection.getConnection()) {
    		PreparedStatement statement = connection.prepareStatement(sql);

    		statement.setInt(1, id);

    		int result = statement.executeUpdate();
			if(result > 0) {
				isDeleted = true;
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}

    	return isDeleted;
    }

    public boolean updateUserInformation(String name, String email, int phone_num, int id) {
    	boolean isUpdated = false;

    	String sql = "UPDATE users SET name = ?, email = ?, phone_number = ? WHERE id = ?";
    	try(Connection connection = DBConnection.getConnection();
    			PreparedStatement stmt = connection.prepareStatement(sql)){
    		stmt.setString(1, name);
    		stmt.setString(2, email);
    		stmt.setInt(3, phone_num);
    		stmt.setInt(4, id);

    		int rowsAffected = stmt.executeUpdate();

    		if(rowsAffected > 0) {
    			isUpdated = true;
    		}
    	}catch(SQLException e) {
			e.printStackTrace();
		}
		return isUpdated;

    }

    public boolean updateUserPassword(String password, int userId) {
    	boolean isUpdated = false;

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    	String sql = "UPDATE users SET password = ? WHERE id = ?";
    	try(Connection connection = DBConnection.getConnection();
    			PreparedStatement stmt = connection.prepareStatement(sql)){
    		stmt.setString(1, hashedPassword);
    		stmt.setInt(2, userId);

    		int rowsAffected = stmt.executeUpdate();

    		if(rowsAffected > 0) {
    			isUpdated = true;
    		}

    	}catch(SQLException e) {
			e.printStackTrace();
		}

    	return isUpdated;
    }

    public List<User> retrieveUserByName(String username){
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id, u.name, u.phone_number, u.address, u.email, "
                    + "COALESCE(SUM(b.total_price), 0) AS total_spent "
                    + "FROM users u "
                    + "LEFT JOIN bookings b ON u.id = b.userid "
                    + "WHERE LOWER(u.name) LIKE ? AND u.role_id != 1 "
                    + "GROUP BY u.id";
        try(Connection connection = DBConnection.getConnection()) {
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, "%" + username + "%");
            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setPhoneNum(resultSet.getInt("phone_number"));
                user.setAddress(resultSet.getString("address"));
                user.setEmail(resultSet.getString("email"));
                user.setTotalSpent(resultSet.getDouble("total_spent"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }


    public List<User> retrieveUserBySpending(String input){
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id, u.name, u.phone_number, u.address, u.email, u.role_id, "
                    + "COALESCE(SUM(b.total_price), 0) AS total_spent "
                    + "FROM users u "
                    + "JOIN bookings b ON u.id = b.userid "
                    + "WHERE u.role_id != 1 "
                    + "GROUP BY u.id "
                    + "ORDER BY total_spent DESC "
                    + "LIMIT 10";
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
                user.setTotalSpent(resultSet.getDouble("total_spent"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }


	// using last booking date of each user
	// find the users with no booking
	// find the users whose last booking was more than 6 months ago
	public List<User> retrieveUserByInactivity(String input){

		List<User> users = new ArrayList<>();
		String sql = "SELECT u.id, u.name, u.phone_number, u.address, MAX(b.created) AS last_booking_date, u.email, "
				+ "SUM(b.total_price) AS total_spent "
				+ "FROM users u "
				+"LEFT JOIN bookings b ON u.id = b.userid "
				+ "WHERE u.role_id != 1 "
				+ "GROUP BY u.id "
				+ "HAVING MAX(b.created) IS NULL OR MAX(b.created) < NOW() - INTERVAL '6 months' "
				+"ORDER BY last_booking_date ASC "
				+"LIMIT 10";


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
				user.setTotalSpent(resultSet.getDouble("total_spent"));

				users.add(user);
			}


		}catch (SQLException e) {
	        e.printStackTrace();
	    }
		return users;
	}
}
