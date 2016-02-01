/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

import java.util.HashMap;

/**
 *
 * @author ab-admin
 */
public class OfficeException extends Exception{
    
    /*static{
        
    errormap =new HashMap<Integer, String>();
    errormap.put(new Integer(1001), "Office not present");
    
    }*/
    //private static HashMap<Integer, String> errormap;
    private String errorstring;

    public String getErrorstring() {
        return errorstring;
    }
    private int errorcode;

    public OfficeException(String error){
        errorstring = error;
    }
    
    
    public void setErrorstring(String errorstring) {
        
        this.errorstring = errorstring;
    }
    public String toString(){
        return errorstring;
    }
}