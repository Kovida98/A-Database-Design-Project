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
            final Mothukuri_Kovida_IP_Task7_DataHandler handler = new Mothukuri_Kovida_IP_Task7_DataHandler();
            final ResultSet getEmployee = handler.FetchEmployees();
        %>
        <table cellspacing="2" cellpadding="2" border="1">
            <tr> <!-- The table headers row -->
              <td align="center">
                <h4>employee name</h4>
              </td>
              <td align="center">
                <h4>employee address</h4>
              </td>
              <td align="center">
                <h4>employee salary</h4>
              </td>
            </tr>
            <%
               while(getEmployee.next()) {
                   final String name = getEmployee.getString("name");
                   final String address = getEmployee.getString("address");
                   final String salary = getEmployee.getString("salary");
                   out.println("<tr>"); 
                   out.println(
                        "<td align=\"center\">" + name +
                        "</td><td align=\"center\"> " + address +
                        "</td><td align=\"center\"> " + salary + "</td>");
                   out.println("</tr>");
               }
               %>
          </table>
    </body>
</html>
