<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@page import="sena.adso.restaurante.db.DatabaseConn"%>
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %><%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    JSONObject jsonResponse = new JSONObject();
    Connection conn = null;
    try {
        String method = request.getMethod();
        jsonResponse.put("debug_method", method);
        if (!"POST".equals(method)) {
            throw new Exception("Método no permitido. Use POST");
        }
        String idParam = request.getParameter("id");
        String estado = request.getParameter("estado");
        jsonResponse.put("debug_id_received", idParam);
        jsonResponse.put("debug_estado_received", estado);
        if (idParam == null || idParam.trim().isEmpty()) {
            throw new Exception("El ID de la reserva es requerido");
        }
        if (estado == null || estado.trim().isEmpty()) {
            throw new Exception("El estado es requerido");
        }
        int id;
        try {
            id = Integer.parseInt(idParam);
            jsonResponse.put("debug_id_parsed", id);
        } catch (NumberFormatException e) {
            throw new Exception("ID inválido: " + idParam + ". Debe ser un número.");
        }
        try {
            conn = DatabaseConn.getConnection();
            jsonResponse.put("debug_connection", conn != null ? "success" : "failed");
            if (conn == null) {
                throw new Exception("No se pudo establecer la conexión a la base de datos");
            }
            PreparedStatement pstmt = conn.prepareStatement("UPDATE reservas SET estado = ? WHERE id = ?");
            pstmt.setString(1, estado);
            pstmt.setInt(2, id);
            int rowsAffected = pstmt.executeUpdate();
            jsonResponse.put("debug_rows_affected", rowsAffected);
            if (rowsAffected > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Estado de la reserva actualizado correctamente");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "No se encontró la reserva con ID: " + id);
            }
        } catch (SQLException e) {
            throw new Exception("Error de base de datos: " + e.getMessage() +
                              " (SQLState: " + e.getSQLState() +
                              ", ErrorCode: " + e.getErrorCode() + ")");
        }
    } catch (Exception e) {
        response.setStatus(500);
        jsonResponse.put("success", false);
        jsonResponse.put("message", e.getMessage());
        jsonResponse.put("error_type", e.getClass().getName());
        application.log("Error en estadoReserva.jsp: " + e.getMessage(), e);
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                application.log("Error al cerrar la conexión: " + e.getMessage(), e);
            }
        }
        out.print(jsonResponse.toString());
    }
%> 