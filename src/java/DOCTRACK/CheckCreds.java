/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DataBase;

/**
 *
 * @author ab-admin
 */
public class CheckCreds {
    private String loginid;
    private String passw;
    DataBase db;
    public CheckCreds(DataBase db) {
        this.db = db;
    }

    public String getLoginid() {
        return loginid;
    }

    public void setLoginid(String loginid) {
        this.loginid = loginid;
    }

    public String getPassw() {
        return passw;
    }

    public void setPassw(String passw) {
        this.passw = passw;
    }
    
    
    public static String checkOfficeValidity( String loginname, String password, DataBase db)
    {
        String checkquery= "select count(*) as count, officeName from employee,office_info,office_creds where loginname='"+loginname+"' and password ='"+password+"' and loginname=employeeid and empOffice=officeid";
        ResultSet rs = db.getQueryResults(checkquery);
        String officename="invalid";
        try{
            if(rs.next()){
            int countrows = Integer.parseInt(rs.getString("count"));
                if( countrows== 1){
                    System.out.print("Found entry... ok valid");
                    officename = rs.getString("officeName");
                   
                }
                   
            }
            
        }catch(SQLException sqle){
            sqle.printStackTrace();
            officename = "invalid";
        }
    return officename;
    }
    
    public static String checkUserValidity( String loginname, String password, DataBase db)
   {
       System.err.print(loginname + "    "+ password);
       String checkquery= "select count(*) as count,username from usercreds u, user_info i where u.userid= '"+loginname+"' and password='"+password+"' and i.userid = '"+loginname+"'";
       ResultSet rs = db.getQueryResults(checkquery);
       String username = "invalid";
       try{
           if(rs.next()){
               
               if(rs.getString("count").equals("1")){
                   
                   username = rs.getString("username");
                   System.err.println(username);
               }
                 
           }

       }catch(SQLException sqle){
           sqle.printStackTrace();
           username = "invalid";
       }
   return username;
   }
}

