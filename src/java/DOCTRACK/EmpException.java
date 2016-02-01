/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

/**
 *
 * @author ab-admin
 */
public class EmpException extends Exception{
    private String errorstring;

    public EmpException(String error){
        errorstring = error;
    }
    public void setErrorstring(String errorstring) {
        this.errorstring = errorstring;
    }
    public String toString(){
        return errorstring;
    }
}
