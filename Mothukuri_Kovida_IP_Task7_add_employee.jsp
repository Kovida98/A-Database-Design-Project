<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Query Result</title>
</head>
    <body>
    <%@page import="Mothukuri.Mothukuri_Kovida_IP_Task7_DataHandler"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.Array"%>
    <%
    Mothukuri_Kovida_IP_Task7_DataHandler handler = new Mothukuri_Kovida_IP_Task7_DataHandler();
	
    String emptype,empname,empaddress,tech_position,degree,type_of_product;
    float empsalary;
    int count_of_products;
    emptype = request.getParameter("emptype");
    empname = request.getParameter("empname");
    empaddress = request.getParameter("empaddress");
    empsalary = Float.parseFloat(request.getParameter("empsalary"));
    tech_position = request.getParameter("tech_position");
    degree = request.getParameter("degree");
    type_of_product = request.getParameter("type_of_product");
    count_of_products = Integer.parseInt(request.getParameter("count_of_products"));

    if (empname.equals("") || empsalary == 0 || empaddress.equals("")) {
        response.sendRedirect("Mothukuri_Kovida_IP_Task7_add_employee_form.jsp");
    } else {
        
        boolean success = handler.addEmployee(emptype, empname, empaddress, empsalary, tech_position, degree, type_of_product, count_of_products);
        
        if (!success) { 
            %>
                <h2>There was a problem inserting the Employee data</h2>
            <%
        } else {
            %>
            <h2>Inserted Employee data:</h2>
            <ul>
                <li>Employee type: <%=emptype%></li>
                <li>Employee name: <%=empname%></li>
                <li>Employee address: <%=empaddress%></li>
                <li>Employee salary: <%=empsalary%></li>
                <li>tech position: <%=tech_position%></li>
                <li>degree: <%=degree%></li>
                <li>product type: <%=type_of_product%></li>
                <li>number of products produced: <%=count_of_products%></li>
            </ul>

            <h2>Was successfully inserted.</h2>
            
            <a href="Mothukuri_Kovida_IP_Task7_get_all_employee.jsp">See all employee data.</a>
            <%
        }
    }
    %>
    </body>
</html>
