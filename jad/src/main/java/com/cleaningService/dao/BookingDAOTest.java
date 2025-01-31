package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Booking;
import com.cleaningService.util.DBConnection;

public class BookingDAOTest {

	/*
	 * JAD-CA1 Class-DIT/FT/2A/23 Student Name: Thiri Lae Win 
	 * Admin No.: P2340739
	 */

	/////////////////////////////////////////////////////////////////////////////
	// ADMIN side
	/////////////////////////////////////////////////////////////////////////////

	/*
	 * public int retrieveBookingNum() { int count = 0; String sql =
	 * "SELECT COUNT(id) AS bookingCount FROM bookings";
	 * 
	 * try (Connection connection = DBConnection.getConnection(); PreparedStatement
	 * stmt = connection.prepareStatement(sql); ResultSet resultSet =
	 * stmt.executeQuery()) {
	 * 
	 * if (resultSet.next()) { count = resultSet.getInt("bookingCount"); } } catch
	 * (SQLException e) { e.printStackTrace(); } System.out.print(count); return
	 * count; }
	 */

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


	public List<Booking> retrieveAllBookings() {
		List<Booking> bookings = new ArrayList<>();
		String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, b.booking_date, c.name AS category_name "
				+ "FROM bookings b " + "JOIN users u ON b.userid = u.id " + "JOIN service s ON b.serviceid = s.id "
				+ "JOIN category c ON b.categoryid = c.id";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Booking booking = new Booking();
				booking.setId(rs.getInt("id"));
				booking.setCustomerName(rs.getString("customer_name"));
				booking.setServiceName(rs.getString("service_name"));
				booking.setDate(rs.getString("booking_date"));
				booking.setCategoryName(rs.getString("category_name"));

				bookings.add(booking);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bookings;
	}

	/*
	 * JAD-CA1 Class-DIT/FT/2A/23 Student Name: Moe Myat Thwe Admin No.: P2340362
	 */

	public boolean createBooking(int userId, int categoryId, int serviceId, String date, String time, int duration,
			String serviceAddress, String specialRequest) {
		String sql = "INSERT INTO bookings (user_id, categoryid, serviceid, date, time, duration, service_address, special_request) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {

			Date sqlDate = Date.valueOf(date);
			Time sqlTime = Time.valueOf(time + ":00");

			statement.setInt(1, userId);
			statement.setInt(2, categoryId);
			statement.setInt(3, serviceId);
			statement.setDate(4, sqlDate);
			statement.setTime(5, sqlTime);
			statement.setInt(6, duration);
			statement.setString(7, serviceAddress);
			statement.setString(8, specialRequest);

			int rowsInserted = statement.executeUpdate();
			return rowsInserted > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
