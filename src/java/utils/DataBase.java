/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package utils;

import DOCTRACK.Document;
import DOCTRACK.DocumentException;
import DOCTRACK.EmpException;
import DOCTRACK.Employee;
import DOCTRACK.Office;
import DOCTRACK.OfficeException;
import DOCTRACK.TransitDoc;
import DOCTRACK.User;
import DOCTRACK.UserException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ab-admin
 */
public class DataBase {
    private static Connection conn;
    private static Statement stmt;
    private static String dbName;
    private PreparedStatement prps;
    
    public DataBase(DbConfig configuration){
        conn = configuration.getConnection();
        dbName = configuration.getDBName();
        String sql = "use "+dbName;
        try{
        stmt= conn.createStatement();
        stmt.executeUpdate(sql);
        }catch(SQLException sqle){
            System.err.println("Problem using database "+dbName+"... abort");
            sqle.printStackTrace();
            System.exit(-1);
        }
    }
    
public static ResultSet getQueryResults(String query){
     try
     {
         return stmt.executeQuery(query);
     }catch(SQLException sqle){
         sqle.printStackTrace();
     }
        return null;
    }
public static ResultSet getQueryResults(String query,boolean createnewst){

    try
     {
    Statement newstmt=conn.createStatement();

         return newstmt.executeQuery(query);
     }catch(SQLException sqle){
         sqle.printStackTrace();
     }
        return null;
    }

public static int getQueryUpdate(String query) throws SQLException{
         return stmt.executeUpdate(query);
     
    
    }

public static int getQueryUpdate(String query, boolean createnewst) throws SQLException{
    //if(createnewst)
        Statement newstmt=conn.createStatement();
    return newstmt.executeUpdate(query);
     
    
    }

public String insertDocument(Document dc){
    PreparedStatement newdoc;
    String sqlquery = "insert into docs(docid,accesscode,ownerid,docinfo) values (?,?,?,?) " ;
    String access=null;
        try {
            int acc=utility.generatecode();
            newdoc = conn.prepareStatement(sqlquery);
            newdoc.setInt(1, dc.getDocId());
            newdoc.setInt(2, acc);
            newdoc.setString(3, dc.getOwnerid());
            newdoc.setString(4, dc.getDocinfo());
            access = new Integer(acc).toString();
        } catch (SQLException ex) {
            //Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
            
            //Find error for owner not present.
            System.out.println("error code is "+ex.getErrorCode());
            ex.printStackTrace();
            access = null;
        }
return access;
}

public int addUserLoginCreds(User userobj, String passw){
    String sql = "insert into usercreds values('"+userobj.getUserid()+"' ,'"+passw+"')";
    int complete = 0;
    try{
        complete = stmt.executeUpdate(sql);
    }catch(SQLException sqle){
        sqle.printStackTrace();
        complete = 0;
    //    System.exit(-3);
    }
    return complete;
}
public int addEmployeeLoginCreds(Employee empobj, String passw){
    String sql = "insert into office_creds values('"+empobj.getEmpid()+"' ,'"+passw+"')";
    int complete = 0;
    try{
        complete = stmt.executeUpdate(sql);
    }catch(SQLException sqle){
        sqle.printStackTrace();
        complete = 0;
    //    System.exit(-3);
    }
    return complete;
}
public void registerUser(User userobj) throws UserException{
    String sql = "insert into user_info values(?,?)";
    try{prps = conn.prepareStatement(sql);
    prps.setString(1, userobj.getUserid());
    prps.setString(2, userobj.getUsername());
    prps.executeUpdate();
    }
    catch(SQLException sqle){
        if(sqle.getErrorCode()==1062){  //Primary key error, key value already exists
            throw new UserException("User already exists");
        }
        else{
            sqle.printStackTrace();
            System.exit(-4);
        }
    }
}
public static String getEmployeeName(String employeeid){
    String employeename="inv";
    String sql;
    sql = "select empname from employee where employeeid = '"+employeeid+"'";
    try{
    ResultSet rs = stmt.executeQuery(sql);
    if(rs.next()){
        employeename = rs.getString("empname");
    }
    }catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return employeename;
}
public static String getOfficeName(String officeid){
    String offname="inv";
    String sql;
    sql = "select officeName from office_info where officeid = '"+officeid+"'";
    try{
    ResultSet rs = stmt.executeQuery(sql);
    if(rs.next()){
        offname = rs.getString("officeName");
    }
    }catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return offname;
}


public static int getnumdocsinoffice(String offname){
    String offid = getOfficeId(offname);
    String sql="select count(*) as count from state where curoffid='"+offid+"'";
    int numdocs=0;
    
    try{
        ResultSet rs = getQueryResults(sql);
        if(rs.next()){
            numdocs = rs.getInt("count");
        }
    }catch(SQLException sqle){
        sqle.printStackTrace();
    }
return numdocs;
}




public static String getOfficeId(String officename){
    String offid="inv";
    String sql;
    sql = "select officeid from office_info where officeName = '"+officename+"'";
    try{
    ResultSet rs = stmt.executeQuery(sql);
    if(rs.next()){
        offid = rs.getString("officeid");
    }
    }catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return offid;
}/*
public static String getEmployeeOffice(String officename){
    String offid="inv";
    String sql;
    sql = "select officeid from office_info where officeName = '"+officename+"'";
    try{
    ResultSet rs = stmt.executeQuery(sql);
    if(rs.next()){
        offid = rs.getString("officeid");
    }
    }catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return offid;
}
*/


public void registerEmployee(Employee empobj) throws EmpException{
    String sql = "insert into employee values(?,?,?)";
    String officeid = getOfficeId(empobj.getEmpofficename());
    try{prps = conn.prepareStatement(sql);
    prps.setString(1, empobj.getEmpid());
    prps.setString(2, empobj.getEmpname());
    prps.setString(3, officeid);
    prps.executeUpdate();
    }
    catch(SQLException sqle){
        if(sqle.getErrorCode()==1062){  //Primary key error, key value already exists
            throw new EmpException("Employee already exists");
        }
        else{
            sqle.printStackTrace();
            System.exit(-4);
        }
    }
}

public static ArrayList<Integer> getDocsinofficenow(String officename){
        String officeid = DataBase.getOfficeId(officename);
        ArrayList<Integer> alldocs= new ArrayList<Integer>();
        String getAvailable= "select * from state where curoffid='"+officeid+"'";
        ResultSet rs = DataBase.getQueryResults(getAvailable);
        int docid;
        try{
            while(rs.next()){
                docid = rs.getInt("docid");
                alldocs.add(docid);
            }
        }catch(SQLException sqle){
            sqle.printStackTrace();
        }
return alldocs;
    
}


public void registerOffice(Office officeobj) throws OfficeException{
    String sql = "insert into office_info values(?,?,?)";
    try{prps = conn.prepareStatement(sql);
    prps.setString(1, officeobj.getOfficeid());
    prps.setString(2, officeobj.getOfficename());
    prps.setString(3, officeobj.getOfficeinfo());
    prps.executeUpdate();
    }
    catch(SQLException sqle){
        if(sqle.getErrorCode()==1062){  //Primary key error, key value already exists
            throw new OfficeException("Office already exists");
        }
        else{
            sqle.printStackTrace();
            System.exit(-4);
        }
    }
}

public int getNumOffices(){
    String sql = "select count(*) as num from office_info";
    int off =-1;
        try {
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                off=rs.getInt("num");
                System.out.println(off +" offices currently present");
            }
        } catch (SQLException ex) {
        ex.printStackTrace();
        }
    return off;
}

