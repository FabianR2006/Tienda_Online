// Favoritos — PixelLoot
// Archivo independiente: NO modifica app.js, openProduct() ni la plantilla de la
// tarjeta. Observa #productGrid y, cada vez que app.js vuelve a dibujar las
// tarjetas, les agrega el botón de corazón y aplica el filtro de favoritos.
(() => {
  const STORAGE_KEY = 'pixelLootFavorites';
  const grid = document.querySelector('#productGrid');
  const chips = document.querySelector('.filter-chips');
  if (!grid || !chips) return;

  const HEART = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>';

  // --- Persistencia (localStorage) ---
  const load = () => {
    try {
      const raw = JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
      return new Set((Array.isArray(raw) ? raw : []).map(Number).filter(Number.isFinite));
    } catch (error) {
      return new Set();
    }
  };
  const favorites = load();
  const save = () => {
    try { localStorage.setItem(STORAGE_KEY, JSON.stringify([...favorites])); } catch (error) { /* modo privado o lleno */ }
  };

  let onlyFavorites = false;

  // --- Botón "Favoritos" junto a los filtros ---
  const chip = document.createElement('button');
  chip.type = 'button';
  chip.className = 'filter-chip fav-chip';
  chips.append(chip);
  const renderChip = () => {
    chip.textContent = `♥ Favoritos${favorites.size ? ` (${favorites.size})` : ''}`;
    chip.classList.toggle('is-active', onlyFavorites);
    chip.setAttribute('aria-pressed', String(onlyFavorites));
  };

  // --- Corazón en cada tarjeta + filtro ---
  const sync = () => {
    observer.disconnect(); // evita que nuestros propios cambios disparen otra vuelta
    let visible = 0;
    grid.querySelectorAll('[data-product-card]').forEach(card => {
      const id = Number(card.dataset.productCard);
      const isFav = favorites.has(id);
      let button = card.querySelector('.fav-button');
      if (!button) {
        const visual = card.querySelector('.product-visual');
        if (!visual) return;
        button = document.createElement('button');
        button.type = 'button';
        button.className = 'fav-button';
        button.dataset.fav = id;
        button.innerHTML = HEART;
        visual.append(button);
      }
      const name = (card.querySelector('.product-title') || {}).textContent || 'producto';
      button.classList.toggle('is-fav', isFav);
      button.setAttribute('aria-pressed', String(isFav));
      button.setAttribute('aria-label', isFav ? `Quitar ${name} de favoritos` : `Guardar ${name} en favoritos`);
      const hide = onlyFavorites && !isFav;
      card.classList.toggle('fav-hidden', hide);
      if (!hide) visible++;
    });
    grid.querySelector('.fav-empty')?.remove();
    if (onlyFavorites && visible === 0) {
      const empty = document.createElement('p');
      empty.className = 'fav-empty';
      empty.innerHTML = favorites.size
        ? 'Ninguno de tus favoritos está en esta categoría.'
        : 'Aún no tienes favoritos.<br>Toca el ♥ de un producto para guardarlo.';
      grid.append(empty);
    }
    observer.observe(grid, { childList: true });
  };
  const observer = new MutationObserver(sync);

  document.addEventListener('click', event => {
    const heart = event.target.closest('[data-fav]');
    if (heart) {
      const id = Number(heart.dataset.fav);
      favorites.has(id) ? favorites.delete(id) : favorites.add(id);
      save(); renderChip(); sync();
      return;
    }
    if (event.target.closest('.fav-chip')) {
      onlyFavorites = !onlyFavorites;
      renderChip(); sync();
    }
  });

  renderChip();
  sync();
})();
