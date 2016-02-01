/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ab-admin
 */
public class DbConfig {
    private static String port;
    private static String dburl;
    private static String userid;
    private static String pass;
    private String dbName;
    private Connection conn;
    static{
        port = "3306";
        dburl = "jdbc:mysql://localhost:";
        userid = "root";
        pass = "123";
    }
    public Connection getConnection(){
        return conn;
    }
     public String getDBName(){
        return dbName;
    }
    public DbConfig(String dbName,boolean makenew){
       this.dbName = dbName;
      try{
          if(!makenew){
              makeConnectionFromPrev();
          }
          else
                if(makeDBconnection())
                    createtables();
      }
      catch(ClassNotFoundException clfe){
          System.err.println("Could not find db class");
      }
      catch(Exception exe){
          exe.printStackTrace();
      }
    }
    
    private boolean makeConnectionFromPrev() throws ClassNotFoundException{
        Class.forName("com.mysql.jdbc.Driver");
        String actualurl;
        Statement stmt = null;
        System.out.println("Connecting to database...");
        try {
            actualurl = dburl + port + "/" + dbName ;
            conn = DriverManager.getConnection(actualurl,userid, pass);
            stmt = conn.createStatement();
            
            
        } catch (SQLException ex) {
          ex.printStackTrace();
          return false;
        }
        return true;
    }
    private boolean makeDBconnection() throws ClassNotFoundException{
      
        Class.forName("com.mysql.jdbc.Driver");
        String actualurl;
        actualurl = dburl + port + "/";
        conn=null;
        Statement stmt = null;
        boolean flag,retry=false;
   
      flag = true;
      do{
      try{
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(actualurl, userid, pass);
            System.out.println("Creating database...");
            stmt = conn.createStatement();
            String sql = "CREATE DATABASE "+dbName;
            stmt.execute(sql);
            System.out.println("Database created successfully...");
            retry=false;
         }
       catch(SQLException sqle){
            System.out.println("exit with error "+sqle.getErrorCode());
            if(sqle.getErrorCode()==1007){
                 System.err.println("Database already exists.. Dropping it");
                 dropDatabase();
                 retry=true;
            }
            else{
                    sqle.printStackTrace();
                    retry=flag=false;
                    
            }
         }
        }while(retry);
   
        return flag;
  } 
   
