<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
        <title>Employee data</title>
    </head>
    <body>
        <%@page import="Mothukuri.Mothukuri_Kovida_IP_Task7_DataHandler"%>
        <%@page import="java.sql.ResultSet"%>
        <%     	
                float Employee_salary = Float.parseFloat(request.getParameter("Employee_salary"));
             	Mothukuri_Kovida_IP_Task7_DataHandler handler =new Mothukuri_Kovida_IP_Task7_DataHandler();
             	final ResultSet getsalary = handler.EmpSalary(Employee_salary);
                %>
        <table cellspacing="2" cellpadding="2" border="1">
            <tr> <!-- The table headers row -->
              <td align="center">
                <h4>Employee name</h4>
              </td>
              <td align="center">
                <h4>Employee address</h4>
              </td>
              <td align="center">
                <h4>Employee salary</h4>
              </td>
            </tr>
            <%
               while(getsalary.next()) 
              { 
                   final String empname = getsalary.getString("employee_name");
                   final String empaddress = getsalary.getString("address");
                   final String empsalary = getsalary.getString("salary");                
                   out.println("<tr>");
                   out.println( 
                        "<td align=\"center\">" + empname +
                        "</td><td align=\"center\"> " + empaddress +
                        "</td><td align=\"center\"> " + empsalary + "</td>");
                   out.println("</tr>");
               }
               %>
          </table>
    </body>
</html>
