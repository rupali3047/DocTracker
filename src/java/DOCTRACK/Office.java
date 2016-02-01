package DOCTRACK;
import DOCTRACK.OfficeException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DataBase;

public class Office {
    private String officeid;
    private String officename;
    private String officeinfo;

    public String getOfficeinfo() {
        return officeinfo;
    }

    public void setOfficeinfo(String officeinfo) {
        this.officeinfo = officeinfo;
    }

    public String getOfficeid() {
        return officeid;
    }

    public void setOfficeid(String officeid) {
        this.officeid = officeid;
    }

    public String getOfficename() {
        return officename;
    }

    public void setOfficename(String officename) {
        this.officename = officename;
    }
    private Office(String officeid, String officename, String officeinfo){
        this.officeid = officeid;
        this.officename = officename;
        this.officeinfo = officeinfo;
    }
    

    
    public static String makeNewOffice(String officename, String officeinfo, DataBase db) throws OfficeException{
        int numoff = db.getNumOffices();
        boolean success = false;
        Office newOffice = null;
        String newOfficeID = "invalid";
        if(numoff<0){
            System.err.println("Error while creating... Abort");
        }
        else{
            newOfficeID= "OFF"+(numoff);
            newOffice = new Office(newOfficeID, officename, officeinfo);
            
            db.registerOffice(newOffice);
            success = true;
        
        }
       return newOfficeID;
    }
    
    
    
    public static ArrayList<TransitDoc> getAvailableDocs(String officename){
        String officeid = DataBase.getOfficeId(officename);
        ArrayList<TransitDoc> alldocs= new ArrayList<TransitDoc>();
        String getAvailable= "select * from docintransit where forwardedtooffice ='"+officeid+"'";
        ResultSet rs = DataBase.getQueryResults(getAvailable);
        TransitDoc newobj;
        int docid;
        try{
            while(rs.next()){
                docid = rs.getInt("docid");
                String forwardedby = rs.getString("forwarded_by");
                String forwardingOffice = rs.getString("forwardingOffice");
                newobj= new TransitDoc(docid, forwardedby, forwardingOffice);
                alldocs.add(newobj);
                    
//String f
                
            }
        }
        catch(SQLException sqle){
            sqle.printStackTrace();
        }
                
        
        
        return alldocs;
    }
    
 
    
    
}
