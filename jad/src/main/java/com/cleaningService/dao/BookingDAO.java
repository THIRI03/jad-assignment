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
	
	// parameters are passed to sort the booking view
	public List<Booking> retrieveAllBookings(String sortColumn) {
		List<Booking> bookings = new ArrayList<>();
 
		String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, b.booking_date, b.booking_time, c.name AS category_name, b.status "
				+ "FROM bookings b " + "JOIN users u ON b.userid = u.id " + "JOIN service s ON b.serviceid = s.id "
				+ "JOIN category c ON b.categoryid = c.id "
				+ "ORDER BY b." + sortColumn + " ASC";

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
	
	public List<Booking> retrieveAllBookingsByGrouping(String status) {
		List<Booking> bookings = new ArrayList<>();
				
		String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, b.booking_date, b.booking_time, c.name AS category_name, b.status "
					+ "FROM bookings b " + "JOIN users u ON b.userid = u.id " + "JOIN service s ON b.serviceid = s.id "
					+ "JOIN category c ON b.categoryid = c.id "
					+ "WHERE b.status = ? "
					+ "ORDER BY b.id ASC";
		
		try (Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, status); 


			ResultSet rs = pstmt.executeQuery();
				
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
	    String sql = "SELECT COUNT(id) AS bookings FROM bookings";

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
}
