(() => {
  const products = window.PRODUCTS || [];
  const grid = document.querySelector('#productGrid');
  const cart = JSON.parse(localStorage.getItem('pixelLootCart') || '{}');
  let activeFilter = 'Todos';
  let offersOnly = false;
  const money = value => '$' + Number(value).toLocaleString('es-CO');
  const save = () => localStorage.setItem('pixelLootCart', JSON.stringify(cart));
  const visibleProducts = () => {
    let list = products.filter(p => (activeFilter === 'Todos' || p.category === activeFilter) && (!offersOnly || p.discount > 0));
    const sort = document.querySelector('#sortSelect').value;
    if (sort === 'price-low') list.sort((a,b) => a.price - b.price);
    if (sort === 'price-high') list.sort((a,b) => b.price - a.price);
    return list;
  };
  const renderProducts = () => {
    grid.innerHTML = visibleProducts().map(p => `<article class="product-card"><div class="product-visual ${p.tone}"><span class="product-tag">${p.tag}</span>${p.discount ? `<span class="product-discount">-${p.discount}%</span>` : ''}<span class="product-emoji">${p.icon}</span></div><div class="product-content"><div class="product-category">${p.category} · ${p.type}</div><h3 class="product-title">${p.name}</h3><div class="product-rating">★ ${p.rating} <span>(128 opiniones)</span></div><div class="product-bottom"><div class="price"><strong>${money(p.price)}</strong>${p.old ? `<del>${money(p.old)}</del>` : ''}</div><button class="add-button" data-add="${p.id}" aria-label="Agregar ${p.name} al carrito">+</button></div></div></article>`).join('') || '<p>No hay productos en esta categoría.</p>';
  };
  const countCart = () => Object.values(cart).reduce((sum, qty) => sum + qty, 0);
  const renderCart = () => {
    const count = countCart();
    document.querySelector('#cartCount').textContent = count;
    document.querySelector('#drawerCount').textContent = `(${count})`;
    const ids = Object.keys(cart).filter(id => cart[id] > 0);
    document.querySelector('#cartItems').innerHTML = ids.length ? ids.map(id => {
      const p = products.find(item => item.id === Number(id));
      return `<div class="cart-item"><div class="cart-thumb">${p.icon}</div><div><div class="cart-item-name">${p.name}</div><div class="cart-item-price">${money(p.price)}</div><div class="qty-control"><button data-qty="${id}" data-delta="-1" aria-label="Quitar uno">−</button><span>${cart[id]}</span><button data-qty="${id}" data-delta="1" aria-label="Agregar uno">+</button></div></div><button class="remove-item" data-remove="${id}" aria-label="Eliminar producto">✕</button></div>`;
    }).join('') : '<div class="empty-cart"><span>🛍️</span>Tu carrito está esperando<br>su primer upgrade.</div>';
    const total = ids.reduce((sum, id) => sum + products.find(p => p.id === Number(id)).price * cart[id], 0);
    document.querySelector('#cartTotal').textContent = money(total);
  };
  const toast = message => { const el = document.querySelector('#toast'); el.textContent = message; el.classList.add('visible'); clearTimeout(toast.timer); toast.timer = setTimeout(() => el.classList.remove('visible'), 2200); };
  document.addEventListener('click', event => {
    const add = event.target.closest('[data-add]');
    if (add) { const id = add.dataset.add; cart[id] = (cart[id] || 0) + 1; save(); renderCart(); toast('Agregado a tu carrito ✦'); }
    const qty = event.target.closest('[data-qty]');
    if (qty) { const id = qty.dataset.qty; cart[id] = (cart[id] || 0) + Number(qty.dataset.delta); if (cart[id] <= 0) delete cart[id]; save(); renderCart(); }
    const remove = event.target.closest('[data-remove]');
    if (remove) { delete cart[remove.dataset.remove]; save(); renderCart(); }
    const filter = event.target.closest('[data-filter]');
    if (filter) { activeFilter = filter.dataset.filter; document.querySelectorAll('.filter-chip').forEach(chip => chip.classList.toggle('selected', chip === filter)); renderProducts(); }
  });
  document.querySelector('#sortSelect').addEventListener('change', renderProducts);
  const drawer = document.querySelector('#cartDrawer'), overlay = document.querySelector('#overlay');
  const closeDrawer = () => { drawer.classList.remove('open'); overlay.classList.remove('open'); };
  document.querySelector('#openCart').addEventListener('click', () => { drawer.classList.add('open'); overlay.classList.add('open'); });
  document.querySelector('#closeCart').addEventListener('click', closeDrawer); overlay.addEventListener('click', closeDrawer);
  const modal = document.querySelector('#demoModal');
  const modalBackdrop = document.createElement('div'); modalBackdrop.className = 'modal-backdrop'; document.body.append(modalBackdrop);
  const openModal = title => { document.querySelector('#modalTitle').textContent = title; modal.classList.add('open'); modalBackdrop.classList.add('open'); };
  const closeModal = () => { modal.classList.remove('open'); modalBackdrop.classList.remove('open'); };
  document.querySelector('#closeModal').addEventListener('click', closeModal); document.querySelector('#modalOk').addEventListener('click', closeModal); modalBackdrop.addEventListener('click', closeModal);
  document.querySelector('#checkoutButton').addEventListener('click', () => { if (!countCart()) { toast('Agrega al menos un producto para continuar'); return; } closeDrawer(); openModal('El pago simulado se construirá en un siguiente Sprint'); });
  document.querySelector('#sellerLink').addEventListener('click', event => { event.preventDefault(); openModal('El registro y el panel de vendedor están pendientes'); });
  document.querySelector('#profileButton').addEventListener('click', () => openModal('El registro e inicio de sesión están pendientes'));
  document.querySelector('.search-toggle').addEventListener('click', () => openModal('La búsqueda de productos está pendiente'));
  document.querySelectorAll('.main-nav a').forEach(link => link.addEventListener('click', event => { const view = link.dataset.view; if (view === 'ofertas') { event.preventDefault(); offersOnly = true; activeFilter = 'Todos'; document.querySelectorAll('.filter-chip').forEach(chip => chip.classList.toggle('selected', chip.dataset.filter === 'Todos')); document.querySelector('#catalogTitle').innerHTML = 'Ofertas <span>para tu setup</span>'; renderProducts(); document.querySelector('#catalogo').scrollIntoView({behavior:'smooth'}); } else if (view === 'inicio') { offersOnly = false; document.querySelector('#catalogTitle').innerHTML = 'Lo más <span>jugado</span>'; renderProducts(); } document.querySelector('.main-nav').classList.remove('mobile-open'); }));
  document.querySelector('#viewAll').addEventListener('click', () => { offersOnly = false; activeFilter = 'Todos'; document.querySelector('#catalogTitle').innerHTML = 'Lo más <span>jugado</span>'; document.querySelectorAll('.filter-chip').forEach(chip => chip.classList.toggle('selected', chip.dataset.filter === 'Todos')); renderProducts(); });
  document.querySelector('#menuToggle').addEventListener('click', () => document.querySelector('.main-nav').classList.toggle('mobile-open'));
  renderProducts(); renderCart();
})();
