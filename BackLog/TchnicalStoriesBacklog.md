TECHNICAL BACKLOG – Tienda Virtual Gamificada /(detalles aun por revisar y eiminar)

Proyecto: Tienda virtual de periféricos y licencias digitales
Metodología: Scrum
Tecnología: PHP (Frontend y Backend)
Responsable de priorización: Product Owner (PO)

---

TS-01. Configuración de la arquitectura del proyecto

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos establecer una estructura organizada para el proyecto en PHP, con el fin de facilitar el desarrollo, mantenimiento e integración de los diferentes módulos de la tienda virtual.

Criterios de aceptación:

- Configurar el entorno de desarrollo PHP.
- Establecer una estructura de carpetas para frontend y backend.
- Separar la lógica de negocio de la presentación visual.
- Centralizar las configuraciones generales del proyecto.
- Garantizar que los módulos puedan integrarse correctamente.

TS-02. Diseño e implementación de la base de datos

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos diseñar e implementar una base de datos que permita almacenar y administrar la información de usuarios, productos, vendedores, pedidos, puntos y recompensas.

Criterios de aceptación:

- Definir las entidades y relaciones necesarias.
- Crear las tablas correspondientes a los módulos del sistema.
- Establecer claves primarias y foráneas.
- Implementar restricciones para mantener la integridad de los datos.
- Garantizar la disponibilidad de la información para los diferentes módulos.

TS-03. Desarrollo de servicios para la gestión de productos

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos implementar servicios de backend que permitan consultar, registrar, actualizar y administrar los productos de la tienda.

Criterios de aceptación:

- Permitir consultar el catálogo de productos.
- Obtener el detalle de cada producto.
- Consultar precios y disponibilidad.
- Permitir operaciones de creación, modificación y eliminación desde los permisos correspondientes.
- Validar la información antes de almacenarla.

TS-04. Implementación del sistema de persistencia local

Prioridad: Media

Descripción:

Como equipo de desarrollo, necesitamos implementar mecanismos de almacenamiento local en el navegador para conservar las preferencias y actividades recientes del usuario.

Criterios de aceptación:

- Implementar LocalStorage para almacenar productos favoritos.
- Implementar LocalStorage para conservar los productos vistos recientemente.
- Evitar registros duplicados en los datos almacenados.
- Mantener un máximo de cinco productos en el historial.
- Conservar la información después de recargar la página.
- Permitir actualizar y eliminar los registros almacenados.

TS-05. Integración técnica del carrito de compras

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos implementar la lógica de funcionamiento del carrito de compras para conectar los productos del catálogo con el proceso de compra.

Criterios de aceptación:

- Permitir agregar productos al carrito.
- Permitir modificar cantidades y eliminar productos.
- Calcular automáticamente los subtotales y el total.
- Validar la disponibilidad de los productos.
- Evitar cantidades superiores al inventario disponible.
- Mantener actualizada la información del carrito.

TS-06. Implementación de la gestión de vendedores externos

Prioridad: Media

Descripción:

Como equipo de desarrollo, necesitamos implementar una estructura que permita registrar y administrar vendedores externos dentro de la plataforma, relacionando sus productos con sus respectivas cuentas.

Criterios de aceptación:

- Establecer una estructura para registrar vendedores.
- Relacionar cada producto con su vendedor correspondiente.
- Permitir identificar qué vendedor ofrece cada producto.
- Implementar controles de permisos para la gestión de productos.
- Evitar que un vendedor modifique productos pertenecientes a otros vendedores.

TS-07. Desarrollo del sistema de puntos

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos implementar un sistema de administración de puntos que permita registrar, acumular y descontar puntos de los usuarios según las actividades y compras realizadas en la tienda.

Criterios de aceptación:

- Registrar los puntos asociados a cada usuario.
- Permitir la acumulación de puntos por compras realizadas.
- Permitir el descuento de puntos al participar en la ruleta.
- Evitar saldos negativos.
- Mantener un registro de los movimientos de puntos.
- Validar las operaciones para evitar modificaciones no autorizadas.

TS-08. Implementación del algoritmo de probabilidades Gacha

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos implementar un algoritmo de selección aleatoria ponderada que permita asignar premios en la ruleta Gacha de acuerdo con las probabilidades establecidas.

Criterios de aceptación:

