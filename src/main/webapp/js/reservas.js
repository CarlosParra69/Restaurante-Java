/* global Swal */

// Variables globales
let reservas = [];
let editando = false;

// Cargar reservas al iniciar
// Siempre mostrar la tabla al cargar la página
// (esto reemplaza el bloque anterior)
document.addEventListener('DOMContentLoaded', function() {
    if (document.getElementById('tablaReservas')) {
        cargarReservas(); // Mostrar todas las reservas al cargar la página
    }
});

// Manejar el envío del formulario (si existe)
if (document.getElementById('reservaForm')) {
    document.getElementById('reservaForm').addEventListener('submit', function(e) {
        e.preventDefault();
        guardarReserva();
    });
}

// Evento para el formulario de búsqueda
const formBuscador = document.getElementById('formBuscador');
if (formBuscador) {
    formBuscador.addEventListener('submit', function(e) {
        e.preventDefault();
        const buscar = formBuscador.buscar.value;
        const campo = formBuscador.campo.value;
        cargarReservas(buscar, campo);
    });
}

function cargarReservas(buscar = '', campo = '') {
    let url = '../jsp/reservas.jsp';
    const params = [];
    if (buscar) params.push('buscar=' + encodeURIComponent(buscar));
    if (campo) params.push('campo=' + encodeURIComponent(campo));
    if (params.length > 0) {
        url += '?' + params.join('&');
    }
    fetch(url)
        .then(response => response.json())
        .then(data => {
            reservas = data;
            mostrarReservas();
        })
        .catch(error => {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se pudieron cargar las reservas: ' + error.message
            });
        });
}

function mostrarReservas() {
    const tbody = document.querySelector('#tablaReservas tbody');
    tbody.innerHTML = '';
    reservas.forEach(reserva => {
        tbody.innerHTML += `
            <tr>
                <td>${reserva.id || ''}</td>
                <td>${reserva.nombre_cliente || ''}</td>
                <td>${reserva.telefono || ''}</td>
                <td>${reserva.correo_electronico || ''}</td>
                <td>${reserva.fecha_hora || ''}</td>
                <td>${reserva.num_comensales || ''}</td>
                <td>${reserva.mesa_asignada || ''}</td>
                <td>${getBadgeEstado(reserva.estado)}</td>
                <td>${reserva.comentarios_especiales || ''}</td>
                <td>${reserva.fecha_creacion || ''}</td>
                <td>
                    <button class="btn btn-info btn-accion btn-sm" onclick="cambiarEstadoReserva(${reserva.id}, '${reserva.estado}')"><i class="fa-solid fa-arrows-rotate"></i> Estado</button>
                    <a href="edit.jsp?id=${reserva.id}" class="btn btn-warning btn-accion btn-sm"><i class="fa-solid fa-pen-to-square"></i> Editar</a>
                    <button class="btn btn-danger btn-accion btn-sm" onclick="eliminarReserva(${reserva.id})"><i class="fa-solid fa-trash"></i> Eliminar</button>        
                </td>
            </tr>
        `;
    });
    actualizarContadorPendientes();
}

function actualizarContadorPendientes() {
    let pendientes = 0, confirmadas = 0, canceladas = 0, completadas = 0;
    reservas.forEach(reserva => {
        if (!reserva.estado) return;
        const estado = reserva.estado.toLowerCase();
        if (estado === 'pendiente') pendientes++;
        else if (estado === 'confirmada') confirmadas++;
        else if (estado === 'cancelada') canceladas++;
        else if (estado === 'completada') completadas++;
    });
    const numPendientes = document.getElementById('numPendientes');
    if (numPendientes) numPendientes.textContent = pendientes;
    const numConfirmadas = document.getElementById('numConfirmadas');
    if (numConfirmadas) numConfirmadas.textContent = confirmadas;
    const numCanceladas = document.getElementById('numCanceladas');
    if (numCanceladas) numCanceladas.textContent = canceladas;
    const numCompletadas = document.getElementById('numCompletadas');
    if (numCompletadas) numCompletadas.textContent = completadas;
}

