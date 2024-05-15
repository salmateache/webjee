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
@WebServlet("/AjouterServlet")
public class AjouterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    private String dbURL = "jdbc:mysql://localhost:3307/jeeprojet";
    private String dbUsername = "root";
    private String dbPassword = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Récupération des données du formulaire
        String texte = request.getParameter("texte");
        String dateStr = request.getParameter("date");
        String chemin_image = request.getParameter("chemin_image");
        
        try {
            // Connexion à la base de données
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword)) {
              
                String sql = "INSERT INTO poste VALUES (null, ?, ?, null, ?)";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
             
                  
          
                    statement.setString(1, texte);
                    if (dateStr != null && !dateStr.isEmpty()) {
                    Date date = Date.valueOf(dateStr);
                    statement.setDate(2, date);}
                    else {
                    	 statement.setDate(2, null);
                    }
                    statement.setString(3, chemin_image);
                    
                    // Exécution de la requête SQL
                    int rowsInserted = statement.executeUpdate();
                    
                    // Vérification si l'ajout a réussi
                    if (rowsInserted > 0) {
                        out.println("<h2>Ajout réussi !</h2>");
                    } else {
                        out.println("<h2>Erreur lors de l'ajout du poste.</h2>");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Gestion des exceptions
            out.println("<h2>Erreur lors de la connexion à la base de données : " + e.getMessage() + "</h2>");
            e.printStackTrace(out);
        }
    }
}
