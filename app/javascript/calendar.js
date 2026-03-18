window.addEventListener('turbo:load', () => {
  const banners = document.querySelectorAll('.banner');
  banners.forEach(banner => {
    setTimeout(() => {
      banner.classList.add('visible')}, 1500);
    setTimeout(() => {
      banner.classList.remove('visible');
      setTimeout(() => banner.style.display = 'none', 2000);
    }, 5000);
  });
});

