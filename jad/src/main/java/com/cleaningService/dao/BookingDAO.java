/* 
 * JAD-CA1
 * Class-DIT/FT/2A/23
 * Student Name: Moe Myat Thwe
 * Admin No.: P2340362
 */
package com.cleaningService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.model.Booking;
import com.cleaningService.util.DBConnection;

public class BookingDAO {

    public List<Booking> retrieveAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, "
                   + "b.booking_date, b.booking_time, b.status, b.total_price, "
                   + "b.special_request, b.service_address, c.name AS category_name "
                   + "FROM bookings b "
                   + "JOIN users u ON b.userid = u.id "
                   + "JOIN service s ON b.serviceid = s.id "
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
                booking.setTime(rs.getString("booking_time"));
                booking.setCategoryName(rs.getString("category_name"));
                booking.setStatus(rs.getString("status"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setSpecialRequest(rs.getString("special_request"));
                booking.setServiceAddress(rs.getString("service_address"));

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }  
        
        // New method to get user email by ID
        public String getUserEmail(int userId) {
            String email = null;
            String sql = "SELECT email FROM users WHERE id = ?";

            try (Connection connection = DBConnection.getConnection();
                 PreparedStatement stmt = connection.prepareStatement(sql)) {

                stmt.setInt(1, userId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        email = rs.getString("email");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return email;
        }

    public boolean createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (userid, categoryid, serviceid, booking_date, booking_time, duration, "
                   + "service_address, special_request, status, total_price, created) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending', ?, CURRENT_TIMESTAMP)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, booking.getUserId());
            statement.setInt(2, booking.getCategoryId());
            statement.setInt(3, booking.getServiceId());
            statement.setDate(4, Date.valueOf(booking.getDate()));
            statement.setTime(5, Time.valueOf(booking.getTime() + ":00"));
            statement.setInt(6, booking.getDuration());
            statement.setString(7, booking.getServiceAddress());
            statement.setString(8, booking.getSpecialRequest());
            statement.setDouble(9, booking.getTotalPrice());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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

    public Booking getBookingDetailsById(int bookingId) {
        Booking booking = null;
        String sql = "SELECT b.id, u.name AS customer_name, s.name AS service_name, "
                   + "b.booking_date, b.booking_time, b.status, b.total_price, "
                   + "b.special_request, b.service_address, c.name AS category_name "
                   + "FROM bookings b "
                   + "JOIN users u ON b.userid = u.id "
                   + "JOIN service s ON b.serviceid = s.id "
                   + "JOIN category c ON b.categoryid = c.id "
                   + "WHERE b.id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, bookingId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setCustomerName(rs.getString("customer_name"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setDate(rs.getString("booking_date"));
                    booking.setTime(rs.getString("booking_time"));
                    booking.setCategoryName(rs.getString("category_name"));
                    booking.setStatus(rs.getString("status"));
                    booking.setTotalPrice(rs.getDouble("total_price"));
                    booking.setSpecialRequest(rs.getString("special_request"));
                    booking.setServiceAddress(rs.getString("service_address"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return booking;
    }
}
