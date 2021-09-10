class PriceFormulaToggle {
  constructor(link) {

  }
}

document.addEventListener("turbolinks:load", () => {
  const links = document.querySelectorAll("a[data-remote]");
  links.forEach((element) => {
    element.addEventListener("ajax:success", () => {
      Turbolinks.clearCache()
      Turbolinks.visit(location.toString());
    });
  });
});
