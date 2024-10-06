<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Date, java.text.SimpleDateFormat" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
           String titulo; 
           java.sql.Date data; 
           String hora_inicio;
           String hora_termino;
           String local;  
           String descricao;  
           String participantes;  
           String categoria; 
           String prioridade;  
           String status;
           
           titulo = request.getParameter("Titulo");
           local = request.getParameter("local");
           descricao = request.getParameter("descricao");
           participantes = request.getParameter("participantes");
           categoria = request.getParameter("categoria");
           prioridade = request.getParameter("prioridade");
           status = request.getParameter("status");

           String dataParam = request.getParameter("data");
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
           java.util.Date utilDate = sdf.parse(dataParam);
           data = new java.sql.Date(utilDate.getTime()); 

           
           hora_inicio = request.getParameter("hora_inicio");
           hora_termino = request.getParameter("hora_termino");

           if (hora_inicio == null || hora_inicio.isEmpty()) {
               out.println("Erro: O campo de horário de início é obrigatório.");
               return;
           }

           if (hora_termino == null || hora_termino.isEmpty()) {
               out.println("Erro: O campo de horário de término é obrigatório.");
               return; 
           }

           Connection co = null;
           PreparedStatement sta = null;

               Class.forName("com.mysql.cj.jdbc.Driver");
               co = DriverManager.getConnection("jdbc:mysql://localhost:3306/Prova_Compromissos", "root", "Mysql123");
               
               sta = co.prepareStatement("INSERT INTO compromissos (titulo, data, hora_inicio, hora_termino, local, descricao, participantes, categoria, prioridade, status) VALUES (?,?,?,?,?,?,?,?,?,?)");
               sta.setString(1, titulo);
               sta.setDate(2, data);
               sta.setString(3, hora_inicio); 
               sta.setString(4, hora_termino); 
               sta.setString(5, local);
               sta.setString(6, descricao);
               sta.setString(7, participantes);
               sta.setString(8, categoria);
               sta.setString(9, prioridade);
               sta.setString(10, status);
               
               sta.executeUpdate();
               out.print("Compromisso cadastrado com sucesso");
       %>
    </body>
</html>

