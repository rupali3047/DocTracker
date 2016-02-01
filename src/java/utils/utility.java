/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package utils;

import java.util.Random;

/**
 *
 * @author ab-admin
 */
public class utility {
public static int generatecode(){
    int acc;
    
    Random num = new Random();
    acc = num.nextInt(9999-1000) + 1000;
    return acc;
}    
}
