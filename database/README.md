# Base de datos de PixelLoot

Esquema inicial para **MySQL/MariaDB de XAMPP**. `schema.sql` crea la base `pixel_loot`, las tablas con nombres en español y datos de demostración para el catálogo y los cinco premios de la ruleta.

El modelo entidad-relación editable está en [`PixelLoot_ER.drawio`](PixelLoot_ER.drawio). Ábrelo en diagrams.net/draw.io con **File → Open From → Device**.

## Importar en XAMPP

1. Inicia **MySQL** desde el panel de control de XAMPP.
2. Abre `http://localhost/phpmyadmin`.`http://localhost/tienda%20gamificada/`
3. Entra en **Importar**.
4. Selecciona `database/schema.sql` y pulsa **Importar** al final del formulario.
5. En el panel izquierdo selecciona `pixel_loot` y verifica las tablas, por ejemplo `usuarios`, `productos` y `recompensas`.

El script crea las tablas si todavía no existen e inserta los datos de catálogo y recompensas de demostración.

## Tablas

| Área | Tablas | Uso |
| --- | --- | --- |
| Usuarios y vendedores | `usuarios`, `direcciones` | Cuentas, roles, idioma y direcciones de entrega. |
| Catálogo | `categorias`, `productos` | Productos, vendedores propietarios y existencias disponibles. |
| Ofertas | `promociones`, `productos_promociones` | Promociones asociadas a productos; el máximo de 50 % se valida por producto. |
| Compras simuladas | `pedidos`, `detalle_pedido`, `pagos_simulados` | Pedidos, precios y cantidades de compra, y estado del pago ficticio. |
| Puntos y ruleta | `movimientos_puntos`, `recompensas`, `giros_ruleta`, `canjes_recompensas` | Historial de puntos, premios, giros de 100 puntos y resultados. |
| Licencias digitales | `codigos_licencia_digital` | Códigos ficticios y su estado de asignación o canje. |

Los premios de demostración tienen probabilidades de 40 %, 25 %, 20 %, 10 % y 5 % (total: 100 %). El esquema no fija cuántos puntos se ganan por compra; esa regla debe acordarse con el cliente.

## Alcance actual

Este esquema es un avance de diseño para la presentación académica. El prototipo todavía define productos en `index.php` y guarda carrito, puntos, premios, favoritos e historial en `localStorage`; **la aplicación aún no está conectada a esta base de datos**. Los productos y códigos de ejemplo son ficticios.
