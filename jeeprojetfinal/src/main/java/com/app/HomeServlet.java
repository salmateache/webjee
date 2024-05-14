package com.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet", "root", "")) {
                String sql = "SELECT * FROM poste";
                try (PreparedStatement statement = conn.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {
                    out.println("<table>");
                    out.println("<tr><th>ID</th><th>Texte</th><th>Date</th><th>ID</th<th>Chemin Image</th></tr>");
                    while (resultSet.next()) {
                        int id_poste = resultSet.getInt("id_poste");
                        String texte = resultSet.getString("texte");
                        Date date = resultSet.getDate("date");
                        int id_utilisateur =resultSet.getInt("id_utilisateur");
                        String chemin_image = resultSet.getString("chemin_image");

                        out.println("<tr>");
                        out.println("<td>" + id_poste + "</td>");
                        out.println("<td>" + texte + "</td>");
                        out.println("<td>" + date + "</td>");
                        out.println("<td>" + id_utilisateur + "</td>");
                        out.println("<td>" + chemin_image + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Erreur : " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
