package users.utils;

import java.util.Random;

public class NameUtils {

    public static String generateRandomName() {
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        int length = 10;
        Random random = new Random();
        StringBuilder randomString = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(chars.length());
            randomString.append(chars.charAt(randomIndex));
        }
        return randomString.toString();
    }
}