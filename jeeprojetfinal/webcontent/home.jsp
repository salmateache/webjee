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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
      <style>
         .illustration {
            float: right;
            margin-left: 20px;
            margin-bottom: 20px;
        }
        .illustration img {
    max-width: 500px; /* Définit une largeur maximale de 100 pixels pour les images */
}
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f8ff; 
            color: #333; 
            flex-direction: column;
            min-height: 100vh; 
           
        }
        .dashboard {
            background-color: #007bff; 
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
            border-collapse: collapse;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
             overflow-y: scroll;
        
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
</head>
<body>

  
<div class="dashboard">
   
 
  <button><a href="index.html"style="color: white;">logout</a></button>
   <button><a href="ajouter.html"style="color: white;">Ajouter un Poste </a></button>

</div>
    
    
   <div class="illustration">
            <img src="https://img.freepik.com/vecteurs-libre/illustration-publication-blog-plat-organique-personnes_23-2148955260.jpg?t=st=1715818010~exp=1715821610~hmac=49556c245efa01e35ca3405e621c039784f7a7012f23f14ea788cbccfed00368&w=900" alt="Ajouter un post">
        </div>
        
        <h2>Fonctionnalités :</h2> 

    
<div class="cards">
    <div class="card">
   
        <i class="fas fa-plus-circle"></i>
        <div class="card-description">
                <h2>Modifier un post existant</h2>
                <p>Cliquez sur le bouton "ajouter un poste " pour ajouter  les informations d'un post.</p>
            </div>
       
    </div>
    <div class="card">
        <i class="fas fa-trash-alt"></i>
         <div class="card-description">
                <h2>Supprimer un post</h2>
                <p>Utilisez le bouton "Supprimer" pour supprimer un post de la base de données.</p>
            </div>
      
    </div>
    <div class="card">
        <i class="fas fa-edit"></i>
      <div class="card-description">
                <h2>Modifier un post existant</h2>
                <p>Cliquez sur le bouton "Modifier" pour mettre à jour les informations d'un post.</p>
            </div>
    </div>
    <div class="card">
        <i class="fas fa-ban"></i>
       <div class="card-description">
                <h2>Consignes</h2>
                <p>Veuillez remplir tous les champs obligatoires dans le formulaire d'ajout de post. Assurez-vous de fournir une date valide et une image.</p>
           
            </div>
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
  <table border="1" style="width: 1000px;">
    <thead>
        <tr>
            <th>ID</th>
            <th>Texte</th>
            <th>Date</th>
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
           <td>
<a href="<%= "file:///C:/Users/hp/Downloads/" + res.getString(5) %>">
    <%=res.getString(5) %>
</a>
</td>
            <td>
          
 <form action="SupprimerServlet" method ="post">
              <input type="hidden" name="postId" value="<%=res.getInt(1)%>">
<button type="submit" style="background-color: #007bff; color: white;">
    <i class="fas fa-trash-alt"></i>
</button> 
</form>    
 <button type="submit" style="background-color: #007bff; color: white;"><a href="modifier.jsp?id=<%=res.getInt(1)%>"style="background-color: #007bff; color: white;"> <i class="fas fa-edit"> </i></a>
</form> 
</button> 

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

 
</body>
</html>