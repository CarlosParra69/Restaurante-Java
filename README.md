# 🍖 Sistema de Reservas - Restaurante BBQ

Este es un sistema web para gestionar reservas en un restaurante BBQ. Desarrollado utilizando **JSP**, **Servlets**, **AJAX**, **Bootstrap**, y **MySQL** como base de datos. El sistema permite a los clientes realizar reservas en línea y al personal del restaurante gestionar las reservas desde un panel administrativo.

## 🚀 Características

- 🧑‍💼 Registro y gestión de reservas por parte del usuario
- 📅 Visualización de disponibilidad en tiempo real (AJAX)
- 🧾 Panel de administración para ver y editar reservas
- 🎨 Diseño responsivo con Bootstrap 5
- 🌐 Interfaz moderna, clara y sencilla
- 🔒 Validación del lado del cliente y del servidor
- 📂 Separación de capas (Modelo - Vista - Controlador)

## 🛠️ Tecnologías Usadas

- **Frontend:**
  - HTML5, CSS3
  - Bootstrap 5
  - JavaScript + AJAX
- **Backend:**
  - JSP y Servlets
  - JDBC (Java Database Connectivity)
- **Base de Datos:**
  - MySQL
- **Servidor:**
  - Apache Tomcat (versión 9 o superior)

## 📸 Capturas

*Incluye aquí capturas de pantalla del sistema en uso: interfaz de reservas, panel administrativo, etc.*

## 📦 Estructura del Proyecto

```

/BBQReservationSystem
│
├── /src
│   ├── /controller       # Servlets y lógica de control
│   ├── /model            # Clases Java (Reserva, Usuario, etc.)
│
├── /web
│   ├── /css              # Estilos personalizados
│   ├── /js               # Scripts JS + AJAX
│   ├── /images           # Recursos gráficos
│   ├── index.jsp         # Página principal
│   ├── reservas.jsp      # Formulario de reservas
│   ├── admin.jsp         # Panel de administración
│
├── /WEB-INF
│   └── web.xml           # Configuración del servlet
│
└── README.md

````

## ⚙️ Instalación y Ejecución

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tuusuario/BBQReservationSystem.git
   ```

2. Importa el proyecto a tu IDE (Eclipse, IntelliJ, etc.) como un proyecto Dynamic Web.

3. Crea una base de datos en MySQL:

   ```sql
   CREATE DATABASE bbq_reservas;
   ```

4. Importa el script SQL ubicado en `/database/bbq_reservas.sql`.

5. Configura la conexión en el archivo `DBConnection.java`:

   ```java
   String url = "jdbc:mysql://localhost:3306/bbq_reservas";
   String user = "root";
   String password = "tupassword";
   ```

6. Ejecuta el proyecto en un servidor Apache Tomcat.

7. Accede a:

   ```
   http://localhost:8080/BBQReservationSystem/
   ```

## 🧪 Funcionalidades a probar

* Realizar una reserva como cliente
* Comprobación de disponibilidad dinámica con AJAX
* Gestión de reservas desde el panel admin
* Validaciones de formularios

## ✍️ Autores

* **Tu Nombre** - *Desarrollador principal*
* Puedes añadir más colaboradores aquí si es necesario.

## 📝 Licencia

Este proyecto está bajo la licencia MIT - consulta el archivo [LICENSE](LICENSE) para más detalles.
