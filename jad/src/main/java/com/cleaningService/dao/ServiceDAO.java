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

import com.cleaningService.model.Service;
import com.cleaningService.util.DBConnection;

public class ServiceDAO {
	
	// Method for retrieving services by category ID
	public List<Service> retrieveServicesByCategoryId(int categoryId) {
	    List<Service> services = new ArrayList<>();
	    String sql = "SELECT * FROM service WHERE category_id = ?";
	    double price = 0.0;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        stmt.setInt(1, categoryId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Service service = new Service();
	            service.setId(rs.getInt("id"));
	            service.setName(rs.getString("name"));
	            service.setDescription(rs.getString("description"));
	            service.setPrice(rs.getDouble("price"));
	            service.setCategory_id(rs.getInt("category_id"));
	            service.setImage(rs.getString("image")); 

	            services.add(service);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return services;
	}

	
=======

	/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
	// Method for retrieving service
	public List<Service> retrieveService() {
		List<Service>services = new ArrayList();
		String sql = "SELECT * FROM service ORDER BY service.id";

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery()){
			while(rs.next()) {
				Service service = new Service(0, null, null, 0, 0, null);
				service.setId(rs.getInt("id"));
				service.setName(rs.getString("name"));
				service.setDescription(rs.getString("description"));
				service.setPrice(rs.getDouble("price"));
				service.setCategory_id(rs.getInt("category_id"));
				service.setImage(rs.getString("image"));

				services.add(service);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return services;
	}

	// Method for retrieving service by id
	public Service retrieveServiceById(int id) {
	    Service service = new Service();
	    String sql = "SELECT * FROM service WHERE id = ?"; // Ensure column name is correct

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        // Set the parameter for the query
	        stmt.setInt(1, id);

	        // Execute the query
	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            // Map the result set to the service object
	            service.setId(rs.getInt("id"));
	            service.setName(rs.getString("name"));
	            service.setDescription(rs.getString("description"));
	            service.setPrice(rs.getDouble("price"));
	            service.setCategory_id(rs.getInt("category_id"));
	            service.setImage(rs.getString("image"));
	        } else {
	            // Handle case where service is not found
	            System.out.println("No service found with ID " + id);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return service;
	}

	// Method for creating service
	public boolean createService(Service service) {
		boolean isServiceCreated = false;
		String sql = "INSERT INTO service(name, description, price, category_id, image) VALUES (?, ?, ?, ?, ?)";

		try(Connection connection = DBConnection.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql)){

			statement.setString(1, service.getName());
			statement.setString(2, service.getDescription());
			statement.setDouble(3, service.getPrice());
			statement.setInt(4, service.getCategory_id());
			statement.setString(5, service.getImage());

			int rowsInserted = statement.executeUpdate();
			if(rowsInserted > 0) {
				isServiceCreated = true;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return isServiceCreated;
	}



	// Method for deleting service
	public boolean deleteService(int id) {
		boolean isDeleted = false;

		String sql = "DELETE FROM service WHERE id=?";
		try(Connection connection = DBConnection.getConnection()){
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

	// Method for updating service
	public boolean updateService(Service service){
		boolean isUpdated = false;
		String sql = "UPDATE service SET name = ?, description = ?, price = ?, category_id = ?, image=? WHERE id = ?";
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql)){
			stmt.setString(1, service.getName());
			stmt.setString(2, service.getDescription());
			stmt.setDouble(3, service.getPrice());
			stmt.setInt(4, service.getCategory_id());
			stmt.setString(5, service.getImage());
			stmt.setInt(6, service.getId());

			int rowsAffected = stmt.executeUpdate();

			if(rowsAffected > 0) {
				isUpdated = true;
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isUpdated;
	}


	//Method to retrieve the number of services offering
	public int retrieveNumberOfServices() {
	    int count = 0;
	    String sql = "SELECT COUNT(id) AS serviceCount FROM service";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql);
	         ResultSet resultSet = stmt.executeQuery()) {

	        if (resultSet.next()) {
	            count = resultSet.getInt("serviceCount");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
	}

	public List<Service> retrieveServiceByName(String userInput){
		List<Service> services = new ArrayList<>();

		String sql = "SELECT * FROM service WHERE LOWER(name) LIKE ?";
		try (Connection connection = DBConnection.getConnection();
	             PreparedStatement pstmt = connection.prepareStatement(sql)) {

	            pstmt.setString(1, "%" + userInput.toLowerCase() + "%");
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {

	        		Service service = new Service();
	        		service.setId(rs.getInt("id"));
					service.setName(rs.getString("name"));
					service.setDescription(rs.getString("description"));
					service.setPrice(rs.getDouble("price"));
					service.setCategory_id(rs.getInt("category_id"));
					service.setImage(rs.getString("image"));
					services.add(service);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		return services;
	}


	public List<Service> retrieveTopAndLeastRatedServices(String filter){
		List<Service>services = new ArrayList<>();

		String sql = null;

		if("top3Rated".equals(filter)) {
			sql = "SELECT s.id, s.name, s.description, s.price, s.image, AVG(f.rating) AS avg_rating "
					+ "FROM service s "
					+ "JOIN feedback f ON s.id = f.serviceid "
					+ "GROUP BY s.id "
					+ "ORDER BY avg_rating DESC "
					+ "LIMIT 3; ";
		}else if("least3Rated".equals(filter)) {
			sql = "SELECT s.id, s.name, s.description, s.price, s.image, AVG(f.rating) AS avg_rating "
					+ "FROM service s "
					+ "JOIN feedback f ON s.id = f.serviceid "
					+ "GROUP BY s.id "
					+ "ORDER BY avg_rating ASC "
					+ "LIMIT 3; ";
		}

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery()){
			while(rs.next()) {
				Service service = new Service();
				service.setId(rs.getInt("id"));
				service.setName(rs.getString("name"));
				service.setDescription(rs.getString("description"));
				service.setPrice(rs.getDouble("price"));
				service.setImage(rs.getString("image"));

				services.add(service);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return services;
	}

	public List<Service> retrieveServicesInDemand(String filter){
		List<Service> services = new ArrayList<>();

		String sql = null;

		if("top3InDemand".equals(filter)) {
			sql = "SELECT s.id, s.name, s.description, s.price, s.image, COUNT(b.id) AS booking_count "
					+"FROM service s "
					+"JOIN bookings b ON s.id = b.serviceid "
					+"GROUP by s.id "
					+"ORDER BY booking_count DESC "
					+"LIMIT 3";
		}else if("least3InDemand".equals(filter)){
			sql = "SELECT s.id, s.name, s.description, s.price, s.image, COUNT(b.id) AS booking_count "
					+"FROM service s "
					+"LEFT JOIN bookings b ON s.id = b.serviceid "
					+"GROUP by s.id "
					+"ORDER BY booking_count ASC "
					+"LIMIT 3";
		}

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery()){

			while(rs.next()) {
				Service service = new Service();
				service.setId(rs.getInt("id"));
				service.setName(rs.getString("name"));
				service.setDescription(rs.getString("description"));
				service.setPrice(rs.getDouble("price"));
				service.setImage(rs.getString("image"));

				services.add(service);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}

		return services;
	}

}
