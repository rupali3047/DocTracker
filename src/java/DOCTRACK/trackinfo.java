/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import utils.DataBase;

/**
 *
 * @author Sumit
 */
public class trackinfo{
private String curoffice;
private String prevoffice;
boolean isfirstOffice;
private String leftoffice;
private String curholder;
private remark associatedremark;

    public remark getAssociatedremark() {
        return associatedremark;
    }

    public void setAssociatedremark(remark associatedremark) {
        this.associatedremark = associatedremark;
    }
public trackinfo() {
    isfirstOffice = false;
    associatedremark = new remark();

}


    public boolean isIsfirstOffice() {
        return isfirstOffice;
    }

    public void setIsfirstOffice(boolean isfirstOffice) {
        this.isfirstOffice = isfirstOffice;
    }

    public String getCurholder() {
        return curholder;
    }

    public void setCurholder(String curholder) {
        this.curholder = curholder;
    }


    public String getLeftoffice() {
        return leftoffice;
    }
    public void setLeftoffice(long transittime){
        /*
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss zZ");
    try {
        java.util.Date dt =format.parse(transittime);
        String leftAt = dt.getHours()+":" +dt.getMinutes();
                this.leftoffice = leftAt;
    } catch (ParseException ex) {
       ex.printStackTrace();
    }*/
        
        
        Time tm =new Time(transittime);
        leftoffice = tm.getHours()+":"+tm.getMinutes();
        System.err.print(leftoffice);
    }
public String getCuroffice() {
       
    return curoffice;
    }

    public void setCuroffice(String curofficeid) {
        
        String curOfficeName = DataBase.getOfficeName(curofficeid);
        this.curoffice = curOfficeName;
    }

    public String getPrevoffice() {
        
        return prevoffice;
    }

    public void setPrevoffice(String prevofficeid) {
        String prevOfficeName=prevofficeid;
        if(!prevofficeid.equalsIgnoreCase("origin"))
             prevOfficeName = DataBase.getOfficeName(prevofficeid);
        
        this.prevoffice = prevOfficeName;
    }

}