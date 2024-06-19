/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package helper;

import java.util.Random;

/**
 *
 * @author ACER
 */
public class KeyGenerator {
    public static String getKey() {
        Random rd = new Random();
        String key = "";
        for(int i=1;i<=50;i++){
            int num = rd.nextInt(65, 116);
            if(num>=91) num+=6;
            key += (char)num;
        }
        return key;
    }
}
