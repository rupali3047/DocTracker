/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DOCTRACK;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import utils.DataBase;


/**
 *
 * @author ab-admin
 */

//only reception calls this.
public class Document {

    public Document(int docId, String ownerid, String creationDate, String docinfo) {
        this.docId = docId;
        this.ownerid = ownerid;
        this.creationDate = creationDate;
        this.docinfo = docinfo;
    }
private int docId;
private String ownerid;
private String creationDate;
private String docinfo;


    public int getDocId() {
        return docId;
    }

    public void setDocId(int docId) {
        this.docId = docId;
    }

    public String getOwnerid() {
        return ownerid;
    }

    public void setOwnerid(String ownerid) {
        this.ownerid = ownerid;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public String getDocinfo() {
        return docinfo;
    }

    public void setDocinfo(String docinfo) {
        this.docinfo = docinfo;
    }
public boolean exists(){
        return false;
    }
private Document(int documentid){
    docId = documentid;
}
public static String createNewDocument(DataBase db,String ownerid, String docinfo, String accesscode, String employeeid){
    
    
    
    String sql = "insert into docs(accesscode,ownerid) values ('"+accesscode+"', '"+ownerid+"')";
    String managecurrent="insert into state values (?,'RECEP')";;
    
    String trackdoc;
    String doc ="invalid";
    //Document newdoc=null;
    try{
        PreparedStatement prpcurrent = DataBase.createprepared(managecurrent);
        int count = db.getQueryUpdate(sql);
        String myid = "select docid from docs order by created_on desc ";
        
        ResultSet rs = db.getQueryResults(myid);
        if(rs.next()){
            
            int docid = rs.getInt("docid");
            //newdoc = new Document(docid, ownerid,docinfo, accesscode);
            doc = new Integer(docid).toString();
             prpcurrent.setInt(1, docid);
             prpcurrent.executeUpdate();
            //
            trackdoc = "insert into trackdocs(docid,currOfficeid,prevOfficeid,lasteditorid,curholderid) values("+docid+",'RECEP','RECEP','"+employeeid+"', '"+employeeid+"')";
            db.getQueryUpdate(trackdoc);
        }
        
    }
    catch(SQLException sqle){
        sqle.printStackTrace();
    }
 return doc;
    
}



public static ArrayList<String> forwardDocs(String docids,String forofficename, String curofficename, String empid, String remark){
    HashMap<String,String> statuslookup = new HashMap<String,String>();
    String successmessage = "Forwarded to office "+forofficename;
    String notadocid = "Wrong formation.. ";
    String notinmyoffice ="Sorry the given document does not exist in this office";
    String withotheremployee = "The document is in the office with ";
    Set<Integer> uniquedocs = new HashSet<Integer>();
    System.err.println(forofficename);
  /*  boolean toarchive=false;
    if(forofficename.equalsIgnoreCase("offarchive"))
        toarchive = true;
    */
    String curofficeid =DataBase.getOfficeId(curofficename);
    String forofficeid = DataBase.getOfficeId(forofficename);
    String[] docs = docids.split(";");
    ArrayList<String> actualAccessible = new ArrayList<String>();
    ResultSet rs;
    String search = "select curholderid from trackdocs where docid =? and currOfficeid = '"+curofficeid+"' order by lastupdatetime desc LIMIT 1";
    String forwardto = "insert into trackdocs(docid,currOfficeid,prevOfficeid,lasteditorid,curholderid) values(?,?,?,?,?)";
    String totransit = "insert into docintransit(docid,forwarded_by,forwardingoffice,forwardedtooffice) values(?,?,?,?)";
    String addremark = "insert into remarks(docid,remarkText,remarkerid,officeid) values (?,'"+remark+"','"+empid+"','"+curofficeid+"')";
    String updatecurholder;
    PreparedStatement forwarding, transit,remarks;
    try{
        PreparedStatement searchdb = DataBase.createprepared(search);
        forwarding = DataBase.createprepared(forwardto);
        transit = DataBase.createprepared(totransit);
        remarks = DataBase.createprepared(addremark);
    for(int i=0;i<docs.length;i++){
        docs[i]=docs[i].trim();
        System.err.println(docs[i]);
        if(docs[i].length()>0){
            //
            try{
                int k = Integer.parseInt(docs[i]);
                if(k>9999||k<0)
                    statuslookup.put(docs[i],notadocid);    
                else{
                    if(uniquedocs.add(k)){
                    actualAccessible.add(docs[i]);
                    searchdb.setInt(1, k);
                    rs = searchdb.executeQuery();
                    if(rs.next()){
                        String holder = rs.getString("curholderid");
                        if(holder.equals(empid)){
                            //Forward to given office
                            forwarding.setInt(1, k);
                   /*         if(!toarchive)
                                forwarding.setString(2, "transit");
                           else */
                            forwarding.setString(2, "transit");
                            forwarding.setString(3, curofficeid);
                            forwarding.setString(4, empid);
                            forwarding.setString(5, "transit@doctrack");
                            forwarding.executeUpdate();
             //               if(toarchive==false){
                                transit.setInt(1, k);
                                transit.setString(2, empid);
                                transit.setString(3, curofficeid);
                                transit.setString(4, forofficeid);
                                transit.executeUpdate();
                                
           //                 }
                            remarks.setInt(1, k);
                            remarks.executeUpdate();
                            statuslookup.put(docs[i],successmessage);
          /*                  if(toarchive)
                                 updatecurholder = "update state set curoffid='offarchive' where docid="+k;
                            else*/
                                 updatecurholder = "update state set curoffid='transit' where docid="+k;
                            
                           
                            DataBase.getQueryUpdate(updatecurholder);
                        }
                        else{
                            statuslookup.put(docs[i],withotheremployee);
                        }
                    }
                    else{
                            statuslookup.put(docs[i],notinmyoffice);
                    }
                    }
                    }
                
            }
            catch(NumberFormatException e){
                e.printStackTrace();
                statuslookup.put(docs[i],notadocid);
            }
            catch(SQLException sqle){
                sqle.printStackTrace();
            }
            
        }
    }
    }catch(SQLException sqle){
        sqle.printStackTrace();
    }
    ArrayList<String> returnArray = new ArrayList<String>();
    Iterator it = statuslookup.entrySet().iterator();
    while(it.hasNext()){
        Map.Entry pair = (Map.Entry)it.next();
        
        String temp = pair.getKey()+":"+pair.getValue();
        returnArray.add(temp);
    }
return returnArray;
}






public static ArrayList<trackinfo> trackthis(int docid){
    String trackdoc = "select * from trackdocs where docid="+docid+" order by lastupdatetime desc";
    ResultSet rs;
    trackinfo newobj;
    ArrayList<trackinfo> wholelist = new ArrayList<trackinfo>();
 try{
     rs=DataBase.getQueryResults(trackdoc);
    while(rs.next()){
        String curoff= rs.getString("currOfficeid");
        String prevoff = rs.getString("prevOfficeid");
        Timestamp lastupdate = rs.getTimestamp("lastupdate");
        String curholder = rs.getString("curholderid");
        newobj = new trackinfo();
        newobj.setCurholder(curholder);
        newobj.setCuroffice(curoff);
        if (curoff.equals(prevoff)){
            newobj.setIsfirstOffice(true);
            newobj.setPrevoffice("ORIGIN");
        }
        else
        newobj.setPrevoffice(prevoff);
        newobj.setLeftoffice(lastupdate.getTime());
        wholelist.add(newobj);
    }
     
 }catch(SQLException sqle){
     sqle.printStackTrace();
 }
    return wholelist;
}


public static ArrayList<trackinfo> trackthiswithremarks(int docid,int accessid) throws DocumentException{
    String trackdoc;
    ArrayList<trackinfo> wholelist = new ArrayList<trackinfo>();
 
    boolean checkdoc=false;
    if(accessid!=-1){
        String docaccess= "select count(*) as count from docs where docid="+docid+" and accesscode="+accessid;
        ResultSet rs;
        rs= DataBase.getQueryResults(docaccess);
        try{
            if(rs.next()){
                int cnt = rs.getInt("count");
    System.err.println(cnt);
                if(cnt==1)
                    checkdoc=true;
                else
                    throw new DocumentException("Access not authorized");
            }
        }catch(SQLException sqle){
            sqle.printStackTrace();
            checkdoc=false;
        }
        catch(DocumentException de){
            throw de;
        }
    }
    else
        checkdoc=true;
    
    if(checkdoc){
        
        trackdoc = "select * from trackdocs where docid="+docid+" order by lastupdatetime desc";
    String getremarks = "select * from remarks where docid = "+docid+" order by remarkon desc";
    ResultSet rst,remrs;
    trackinfo newobj;
    remark remobj;
    try{
     rst=DataBase.getQueryResults(trackdoc,true);
     
     remrs=DataBase.getQueryResults(getremarks,true);
    while(rst.next()){
        String curoff= rst.getString("currOfficeid");
        String prevoff = rst.getString("prevOfficeid");
        //String lastupdate = rst.getString("lastupdatetime");
        Timestamp lastupdate = rst.getTimestamp("lastupdatetime");
        
        System.err.println(lastupdate);
        String curholder = rst.getString("curholderid");
        if(remrs.next()){
        String remarkerid = remrs.getString("remarkerid");
        String remarkername = DataBase.getEmployeeName(remarkerid);
        //String remarkofficeid = rs.getString("");
        Timestamp remarkTime=remrs.getTimestamp("remarkon");
        String remarkText = remrs.getString("remarkText");
     
        remobj = new remark();
        remobj.setRemarkText(remarkText);
        remobj.setRemarker(remarkername);
        remobj.setRemarkDate(remarkTime.getTime());
        newobj = new trackinfo();
        newobj.setAssociatedremark(remobj);
        newobj.setCurholder(curholder);
        newobj.setCuroffice(curoff);
        if (curoff.equals(prevoff)){
            newobj.setIsfirstOffice(true);
            newobj.setPrevoffice("ORIGIN");
        }
        else
            newobj.setPrevoffice(prevoff);
        newobj.setLeftoffice(lastupdate.getTime());
        
        wholelist.add(newobj);
        
        }
    }
     
 }catch(SQLException sqle){
     sqle.printStackTrace();
 }
    }
    return wholelist;
}
}
