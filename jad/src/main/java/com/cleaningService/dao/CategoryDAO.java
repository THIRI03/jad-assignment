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

import com.cleaningService.model.Category;
import com.cleaningService.util.DBConnection;

public class CategoryDAO{

	// Method for retrieving category
	/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
	public List<Category> getAllCategory(){
		List<Category>categories = new ArrayList<>();
		String sql = "SELECT * FROM category";

		try(Connection connection  = DBConnection.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet rs = statement.executeQuery()){
				while(rs.next()) {
					Category ctg = new Category();
					ctg.setId(rs.getInt("id"));
					ctg.setCategoryName(rs.getString("name"));
					ctg.setDescription(rs.getString("description"));
		            ctg.setImage(rs.getString("image"));

					categories.add(ctg);
				}
			}catch(SQLException e){
				e.printStackTrace();
			}

		return categories;
	}

	// Method for retrieving category

		public Category retrieveCategoryById(int categoryId){
			Category ctg = new Category();
			String sql = "SELECT * FROM category WHERE id=?";

			try(Connection connection  = DBConnection.getConnection();
					PreparedStatement statement = connection.prepareStatement(sql)){
				statement.setInt(1, categoryId);
				ResultSet rs = statement.executeQuery();
				if(rs.next()) {
					ctg.setId(rs.getInt("id"));
					ctg.setCategoryName(rs.getString("name"));
					ctg.setDescription(rs.getString("description"));
					ctg.setImage(rs.getString("image"));
				}else {
		            // Handle case where service is not found
		            System.out.println("No service found with ID " + categoryId);
		        }

			}catch(SQLException e){
				e.printStackTrace();
			}

			return ctg;
		}

	// Method for creating category
	public boolean createCategory(String categoryName, String image, String description) {
		boolean isCreated = false;
		String sql = "INSERT INTO category(name, image, description) VALUES (?,?,?)";

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)){

				statement.setString(1, categoryName);
				statement.setString(2, image);
				statement.setString(3, description);

				int rowsInserted = statement.executeUpdate();
				if(rowsInserted > 0) {
					isCreated = true;
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		return isCreated;
	}

	// Method for updating category
	public boolean updateCategory(Category category) {
		boolean isUpdated = false;
		String sql ="UPDATE category SET name=?, image=?, description=? WHERE id=?";

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql)){
				stmt.setString(1, category.getCategoryName());
				stmt.setString(2, category.getImage());
				stmt.setString(3, category.getDescription());
				stmt.setInt(4, category.getId());

				int rowsAffected = stmt.executeUpdate();
				if (rowsAffected > 0){
					isUpdated = true;
				}

			}catch (SQLException e) {
	            e.printStackTrace();

        }
		return isUpdated;
	}

	// Method for deleting category
	public boolean deleteCategory(int id) {
		boolean isDeleted = false;
		String sql = "DELETE FROM category WHERE id=?";

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

}
