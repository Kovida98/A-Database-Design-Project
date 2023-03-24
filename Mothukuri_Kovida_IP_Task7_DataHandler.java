package Mothukuri;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class Mothukuri_Kovida_IP_Task7_DataHandler {
	private Connection conn;

    private String server = "moth0000-sql-server.database.windows.net";
    private String database = "cs-dsa-4513-sql-db";
    private String username = "moth0000";
    private String password = "Srinuani@9398";
    
    final private String url =
            String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;"
            		+ "trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
                    server, database, username, password);

    public void getDBConnection() throws SQLException {
        if (conn != null) {
            return;
        }

        this.conn = DriverManager.getConnection(url);
    }    

    public ResultSet FetchEmployees() throws SQLException {
        getDBConnection();
        
        final String option1 = "select tech_name as name ,tech_salary as salary ,tech_address as address from Tech_Staff UNION\r\n"
        		+ "SELECT qc_name,qc_salary, qc_address from Quality_Controller UNION\r\n"
        		+ "select w_name,w_salary,w_address from Worker;";
        final PreparedStatement s = conn.prepareStatement(option1);
        return s.executeQuery();
    }
    public ResultSet EmpSalary(
            float Employee_salary) throws SQLException {

    getDBConnection();
    final String option12 = "EXEC q12 @salary = "+ Employee_salary + ";";
    Statement s = conn.createStatement();
    return s.executeQuery(option12);
    }

    public boolean addEmployee(
            String emptype, String empname, String empaddress, float empsalary, String tech_position, 
            String degree, String type_of_product, int count_of_products) throws SQLException {

        getDBConnection(); // Prepare the database connection
        final String option1 = "EXEC q1  @emptype  = '"+emptype+"' , @ename = '"+empname+"', "
		+ "@address = '"+empaddress +"',@salary = '"+empsalary +"',@tech_position = '"+tech_position+"',"
		+ " @degree = '"+degree+"', @type_of_product = '"+type_of_product+"' , @count_of_Products =  '"+count_of_products+"';";

        final PreparedStatement s = conn.prepareStatement(option1);
        return s.executeUpdate() == 1;
    }
        

}
