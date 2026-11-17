# Tienda virtual gamificada

Proyecto académico de comercio electrónico para la venta de periféricos tecnológicos y licencias digitales. La plataforma combina una tienda en línea con puntos y una ruleta de recompensas para motivar la participación y las compras recurrentes.

> **Estado del proyecto:** prototipo frontend inicial. Los datos del catálogo son demostrativos; todavía no hay backend, base de datos, autenticación ni procesamiento real de pedidos.

## Objetivo

Diseñar y desarrollar una tienda virtual funcional, responsiva y disponible en español, inglés y portugués. Los clientes podrán explorar productos, simular una compra, acumular puntos y canjearlos por recompensas.

## Funcionalidades previstas

- Catálogo de periféricos tecnológicos y licencias digitales, con descripción, imágenes, precio y disponibilidad.
- Registro de clientes y vendedores.
- Publicación y administración de productos por parte de cada vendedor.
- Carrito para agregar, quitar y modificar productos y cantidades, con cálculo del total.
- Promociones con un límite acumulado de descuento del 50 % por producto.
- Simulación del pago; no se procesarán pagos reales.
- Envío por correo de una licencia digital ficticia después de completar la compra simulada.
- Acumulación de puntos por compras que cumplan las condiciones de entrega o canje.
- Ruleta de recompensas que cuesta 100 puntos por giro
- Interfaz adaptable a computadores, tabletas y teléfonos.

## Reglas de negocio acordadas

### Cuentas y productos

- La plataforma tendrá cuentas de **cliente** y **vendedor**.
- Los vendedores podrán registrarse, publicar sus productos y administrarlos directamente.

### Compras y licencias

- El pago será simulado con fines académicos; no habrá integración con una pasarela de pago real.
- Las licencias serán ficticias y se enviarán por correo después de completar la compra simulada.

### Puntos y ruleta

- Cada giro cuesta **100 puntos**.
- Solo se pueden usar puntos obtenidos por compras. No hay un límite de giros por usuario, siempre que tenga los puntos necesarios.
- Los puntos de productos físicos se acreditan cuando el pedido se marca como entregado.
- Los puntos de licencias digitales se acreditan cuando la licencia figura como canjeada.
- Si se reembolsa una compra, se revierten los puntos otorgados por esa compra.

### Descuentos e idiomas

- El descuento acumulado no puede superar el **50 % del precio original de cada producto**. El límite se calcula por producto, no sobre el carrito completo.
- La plataforma ofrecerá **español, inglés y portugués**.

## Propuestas pendientes de validación

Los siguientes valores son propuestas iniciales y deben revisarse con el cliente antes de implementarse:

- **Acumulación de puntos:** 1 punto por cada $1.000 COP pagados, redondeando hacia abajo. Debe revisarse con los precios del catálogo.
- **Probabilidades de la ruleta:** 60 % descuento, 25 % envío gratis, 10 % devolución de puntos y 5 % periférico.
- Falta definir el valor o las condiciones de los descuentos premio, el costo y disponibilidad de premios físicos, y cómo se simularán los estados de pago, entrega, canje y reembolso.

## Tecnologías previstas

- **Frontend del prototipo:** PHP para servir el catálogo, HTML, CSS y JavaScript para la interfaz y sus interacciones locales.
- **Backend del producto:** PHP (pendiente de desarrollo).
- **Base de datos:** pendiente de selección por el equipo.

## Ejecutar el prototipo

Se necesita PHP instalado. Desde la carpeta raíz del repositorio, ejecuta:

```bash
php -S localhost:8000
```

Luego abre `http://localhost:8000` en el navegador. El carrito se conserva en el almacenamiento local del navegador; estos datos no son cuentas ni pedidos reales.

## Estructura actual

```text
├── index.php          # Página de inicio y catálogo de demostración
├── assets/
│   ├── app.js          # Filtros y carrito local de demostración
│   └── styles.css      # Estilos responsivos
├── README.md           # Presentación general del proyecto
└── GUIA_SCRUM.md       # Guía práctica para organizar los Sprints
```

## Equipo

| Integrante | Rol | Responsabilidad |
| --- | --- | --- |
| Fabian | Scrum Master | Facilitar el proceso Scrum, acompañar al equipo y ayudar a remover impedimentos. |
| Parra | Product Owner | Representar al cliente, aclarar necesidades y priorizar el Product Backlog. |
| Silva | Desarrollador | Colaborar en el diseño, desarrollo e integración del producto. |
| Maicol | Desarrollador | Colaborar en el diseño, desarrollo e integración del producto. |

## Épicas iniciales

1. Catálogo y detalle de productos.
2. Registro de vendedores y administración de productos.
3. Carrito y simulación de compra.
4. Promociones y descuentos.
5. Puntos y ruleta de recompensas.
6. Envío y canje de licencias digitales ficticias.
7. Interfaz multidioma y responsiva.

## Flujo de trabajo

El equipo trabajará con Scrum. Parra priorizará las historias de usuario con base en las necesidades del cliente; el equipo de desarrollo seleccionará y organizará el trabajo de cada Sprint. Al terminar cada Sprint, se revisará el incremento y se recogerán comentarios para ajustar el backlog.

## Organización del trabajo

Consulta [GUIA_SCRUM.md](GUIA_SCRUM.md) para ver el roadmap sugerido por Sprints, ideas para preparar historias y recomendaciones para facilitar las ceremonias.

## Próximo hito

Revisar el prototipo con Parra y el cliente, confirmar las reglas pendientes y convertir el primer objetivo acordado en historias pequeñas con criterios de aceptación.
