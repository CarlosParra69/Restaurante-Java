<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sena.adso.restaurante.db.DatabaseConn" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%
    String buscar = request.getParameter("buscar");
    String campo = request.getParameter("campo");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Reservas - Restaurante BBQ</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #fbeee6 0%, #fbb347 100%);
                min-height: 100vh;
                font-family: 'Roboto', Arial, sans-serif;
            }
            .navbar {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }
            .navbar-brand {
                font-family: 'Roboto', cursive;
                font-size: 2rem;
                color: #fff !important;
                letter-spacing: 1px;
            }
            .main-title {
                color: #b22222;
                font-family: 'Roboto', cursive;
                font-size: 2.2rem;
                text-align: center;
                margin-top: 2rem;
                margin-bottom: 2rem;
                text-shadow: 1px 2px 8px #ffe5b4;
                letter-spacing: 2px;
            }
            .table-responsive {
                background: #fff;
                border-radius: 1rem;
                box-shadow: 0 4px 24px rgba(255, 179, 71, 0.15);
                padding: 2rem 1rem;
            }
            th {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                color: #fff;
                font-family: 'Roboto', cursive;
            }
            .btn-accion {
                border-radius: 2rem;
                font-weight: 600;
                padding: 0.3rem 1rem;
                color: #fff;
                border: none;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .btn-estado {
                background-color: #17a2b8;
            }
            .btn-editar, .btn-eliminar {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
            }
            .badge {
                border-radius: 1rem;
                font-weight: 600;
                box-shadow: none !important;
                background-image: none !important;
            }
            /* Estilos para los contadores de estado sin brillo - versión mejorada */
            #contadorConfirmadas {
                background: #198754 !important;
                background-image: none !important;
                filter: none !important;
                border: none !important;
                text-shadow: none !important;
            }
            #contadorPendientes {
                background: #ffc107 !important;
                background-image: none !important;
                filter: none !important;
                border: none !important;
                text-shadow: none !important;
            }
            #contadorCanceladas {
                background: #dc3545 !important;
                background-image: none !important;
                filter: none !important;
                border: none !important;
                text-shadow: none !important;
            }
            #contadorCompletadas {
                background: #0d6efd !important;
                background-image: none !important;
                filter: none !important;
                border: none !important;
                text-shadow: none !important;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg mb-4">
            <div class="container">
                <a class="navbar-brand" href="../index.jsp">
                    <i class="fa-solid fa-fire"></i> Restaurante BBQ
                </a>
            </div>
        </nav>
        <div class="container">
            <div class="main-title d-flex justify-content-between align-items-center">
                <span><i class="fa-solid fa-gear"></i> Gestion de Reservas</span>
                <div class="info-section mb-4" style="background: #fffbe6; border-radius: 1rem; box-shadow: 0 2px 12px rgba(255, 179, 71, 0.10); padding: 0rem 1rem 0.5rem 1rem;" style="margin-left:auto;">
                    <div id="contadorConfirmadas" class="badge text-light fs-6" style="background: #198754 !important; background-image: none !important; filter: none !important;">Confirmadas: <span id="numConfirmadas">0</span></div>
                    <div id="contadorPendientes" class="badge text-light fs-6" style="background: #ffc107 !important; background-image: none !important; filter: none !important;">Pendientes: <span id="numPendientes">1</span></div>
                    <div id="contadorCanceladas" class="badge text-light fs-6" style="background: #dc3545 !important; background-image: none !important; filter: none !important;">Canceladas: <span id="numCanceladas">0</span></div>
                    <div id="contadorCompletadas" class="badge text-light fs-6" style="background: #0d6efd !important; background-image: none !important; filter: none !important;">Completadas: <span id="numCompletadas">0</span></div>
                </div>
            </div>
            <div class="search-section mb-4" style="background: #fffbe6; border-radius: 1rem; box-shadow: 0 2px 12px rgba(255, 179, 71, 0.10); padding: 1.5rem 2rem 1rem 2rem;">
                <div class="row mb-3 align-items-center justify-content-between">
                    <div class="col-md-9">
                        <form id="formBuscador" action="list.jsp" method="GET" class="row g-3">
                            <div class="col-md-5">
                                <input type="text" name="buscar" class="form-control" 
                                       placeholder="Buscar..." 
                                       value="<%= buscar != null ? buscar : ""%>" 
                                       style="border-radius: 2rem; border: 1px solid orange;">
                            </div>
                            <div class="col-md-3" >
                                <select name="campo" class="form-control" style="border-radius: 2rem; border: 2px solid #b4d4ff;">                                
                                    <option value="todos" <%= campo == null || campo.equals("todos") ? "selected" : ""%>>Todos los campos</option>
                                    <option value="cliente" <%= "cliente".equals(campo) ? "selected" : ""%>>Cliente</option>
                                    <option value="telefono" <%= "telefono".equals(campo) ? "selected" : ""%>>Teléfono</option>
                                    <option value="correo" <%= "correo".equals(campo) ? "selected" : ""%>>Correo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn w-80"
                                        style="background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                                        color: #fff; border: none; border-radius: 2rem; font-weight: 600;
                                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); padding: 0.5rem 1.5rem;">
                                    <i class="fa fa-search me-1"></i> Buscar
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3 text-end">
                        <a href="add.jsp" class="btn w-80"
                           style="background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                           color: #fff; font-weight: 600; border-radius: 2rem;
                           box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); padding: 0.5rem 1.5rem;">
                            <i class="bi bi-plus-circle me-1"></i> Agregar Producto
                        </a>
                    </div>
                </div>
            </div>
            <div class="table-responsive mb-5 mt-10 px-4" style="max-width: 100%; margin: 0 auto;">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="fw-bold" style="color: #b22222;"><i class="fa-solid fa-list"></i> Lista de Reservas</h5>
                </div>
                <table class="table table-hover align-middle text-center w-100" id="tablaReservas" style="min-width: 1200px;">
                    <thead>
                        <tr style="border-radius: 2rem">
                            <th><i class="fa-solid fa-hashtag"></i> ID</th>
                            <th><i class="fa-solid fa-user"></i> Cliente</th>
                            <th><i class="fa-solid fa-phone"></i> Teléfono</th>
                            <th><i class="fa-solid fa-envelope"></i> Correo</th>
                            <th><i class="fa-solid fa-calendar-day"></i> Fecha y Hora</th>
                            <th><i class="fa-solid fa-users"></i> Comensales</th>
                            <th><i class="fa-solid fa-chair"></i> Mesa</th>
                            <th><i class="fa-solid fa-circle-info"></i> Estado</th>
                            <th><i class="fa-solid fa-comment"></i> Comentarios</th>
                            <th><i class="fa-solid fa-clock"></i> Creación</th>
                            <th><i class="fa-solid fa-gear"></i> Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- JS insertará filas aquí -->
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="../js/reservas.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                let contador = 0;
                document.querySelectorAll('#tablaReservas tbody tr').forEach(function (fila) {
                    const estado = fila.querySelector('.badge, .btn, .estado, .label, .badge-warning');
                    if (estado && estado.textContent.includes('Pendiente')) {
                        contador++;
                    }
                });
                document.getElementById('numPendientes').textContent = contador;
            });
        </script>
    </body>
</html>