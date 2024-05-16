package com.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ModifierServlet
 */
@WebServlet("/ModifierServlet")
public class ModifierServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  response.setContentType("text/html");
	        PrintWriter out = response.getWriter();
	        
	        // Récupération des données du formulaire
	        int postId = Integer.parseInt(request.getParameter("postId"));
	        String texte = request.getParameter("texte");
	        String dateStr = request.getParameter("date");
	        String chemin_image = request.getParameter("chemin_image");
	        
	      
	            // Connexion à la base de données
	         
	            try  {
	            	   Class.forName("com.mysql.jdbc.Driver");
	           
	            	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet","root","");

	                String sql = "UPDATE poste SET texte = ?, date = ?, chemin_image = ? WHERE id_poste = ?";
	                try (PreparedStatement statement = conn.prepareStatement(sql)) {
	                    statement.setString(1, texte);
	                    if (dateStr != null && !dateStr.isEmpty()) {
	                        Date date = Date.valueOf(dateStr);
	                        statement.setDate(2, date);
	                    } else {
	                        statement.setNull(2, java.sql.Types.DATE); // Spécifie que c'est une valeur NULL pour la colonne date
	                    }
	                    statement.setString(3, chemin_image);
	                    statement.setInt(4, postId);
	                    
	                    // Exécution de la requête
	                    int rowsUpdated = statement.executeUpdate();
	                    
	                    if (rowsUpdated > 0) {
	                        out.println("<h2>Modification réussie !</h2>");
	                        response.sendRedirect("home.jsp");
	                    } else {
	                        out.println("<h2>Le poste avec l'ID " + postId + " n'existe pas.</h2>");
	                        response.sendRedirect("home.jsp");
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