public static ArrayList<Integer> getUserDocs(String userid) throws DocumentException{
    ArrayList<Integer> doclist = new ArrayList<Integer>();
    String sql="select docid from docs where ownerid = '"+userid+"'";
    ResultSet rs;
    try{
        rs = stmt.executeQuery(sql);
        while(rs.next()){
            int docid = rs.getInt("docid");
            doclist.add(docid);
        }
    
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
        throw new DocumentException("Fetch error");
        
    }
     return doclist;
}

public static ArrayList<String> getOffices() throws DocumentException{
    ArrayList<String> officelist = new ArrayList<String>();
    String sql="select officeName from office_info where officeid like 'off%'";
    ResultSet rs;
    try{
        rs = stmt.executeQuery(sql);
        while(rs.next()){
            String offname = rs.getString("officeName");
            officelist.add(offname);
        }
    
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
        throw new DocumentException("Fetch error");
        
    }
    catch(Exception e){
        e.printStackTrace();
    }
     return officelist;
}
public static PreparedStatement createprepared(String sql) throws SQLException
{
    PreparedStatement prps;
    prps=conn.prepareStatement(sql);
    return prps;
}

public static int numprocesseddocs(String offname){
    String offid = getOfficeId(offname);
    int count =0;
    String query = "select count(*) as count from trackdocs,state where trackdocs.docid=state.docid and trackdocs.currOfficeid <> state.curoffid and trackdocs.currOfficeid='"+offid+"'";
    try{
        ResultSet rs = getQueryResults(query,true);
        if(rs.next()){
            count=rs.getInt("count");
        }
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return count;
}

public static int totaldocsinsystem(){
    int count =0;
    String query = "select count(*) as count from docs";
    try{
        ResultSet rs = getQueryResults(query,true);
        if(rs.next()){
            count=rs.getInt("count");
        }
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return count;
}

public static int totaldocsintransit(){
    int count =0;
    String query = "select count(*) as count from docintransit";
    try{
        ResultSet rs = getQueryResults(query,true);
        if(rs.next()){
            count=rs.getInt("count");
        }
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
    }
    return count;
}

public static ArrayList<String> listcurdocholders(String offname){
    String officeid = getOfficeId(offname);
    ArrayList<String> holders = new ArrayList<String>();
    String query="select trackdocs.docid, empname from state,employee,trackdocs where state.curoffid='"+officeid+"' and state.curoffid=trackdocs.currOfficeid and state.docid=trackdocs.docid and employee.employeeid=trackdocs.curholderid;";
    ResultSet rs;
    try{
        rs = getQueryResults(query);
        while(rs.next()){
            String docid=rs.getString("docid");
            String empname=rs.getString("empname");
            holders.add(docid+":"+empname);
        }
    }
catch(SQLException sqle){
    sqle.printStackTrace();
}
return holders;
}
}
