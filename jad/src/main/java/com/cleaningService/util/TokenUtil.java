
//    JAD-CA1
//    Class-DIT/FT/2A/23
//    Student Name: Thiri Lae Win
//    Admin No.: P2340739
package com.cleaningService.util;

import java.util.Base64;

public class TokenUtil {
    public static boolean isTokenValid(String token) {
        if (token == null || token.isEmpty()) {
            return false;
        }
        try {
            // Decode the token and extract its timestamp
            String decodedToken = new String(Base64.getDecoder().decode(token));
            String[] parts = decodedToken.split(":");
            if (parts.length != 2) {
                return false;
            }
            long tokenExpiry = Long.parseLong(parts[1]);
            long currentTime = System.currentTimeMillis();

            // Check if the token has expired
            return currentTime <= tokenExpiry;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
