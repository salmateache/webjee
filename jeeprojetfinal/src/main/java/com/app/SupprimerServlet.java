package com.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SupprimerServlet")
public class SupprimerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupprimerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     

    }
        

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     // Récupérer l'ID du poste à supprimer à partir des paramètres de la requête
        int postId = Integer.parseInt(request.getParameter("id"));
        
        // Connexion à la base de données et exécution de la requête de suppression
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet", "root", "");
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM poste WHERE id_poste = ?")) {
            
            // Définir le paramètre de l'ID du poste à supprimer
            stmt.setInt(1, postId);
            
            // Exécuter la requête de suppression
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // La suppression a réussi
                response.sendRedirect("liste_des_postes.jsp"); // Redirection vers la page de liste des postes
            } else {
                // La suppression a échoué
                response.getWriter().println("La suppression du poste a échoué.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur lors de la suppression du poste : " + e.getMessage());
        }
	}

}
