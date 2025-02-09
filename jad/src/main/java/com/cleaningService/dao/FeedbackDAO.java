/*-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--*/
package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Feedback;
import com.cleaningService.util.DBConnection;

public class FeedbackDAO {
	
	/* 
	 * JAD-CA2
	 * Class-DIT/FT/2A/23
	 * Student Name: Moe Myat Thwe
	 * Admin No.: P2340362
	 */
	
	public boolean addFeedback(int userId, int bookingId, int serviceId, String comments, int rating) {
        // Update to match the correct column names
        String sql = "INSERT INTO feedback (userid, bookingid, serviceid, comment, rating) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Set values in the query
            statement.setInt(1, userId);
            statement.setInt(2, bookingId);
            statement.setInt(3, serviceId);
            statement.setString(4, comments);
            statement.setInt(5, rating);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


	/*
	 * JAD-CA2
	 * Class-DIT/FT/2A/23
	 * Student Name: Thiri Lae Win
	 * Admin No.: P2340739
	 */

    /////////////////////////////////////////////////////////////////////////////
    // ADMIN side
    /////////////////////////////////////////////////////////////////////////////
    public int retrieveFeedbackNum() {
    	int count = 0;
	    String sql = "SELECT COUNT(id) AS feedbackCount FROM feedback";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql);
	         ResultSet resultSet = stmt.executeQuery()) {

	        if (resultSet.next()) {
	            count = resultSet.getInt("feedbackCount");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
    }

    public List<Feedback> retrieveAllFeedbacks() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT fb.id, fb.comment, fb.rating, u.name AS customer_name, s.name AS service_name, fb.bookingid "
                     + "FROM feedback fb "
                     + "JOIN users u ON fb.userid = u.id "
                     + "JOIN service s ON fb.serviceid = s.id ";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Feedback feedback = new Feedback(0,null,0,null,null,0);

                feedback.setId(rs.getInt("id"));
                feedback.setUsername(rs.getString("customer_name"));  // Correctly map customer_name
                feedback.setServiceName(rs.getString("service_name")); // Correctly map service_name
                feedback.setRating(rs.getInt("rating"));
                feedback.setComments(rs.getString("comment"));
                feedback.setBooking_id(rs.getInt("bookingid"));

                feedbackList.add(feedback);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
    
    public List<Feedback> retrieveAllFeedbacksByRating(int rating) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT fb.id, fb.comment, fb.rating, u.name AS customer_name, s.name AS service_name, fb.bookingid "
                     + "FROM feedback fb "
                     + "JOIN users u ON fb.userid = u.id "
                     + "JOIN service s ON fb.serviceid = s.id "
                     + "WHERE rating = ? ";
        

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement pstmt = connection.prepareStatement(sql)) {

               // Set the rating parameter
               pstmt.setInt(1, rating);

               try (ResultSet rs = pstmt.executeQuery()) {
                   while (rs.next()) {
                       Feedback feedback = new Feedback(0, null, 0, null, null, 0);
                       feedback.setId(rs.getInt("id"));
                       feedback.setUsername(rs.getString("customer_name"));  // Correctly map customer_name
                       feedback.setServiceName(rs.getString("service_name")); // Correctly map service_name
                       feedback.setRating(rs.getInt("rating"));
                       feedback.setComments(rs.getString("comment"));
                       feedback.setBooking_id(rs.getInt("bookingid"));

                       feedbackList.add(feedback);
                   }
               }

           } catch (SQLException e) {
               e.printStackTrace();
           }
        return feedbackList;
    }


}
