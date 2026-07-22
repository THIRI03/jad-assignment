package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Booking;
import com.cleaningService.util.DBConnection;

public class BookingDAO {

	/*
	 * Used by adminDashboard.jsp.
	 *
	 * Retrieves only a limited number of recent bookings.
	 * It does not retrieve every booking detail because the dashboard
	 * only needs a simple preview.
	 */
	public List<Booking> retrieveRecentBookings(int limit) {

		List<Booking> bookings = new ArrayList<>();

		String sql =
				"SELECT b.id, " +
				"u.name AS customer_name, " +
				"s.name AS service_name, " +
				"b.booking_date, " +
				"b.booking_time " +
				"FROM bookings b " +
				"JOIN users u ON b.userid = u.id " +
				"JOIN service s ON b.serviceid = s.id " +
				"ORDER BY b.created DESC " +
				"LIMIT ?";

		try (
			Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql)
		) {

			pstmt.setInt(1, limit);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {

					Booking booking = new Booking();

					booking.setId(rs.getInt("id"));
					booking.setCustomerName(
							rs.getString("customer_name"));
					booking.setServiceName(
							rs.getString("service_name"));
					booking.setDate(
							rs.getString("booking_date"));
					booking.setTime(
							rs.getString("booking_time"));

					bookings.add(booking);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bookings;
	}

	/*
	 * Used by adminManageBooking.jsp.
	 *
	 * Retrieves all bookings and the full details required
	 * for the booking management table.
	 */
	public List<Booking> retrieveAllBookings() {

		List<Booking> bookings = new ArrayList<>();

		String sql =
				"SELECT b.id, " +
				"b.userid, " +
				"u.name AS customer_name, " +
				"u.email AS customer_email, " +
				"u.phone_number AS customer_phone, " +
				"s.name AS service_name, " +
				"c.name AS category_name, " +
				"b.special_request, " +
				"b.duration, " +
				"b.service_address, " +
				"b.booking_date, " +
				"b.booking_time, " +
				"b.status, " +
				"b.total_price, " +
				"b.cleaner_id " +
				"FROM bookings b " +
				"JOIN users u ON b.userid = u.id " +
				"JOIN service s ON b.serviceid = s.id " +
				"JOIN category c ON b.categoryid = c.id " +
				"ORDER BY b.created DESC";

		try (
			Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()
		) {

			while (rs.next()) {

				Booking booking = new Booking();

				booking.setId(rs.getInt("id"));
				booking.setUserId(rs.getInt("userid"));

				booking.setCustomerName(
						rs.getString("customer_name"));
				
				booking.setCustomerEmail(
						rs.getString("customer_email"));

				booking.setCustomerPhone(
						rs.getString("customer_phone"));

				booking.setServiceName(
						rs.getString("service_name"));

				booking.setCategoryName(
						rs.getString("category_name"));

				booking.setSpecialRequest(
						rs.getString("special_request"));

				booking.setDuration(
						rs.getInt("duration"));

				booking.setServiceAddress(
						rs.getString("service_address"));

				booking.setDate(
						rs.getString("booking_date"));

				booking.setTime(
						rs.getString("booking_time"));

				booking.setStatus(
						rs.getString("status"));

				booking.setTotalPrice(
						rs.getDouble("total_price"));

				int cleanerId = rs.getInt("cleaner_id");

				if (rs.wasNull()) {
					booking.setCleanerId(null);
				} else {
					booking.setCleanerId(cleanerId);
				}

				bookings.add(booking);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bookings;
	}

	public int retrieveBookingNum() {

		int count = 0;

		String sql =
				"SELECT COUNT(id) AS bookings FROM bookings";

		try (
			Connection connection = DBConnection.getConnection();
			PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet resultSet = stmt.executeQuery()
		) {

			if (resultSet.next()) {
				count = resultSet.getInt("bookings");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return count;
	}
}