package com.cleaningService.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

public class TempFileHandler {

    public static void main(String[] args) throws IOException {
        // Create a temporary directory in the default temp directory
        Path tempDir = Files.createTempDirectory("temp_upload");
        System.out.println("Temp directory created: " + tempDir.toString());

        // Now you can store files in this temp directory
        File tempFile = new File(tempDir.toString() + File.separator + "myfile.jpg");
        // Simulating file copy from some input stream (e.g., uploaded file)
        // Files.copy(inputStream, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
    }
}
