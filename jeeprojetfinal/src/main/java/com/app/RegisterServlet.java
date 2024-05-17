package com.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  response.setContentType("text/html");
	        PrintWriter out = response.getWriter();
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String cin = request.getParameter("cin");
	        String telephone = request.getParameter("telephone");
	     
	        try  {
	        	
	        	Class.forName("com.mysql.jdbc.Driver");
	        	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet","root","");
	            String sql = "INSERT INTO utilisateurS VALUES (null ,?, ?, ? ,?)";
	            try (PreparedStatement statement = conn.prepareStatement(sql)) {
	                statement.setString(1, cin);
	                statement.setString(2, telephone);
	                statement.setString(3, email);
	                statement.setString(4, password);
	                int rowsAffected = statement.executeUpdate();
	            	
	                if (rowsAffected > 0) {
	                	response.sendRedirect("home.jsp");
	                } else {
	                    out.print("Échec de l'insertion !");
	                }
	                
	            }
	        } catch (SQLException e) {
	         
	            out.print("Erreur  : " + e.getMessage());
	            e.printStackTrace(); 
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

}
