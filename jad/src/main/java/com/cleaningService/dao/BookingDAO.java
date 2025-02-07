package com.cleaningService.dao;

import java.net.ResponseCache;
import java.net.http.HttpRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Booking;
import com.cleaningService.util.DBConnection;

import jakarta.ws.rs.core.Request;

public class BookingDAO {
	
	public List<Booking> retrieveAllBookings(){
		List<Booking> bookings = new ArrayList<>();
		 
		String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, b.booking_date, b.booking_time, c.name AS category_name, b.status "
				+ "FROM bookings b " + "JOIN users u ON b.userid = u.id " + "JOIN service s ON b.serviceid = s.id "
				+ "JOIN category c ON b.categoryid = c.id "
				+ "ORDER BY b.id ASC";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Booking booking = new Booking();
				booking.setId(rs.getInt("id"));
				booking.setCustomerName(rs.getString("customer_name"));
				booking.setServiceName(rs.getString("service_name"));
				booking.setDate(rs.getString("booking_date"));
				booking.setTime(rs.getString("booking_time"));
				booking.setCategoryName(rs.getString("category_name"));
				booking.setStatus(rs.getString("status"));

				bookings.add(booking);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bookings;
	}
	
	// parameters are passed to sort the booking view
	public List<Booking> retrieveAllBookingsBySortedAndStatus(String sortColumn, String status) {
		List<Booking> bookings = new ArrayList<>();
 
		String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, b.booking_date, b.booking_time, c.name AS category_name, b.status "
				+ "FROM bookings b " + "JOIN users u ON b.userid = u.id " + "JOIN service s ON b.serviceid = s.id "
				+ "JOIN category c ON b.categoryid = c.id "
				+ "WHERE b.status = ? "
				+ "ORDER BY b." + sortColumn + " ASC";

		try (Connection connection = DBConnection.getConnection();
		         PreparedStatement pstmt = connection.prepareStatement(sql)) {
		        
		        // Set the status value in the prepared statement
		        pstmt.setString(1, status); // Set the first parameter as 'status'

		        try (ResultSet rs = pstmt.executeQuery()) {
		            while (rs.next()) {
		                Booking booking = new Booking();
		                booking.setId(rs.getInt("id"));
		                booking.setCustomerName(rs.getString("customer_name"));
		                booking.setServiceName(rs.getString("service_name"));
		                booking.setDate(rs.getString("booking_date"));
		                booking.setTime(rs.getString("booking_time"));
		                booking.setCategoryName(rs.getString("category_name"));
		                booking.setStatus(rs.getString("status"));

		                bookings.add(booking);
		            }
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		return bookings;
	}
	
	public Booking retrieveBookingById(int booking_id) {
		Booking booking = new Booking();
		
		String sql = "SELECT b.id, b.special_request, b.duration, b.service_address, u.name AS customer_name, b.userid, s.name AS service_name, "
				+ "s.image AS service_image, c.name as category_name, b.booking_date, b.booking_time, b.status "
				+"FROM bookings b " 
				+ "JOIN category c ON b.categoryid = c.id " 
				+ "JOIN service s ON b.serviceid = s.id "
				+ "JOIN users u ON b.userid = u.id "
				+ "WHERE b.id = ?";
		
		try (Connection connection = DBConnection.getConnection();
		         PreparedStatement pstmt = connection.prepareStatement(sql)) {
		        
		        pstmt.setInt(1, booking_id); 

		        try (ResultSet rs = pstmt.executeQuery()) {
		            while (rs.next()) {
		                booking.setId(rs.getInt("id"));
		                booking.setSpecialRequest(rs.getString("special_request"));
		                booking.setDuration(rs.getInt("duration"));  
		                booking.setServiceAddress(rs.getString("service_address"));
		                booking.setCustomerName(rs.getString("customer_name"));
		                booking.setServiceName(rs.getString("service_name"));
		                booking.setDate(rs.getString("booking_date"));
		                booking.setTime(rs.getString("booking_time"));
		                booking.setCategoryName(rs.getString("category_name"));
		                booking.setStatus(rs.getString("status"));
		                booking.setServiceImage(rs.getString("service_image"));
		            }
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		return booking;
		
		
	}
	
	// this is for dashboard, where the not completed and in progress bookings will be shown
	public List<Booking> retrieveBookingForDashboard() {
		List<Booking> bookings = new ArrayList<>();
 
		String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, b.booking_date, b.booking_time, c.name AS category_name, b.status "
				+ "FROM bookings b " + "JOIN users u ON b.userid = u.id " + "JOIN service s ON b.serviceid = s.id "
				+ "JOIN category c ON b.categoryid = c.id WHERE b.status != 'Completed' "
				+ "ORDER BY b.id ASC";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Booking booking = new Booking();
				booking.setId(rs.getInt("id"));
				booking.setCustomerName(rs.getString("customer_name"));
				booking.setServiceName(rs.getString("service_name"));
				booking.setDate(rs.getString("booking_date"));
				booking.setTime(rs.getString("booking_time"));
				booking.setCategoryName(rs.getString("category_name"));
				booking.setStatus(rs.getString("status"));

				bookings.add(booking);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bookings;
	}
	
	
	public int retrieveBookingNum() {
	    int count = 0;
	    String sql = "SELECT COUNT(id) AS bookings FROM bookings WHERE status != 'Completed' ";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql);
	         ResultSet resultSet = stmt.executeQuery()) {
	        if (resultSet.next()) {
	            count = resultSet.getInt("bookings");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	
	public boolean updateBookingStatus(int id, String status) {
		boolean isUpdated = false;

		String sql = "UPDATE bookings SET status = ? WHERE id = ?";
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql)){
			stmt.setString(1, status);
			stmt.setInt(2, id);
			
			int rowsAffected = stmt.executeUpdate();
			
			if(rowsAffected > 0) {
				isUpdated = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isUpdated;
	}
	
}
