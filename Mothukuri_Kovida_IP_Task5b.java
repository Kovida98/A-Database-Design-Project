package Mothukuri;

import java.io.File;
import java.util.Date;
import java.util.Scanner; 
import java.io.FileWriter;
import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.Statement; 
import java.sql.ResultSet; 
import java.sql.SQLException; 
import java.sql.DriverManager; 

public class Mothukuri_Kovida_IP_Task5b {
	final static String HOSTNAME = "moth0000-sql-server.database.windows.net"; 
    final static String DBNAME = "cs-dsa-4513-sql-db"; 
    final static String USERNAME = "moth0000"; 
    final static String PASSWORD = "Srinuani@9398";  
 
    // Database connection string 
    final static String URL = 
String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;"
		+ "trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", 
            HOSTNAME, DBNAME, USERNAME, PASSWORD);
    
    // User input prompt// 
    final static String PROMPT =  
            "\nPlease select any of the options below: \n" + 
            "1) Enter a new employee (option 1) \n" + 
            "2) Enter a new product associated with the person who made the product, repaired the product if it is repaired, or checked the product (option 2) \n"+ 
            "3) Enter a customer associated with some products (option 3) \n" +  
            "4) Create a new account associated with a product (option 4) \n"+
            "5) Enter a complaint associated with a customer and product (option 5)  \n"+
            "6) Enter an accident associated with an appropriate employee and product  (option 6) \n"+
            "7) Retrieve the date produced and time spent to produce a particular product (option 7)  \n"+
            "8) Retrieve all products made by a particular worker (option 8) \n"+
            "9) Retrieve the total number of errors a particular quality controller made.This is the total number of products certified"
            + " by this controller and got some complaints (option 9)\n"+
            "10) Retrieve the total costs  of the  products  in the product3 category which were repaired at the \r\n"
            + "request of a particular quality controller(option 10) \n"+
            "11) Retrieve all customers (in name order) who purchased all products of a particular color (option 11)  \n"+
            "12) Retrieve all employees whose salary is above a particular salary (option 12)\n"+
            "13) Retrieve the total number of workdays lost due to accidents in repairing the products which got complaints (option 13) \n"+
            "14) Retrieve the average cost of all products made in a particular year (option 14)\n"+
            "15) Delete all accidents whose dates are in some range (option 15)\n"+
            "16) Import: enter new employees from a data file until the file is empty (the user must enter the input file name) (option 16)\n"+
            "17) Export:  Retrieve  all  customers  (in  name  order)  who  purchased  all  products  of  a particular color  \n"
            + "and output them to a data file instead of screen (the user must enter the output file name) (option 17)\n"+ 
            "18) Exit (option 18) ";
    
    public static void main(String[] args) throws SQLException { 
    	
    	System.out.println("Now you can start using the application");
        final Scanner input = new Scanner(System.in); // Scanner is used to collect the user input 
        String option = ""; // Initialize user option selection as nothing 
        while (!option.equals("18")) { // As user for options until option 18 is selected 
            System.out.println(PROMPT); // Print the available options 
            option = input.next(); // Read in the user option selection
            
            final Connection connection = DriverManager.getConnection(URL);           
            switch (option) { // Switch between different options 
            // employee insertion
            case "1":
            	try {
            		
            	String emptype,empname,empaddress,tech_position,degree,type_of_product;
            	int count_of_products;
            	Float empsalary;
            	
            	System.out.println("enter employee type"); 
            	input.nextLine();
                emptype= input.nextLine(); // input of employee type
            	
            	System.out.println("enter employee name");  
                empname= input.nextLine(); // input of employee name 

                System.out.println("enter employee address"); 
                empaddress = input.nextLine(); // input of employee address 
                
                System.out.println("enter employee salary"); 
                empsalary= input.nextFloat(); // input of employee salary
                
                System.out.println("enter position");
                input.nextLine();
                tech_position= input.nextLine(); // position of employee
                
                System.out.println("enter degree");
                degree= input.nextLine(); // degree of the employee
                
                System.out.println("enter type of product");
                type_of_product = input.nextLine(); // type of product
                 
                System.out.println("enter count of products per day");
                count_of_products= input.nextInt(); // max products a employee Produce
                
                
                final String option1 = "EXEC q1  @emptype  = '"+emptype+"' , @ename = '"+empname+"', "
                		+ "@address = '"+empaddress +"',@salary = '"+empsalary +"',@tech_position = '"+tech_position+"',"
                				+ " @degree = '"+degree+"', @type_of_product = '"+type_of_product+"' , @count_of_Products =  '"+count_of_products+"';";
                
                
            	System.out.println("Connecting to the database..."); 
                
            	final Statement statement1 = connection.createStatement(); 
 
                    final int rows_inserted = statement1.executeUpdate(option1); 
                    System.out.println(String.format("employee record inserted Successfully. %d rows inserted.", rows_inserted)); 

            	}
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 1" +e);
        		}
            break;
            
            //product insertion
            case "2":
            	try {
            		
                String protype,prod_date,prod_per,test_per,rep_per,date_rep,size,soft_name,color;
                int product_id,making_time,req;
                Float p_Weight;
                
                System.out.println("Enter the type of product");
                input.nextLine(); 
                protype = input.nextLine(); // type of product
            	
            	System.out.println("Enter Product id");  
                product_id = input.nextInt(); // product id 

                System.out.println("Enter Produced date");
                input.nextLine();
                prod_date = input.nextLine(); // produced date
                
                System.out.println("Enter making time"); 
                making_time = input.nextInt(); //making time
                
                
                System.out.println("Enter Produced person name");
                input.nextLine();
                prod_per= input.nextLine(); // produced person
                
                System.out.println("Enter tested person name");
                test_per = input.nextLine(); // tested person 
                
                
                System.out.println("Enter Repaired person name "); 
                rep_per= input.nextLine(); // repaired  person
                
                
                System.out.println("Enter Repaired date"); 
                date_rep= input.nextLine(); // repaired date
                
                System.out.println("Enter the size of product"); 
                size= input.nextLine(); // size of product
                
                System.out.println("Enter software Name"); 
                soft_name= input.nextLine(); // software name
                
                System.out.println("Enter Color of product");
                color= input.nextLine(); // color of product2
                
                System.out.println("Enter Weight of product"); 
                p_Weight= input.nextFloat(); // weight of product3

                
                System.out.println("if product repaired enter 1 or -1"); 
                req= input.nextInt(); // repaired 1 or -1
                
                
                final String option2 = " EXEC q2  @protype  = '"+protype+"', @product_ID = '"+product_id+"',"
                		+ " @produced_date = '"+prod_date+"', @making_time = '"+making_time+"', "
                				+ "@produced_person = '"+prod_per+"',@tested_person= '"+test_per+"', "
                						+ "@repaired_person = '"+rep_per+"', @date_repaired = '"+date_rep+"', "
                								+ "@size = '"+size+"', @software_name = '"+soft_name+"',"
                										+ " @color = '"+color+"', @p_weight= '"+p_Weight+"', @req = '"+req+"';";
                
                
            	System.out.println("Connecting to the database..."); 
            	
            	final Statement statement2 = connection.createStatement(); 
            	
                final int rows_inserted = statement2.executeUpdate(option2); 
                System.out.println(String.format("product record inserted Successfully. %d rows inserted.", rows_inserted));
        	}
        	

        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 2" +e);
        		}
            break;           
            case "3":
            	try {
            	
            	String customer_name,customer_address;
            	int Product_ID;
            	
            	System.out.println("Enter customer name"); 
            	input.nextLine(); 
                customer_name= input.nextLine(); //customer name
                
                System.out.println("Enter customer address"); 
                customer_address= input.nextLine(); // customer address
                

                System.out.println("Enter customer purchased product id "); 
                Product_ID= input.nextInt(); // product id
                
                final String option3 = "EXEC q3  @customer_name  = '"+customer_name+"',"
                		+ " @customer_address = '"+ customer_address+"', @product_ID = '"+Product_ID+"';";
                
            		
            	System.out.println("Connecting to the database..."); 
            	final Statement statement3 = connection.createStatement(); 
                final int rows_inserted = statement3.executeUpdate(option3); 
                System.out.println(String.format("Customer record inserted Successfully. %d rows inserted.", rows_inserted));
        	}
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 3" +e);
        		}
            	
            break;
            
            case "4":
            	try {

	            int acc_product_id,ptype;
	            Float Cost;
	            String created_date,account_number;
	            
	            System.out.println("enter Account number");
	            input.nextLine();
	            account_number= input.nextLine(); // account number 
	            
	            System.out.println("enter date created"); 
	            created_date= input.nextLine(); // created date
	            
	            System.out.println("enter product cost"); 
	            Cost= input.nextFloat(); // cost	  
	            
	            System.out.println("enter product id"); 
	            acc_product_id= input.nextInt(); // product id 
	            
	            System.out.println("enter account type"); 
	            input.nextLine(); 
	            ptype= input.nextInt(); // account type
	            


	            final String option4 = "EXEC q4  @account_number  = '"+account_number+"', "
	            		+ "@created_date = '"+created_date+"', @cost = '"+Cost+"',"
	            				+ "@product_ID = '"+acc_product_id+"',@ptype = '"+ptype+"';";
            		
            	System.out.println("Connecting to the database..."); 
            	final Statement statement4 = connection.createStatement(); 
            		 
             
                
                final int rows_inserted = statement4.executeUpdate(option4); 
                System.out.println(String.format("account record inserted Successfully. %d rows inserted.", rows_inserted));
        	}
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 4" +e);
        			input.nextLine();
        		}
            break;
            
            case "5":
            	try {
            		
            	int Complaint_Product_id,repreq;
            	String complaint_ID,complaint_date,comp_desc,treatment,techname,date_repaired;

	            System.out.println("enter Complaint id"); 
	        	input.nextLine(); 
	            complaint_ID= input.nextLine(); // complaint id
	            
	            System.out.println("enter complaint date"); 
	            complaint_date= input.nextLine(); //complaint date
	            

	            System.out.println("enter description"); 
	            comp_desc= input.nextLine(); // description
	            
	            System.out.println("treatment expected"); 
	            treatment= input.nextLine(); // treatment expected
	            
	            System.out.println("enter product id"); 
	            Complaint_Product_id= input.nextInt(); // product id
	            
	            System.out.println("enter 1 if possible to repair or 0");
	            input.nextLine(); 
	            repreq= input.nextInt(); 

	            System.out.println("enter technical staff name"); 
	            input.nextLine(); 
	            techname= input.nextLine(); //technical staff name
	            
	            System.out.println("enter date of repair"); 
	            date_repaired= input.nextLine(); // repair date
	            
	            final String option5 = "EXEC q5  @complaint_ID = '"+complaint_ID+"', "
	            		+ "@complaint_date = '"+complaint_date+"', @comp_desc = '"+comp_desc+"',"
	            				+ "@treatment = '"+treatment+"',@product_ID = '"+Complaint_Product_id+"',"
	            						+ " @repreq = '"+repreq+"', @techname =  '"+techname+"',"
	            								+ " @date_repaired = '"+date_repaired+"';";
            		
            	System.out.println("Connecting to the database..."); 
            	final Statement statement5 = connection.createStatement(); 
            		 

               
                final int rows_inserted = statement5.executeUpdate(option5); 
                System.out.println(String.format("complaint record inserted Successfully. %d rows inserted.", rows_inserted));
        	}
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 5" +e);
        		}
            break;

            
            case"6":
            	try {
            		
            	String accident_number,accident_date,accitype;
            	int days_lost,Product_id;
	            
            	System.out.println("enter Accident number"); 
            	input.nextLine(); 
	            accident_number= input.nextLine(); // Accident number
	            
	            System.out.println("enter accident date");
	            accident_date= input.nextLine(); // accident date
	            
	            System.out.println("enter days lost"); 
	            days_lost= input.nextInt(); // days lost due to accident
	            
	            System.out.println("enter accident product id:"); 
	            Product_id= input.nextInt(); // product id
	            
	            System.out.println("Enter accident type(type1 or type2)");
	            input.nextLine(); 
	            accitype= input.nextLine(); // accident type 
	            
	            final String option6 = "EXEC q6  @accident_number  = '"+accident_number+"',"
	            		+ " @accident_date = '"+accident_date+"' , @days_lost = '"+days_lost+"' ,"
	            				+ "@product_ID = '"+Product_id+"',@accitype = '"+accitype+"';";          		

           		
            	System.out.println("Connecting to the database..."); 
            	final Statement statement6 = connection.createStatement(); 
            	
                final int rows_inserted = statement6.executeUpdate(option6); 
                System.out.println(String.format("complaint record inserted Successfully. %d rows inserted.", rows_inserted));
        	}
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 6" +e);
        		}
            break;
            
            
            case"7":           	
            	try {           		
            	int product_id;
            	System.out.println("Please enter Product id"); 
	        	input.nextLine(); 
	            product_id= input.nextInt(); // product id
	            final String option7 = "EXEC q7 @product_id = '"+product_id+"';";
	            try (final Statement statement7 = connection.createStatement(); 
	            		final ResultSet resultSet1 = statement7.executeQuery(option7)){
                    System.out.println("Results");
                    input.nextLine();
                    System.out.println(" Produced_date | making_time "); 
                    
                    while (resultSet1.next()) { 
                        System.out.println(String.format("  %s	 | %s ", 
                            resultSet1.getString(1), 
                            resultSet1.getFloat(2)));                     
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 7" +e);
        		}
	            
            break;
            
            case"8":            	
            	try {            		
            	String produced_per;
        		System.out.println("enter produced person name"); 
	        	input.nextLine(); 
	            produced_per= input.nextLine(); // produced person
	            
	            	
	            final String option8 = "EXEC q8 @produced_person = '"+produced_per+"';";
	            
	            try (final Statement statement8 = connection.createStatement(); 
	            		final ResultSet resultSet2 = statement8.executeQuery(option8)){
                    System.out.println(" product_ID "); 
                    while (resultSet2.next()) { 
                        System.out.println(String.format("  %s  ", 
                            resultSet2.getInt(1)));                     
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 8" +e);
        		}	            
            break;
            
            case"9":
            	
            	try {            		
            	String tested_per;
        		System.out.println("enter tested person name"); 
	        	input.nextLine(); 
	            tested_per= input.nextLine(); // tested person
	            
	            	
	            final String option9 = "EXEC q9 @tested_person = '"+tested_per+"';";
	            
	            try (final Statement statement9 = connection.createStatement(); 
	            		final ResultSet resultSet3 = statement9.executeQuery(option9)){	            
                    System.out.println(" total errors "); 
                    while (resultSet3.next()) { 
                        System.out.println(String.format("  %s  ", 
                            resultSet3.getInt(1)));                     
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 9" +e);
        		}	            
            break;
            
            case"10":            	
            	try {            		
            	String qc_name;
        		System.out.println("enter tested person name"); 
	        	input.nextLine(); 
	        	qc_name= input.nextLine(); // tested person	            	            	
	            final String option10 = "EXEC q10 @qc_name = '"+qc_name+"';";	            
	            try (final Statement statement10 = connection.createStatement(); 
	            		final ResultSet resultSet4 = statement10.executeQuery(option10)){
                    System.out.println(" total cost "); 
                    while (resultSet4.next()) { 
                        System.out.println(String.format("  %s  ", 
                            resultSet4.getFloat(1))); 
                    
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 10" +e);
        		}	            
            break;
            
            case"11":
            	
            	try {            		
            	String color;
        		System.out.println("enter color"); 
	        	input.nextLine(); 
	        	color= input.nextLine(); // tested person	            	            	
	            final String option11 = "EXEC q11 @color = '"+color+"';";
	            
	            try (final Statement statement11 = connection.createStatement(); 
	            		final ResultSet resultSet5 = statement11.executeQuery(option11)){
                    System.out.println(" Customer names "); 
                    while (resultSet5.next()) { 
                        System.out.println(String.format("  %s  ", 
                            resultSet5.getString(1)));                     
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 11" +e);
        		}	            
            break;
            
            case"12":            	
            	try {            		
            	Float salary;
        		System.out.println("enter salary"); 
	        	input.nextLine(); 
	        	salary= input.nextFloat(); // salary	            	            	
	            final String option12 = "EXEC q12 @salary = '"+salary+"';";	            
	            try (final Statement statement12 = connection.createStatement(); 
	            		final ResultSet resultSet6 = statement12.executeQuery(option12)){	             
                    System.out.println(" Employee name		| salary	| 	address "); 
                    while (resultSet6.next()) { 
                        System.out.println(String.format("    %s      |      %s      |      %s      ", 
                            resultSet6.getString(1),
                            resultSet6.getFloat(2),
                            resultSet6.getString(3)));                   
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 12" +e);
        		}
	            
            break;
            
            case"13":           	
            	try {            		    	            	
	            final String option13 = "EXEC q13;";	            
	            try (final Statement statement13 = connection.createStatement(); 
	            		final ResultSet resultSet7 = statement13.executeQuery(option13)){	            
                    System.out.println(" total days lost"); 
                    while (resultSet7.next()) { 
                        System.out.println(String.format("    %s      ", resultSet7.getInt(1)));
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 13" +e);
        		}	            
            break;
            
            case"14":
            	
            	try {
            		
            	int year;
        		System.out.println("enter year"); 
	        	input.nextLine(); 
	        	year= input.nextInt(); // year	            	            	
	            final String option14 = "EXEC q14 @year = '"+year+"';";
	            
	            try (final Statement statement14 = connection.createStatement(); 
	            		final ResultSet resultSet8 = statement14.executeQuery(option14)){	                            
                    System.out.println(" average cost"); 
                    while (resultSet8.next()) { 
                        System.out.println(String.format("    %s    ",  resultSet8.getFloat(1)));                    
                    }
                    }
	            }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 14" +e);
        		}
	            
            break;
            
            case"15":
            	
            	try {            		
            	String date1,date2;
        		System.out.println("enter date1"); 
	        	input.nextLine(); 
	        	date1= input.nextLine(); // date1
	        	
        		System.out.println("enter date2");  
	        	date2= input.nextLine(); //date2	            	            	
	            final String option15 = "EXEC q15 @date1='"+date1+"',@date2='"+date2+"';";
	            
	            final Statement statement15 = connection.createStatement(); 
	            		statement15.executeUpdate(option15);	             
                    System.out.println("deleted succesfully"); 
                    }
        		catch(Exception e ) {
        			System.out.println("you got an error,exception in option 15" +e);
        		}	            
            break;
            
            case "16":
            	try {
            		String path, eachline,emptype,empname,empaddress,tech_position,degree,type_of_product;
            		int empsalary,count_of_products;
            		System.out.println("enter the file name for import"); // read in the file name
            		path = input.next();
            		
            		File csv_file = new File(path);            		
            		Scanner input1= new Scanner(csv_file);            		
            		while(input1.hasNextLine()) {
            			eachline = input1.nextLine(); // read in the line
            			
            			String[] strings = eachline.split(",");
            			
            			emptype = strings[0];
            			empname = strings[1];
            			empaddress = strings[2];
            			empsalary = Integer.parseInt(strings[3]);
            			tech_position = strings[4];
            			degree = strings[5];
            			type_of_product = strings[6];
            			count_of_products = Integer.parseInt(strings[7]);
            			
                        final String option16 = "EXEC q1  @emptype  = '"+emptype+"' , @ename = '"+empname+"', "
                        		+ "@address = '"+empaddress +"',@salary = '"+empsalary +"',@tech_position = '"+tech_position+"',"
                        				+ " @degree = '"+degree+"', @type_of_product = '"+type_of_product+"' , @count_of_Products =  '"+count_of_products+"';";
            			
        	            final Statement statement16 = connection.createStatement(); 
	            		statement16.executeUpdate(option16);
	            		
	            		System.out.println("inserted successfully");
     
            	}
            	}   catch(Exception e ) {
        			System.out.println("you got an error,exception in option 16" +e);
        		}
            	break;
            	
            case"17":           	
            	try {            	
            		System.out.println("Enter the path with file name"); 
            		String path = input.next();
            		
            		System.out.println("Enter the color of product"); 
            		String color = input.next();
            		
            		FileWriter fw = new FileWriter(path);
            		
            		final String option17 ="EXEC q11 @color = '"+color+"';";
            		
    	            try (final Statement statement17 = connection.createStatement(); 
    	            		final ResultSet resultSet10 = statement17.executeQuery(option17)){
    	            	
        				
        				while(resultSet10.next()) {
        					fw.write(resultSet10.getString(1) + "\n");
        					System.out.println("Exported Successfully");
        				}
        				fw.close();
    	            	
    	            }catch(Exception e) {
                		System.out.println("you got an error,exception in option 17"+e);
            				
            	}
            		
            	}catch(Exception e) {
            		System.out.println("you got an error,exception in option 17"+e);
            	}
            
            break;
            
            
            case "18":
            	System.out.println("You choose to Quit! bye");
            
           }  

        }
    }


}
