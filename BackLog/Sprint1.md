Sprint – Catálogo de productos y avance de gamificación

1. Objetivo del Sprint

Desarrollar y mejorar las funcionalidades principales del catálogo de productos de la tienda virtual, facilitando la búsqueda, consulta y selección de artículos por parte de los usuarios. Adicionalmente, implementar un prototipo local de la ruleta Gacha como avance del sistema de gamificación y fidelización de clientes.

2. Historias de usuario y tareas asignadas

HU-01. Detalle de productos

Responsable: Fabián
Módulo: Catálogo

Descripción:

Como usuario de la tienda virtual, quiero consultar el detalle de cada producto para conocer sus características y disponibilidad antes de realizar una compra.

Funcionalidades:

- Mostrar el nombre del producto.
- Mostrar una descripción detallada.
- Mostrar el precio correspondiente.
- Indicar la disponibilidad del producto.
- Permitir agregar productos al carrito de compras.

Criterios de aceptación:

- Cada producto debe contar con una vista de detalle.
- La información presentada debe corresponder al producto seleccionado.
- El botón para agregar al carrito debe funcionar correctamente.
- Los productos sin disponibilidad no deben poder agregarse al carrito.
- El usuario debe recibir una confirmación al agregar un producto al carrito.

HU-02. Búsqueda de productos

Responsable: Parra
Módulo: Catálogo

Descripción:

Como usuario de la tienda virtual, quiero buscar productos por nombre o categoría para encontrar fácilmente los artículos que necesito.

Funcionalidades:

- Buscar productos por nombre.
- Buscar productos por categoría.
- Ignorar diferencias entre mayúsculas y minúsculas.
- Ignorar diferencias entre palabras con y sin tildes.
- Conservar los filtros activos durante la búsqueda.
- Mostrar un mensaje cuando no existan coincidencias.

Criterios de aceptación:

- La búsqueda debe mostrar resultados relacionados con el término ingresado.
- Las búsquedas deben funcionar independientemente del uso de mayúsculas, minúsculas o tildes.
- Los filtros seleccionados deben mantenerse al realizar nuevas búsquedas.
- Cuando no existan resultados, se debe mostrar un mensaje informativo.
- Al limpiar la búsqueda, deben recuperarse los productos correspondientes a los filtros activos.

HU-03. Productos favoritos

Responsable: Silva
Módulo: Catálogo

Descripción:

Como usuario de la tienda virtual, quiero marcar productos como favoritos para guardar y consultar fácilmente los artículos que me interesan.

Funcionalidades:

- Incorporar botones de corazón en los productos.
- Permitir agregar y quitar productos de favoritos.
- Filtrar el catálogo para visualizar únicamente los productos favoritos.
- Almacenar los favoritos en el navegador mediante almacenamiento local (LocalStorage).

Criterios de aceptación:

- El botón de corazón debe cambiar visualmente según el estado del producto.
- Un producto debe poder agregarse y eliminarse de favoritos.
- El usuario debe poder consultar exclusivamente sus productos favoritos.
- Los favoritos deben conservarse al recargar o cerrar y volver a abrir la página en el mismo navegador.
- No deben generarse registros duplicados de un mismo producto.

HU-04. Productos vistos recientemente

Responsable: Maicol
Módulo: Catálogo

Descripción:

Como usuario de la tienda virtual, quiero consultar los productos que he visitado recientemente para poder encontrarlos nuevamente sin tener que buscarlos desde cero.

Funcionalidades:

- Registrar los productos consultados por el usuario.
- Ordenar los productos desde el más reciente hasta el más antiguo.
- Evitar productos duplicados en el historial.
- Limitar el historial a un máximo de cinco productos.
- Permitir limpiar el historial de navegación.
- Conservar los registros mediante almacenamiento local (LocalStorage).

Criterios de aceptación:

- Cada producto visitado debe registrarse automáticamente.
- El producto consultado más recientemente debe aparecer primero.
- Si un producto ya existe en el historial, debe actualizarse su posición en lugar de duplicarse.
- El historial no debe superar los cinco productos.
- El usuario debe poder eliminar todos los registros mediante la opción de limpiar historial.
- Los productos vistos deben conservarse después de recargar la página o cerrar y volver a abrir el navegador.

---

3. Avance adicional: Ruleta Gacha

Módulo: Gamificación
Tipo de desarrollo: Prototipo local.

