/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Sumit
 */
public class remark {

 private String remarkText;
 private String remarkDate;
private String remarker;
    public remark(String remarkText, String remarkDate, String remarker) {
        this.remarkText = remarkText;
        this.remarkDate = remarkDate;
        this.remarker = remarker;
    }
 

    public String getRemarkText() {
        return remarkText;
    }

    public void setRemarkText(String remarkText) {
     
        
        this.remarkText = remarkText;
    }

    public String getRemarkDate() {
        return remarkDate;
    }

    public void setRemarkDate(long remarkDate) {
     /*
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
    try {
        java.util.Date dt =format.parse(remarkDate);
        String date = dt.getHours()+":" +dt.getMinutes();
        this.remarkDate = date; 
    } catch (ParseException ex) {
       ex.printStackTrace();
    }*/
        
        
        Time tm =new Time(remarkDate);
        this.remarkDate = tm.getHours()+":"+tm.getMinutes();
        System.err.print(this.remarkDate);
    }
    

    public String getRemarker() {
        return remarker;
    }

    public void setRemarker(String remarker) {
        this.remarker = remarker;
    }
public remark(){    
}

}