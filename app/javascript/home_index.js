document.addEventListener("turbo:load", () => {
  const line1 = document.querySelector(".line1");
  const line2 = document.querySelector(".line2");

  if (!line1 || !line2) return;

  let toggle = true;

  setInterval(() => {
    if (toggle) {
      line1.classList.add("glow");
      line2.classList.remove("glow");
    } else {
      line1.classList.remove("glow");
      line2.classList.add("glow");
    }
    toggle = !toggle;
  }, 1200);
});

document.addEventListener("turbo:load", () => {
  const h2 = document.querySelector("h2.float");

  setInterval(() => {
    h2.classList.add("active");

    setTimeout(() => {
      h2.classList.remove("active");
    }, 600); // 浮き上がり時間と合わせる
  }, 2000);
});