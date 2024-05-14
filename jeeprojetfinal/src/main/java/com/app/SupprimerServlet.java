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
     

        String sql = "SELECT * FROM poste";
        StringBuilder jsonArray = new StringBuilder();
        jsonArray.append("[");
        
        try {
        		 Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet", "root", "");
        
            PreparedStatement stmt = conn.prepareStatement(sql);
         
            ResultSet rs = stmt.executeQuery();
       
            // Parcours des résultats de la requête
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    jsonArray.append(",");
                }
                // Construction de chaque poste au format JSON
                jsonArray.append("{");
                jsonArray.append("\"id_poste\":").append(rs.getInt("id_poste")).append(",");
                jsonArray.append("\"texte\":\"").append(rs.getString("texte")).append("\",");
                jsonArray.append("\"date\":\"").append(rs.getDate("date")).append("\"");
                jsonArray.append("\"id_utilisateur\":\"").append(rs.getInt("id_utilisateur")).append("\"");
                jsonArray.append("\"chemin_image\":\"").append(rs.getString("chemin_image")).append("\",");
                jsonArray.append("}");
                first = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        jsonArray.append("]");

        // Écriture de la réponse JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();
    }
        

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
