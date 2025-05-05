<%@page import="sena.adso.restaurante.db.DatabaseConn"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page contentType="application/json" %>
<%
    String buscar = request.getParameter("buscar");
    String campo = request.getParameter("campo");
    Connection conn = null;
    JSONArray jsonArray = new JSONArray();
    try {
        conn = DatabaseConn.getConnection();
        String sql = "SELECT id, nombre_cliente, telefono, correo_electronico, fecha_hora, num_comensales, mesa_asignada, estado, comentarios_especiales, fecha_creacion FROM reservas";
        boolean hayFiltro = (buscar != null && !buscar.trim().isEmpty());
        PreparedStatement stmt;
        if (hayFiltro) {
            buscar = "%" + buscar + "%";
            if ("cliente".equals(campo)) {
                sql += " WHERE nombre_cliente LIKE ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, buscar);
            } else if ("telefono".equals(campo)) {
                sql += " WHERE telefono LIKE ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, buscar);
            } else if ("correo".equals(campo)) {
                sql += " WHERE correo_electronico LIKE ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, buscar);
            } else {
                sql += " WHERE nombre_cliente LIKE ? OR telefono LIKE ? OR correo_electronico LIKE ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, buscar);
                stmt.setString(2, buscar);
                stmt.setString(3, buscar);
            }
        } else {
            stmt = conn.prepareStatement(sql);
        }
        ResultSet rs = stmt.executeQuery();
        while(rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("id", rs.getString("id"));
            obj.put("nombre_cliente", rs.getString("nombre_cliente"));
            obj.put("telefono", rs.getString("telefono"));
            obj.put("correo_electronico", rs.getString("correo_electronico"));
            obj.put("fecha_hora", rs.getString("fecha_hora"));
            obj.put("num_comensales", rs.getString("num_comensales"));
            obj.put("mesa_asignada", rs.getString("mesa_asignada"));
            obj.put("estado", rs.getString("estado"));
            obj.put("comentarios_especiales", rs.getString("comentarios_especiales"));
            obj.put("fecha_creacion", rs.getString("fecha_creacion"));
            jsonArray.put(obj);
        }
        out.print(jsonArray.toString());
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
