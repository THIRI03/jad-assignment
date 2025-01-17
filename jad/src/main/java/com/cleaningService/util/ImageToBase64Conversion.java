package com.cleaningService.util;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ImageToBase64Conversion {
    public static void main(String[] args) {
        String dbUrl = "jdbc:postgresql://ep-black-sea-a1x1cg6b.ap-southeast-1.aws.neon.tech/jad_assignment?user=neondb_owner&password=nYHFhP9l5UaJ&sslmode=require";
        String filePath = "C:\\SP_DIT\\DIT_YR2_SEM2\\JAD\\jad-assignment\\jad\\src\\main\\webapp\\gallery\\upholstery_cleaning.jpg";

        String updateQuery = "UPDATE service SET image = ? WHERE id = 9";

        try (Connection connection = DriverManager.getConnection(dbUrl);
             PreparedStatement statement = connection.prepareStatement(updateQuery);
             FileInputStream inputStream = new FileInputStream(new File(filePath))) {

            // Set binary stream for the image
            statement.setBinaryStream(1, inputStream);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Image updated successfully!");
            } else {
                System.out.println("No record with id = 1 found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
