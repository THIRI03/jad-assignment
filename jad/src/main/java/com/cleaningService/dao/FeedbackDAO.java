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
	 * JAD-CA1
	 * Class-DIT/FT/2A/23
	 * Student Name: Moe Myat Thwe
	 * Admin No.: P2340362
	 */
	
    public boolean addFeedback(int userId, int bookingId, int subServiceId, String comments, int rating) {
        String sql = "INSERT INTO feedback (user_id, booking_id, sub_service_id, comments, rating) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, bookingId);
            statement.setInt(3, subServiceId);
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
	 * JAD-CA1
	 * Class-DIT/FT/2A/23
	 * Student Name: Thiri Lae Win
	 * Admin No.: P2340739
	 */
    
    /////////////////////////////////////////////////////////////////////////////
    // ADMIN side
    /////////////////////////////////////////////////////////////////////////////
    public int retrieveFeedbackNum() {
    	int count = 0;
	    String sql = "SELECT COUNT(feedback_id) AS feedbackCount FROM feedback";

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
        String sql = "SELECT fb.feedback_id, fb.comments, fb.rating, u.name AS customer_name, s.service_name AS service_name "
                     + "FROM feedback fb "
                     + "JOIN users u ON fb.user_id = u.id "
                     + "JOIN service s ON fb.service_id = s.service_id ";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Feedback feedback = new Feedback(0,null,0,null,null,0);
                
                feedback.setId(rs.getInt("feedback_id"));
                feedback.setUsername(rs.getString("customer_name"));  // Correctly map customer_name
                feedback.setServiceName(rs.getString("service_name")); // Correctly map service_name
                feedback.setRating(rs.getInt("rating"));
                feedback.setComments(rs.getString("comments"));
                
                feedbackList.add(feedback);
                System.out.println("id" + feedback.getId());
                System.out.println("comment" + feedback.getComments());
                System.out.println("name" + feedback.getUsername());

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Feedback list size: " + feedbackList.size()); // Check how many records are retrieved
        return feedbackList;  
    }
}
