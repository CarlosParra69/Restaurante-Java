<%@page import="sena.adso.restaurante.db.DatabaseConn"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    Connection conn = null;
    JSONObject jsonResponse = new JSONObject();
    try {
        String id = request.getParameter("id");
        String nombre_cliente = request.getParameter("nombre_cliente");
        String telefono = request.getParameter("telefono");
        String correo_electronico = request.getParameter("correo_electronico");
        String fecha_hora = request.getParameter("fecha_hora");
        String num_comensales = request.getParameter("num_comensales");
        String mesa_asignada = request.getParameter("mesa_asignada");
        String comentarios_especiales = request.getParameter("comentarios_especiales");
        // Validar que el ID no sea nulo
        if (id == null || id.trim().isEmpty()) {
            throw new Exception("El ID de la reserva es requerido");
        }
        conn = DatabaseConn.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(
            "UPDATE reservas SET nombre_cliente=?, telefono=?, correo_electronico=?, fecha_hora=?, num_comensales=?, mesa_asignada=?, comentarios_especiales=? WHERE id=?"
        );
        pstmt.setString(1, nombre_cliente);
        pstmt.setString(2, telefono);
        pstmt.setString(3, correo_electronico);
        pstmt.setString(4, fecha_hora);
        pstmt.setString(5, num_comensales);
        pstmt.setString(6, mesa_asignada);
        pstmt.setString(7, comentarios_especiales);
        pstmt.setInt(8, Integer.parseInt(id));
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Reserva actualizada exitosamente");
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "No se encontró la reserva con ID: " + id);
        }
    } catch(Exception e) {
        jsonResponse.put("success", false);
        jsonResponse.put("message", e.getMessage());
        application.log("Error en actualizarReserva.jsp: " + e.getMessage(), e);
    } finally {
        if(conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                application.log("Error al cerrar la conexión: " + e.getMessage(), e);
            }
        }
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(jsonResponse.toString());
%>
