<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Restaurante BBQ - Gestión de Reservas</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', Arial, sans-serif;
                min-height: 100vh;
                background-color: #fbeee6;
                position: relative;
            }
            
            /* Imagen de fondo */
            body::before {
                content: "";
                background-image: url('./img/restaurant.png');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                opacity: 0.15;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
            }
            
            .navbar {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            }
            
            .navbar-brand {
                font-family: 'Roboto', cursive;
                font-size: 1.75rem;
                color: #fff !important;
                letter-spacing: 1px;
            }
            
            .navbar-toggler {
                border-color: rgba(255,255,255,0.5);
            }
            
            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.85%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            }
            
            .nav-link {
                color: white !important;
                font-weight: 600;
                padding: 0.5rem 1rem;
                transition: transform 0.2s;
            }
            
            .nav-link:hover {
                transform: translateY(-2px);
            }
            
            .dropdown-menu {
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 0.5rem;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
            
            .dropdown-item {
                color: #b22222;
                font-weight: 500;
            }
            
            .dropdown-item:hover {
                background: rgba(178, 34, 34, 0.1);
            }
            
            .main-title {
                color: #b22222;
                font-family: 'Roboto', cursive;
                font-size: 2.5rem;
                text-align: center;
                margin-top: 2rem;
                margin-bottom: 1.5rem;
                text-shadow: 1px 2px 8px #ffe5b4;
                letter-spacing: 2px;
            }
            
            @media (min-width: 768px) {
                .main-title {
                    font-size: 3rem;
                    margin-top: 2.5rem;
                }
            }
            
            .lead {
                color: #333;
                font-size: 1.1rem;
                text-align: center;
                margin-bottom: 2rem;
                font-weight: 400;
            }
            
            @media (min-width: 768px) {
                .lead {
                    font-size: 1.3rem;
                    margin-bottom: 2.5rem;
                }
            }
            
            .content-wrapper {
                background: rgba(255, 255, 255, 0.85);
                border-radius: 1rem;
                padding: 2rem 1rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 16px rgba(178, 34, 34, 0.1);
            }
            
            @media (min-width: 768px) {
                .content-wrapper {
                    padding: 2.5rem;
                }
            }
            
            .btn-reserva, .btn-ver {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                color: #fff;
                border: none;
                border-radius: 2rem;
                font-weight: 600;
                font-size: 1rem;
                padding: 0.6rem 1.5rem;
                box-shadow: 0 4px 12px rgba(178,34,34, 0.2);
                transition: all 0.3s ease;
                margin: 0.5rem;
                width: 100%;
                max-width: 250px;
            }
            
            @media (min-width: 768px) {
                .btn-reserva, .btn-ver {
                    font-size: 1.1rem;
                    padding: 0.75rem 2rem;
                }
            }
            
            .btn-reserva:hover, .btn-ver:hover {
                background: linear-gradient(90deg, #ff7043 0%, #b22222 100%);
                color: #fff;
                transform: translateY(-3px);
                box-shadow: 0 6px 15px rgba(178,34,34, 0.25);
            }
            
            .btn-ver {
                background: linear-gradient(90deg, #ff7043 0%, #b22222 100%);
            }
            
            .btn-ver:hover {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
            }
            
            .card {
                transition: transform 0.3s, box-shadow 0.3s;
                border-radius: 0.75rem;
                overflow: hidden;
                height: 100%;
            }
            
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(178,34,34, 0.15);
            }
            
            .card-img-top {
                height: 180px;
                object-fit: cover;
            }
            
            .card-title {
                color: #b22222;
                font-family: 'Roboto', cursive;
                font-size: 1.25rem;
            }
            
            .section-title {
                color: #b22222;
                font-family: 'Roboto', cursive;
                text-align: center;
                margin-bottom: 1.5rem;
                font-size: 1.75rem;
            }
            
            @media (min-width: 768px) {
                .section-title {
                    font-size: 2rem;
                    margin-bottom: 2rem;
                }
            }
            
            footer {
                background: linear-gradient(90deg, #b22222 0%, #ff7043 100%);
                color: #fff;
                padding-bottom: 1rem;
            }
            
            .benefits-list li {
                padding: 0.5rem 0;
                display: flex;
                align-items: center;
            }
            
            .benefits-list i {
                margin-right: 0.75rem;
                color: #28a745;
                font-size: 1.1rem;
            }
            
            .social-links a {
                color: white;
                margin-right: 1rem;
                transition: transform 0.2s;
                display: inline-block;
            }
            
            .social-links a:hover {
                transform: scale(1.2);
            }
        </style>
    </head>
    <body>
        <!-- Navbar con menú desplegable -->
        <nav class="navbar navbar-expand-lg sticky-top mb-4">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fa-solid fa-fire"></i> Restaurante BBQ
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Reservas
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="views/add.jsp"><i class="fa-solid fa-calendar-plus me-2"></i>Añadir Reserva</a></li>
                                <li><a class="dropdown-item" href="views/list.jsp"><i class="fa-solid fa-list me-2"></i>Ver Reservas</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#menu">Menú</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#nosotros">Nosotros</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <main>
            <div class="container">
                <div class="content-wrapper">
                    <div class="main-title">
                        <i class="fa-solid fa-fire"></i> Restaurante BBQ
                    </div>
                    <p class="lead">Bienvenido al sistema de gestión de reservas de Restaurante BBQ.<br>¡Reserva tu mesa y vive la mejor experiencia de BBQ!</p>
                    
                    <div class="text-center d-flex flex-column flex-md-row justify-content-center align-items-center gap-2 gap-md-4 mb-4">
                        <a href="views/add.jsp" class="btn btn-reserva">
                            <i class="fa-solid fa-calendar-plus me-2"></i> Añadir reserva
                        </a>
                        <a href="views/list.jsp" class="btn btn-ver">
                            <i class="fa-solid fa-list me-2"></i> Ver reservas
                        </a>
                    </div>
                </div>
                
                <!-- Sección de Menús -->
                <div class="content-wrapper mb-4" id="menu">
                    <h2 class="section-title">Nuestros Menús</h2>
                    <div class="row g-4 justify-content-center">
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="card h-100 shadow-sm">
                                <img src="./img/pork.png" class="card-img-top" alt="Cerdo BBQ">
                                <div class="card-body">
                                    <h5 class="card-title">Cerdo BBQ</h5>
                                    <p class="card-text">Costillas, chuletas y cortes especiales de cerdo preparados a la parrilla con nuestro toque especial.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="card h-100 shadow-sm">
                                <img src="./img/cow.png" class="card-img-top" alt="Res BBQ">
                                <div class="card-body">
                                    <h5 class="card-title">Res y derivados</h5>
                                    <p class="card-text">Cortes premium de res, hamburguesas, chorizos y embutidos de la mejor calidad.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="card h-100 shadow-sm">
                                <img src="./img/pollo.png" class="card-img-top" alt="Pollo BBQ">
                                <div class="card-body">
                                    <h5 class="card-title">Pollo a la BBQ</h5>
                                    <p class="card-text">Jugosos muslos, pechugas y alitas de pollo marinadas y asadas al carbón.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-3">
                            <div class="card h-100 shadow-sm">
                                <img src="./img/mixto.png" class="card-img-top" alt="Mixto BBQ">
                                <div class="card-body">
                                    <h5 class="card-title">Mixtos y otros</h5>
                                    <p class="card-text">Parrilladas mixtas, embutidos artesanales y opciones para todos los gustos.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Sección de Por qué usar el sistema -->
                <div class="content-wrapper mb-4" id="nosotros">
                    <h2 class="section-title">¿Por qué usar nuestro sistema de reservas?</h2>
                    <div class="row justify-content-center">
                        <div class="col-12 col-lg-10">
                            <ul class="list-unstyled benefits-list mb-0">
                                <li><i class="fa-solid fa-check-circle"></i>Evita filas y esperas innecesarias, reserva tu mesa desde cualquier lugar.</li>
                                <li><i class="fa-solid fa-check-circle"></i>Gestiona tus reservas de forma rápida y sencilla.</li>
                                <li><i class="fa-solid fa-check-circle"></i>Recibe confirmaciones inmediatas y recordatorios.</li>
                                <li><i class="fa-solid fa-check-circle"></i>Mejor organización para eventos y grupos grandes.</li>
                                <li><i class="fa-solid fa-check-circle"></i>¡Disfruta más tiempo de la experiencia BBQ y menos preocupaciones!</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        
        <!-- Footer -->
        <footer class="mt-5 pt-4 pb-3">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <h5 class="mb-1" style="font-family:'Roboto',cursive;">Restaurante BBQ</h5>
                        <p class="mb-0">Sogamoso, Carrera 11 A #54-34, Barrio Principal<br>Tel: (555) 123-4567<br>Email: contacto@restaurantebbq.com</p>
                    </div>
                    <div class="col-12 col-md-6 text-md-end">
                        <h6 class="mb-1">Horario de atención</h6>
                        <p class="mb-0">Lunes a Domingo: 8:00am - 11:00pm</p>
                        <div class="mt-3 social-links">
                            <a href="#" aria-label="Facebook"><i class="fab fa-facebook fa-lg"></i></a>
                            <a href="#" aria-label="Instagram"><i class="fab fa-instagram fa-lg"></i></a>
                            <a href="#" aria-label="WhatsApp"><i class="fab fa-whatsapp fa-lg"></i></a>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col text-center">
                        <small>&copy; 2024 Restaurante BBQ. Todos los derechos reservados.</small>
                    </div>
                </div>
            </div>
        </footer>
        
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- FontAwesome para iconos -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    </body>
</html>