Descripción

Implementar una ruleta Gacha que permita al usuario utilizar puntos acumulados para participar en un sistema de recompensas aleatorias, incentivando la interacción con la tienda virtual.

3.1. Reglas de funcionamiento

- Cada giro de la ruleta tiene un costo de 100 puntos.
- El usuario inicia con un saldo de prueba de 100 puntos.
- El sistema debe descontar los puntos correspondientes antes de permitir cada giro.
- El usuario puede reiniciar el saldo de prueba.
- Los premios se asignan de acuerdo con las probabilidades establecidas.

3.2. Tabla de premios y probabilidades

Premio|                                    Probabilidad
Cupón de descuento del          5 %| 40 %
Cupón de descuento del         10 %| 25 %
50 puntos adicionales|             20 %
Envío gratis|                                10 %
Periférico sorpresa|                  5 %
Total|                                              100 %

3.3. Criterios de aceptación

- La ruleta debe mostrar visualmente los cinco premios disponibles.
- El usuario debe visualizar su saldo actual de puntos.
- Cada giro debe descontar 100 puntos.
- No se debe permitir girar cuando el saldo sea inferior a 100 puntos.
- El resultado debe corresponder a las probabilidades configuradas.
- El premio obtenido debe mostrarse claramente al finalizar cada giro.
- Cuando el usuario obtenga 50 puntos, estos deben sumarse a su saldo.
- Debe existir una opción para reiniciar el saldo de prueba a 100 puntos. 
- El sistema debe impedir que el usuario realice giros sin contar con los puntos necesarios.

3.4. Limitaciones del prototipo

- La ruleta funciona únicamente en un entorno local.
- Los 100 puntos iniciales son exclusivamente de prueba.
- Los cupones de descuento y el periférico sorpresa son premios demostrativos.
- Los premios obtenidos todavía no se pueden canjear en compras reales.
- No existe integración con un sistema de pagos ni con el sistema definitivo de puntos de la tienda.

---

4. Observaciones del Product Owner (PO)

Después de revisar las funcionalidades propuestas, se establecen las siguientes observaciones:

1. Integración del catálogo: Las funcionalidades desarrolladas por los integrantes deben trabajar sobre una misma fuente de productos para evitar inconsistencias entre búsqueda, favoritos, historial y detalle.

2. Persistencia de información: Los favoritos y productos vistos recientemente deben utilizar LocalStorage para garantizar que la información permanezca disponible después de recargar la página.

3. Experiencia de usuario: Los botones, mensajes de confirmación, estados vacíos y filtros deben mantener una presentación coherente en todo el catálogo.

4. Integración del carrito: La opción de agregar productos desde el detalle debe conectarse con el carrito general de la tienda.

5. Ruleta Gacha: Se considera un avance adicional del Sprint y no una funcionalidad completamente terminada del sistema de gamificación. Su integración con las compras y los puntos reales queda pendiente.

6. Validación de probabilidades: Los porcentajes de los premios deben respetarse en cada sorteo. La animación visual de la ruleta debe coincidir con el premio realmente seleccionado.

7. Seguridad: El saldo y los premios del prototipo no deben considerarse información confiable para una implementación comercial. En producción, la asignación de puntos y premios deberá validarse desde el servidor.

---

5. Definition of Done (Criterios generales de finalización)

Una funcionalidad se considerará terminada cuando cumpla las siguientes condiciones:

- [ ] La funcionalidad está implementada y cumple su objetivo.
- [ ] Los criterios de aceptación han sido verificados.
- [ ] Los botones y elementos interactivos funcionan correctamente.
- [ ] No presenta errores que impidan su funcionamiento.
- [ ] Se ha comprobado su integración con los demás módulos.
- [ ] La interfaz mantiene coherencia con el diseño general de la tienda.
- [ ] Los cambios han sido probados antes de integrarse a la versión principal.

6. Resultado esperado del Sprint

Al finalizar el Sprint, la tienda virtual deberá contar con un catálogo mejorado que permita consultar detalles de productos, realizar búsquedas avanzadas, administrar favoritos y consultar el historial de productos vistos.

Como avance adicional, se espera disponer de un prototipo funcional de la ruleta Gacha, con saldo de prueba, probabilidades configuradas y visualización de recompensas.

Entregable: Módulo de catálogo funcional y prototipo local de gamificación integrado a la plataforma.