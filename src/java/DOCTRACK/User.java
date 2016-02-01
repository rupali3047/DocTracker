/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

import java.sql.SQLException;
import utils.DataBase;

/**
 *
 * @author ab-admin
 */
public class User {
    private String userid;
    private String username;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    private User(String userid, String username){
        this.userid = userid;
        this.username = username;
    }
    public static boolean makeNewUser(String userid, String username, String passw, DataBase db) throws UserException{
       if(db==null){
           System.err.println("dekh le sale");
           System.exit(-3);
       }
        User newuser=new User(userid,username);
            db.registerUser(newuser);
            int success = db.addUserLoginCreds(newuser,passw);
            if(success == 1){
                System.out.print("added the login entry..");
                return true;
            }else
                return false;
        
       
    }
    
    public static boolean ownDocument(String docid, String accesscode, String ownerid ){
        String sqlquery = "update docs set ownerid = '"+ownerid+"' where docid="+docid+" and accesscode="+accesscode;
        boolean updated = false;
        try{
            if(DataBase.getQueryUpdate(sqlquery)>0)
                updated=true;
        }catch(SQLException sqle){
            sqle.printStackTrace();
        }
        return updated;
    }
}