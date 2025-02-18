package com.example.taskmaster;

import java.util.Random;

public class Test {
//    public static void main(String[] args) {
//        String originalString = "Thuy Pham";
//        String similarString = generateSimilarString(originalString);
//        System.out.println("Original String: " + originalString);
//        System.out.println("Similar String: " + similarString);
//    }
//
//    public static String generateSimilarString(String input) {
//        Random random = new Random();
//        StringBuilder similarString = new StringBuilder();
//
//        for (char c : input.toCharArray()) {
//            // Randomly decide whether to change the character or not
//            if (random.nextBoolean()) {
//                // Change the character to a random one within the same case
//                if (Character.isUpperCase(c)) {
//                    similarString.append((char) ('A' + random.nextInt(26)));
//                } else {
//                    similarString.append((char) ('a' + random.nextInt(26)));
//                }
//            } else {
//                // Keep the original character
//                similarString.append(c);
//            }
//        }
//        return similarString.toString();
//    }


    public static void main(String[] args) {
        String generatedString = generateCustomRandomString();
        System.out.println(generatedString);
    }

    public static String generateCustomRandomString() {
        String regex = "[a-z0-9_]";
        StringBuilder characters = new StringBuilder();
        for (char c = 'a'; c <= 'z'; c++) characters.append(c);
        for (char c = '0'; c <= '9'; c++) characters.append(c);
        characters.append('_');

        Random random = new Random();
        int length = determineLength(random);
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }
        return sb.toString();
    }

    public static int determineLength(Random random) {
        double probability = random.nextDouble();
        if (probability < 0.80) {
            return random.nextInt(11) + 7; // 80% cho độ dài từ 8-17
        } else if (probability < 0.95) {
            return random.nextInt(4) + 4; // 15% cho độ dài từ 4-7
        } else {
            return random.nextInt(10) + 19; // 5% cho độ dài lớn hơn 18
        }
    }
}