- Configurar los cinco premios disponibles.
- Establecer las probabilidades correspondientes:
  - Cupón del 5 %: 40 %.
  - Cupón del 10 %: 25 %.
  - 50 puntos: 20 %.
  - Envío gratis: 10 %.
  - Periférico sorpresa: 5 %.
- Garantizar que la suma de probabilidades sea del 100 %.
- Implementar una selección aleatoria ponderada.
- Descontar 100 puntos por cada giro válido.
- Sumar los 50 puntos adicionales cuando corresponda.
- Garantizar que el resultado visual coincida con el premio seleccionado.

Nota técnica: En el prototipo actual se utilizará un saldo inicial de 100 puntos de prueba y una opción para reiniciarlo. Los premios serán demostrativos y no tendrán validez comercial.

TS-09. Implementación de las reglas de descuentos y promociones

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos establecer reglas de validación para la aplicación de descuentos y promociones, garantizando que ninguna oferta supere el límite máximo del 50 % establecido por el cliente.

Criterios de aceptación:

- Permitir configurar descuentos para los productos.
- Validar que ningún descuento supere el 50 %.
- Calcular correctamente el precio final.
- Mostrar el precio original y el precio con descuento.
- Evitar la aplicación de descuentos que incumplan las condiciones establecidas.

TS-10. Implementación de soporte multidioma

Prioridad: Media

Descripción:

Como equipo de desarrollo, necesitamos implementar una estructura de internacionalización que permita visualizar la tienda virtual en diferentes idiomas.

Criterios de aceptación:

- Crear archivos o estructuras de traducción.
- Permitir seleccionar el idioma de la plataforma.
- Traducir los textos de navegación, botones y mensajes.
- Mantener el idioma seleccionado durante la navegación.
- Facilitar la incorporación de nuevos idiomas sin modificar toda la estructura del sistema.

TS-11. Implementación de seguridad y validaciones

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos implementar mecanismos de seguridad que protejan la información de los usuarios y garanticen la integridad de las operaciones realizadas en la tienda virtual.

Criterios de aceptación:

- Validar los datos enviados desde formularios.
- Proteger las consultas a la base de datos mediante consultas preparadas.
- Implementar protección contra ataques XSS y CSRF.
- Gestionar correctamente las sesiones de usuario.
- Controlar los permisos de clientes, vendedores y administradores.
- Proteger las operaciones relacionadas con compras, puntos y recompensas.

TS-12. Pruebas técnicas e integración de módulos

Prioridad: Alta

Descripción:

Como equipo de desarrollo, necesitamos realizar pruebas técnicas y de integración para verificar el correcto funcionamiento de los diferentes módulos y garantizar que trabajen de manera conjunta.

Criterios de aceptación:

- Realizar pruebas individuales de cada módulo.
- Verificar la integración del catálogo con el carrito.
- Comprobar la persistencia de favoritos e historial.
- Validar el funcionamiento del sistema de puntos y la ruleta.
- Verificar las restricciones de descuentos.
- Corregir errores identificados durante las pruebas.
- Comprobar que las funcionalidades principales no se vean afectadas por nuevas implementaciones.

---

Resumen del Technical Backlog

ID| Technical Story| Prioridad
TS-01| Arquitectura del proyecto| Alta
TS-02| Base de datos| Alta
TS-03| Servicios de productos| Alta
TS-04| Persistencia local| Media
TS-05| Integración del carrito| Alta
TS-06| Gestión de vendedores| Media
TS-07| Sistema de puntos| Alta
TS-08| Algoritmo Gacha| Alta
TS-09| Reglas de descuentos| Alta
TS-10| Soporte multidioma| Media
TS-11| Seguridad y validaciones| Alta
TS-12| Pruebas e integración| Alta

Observaciones del Product Owner

1. Las historias técnicas deben estar relacionadas con las necesidades funcionales del Product Backlog.
2. La implementación debe realizarse de manera modular para facilitar el mantenimiento y la escalabilidad.
3. Las funcionalidades de puntos, ruleta y recompensas deben contar con validaciones que eviten modificaciones indebidas.
4. El límite máximo de descuentos del 50 % debe respetarse en todas las operaciones comerciales.
5. La ruleta actual es un prototipo local; su integración comercial queda como trabajo futuro.
6. Las historias técnicas deberán estimarse con el equipo de desarrollo antes de ser asignadas a un Sprint.

Resultado esperado: Contar con una infraestructura técnica organizada, segura y funcional que permita desarrollar, integrar y mantener los diferentes módulos de la tienda virtual gamificada.