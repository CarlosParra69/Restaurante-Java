<%@page import="sena.adso.restaurante.db.DatabaseConn"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    Connection conn = null;
    JSONObject jsonResponse = new JSONObject();
    try {
        String nombre_cliente = request.getParameter("nombre_cliente");
        String telefono = request.getParameter("telefono");
        String correo_electronico = request.getParameter("correo_electronico");
        String fecha_hora = request.getParameter("fecha_hora");
        String num_comensales = request.getParameter("num_comensales");
        String mesa_asignada = request.getParameter("mesa_asignada");
        String comentarios_especiales = request.getParameter("comentarios_especiales");

        // Validaciones básicas
        if (nombre_cliente == null || nombre_cliente.trim().isEmpty()) {
            throw new Exception("El nombre del cliente es requerido");
        }
        if (telefono == null || telefono.trim().isEmpty()) {
            throw new Exception("El teléfono es requerido");
        }
        if (fecha_hora == null || fecha_hora.trim().isEmpty()) {
            throw new Exception("La fecha y hora de la reserva es requerida");
        }
        if (num_comensales == null || num_comensales.trim().isEmpty()) {
            throw new Exception("El número de comensales es requerido");
        }

        conn = sena.adso.restaurante.db.DatabaseConn.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO reservas (nombre_cliente, telefono, correo_electronico, fecha_hora, num_comensales, mesa_asignada, comentarios_especiales) VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        pstmt.setString(1, nombre_cliente);
        pstmt.setString(2, telefono);
        pstmt.setString(3, correo_electronico);
        pstmt.setString(4, fecha_hora.replace('T', ' ')); // formato datetime
        pstmt.setInt(5, Integer.parseInt(num_comensales));
        if (mesa_asignada != null && !mesa_asignada.trim().isEmpty()) {
            pstmt.setInt(6, Integer.parseInt(mesa_asignada));
        } else {
            pstmt.setNull(6, java.sql.Types.INTEGER);
        }
        pstmt.setString(7, comentarios_especiales);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Reserva guardada exitosamente");
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "No se pudo guardar la reserva");
        }
    } catch(Exception e) {
        jsonResponse.put("success", false);
        jsonResponse.put("message", e.getMessage());
        application.log("Error en guardarReserva.jsp: " + e.getMessage(), e);
    } finally {
        if(conn != null) {
            try { conn.close(); } catch (SQLException e) { application.log("Error al cerrar la conexión: " + e.getMessage(), e); }
        }
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(jsonResponse.toString());
%>
