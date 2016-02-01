<%@page import="DOCTRACK.DocumentException"%>
<%@page import="DOCTRACK.trackinfo"%>
<%@page import="DOCTRACK.Document"%>
<%@page import="DOCTRACK.OfficeException"%>
<%@page import="DOCTRACK.Employee"%>
<%@page import="DOCTRACK.UserException"%>
<%@ page import="DOCTRACK.Office"%>
<%@ page import="DOCTRACK.User"%>
<%@ page import="DOCTRACK.CheckCreds"%>

<%@ page import="utils.DataBase"%>
<%@ page import="utils.DbConfig"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.util.*" %>
<%
String action = request.getParameter( "action" );
int control = 0;

	if(action.equals("LoginAdmin"))
    control = 1;
else if(action.equals("LoginUser"))
	control = 2;

else if(action.equals("Register"))
	control = 3;

else if(action.equals("AddOffice"))
	control = 4;

else if(action.equals("RemoveOffice"))
	control = 5;
else if(action.equals("AddEmployee"))
	control = 6;
else if(action.equals("RemoveEmployee"))
	control = 7;
else if(action.equals("AddDocumentRecep"))
	control = 8;
else if(action.equals("ForwardDocument"))
	control = 9;
else if(action.equals("AddDocumentEmp"))
	control = 10;
else if(action.equals("OfficeWiseDetails"))
	control = 11;
else if(action.equals("CheckStatusOut"))
	control = 12;
else if(action.equals("AddDocumentUser"))
	control = 13;
else if(action.equals("Check!!")) //Check Status Out
	control = 14;

//out.println("control is"+ control);