    private void dropDatabase(){
        try {
            String dropquery = "DROP DATABASE "+dbName;
            Statement stmt = null;
            stmt = conn.createStatement();
            stmt.executeUpdate(dropquery);
        } catch (SQLException ex) {
          ex.printStackTrace();
          System.exit(-4);
        }
    }
    private void createtables() {
        try {
            Statement stmt = null;
            stmt = conn.createStatement();
            String sql = "use "+dbName;
            stmt.executeUpdate(sql);
            String tablequery = "CREATE TABLE IF NOT EXISTS office_info ("+
                                 "officeid varchar(10) PRIMARY KEY,"+
                                 "officeName VARCHAR(50) NOT NULL UNIQUE,"+
                                 "officeDesc VARCHAR(100) NOT NULL"+
                                 ")";
            stmt.addBatch(tablequery);
            
            tablequery = "CREATE TABLE IF NOT EXISTS employee("+
                         "employeeid VARCHAR(50) PRIMARY KEY,"+
                         "empname varchar(40),"+
                         "empOffice varchar(10),"+
                         "FOREIGN KEY (empOffice) REFERENCES office_info(officeid))";
                         
            stmt.addBatch(tablequery);             
                        
            tablequery = "CREATE TABLE IF NOT EXISTS office_creds("+
                     "loginname VARCHAR(50) NOT NULL ,"+
                     "password VARCHAR(30),"+
                     "FOREIGN KEY(loginname) REFERENCES employee(employeeid) )";
            stmt.addBatch(tablequery);
            tablequery = "CREATE TABLE IF NOT EXISTS user_info (" +
                            "userid VARCHAR(50) NOT NULL PRIMARY KEY," +
                            "username VARCHAR(20) NOT NULL)";
            stmt.addBatch(tablequery);

            tablequery = "CREATE TABLE IF NOT EXISTS usercreds(" +
                         " userid VARCHAR(50) NOT NULL UNIQUE," +
                         " password VARCHAR(50) NOT NULL," +
                         " FOREIGN KEY (userid) REFERENCES user_info(userid))";
            stmt.addBatch(tablequery);
            
            tablequery = "CREATE TABLE IF NOT EXISTS docs (" +
                            "docid INTEGER(10) PRIMARY KEY AUTO_INCREMENT," +
                            "accesscode INTEGER(4) NOT NULL," +
                            "ownerid VARCHAR(50) NOT NULL," +
                            "created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"+
                            "FOREIGN KEY (ownerid) REFERENCES user_info(userid))";
            stmt.addBatch(tablequery);
            
            tablequery = "CREATE TABLE IF NOT EXISTS remarks (" +
                        "docid INTEGER(10)," +
                        "remarkText  VARCHAR(200)  NOT NULL ," +
                        "remarkon timestamp DEFAULT CURRENT_TIMESTAMP," +
                        "remarkerid varchar(50)," +
                        "officeid varchar(10)," +
                        "FOREIGN KEY(docid) REFERENCES docs(docid),"+
                        "FOREIGN KEY(remarkerid) REFERENCES employee(employeeid),"+
                        "FOREIGN KEY(officeid) REFERENCES office_info(officeid))";
             stmt.addBatch(tablequery);
            tablequery = "CREATE TABLE IF NOT EXISTS docintransit( docid INTEGER(10) NOT NULL ," +
                        "forwarded_by varchar(50)," +
                        "forwardingoffice  varchar(10) ," +
                        "forwardedtooffice varchar(10) ,"+
                        "fowardedon TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"+
                        "FOREIGN KEY(docid) REFERENCES docs(docid),"+
                        "FOREIGN KEY(forwardingoffice) REFERENCES office_info(officeid),"+
                        "FOREIGN KEY(forwardedtooffice) REFERENCES office_info(officeid),"+
                        "FOREIGN KEY(forwarded_by) REFERENCES employee(employeeid))";
             stmt.addBatch(tablequery);
            tablequery = "CREATE TABLE IF NOT EXISTS trackDocs (" +
                        "docid  INTEGER(10)  NOT NULL ," +
                        "currOfficeid varchar(10) NOT NULL," +
                        "prevOfficeid VARCHAR(10) NOT NULL," +
                        "lasteditorid varchar(50) NOT NULL," +
                        "curholderid varchar(50) NOT NULL," +
                        "lastupdatetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"+
                        "FOREIGN KEY(docid) REFERENCES docs(docid), " +
                        "FOREIGN KEY (currOfficeid) REFERENCES office_info(officeid),"+
                        "FOREIGN KEY (prevOfficeid) REFERENCES office_info(officeid),"+
                        "FOREIGN KEY (curholderid) REFERENCES employee(employeeid),"+
                        "FOREIGN KEY (lasteditorid) REFERENCES employee(employeeid))";
                        
            stmt.addBatch(tablequery);
       
            tablequery = "CREATE TABLE IF NOT EXISTS state("+
                         "docid INTEGER(10) unique ,"+
                         "curoffid varchar(10),"+
                         "FOREIGN KEY(docid) REFERENCES docs(docid),"+
                         "FOREIGN KEY(curoffid) REFERENCES office_info(officeid))";
                    
            stmt.addBatch(tablequery);
            
            
            
            
            
            
            String addOfficeQuery, addSpecialEmployee, addOfficeCredens;  //Adds reception and admin offices initially.
            
            
            addOfficeQuery = "insert into office_info values('ADMIN','ADMINISTRATORS OFFICE','SUPER ACCOUNT..HAS FACILITIES TO VIEW ALL DOCS, EMPLOYEES etc.')";
            addSpecialEmployee = "insert into employee values('admin@doctrack','ADMINISTRATOR','ADMIN')";
            addOfficeCredens = "insert into office_creds values('admin@doctrack', 'admin123')";
            stmt.addBatch(addOfficeQuery);
            stmt.addBatch(addSpecialEmployee);
            stmt.addBatch(addOfficeCredens);
            
            
            
            addOfficeQuery = "insert into office_info values('RECEP','RECEPTION','GATEWAY TO THE SYSTEM.. FIRST POINT FOR ALL DOCUMENTS')";
            addSpecialEmployee = "insert into employee values('reception@doctrack','Receptionist','RECEP')";
            addOfficeCredens = "insert into office_creds values('reception@doctrack', 'recep123')";
            
            stmt.addBatch(addOfficeQuery);
            stmt.addBatch(addSpecialEmployee);
            stmt.addBatch(addOfficeCredens);
            
       //     addOfficeQuery = "insert into office_info values('OFFARCHIVE','ARCHIVE','Holds completed documents')";
        //    stmt.addBatch(addOfficeQuery);
            
            String addPublicUser = "insert into user_info values('public','public')";
            stmt.addBatch(addPublicUser);
            
            String addTransitOffice = "insert into office_info values('TRANSIT','TRANSIT','DOCS IN TRANSIT')";
            stmt.addBatch(addTransitOffice);
            
            String addTransitEmployee = "insert into employee values('transit@doctrack','transit guy','TRANSIT')";
            stmt.addBatch(addTransitEmployee);
            
            stmt.executeBatch();
        } 
        catch (SQLException ex) {
            ex.printStackTrace();

        }

    }
}
    
