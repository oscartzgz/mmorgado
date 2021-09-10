class PriceFormulaToggle {
  constructor(link) {

  }
}

document.addEventListener("turbolinks:load", () => {
  const links = document.querySelectorAll("a[data-remote]");
  links.forEach((element) => {
    console.log(element);
    element.addEventListener("ajax:success", () => {
      alert("Price toggle was success");
    });
  });
});