function eliminarReserva(id) {
    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Esta acción eliminará la reserva de forma permanente.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#b22222',
        cancelButtonColor: '#aaa',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            const params = new URLSearchParams();
            params.append('action', 'delete');
            params.append('id', id);
            fetch('../jsp/eliminarReserva.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(response => response.text())
            .then(text => {
                let data;
                try {
                    data = JSON.parse(text);
                } catch (e) {
                    Swal.fire('Error', 'Respuesta inválida del servidor: ' + text, 'error');
                    return;
                }
                if (data.success) {
                    Swal.fire('Eliminado', data.message, 'success');
                    cargarReservas();
                } else {
                    Swal.fire('Error', data.message, 'error');
                }
            })
            .catch(error => {
                Swal.fire('Error', 'Error al eliminar la reserva: ' + error.message, 'error');
            });
        }
    });
}

function cambiarEstadoReserva(id, estadoActual) {
    Swal.fire({
        title: 'Cambiar estado',
        input: 'select',
        inputOptions: {
            'confirmada': 'Confirmada',
            'pendiente': 'Pendiente',
            'cancelada': 'Cancelada',
            'completada': 'Completada'
        },
        inputValue: estadoActual || 'pendiente',
        showCancelButton: true,
        confirmButtonText: 'Cambiar',
        cancelButtonText: 'Cancelar',
        inputLabel: 'Selecciona el nuevo estado',
        inputValidator: (value) => {
            if (!value) {
                return 'Debes seleccionar un estado';
            }
        }
    }).then((result) => {
        if (result.isConfirmed) {
            const params = new URLSearchParams();
            params.append('id', id);
            params.append('estado', result.value);
            fetch('../jsp/estadoReserva.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(response => response.text())
            .then(text => {
                let data;
                try {
                    data = JSON.parse(text);
                } catch (e) {
                    Swal.fire('Error', 'Respuesta inválida del servidor: ' + text, 'error');
                    return;
                }
                if (data.success) {
                    Swal.fire('Estado actualizado', data.message, 'success');
                    cargarReservas();
                } else {
                    Swal.fire('Error', data.message, 'error');
                }
            })
            .catch(error => {
                Swal.fire('Error', 'Error al cambiar el estado: ' + error.message, 'error');
            });
        }
    });
}

function guardarReserva() {
    // Capturar datos del formulario
    const reserva = {
        nombre_cliente: document.getElementById('nombre_cliente').value,
        telefono: document.getElementById('telefono').value,
        correo_electronico: document.getElementById('correo_electronico').value,
        fecha_hora: document.getElementById('fecha_hora').value,
        num_comensales: document.getElementById('num_comensales').value,
        mesa_asignada: document.getElementById('mesa_asignada').value,
        comentarios_especiales: document.getElementById('comentarios_especiales').value
    };

    // Crear parámetros para POST
    const params = new URLSearchParams();
    for (const key in reserva) {
        params.append(key, reserva[key]);
    }

    fetch('../jsp/guardarReserva.jsp', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => response.text())
    .then(text => {
        let data;
        try {
            data = JSON.parse(text);
        } catch(e) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Respuesta inválida del servidor: ' + text
            });
            return;
        }
        if(data.success) {
            Swal.fire({
                icon: 'success',
                title: '¡Reserva guardada!',
                text: data.message,
                confirmButtonText: 'OK'
            }).then(() => {
                window.location.href = 'list.jsp';
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: data.message
            });
        }
    })
    .catch(error => {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Error al guardar la reserva: ' + error.message
        });
    });
}

function getBadgeEstado(estado) {
    switch (estado) {
        case 'confirmada': return '<span class="badge bg-success"><i class="fa-solid fa-check"></i> Confirmada</span>';
        case 'pendiente': return '<span class="badge bg-warning text-dark"><i class="fa-solid fa-hourglass-half"></i> Pendiente</span>';
        case 'cancelada': return '<span class="badge bg-danger"><i class="fa-solid fa-xmark"></i> Cancelada</span>';
        case 'completada': return '<span class="badge bg-primary"><i class="fa-solid fa-star"></i> Completada</span>';
        default: return '<span class="badge bg-secondary">Desconocido</span>';
    }
}
