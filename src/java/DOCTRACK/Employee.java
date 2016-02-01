/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import utils.DataBase;

/**
 *
 * @author ab-admin
 */
public class Employee {
    
    
public static ArrayList<String> checkErrors(String offname){
    String offid = DataBase.getOfficeId(offname);
    String query ="select * from claimerrors where prevclaimoff ='"+offid+"'";
    ArrayList<String> arr= new ArrayList<>();
    ResultSet rs;
    rs = DataBase.getQueryResults(query);
    try{
    while (rs.next()){
        String office = rs.getString("claimoff");
        int docid = rs.getInt("docid");
        String notice = docid +" is in "+DataBase.getOfficeName(office);
        arr.add(notice);
    }
    }
    catch(SQLException sql){
        sql.printStackTrace();
    }
    return arr;
}
    

public static boolean checkclaim (String ownoffid, int docid){
    
    //String ownofficeid = DataBase.getOfficeId(ownoffname);
    String query = "select count(*) as count from claimerrors where prevclaimoff='"+ownoffid+"' and docid ="+docid;
    
    try{
        ResultSet rs = DataBase.getQueryResults(query,true);
        if(rs.next()){
            if(rs.getInt("count")==1){
                String deleteit = "delete from claimerrors where prevclaimoff='"+ownoffid+"' and docid ="+docid;
                DataBase.getQueryUpdate(deleteit, true);
                System.out.println("Deleted the entry");
            }        
            
        }
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
    }
    
    
    
    return true;
}


    public String getEmpid() {
        return empid;
    }

    public void setEmpid(String empid) {
        this.empid = empid;
    }

    public String getEmpname() {
        return empname;
    }

    public void setEmpname(String empname) {
        this.empname = empname;
    }

    public String getEmpofficename() {
        return empofficename;
    }

    public void setEmpofficename(String empofficename) {
        this.empofficename = empofficename;
    }
    private String empid;
    private String empname;
    private String empofficename;

    private Employee(String empid, String empname, String empofficename){
        this.empid = empid;
        this.empname = empname;
        this.empofficename = empofficename;
    }
    public static boolean makeNewEmployee(String empoffice, String empname, String empid, String passw, DataBase db) throws EmpException{
       if(db==null){
           System.err.println("DB is null");
           System.exit(-3);
       }
        Employee newemp=new Employee(empid, empname, empoffice);
            db.registerEmployee(newemp);
            int success = db.addEmployeeLoginCreds(newemp,passw);
            if(success == 1){
                System.out.print("added the login entry..");
                return true;
            }else
                return false;
        
       
    }
    
 public static List<Integer> getlistofDocs(String empid,String officename){
    List<Integer> alldocs = new ArrayList<Integer>();
    String officeid = DataBase.getOfficeId(officename);
    //String empoffice = DataBase.getEmployeeOffice(empid);
    
    String sql = "select trackdocs.docid from trackdocs,state where curholderid = '"+empid+"' and state.docid=trackdocs.docid and state.curoffid='"+officeid+"'";
     ResultSet docs = DataBase.getQueryResults(sql);
     int temp;
     try{
     while(docs.next()){
         temp = docs.getInt("docid");
         alldocs.add(temp);
     }
     }catch(SQLException sqle){
         sqle.printStackTrace();
     }
return alldocs;
 }
 
 public static ArrayList<String> claimDocument(String empid, String listdocs, String offname){
    ArrayList<Integer> claimeddocs = new ArrayList<Integer>();
    HashMap<String,String> statuslookup = new HashMap<String,String>();

    String offid = DataBase.getOfficeId(offname);
    String[] docs = listdocs.split(";");
    String notadocid = "Wrong formation.. ";
    Set<Integer> uniquedocs = new HashSet<Integer>();
    String nosuchdoc="No such document id at this stage";
    String notformyoffice ="Sorry this document belongs to office ";
    String claimed = "Acquired document and granted access to you";
    
    //String searchquery ="select count(*) as count, forwardedtooffice from docintransit where docid = ? and forwardedtooffice='"+offid+"'";
    String searchquery ="select forwardedtooffice as fwd from docintransit where docid = ? ";
    String deleteentry= "delete from docintransit where docid=?";
    String updatestate = "update state set curoffid='"+offid+"' where docid = ?";
    String updatetrack = "update trackdocs set curholderid ='"+empid+"',currOfficeid='"+offid+"' where docid =? and currOfficeid='transit'";
    ResultSet rs;
    try{ 
    PreparedStatement prs = DataBase.createprepared(searchquery);
    PreparedStatement delprs = DataBase.createprepared(deleteentry);
    PreparedStatement updprs = DataBase.createprepared(updatestate);
    PreparedStatement updtrackprs = DataBase.createprepared(updatetrack);
    for(int i=0;i<docs.length;i++){
        docs[i]=docs[i].trim();
        System.err.println(docs[i]);
        if(docs[i].length()>0){
             try{
                int k = Integer.parseInt(docs[i]);
                if(uniquedocs.add(k)){
                    prs.setInt(1, k);
                    rs=prs.executeQuery();
                    String targetoff=offid;
                    if(rs.next()){
                        targetoff = rs.getString("fwd");
                        if(targetoff.equals(offid)){
                            //Employee has access
                            //remove from transit
                            delprs.setInt(1, k);
                            delprs.executeUpdate();
                            updprs.setInt(1, k);
                            updprs.executeUpdate();
                            updtrackprs.setInt(1,k);
                            updtrackprs.executeUpdate();
                            claimeddocs.add(k);
                            statuslookup.put(docs[i], claimed);
                            checkclaim(offid, k);
                            
                        }
                        else{
                        
                        String insertquery="insert into claimerrors values("+docs[i]+",'"+offid+"','"+targetoff+"')";
                        try{
                            DataBase.getQueryUpdate(insertquery, true);
                            //String updatetransit = "update docsintransit set forwardingoffice = '"+offid+"'";
                            //DataBase.getQueryUpdate(updatetransit,true);
                            statuslookup.put(docs[i],notformyoffice+".. I have informed the intended office"+DataBase.getOfficeName(targetoff));
                            
                            }
                        catch(SQLException sq){
                            sq.printStackTrace();
                        }
                        
                        }
                    }else{
                        statuslookup.put(docs[i],nosuchdoc);
                    }
                }
             }
            catch(NumberFormatException e){
                
                statuslookup.put(docs[i],notadocid);
                e.printStackTrace();
            //    statuslookup.put(docs[i],notadocid);
            }
            catch(SQLException sqle){
                sqle.printStackTrace();
            }
        }
            
    }
  }catch(SQLException sqle){
    sqle.printStackTrace();
       }
    
//System.err.println(claimeddocs.size());
        ArrayList<String> returnArray = new ArrayList<String>();
    Iterator it = statuslookup.entrySet().iterator();
    while(it.hasNext()){
        Map.Entry pair = (Map.Entry)it.next();
        String temp = pair.getKey()+":"+pair.getValue();
        returnArray.add(temp);
    }
return returnArray;

    
    
    
 //return claimeddocs;    
 }
 
 
 
 
 
}
