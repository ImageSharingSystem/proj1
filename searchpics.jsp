<!-- Template referenced from http://luscar.cs.ualberta.ca:8080/yuan/ 
/***
 *  Copyright 2016 COMPUT 391, CS, UofA                             
 *  Author:  Liyan Yuan
 *                                                                  
 *  Licensed under the Apache License, Version 2.0 (the "License");         
 *  you may not use this file except in compliance with the License.        
 *  You may obtain a copy of the License at                                 
 *      http://www.apache.org/licenses/LICENSE-2.0                          
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  
 ***/
-->

<%@ page import="java.sql.*, java.util.*" %>
<html>
<div style="background-image:url('blue.jpg');width:100%;height:100%;solid black;">
<head>
</head>
<body text="yellow" >
<center>
<h3>Searched Images </h3>
<%   
      String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
      String m_driverName = "oracle.jdbc.driver.OracleDriver";
      
      String m_userName = "dingkai"; //supply username
      String m_password = "az11kt133"; //supply password
      
      Connection m_con;
      Statement stmt;
      try
      {
        Class drvClass = Class.forName(m_driverName);
        DriverManager.registerDriver((Driver)
        drvClass.newInstance());
        m_con = DriverManager.getConnection(m_url, m_userName, m_password);
        
      } 
      catch(Exception e)
      {      
        out.print("Error displaying data: ");
        out.println(e.getMessage());
        return;
      }
      try{
              
        if (request.getParameter("search") != null)
        {
        
          out.println("<br>");
          out.println("Query is " + request.getParameter("query"));
          out.println("<br>");
        
          if(!(request.getParameter("query").equals("")))
          {
            PreparedStatement doSearch;
            String startD, endD;
            startD = request.getParameter("start");          
            endD = request.getParameter("end");
            if(startD==""){startD = "1900-01-01";}
            if(endD==""){endD ="2100-01-01";}
            String sql = "SELECT photo_id, permitted, owner_name FROM images WHERE contains(subject, ?, 1) > 0 OR contains(place, ?, 2) > 0 OR contains(description, ?, 3) > 0 order by ";
            // time is at: anytime
            if(request.getParameter("time").equals("at")){
              sql += "(6*score(1)+3*score(2)+score(3)) desc";
              doSearch = m_con.prepareStatement(sql);
            }
            // time is mrf: ranking is based on most recent first    
            else if(request.getParameter("time").equals("mrf")){
              sql += "date_upload desc";
              doSearch = m_con.prepareStatement(sql);
            }
            // time is mrl: ranking is based on most recent last
            else{
              sql += "date_upload asc";
              doSearch = m_con.prepareStatement(sql);
            }  

            doSearch.setString(1, request.getParameter("query"));
            doSearch.setString(2, request.getParameter("query"));
            doSearch.setString(3, request.getParameter("query"));
            ResultSet rset = doSearch.executeQuery();
            String p_id = "", permitted = "", owner ="";
            Integer score;
            String userName = request.getParameter("usrName");
            boolean allowed;
            Statement stat = null;
            ResultSet rset2=null;
            String sqlStatement;
            Statement st = null;
            ResultSet rset3=null;
            String sqlt;
            while(rset.next())
            {
            

              p_id = (rset.getObject(1)).toString();
              sqlt ="select photo_id from images where photo_id = "+p_id+" and date_upload BETWEEN TO_DATE ('"+startD+"', 'yyyy-mm-dd') AND TO_DATE ('"+endD+"', 'yyyy-mm-dd')";
              st = m_con.createStatement();
              rset3 = st.executeQuery(sqlt);
              if(rset3.next()){
                permitted = (rset.getObject(2)).toString();
                owner = rset.getString(3);
                sqlStatement ="select friend_id from group_lists where group_id ="+permitted+" AND friend_id = '"+userName+"' ";
              
                stat = m_con.createStatement();
              //  out.println(sqlStatement);
                rset2 = stat.executeQuery(sqlStatement);
                allowed = false;
                // if we have value in the rset2, that means this user is permitted  
                while(rset2.next()){
                  allowed = true;          
                }
            
                // permitted is public is a special case
                if(allowed || permitted.equals("1") || owner.equals(userName) || userName.equals("admin")){
                 // specify the servlet for the image
                  out.println("<a href=\"GetBigPic?big"+p_id+"\">");
                 // specify the servlet for the themernail
                  out.println("<img src=\"/proj1/GetOnePic?"+p_id +
                             "\"></a>");
                
                }
              }
            }
          } 
          else
          {
            out.println("<br><b>Please enter text for quering</b>");
          }   
        }
        m_con.close();
      }
    catch(SQLException e)
    {
      out.println("SQLException: " +
      e.getMessage());
 //     m_con.rollback();
    }
%>

</body>
<html>
