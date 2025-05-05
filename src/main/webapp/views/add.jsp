<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nueva Reserva - Restaurante BBQ</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts -->
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
            .btn-reserva {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                color: #fff;
                border: none;
                border-radius: 2rem;
                font-weight: 600;
                font-size: 1.1rem;
                padding: 0.6rem 2rem;
                box-shadow: 0 4px 24px rgba(178,34,34, 0.15);
                transition: background 0.3s, color 0.3s;
            }
            .btn-reserva:hover {
                background: linear-gradient(90deg, #ff7043 0%, #b22222 100%);
                color: #fff;
            }
            .card {
                border-radius: 1rem;
                box-shadow: 0 4px 24px rgba(255, 179, 71, 0.15);
            }
            label {
                font-weight: 600;
                color: #b22222;
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
            <div class="main-title">
                <i class="fa-solid fa-calendar-plus"></i> Nueva Reserva
            </div>
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">
                    <div class="card p-4">
                        <form id="reservaForm" action="guardarReserva.jsp" method="post" autocomplete="off">
                            <div class="mb-3">
                                <label for="nombre_cliente" class="form-label">Nombre del cliente</label>
                                <input type="text" class="form-control" id="nombre_cliente" name="nombre_cliente" maxlength="100" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" maxlength="20" required>
                            </div>
                            <div class="mb-3">
                                <label for="correo_electronico" class="form-label">Correo electrónico</label>
                                <input type="email" class="form-control" id="correo_electronico" name="correo_electronico" maxlength="100">
                            </div>
                            <div class="mb-3">
                                <label for="fecha_hora" class="form-label">Fecha y hora de la reserva</label>
                                <input type="datetime-local" class="form-control" id="fecha_hora" name="fecha_hora" required>
                            </div>
                            <div class="mb-3">
                                <label for="num_comensales" class="form-label">Número de comensales</label>
                                <input type="number" class="form-control" id="num_comensales" name="num_comensales" min="1" required>
                            </div>
                            <div class="mb-3">
                                <label for="mesa_asignada" class="form-label">Mesa asignada</label>
                                <input type="number" class="form-control" id="mesa_asignada" name="mesa_asignada" min="1">
                            </div>
                            <div class="mb-3">
                                <label for="comentarios_especiales" class="form-label">Comentarios especiales</label>
                                <textarea class="form-control" id="comentarios_especiales" name="comentarios_especiales" rows="2" maxlength="500"></textarea>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="../index.jsp" class="btn btn-secondary">Cancelar</a>
                                <button type="submit" class="btn btn-reserva">Guardar reserva</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- FontAwesome para iconos -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="../js/reservas.js"></script>
    </body>
</html>
