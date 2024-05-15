<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Liste des postes </title>
</head>
<body>
  
<div class="dashboard">
    <button id="profile">Profil</button>
    <button id="logout">Log out</button>
</div>
    
    <h1>Liste des postes</h1>
    
<div class="cards">
    <div class="card">
        <i class="fas fa-plus-circle"></i>
        <a href="ajouter.html"> <p>ajouter</p></a>
       
    </div>
    <div class="card">
        <i class="fas fa-trash-alt"></i>
       <a href="suprimer.html"> <p>Supprimer</p></a>
    </div>
    <div class="card">
        <i class="fas fa-edit"></i>
      <a href="modifier.html"> <p>Modifer</p></a>
    </div>
    <div class="card">
        <i class="fas fa-ban"></i>
       <a href="ajouter.html"> <p>Vider</p></a>
    </div>
</div>
    
    <% 
    try {
		 Class.forName("com.mysql.jdbc.Driver");
   Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet", "root", "");
          String sql ="SELECT * FROM poste";
            PreparedStatement stmt = con.prepareStatement(sql);
            
            ResultSet res = stmt.executeQuery();
    %>
  <table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Texte</th>
            <th>Date</th>
            <th>ID Utilisateur</th>
            <th>Chemin d'image</th>
            <th>Actions</th> <!-- Nouvelle colonne pour les boutons d'action -->
        </tr>
    </thead> 
    <tbody>
        <% 
            while(res.next()) {
        %>
        <tr>
            <td><%=res.getInt(1)%></td>
            <td><%=res.getString(2) %></td>
            <td><%=res.getDate(3) %></td>
            <td><%=res.getInt(4) %></td>
            <td><%=res.getString(5) %></td>
            <!-- Nouvelle colonne pour les boutons d'action -->
            <td>
                <!-- Bouton de suppression -->
                <form action="SupprimerServlet" method="post">
            <!-- Champ caché pour l'ID du poste -->
            <input type="hidden" name="id" value="<%=res.getInt(1)%>">
            <!-- Bouton de suppression -->
            <button type="submit" style="background-color: #007bff; color: white;">Supprimer</button>
        </form>
                <!-- Bouton de modification -->
                <form action="ModifierServlet" method="post">
                    <input type="hidden" name="id" value="<%=res.getInt(1)%>">
                    <button type="submit" style="background-color: white; color: white;"><a href="modifier.html">modifier</a></button>
                </form>
            </td>
        </tr>
        <% 
            }
            res.close();
            con.close();
        %>
    </tbody>
</table>
    <% 
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    %>

   <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f8ff; /* Couleur de fond bleu clair */
            color: #333; /* Couleur de texte sombre */
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Hauteur minimum de la fenêtre visible */
        }
        .dashboard {
            background-color: #007bff; /* Bleu primaire */
            color: #fff;
            padding: 10px;
            text-align: right;
        }
        .dashboard button {
            background-color: #0056b3; /* Bleu foncé */
            color: #fff;
            border: none;
            padding: 5px 10px;
            margin-left: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
        }
        .card {
            width: 200px;
            background-color: #fff;
            margin: 10px;
            border-radius: 5px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.1); /* Ombre légère */
        }
        .card i {
            font-size: 48px;
            color: #007bff; /* Bleu primaire */
        }
        .card p {
            margin-top: 10px;
        }
        table {
            flex-grow: 1; /* Fait en sorte que le tableau prenne tout l'espace disponible */
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</body>
</html>