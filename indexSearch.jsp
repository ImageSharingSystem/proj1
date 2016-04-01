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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<div style="background-image:url('blue.jpg');width:100%;height:100%;solid black;">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <title>Inverted Index example</title>
  </head>
  <body>

<%
      String usrName = request.getQueryString();
%>
      <div align="center"><br><br><br><br><br><br>
      <form name=insertData method=post action=searchpics.jsp> 
        <font color="yellow"><h1>Query for the images</h1></font>
        <table>
          <tr>
            <td>
              <font color="yellow"><input type=text name=query align="center" placeholder="Input Query.."> </br>

              <input type="radio" name="time" value="mrf"> Most-Recent-First<br><br>
              <input type="radio" name="time" value="mrl"> Most-Recent-Last<br><br>
              <input type="radio" name="time" value="at" checked ="checked"> Any-Time <br><br><br>

              Start Date: <input name="start" type="date"> </br></br>    
	      End Date:  <input name="end" type="date">  </br>  

              <input hidden type=text name="usrName" value=<%= usrName%>></br>
       
              <input type=submit value="Search" name="search" align="center">
            </td>
          </tr>
        </table>
   
    </form>
</div>
  </body>
</html>