String user_name;
String name;
String off_name;
String desc;
String email;
String password;
String off_id;
String emp_name;
String result;
String str;
String doc_id;
String remarks;
Integer count;
String mobile;
String doc_details;
String access_code;
String emp_id;
String[] resultArray;
List<String> resultArraystr = new ArrayList<String>();
List<Integer> resultArrayint = new ArrayList<Integer>();
ArrayList<trackinfo> trackarr = new ArrayList<trackinfo>();
DbConfig configdb = new DbConfig("doctrack",false);
DataBase mydb;
mydb = new DataBase(configdb);
boolean success;
String[] strArray;
switch(control)
{
	
	case 1: //LoginAdmin
		   user_name = request.getParameter( "email" );
                   password = request.getParameter( "password" );
		   // Call to Login Feature
		   result = CheckCreds.checkOfficeValidity(user_name, password, mydb);
		   if(!result.equals("invalid"))
                   {
                   session.setAttribute( "theName", user_name );    
                   session.setAttribute( "offName", result );    
                   }
                   out.print(result);
		   //out.print(password);
                   break;

	case 2: //LoginUser
		   user_name = request.getParameter( "email" );
                   password = request.getParameter( "password" );
		   // Call to Login Feature
		   result = CheckCreds.checkUserValidity(user_name, password, mydb);
		   if(!result.equals("invalid"))
                   {
                   session.setAttribute( "name", result );    
                   session.setAttribute( "theName", user_name );    
                   }
                   out.print(result);
		   
                   break;
         case 3: //Register
		   user_name = request.getParameter( "user_name" );
                   email = request.getParameter( "email" );
                   password = request.getParameter( "password" );
		   // Call to Login Feature
		   success=false;
                   try{
                   success = User.makeNewUser(email,user_name, password, mydb);
                   }
                   catch(UserException obj){
                       System.err.println("user already exists...");
                       //
                       
                       //
                   }
                   out.print(success);
                   
                   break;
          case 4: //Add New Office
		   off_name = request.getParameter( "off_name" );
                   desc = request.getParameter( "description" );
                   try{
                   result = Office.makeNewOffice(off_name, desc, mydb);
		   if(result.equals("invalid"))
                   {
                           out.print("office Could Not be created... Please Try Again!!");
                   }
                       
                   else
                   {
                       out.println("Office With Name : "+ off_name + " created Successfully.");
                     out.print("Office ID : " + result);
                   }
                   }catch(OfficeException ofe){
                       out.print(ofe);
                   }
                   /*str="good;luck";
                   strArray = str.split("\\;");
                   if(strArray[0].equals("good"))
                   {
                     out.println("Office With Name : "+ off_name + " created Successfully.");
                     out.print("Office ID : " + strArray[1]);
                   }
                   else
                       out.print("invalid");
                   */
                   break;
           case 5: //Remove Office
		   off_name = request.getParameter( "off_name" );
                   
                   
                   //success = Office.removeOffice(off_id,off_name, mydb);
		   out.print("true");
                   
                   break;    
	    case 6: //Add New Employee
                 //out.print("here");
                off_name = request.getParameter( "off_name" );
                   emp_name = request.getParameter( "emp_name" );
                   email = request.getParameter( "email" );
                   password = request.getParameter( "pwd" );
                   System.err.println(email+  "       sdlfkdksjf");
                   success = Employee.makeNewEmployee(off_name, emp_name,email,password, mydb);
		   out.print(success);
                   if(success)
                   {
                       out.println("Employee With Name : "+ emp_name + " is added in Office - "+off_name );
                   }
                   else
                   {
                   out.print("invalid" );
                   }
                   /*str="true;luck";
                   strArray = str.split("\\;");
                   if(strArray[0].equals("true"))
                   {
                     out.println("Employee With Name : "+ emp_name + " is added in Office - "+off_name );
                     out.print("Employee ID : " + strArray[1]);
                   } 
                   else
                       out.print("invalid");
                   */        
                   break; 
            case 7: //Remove Employee
		   emp_id = request.getParameter( "emp_id" );
                   //success = Office.makeNewOffice(off_name, desc, mydb);
		   out.print("true");
                   
                   break;
            case 8: //Add New Document Reception
		   
                   email = request.getParameter( "email" );
                   access_code = request.getParameter( "access_code" );
                   user_name=(String)session.getAttribute("theName");
                   doc_details = request.getParameter( "doc_details" );
                   if(email.equals(""))
                   {
                       email="public";
                   }
                   result = Document.createNewDocument(mydb , email, doc_details,access_code,user_name);
		   if (result.equals("invalid"))
                   {
                       out.print("invalid");
                   }
                   else
                   {
                       out.println("Document Submitted successfully..." );
                     out.print("Document ID : " + result);
                   }
                   /*str="true;docid";
                   strArray = str.split("\\;");
                   if(strArray[0].equals("true"))
                   {
                     out.println("Document Submitted successfully..." );
                     out.print("Document ID : " + strArray[1]);
                   }
                   else
                       out.print("invalid");
                           */
                   break;
            case 9: //Forward Document 
                System.err.println("hii");
		   doc_id = request.getParameter( "doc_id" );
                   off_name = request.getParameter( "off_name" );
                   remarks = request.getParameter( "remarks" );
                   emp_id=(String)session.getAttribute("theName"); 
                   user_name=(String)session.getAttribute("offName");
                   resultArraystr = Document.forwardDocs(doc_id,off_name,user_name,emp_id,remarks);
                   count = resultArraystr.size();
                   while(count>0)
                   {
                    strArray = resultArraystr.get(count-1).split(":");
                    out.println("Document :- "+strArray[0]+" - "+strArray[1]);
                    count=count-1;
                   }
                   
                   //success = Office.addOffice(off_name, emp_name, mydb);
		   //out.print(success);
                   
                   break;
            case 10: //Add New Document Employee
		   doc_id = request.getParameter( "doc_id" );
                   emp_id=(String)session.getAttribute("theName"); 
                   off_name = (String)session.getAttribute("offName");
                   resultArraystr = Employee.claimDocument(emp_id, doc_id, off_name);
		   count = resultArraystr.size();
                   System.err.print(count);
                  
                   while(count>0)
                   {
                    
                    out.println("Document :- "+resultArraystr.get(count-1));
                    count=count-1;
                   }
                   
                   //out.print(success);
                   break;    
            case 11: //Office Wise Details
		   off_name = request.getParameter( "office_name" );
                   
                   count = DataBase.getnumdocsinoffice(off_name);
                   
                   //success = Office.addNewEmployee(off_name, emp_name, mydb);
		   //out.print(success);
                   out.println("# of Docs at Present :- "+count);
                   break;        
             case 12: //Check Status Out
		   doc_id = request.getParameter( "doc_id" );
                   access_code = request.getParameter("access_code");
                   try
                   {
                   int docid= Integer.parseInt(doc_id);
                   int accesscode = Integer.parseInt(access_code);
                   
                   trackarr = Document.trackthiswithremarks(docid,accesscode);
                   count = trackarr.size();
                   out.println("Status of the Doc : -"+docid);
                   out.println();
                   if(trackarr.get(0).getCuroffice().equals("TRANSIT"))
                   {
                       out.println("Approved & Forwarded By  : - "+trackarr.get(1).getCuroffice());
                       out.println("Currently in Transit..");
                   }
                   else
                   {
                       out.println("Current Office : - "+trackarr.get(0).getCuroffice());
                   }
                   out.println();
                   out.println();
                   out.println("Track Path : -");
                   int i=1;
                   while(count>1)
                   {
                       
                   out.println(i +". "+ trackarr.get(count-1).getCuroffice() +" >> "+trackarr.get(count-2).getAssociatedremark().getRemarkText()+" @ "+ trackarr.get(count-1).getAssociatedremark().getRemarkDate() );
                   count= count-1;
                   i=i+1;
                   }
                   }
                   catch(NumberFormatException nbfe){
                       nbfe.printStackTrace();
                       //Do exception handling here...
                       
                       
                   }
                   catch(DocumentException de)
                   {
                       out.print(de);
                   }
                   //success = Office.addNewEmployee(off_name, emp_name, mydb);
		   //out.print(success);
                   
                   break;        

             case 13: // Add Document User
                   access_code = request.getParameter( "access_code" );
                   doc_id = request.getParameter( "doc_id" );
                   user_name=(String)session.getAttribute("theName"); 
                   success = User.ownDocument(doc_id,access_code,user_name);
		   
                   if(success)
                   {
                       out.println("Document : "+ doc_id + " is added to your account successfully." );
                   }
                   else
                   {
                   out.print("Sorry!!! Document could not be added.... Please Try Again.." );
                   }
             case 14: // Check Status Out
                   access_code = request.getParameter( "access_code" );
                   doc_id = request.getParameter( "doc_id" );
                   user_name=(String)session.getAttribute("theName"); 
                   success = User.ownDocument(doc_id,access_code,user_name);
		   
                   if(success)
                   {
                       out.println("Document : "+ doc_id + " is added to your account successfully." );
                   }
                   else
                   {
                   out.print("Sorry!!! Document could not be added.... Please Try Again.." );
                   }
               
                 


}
	

%>
            