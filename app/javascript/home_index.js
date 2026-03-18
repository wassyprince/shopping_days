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
  if (!h2) return;

  // テキストを一文字ずつ<span>で囲む（初回のみ）
  const text = h2.textContent;
  h2.innerHTML = text.split("").map((char, i) => 
    `<span style="--i: ${i}">${char === " " ? "&nbsp;" : char}</span>`
  ).join("");

  const intervalId = setInterval(() => {
    h2.classList.add("active");
    
    // 0.6s（上昇）+ 文字数分の遅延を考慮してクラスを外す
    setTimeout(() => {
      h2.classList.remove("active");
    }, 1500); 
  }, 3000); // 間隔を少し広げると綺麗に見えます

  document.addEventListener("turbo:before-cache", () => {
    clearInterval(intervalId);
  }, { once: true });
});