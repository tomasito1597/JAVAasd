<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Usuarios</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 80%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .error { color: red; font-weight: bold; }
        .success { color: green; font-weight: bold; }
        .center-button { text-align: center; margin-top: 20px; }
    </style>
</head>
<body>

    <h1>Tabla de Usuarios (Prueba de Conexión Web)</h1>
    
    <%
        // 1. Configuración de la Conexión a la Base de Datos
        // ---------------------------------------------------------------------------------
        
        final String DB_HOST = "mysql-11553b42-tomasito159.l.aivencloud.com";
        final String DB_PORT = "23634";
        final String DB_NAME = "defaultdb";
        final String DB_USER = "avnadmin";
        final String DB_PASS = "AVNS_ItKZ96PF8zRX-rKsp6c"; // 🔴 CONTRASEÑA COMPLETA
        
        // Parámetros: useSSL=true y requireSSL=true (para Aiven) y verifyServerCertificate=false (para prueba)
        final String DB_OPTIONS = "?allowPublicKeyRetrieval=true&useSSL=true&requireSSL=true&verifyServerCertificate=false";
        final String DB_URL = "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME + DB_OPTIONS;
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
    %>

    <%
        try {
            // Cargar el driver moderno (cj).
            try {
    			Class.forName("com.mysql.jdbc.Driver");
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
            
            // 2. Abrir la Conexión
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            out.println("<p class='success'>✅ Conexión a la base de datos exitosa.</p>");
            
            // 3. Ejecutar la Consulta
            String sql = "SELECT * FROM Usuarios"; // La consulta solicitada
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            // 4. Mostrar los resultados en una tabla HTML
            out.println("<h2>Registros encontrados:</h2>");
            out.println("<table>");
            
            // Obtener metadatos para generar los encabezados de columna dinámicamente
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            
            // Imprimir encabezados de columna
            out.println("<tr>");
            for (int i = 1; i <= columnCount; i++) {
                out.println("<th>" + rsmd.getColumnName(i) + "</th>");
            }
            out.println("</tr>");
            
            // Imprimir los datos de las filas
            while (rs.next()) {
                out.println("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                    out.println("<td>" + rs.getString(i) + "</td>");
                }
                out.println("</tr>");
            }
            
            out.println("</table>");

        } catch (Exception e) {
            // 5. Manejo de Errores (muesta el error específico en la web)
            out.println("<p class='error'>❌ Error al conectar o consultar la base de datos:</p>");
            out.println("<p class='error'>Mensaje: " + e.getMessage() + "</p>");
            // Imprime el stack trace en el log del servidor para depuración
            // e.printStackTrace(); 
        } finally {
            // 6. Cerrar recursos de JDBC
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    %>
    
    <div class="center-button">
        <button onclick="window.location.reload();">Recargar y Ver Usuarios</button>
    </div>
    
</body>
</html>