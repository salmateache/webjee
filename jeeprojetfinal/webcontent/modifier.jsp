<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
    <title>FSA_BLOG</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            background-color: #f0f8ff; /* Bleu clair */
            color: #333; /* Couleur de texte sombre */
            font-family: Arial, sans-serif; /* Police de caractères par défaut */
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #007bff; /* Bleu primaire */
            color: #fff; /* Texte en blanc */
            padding: 20px;
            text-align: center;
        }

        nav {
            background-color: #0056b3; /* Bleu foncé */
            color: #fff;
            padding: 10px;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        nav ul li {
            display: inline;
            margin-right: 20px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
        }

        section {
            padding: 20px;
            text-align: center; /* Centrage du contenu */
        }

        form {
            display: inline-block; /* Pour centrer le formulaire */
            width: 300px;
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
        }

        input[type="email"], input[type="password"] {
            width: calc(100% - 40px); /* Largeur moins le padding */
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: calc(100% - 40px); /* Largeur moins le padding */
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>FSA_BLOG !</h1>
    </header>
    
    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
         <button onclick="window.print()" "style="background-color: #007bff; color: white;">Imprimer la page</button>
        </ul>
    </nav>
    
    <section>
        <%
    // Récupérer l'ID du poste depuis le paramètre de requête
    String postIdString = request.getParameter("id");
    if (postIdString != null && !postIdString.isEmpty()) {
        int postId = Integer.parseInt(postIdString);
        
     
        InitialContext ctx = new InitialContext();
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/jeeprojet","root","");
        
        // Requête pour récupérer les informations du poste avec l'ID donné
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM poste WHERE id_poste = ?");
        stmt.setInt(1, postId);
        ResultSet rs = stmt.executeQuery();
        
        // Vérifier si le poste existe
        if (rs.next()) {
            // Récupérer les informations du poste
            String texte = rs.getString("texte");
            Date date = rs.getDate("date");
            int utilisateurId = rs.getInt("id_utilisateur");
            String cheminImage = rs.getString("chemin_image");
            
            // Afficher un formulaire avec les informations du poste
%>
            <h1>Modifier Poste</h1>
            <form action="ModifierServlet" method="post">
                <input type="hidden" name="postId" value="<%= postId %>">
                <label for="texte">Texte :</label><br>
                <textarea id="texte" name="texte" rows="4" cols="50"><%= texte %></textarea><br>
                
                <label for="date">Date :</label><br>
                <input type="date" id="date" name="date" value="<%= date %>"><br>
    
                <label for="image">Chemin d'image :</label><br>
                <input type="file"  name="chemin_image" value="<%= cheminImage %>"><br>
                
                <!-- Ajoute d'autres champs selon tes besoins -->
                
                <button type="submit">Enregistrer</button>
            </form>
<%
        } else {
            // Le poste avec l'ID donné n'existe pas
            out.println("Le poste avec l'ID " + postId + " n'existe pas.");
        }
        
        // Fermer les ressources
        rs.close();
        stmt.close();
        conn.close();
    } else {
        // Le paramètre d'ID est manquant
        out.println("L'ID du poste est manquant.");
    }
%>
    </section>

</body>
</html>
