class ProviderSearch {
  constructor(search_input){
    this.search_input = search_input
    this.search_results = document.getElementById('providers_purchases_search_results')
    this.initListeners()
  }

  initListeners() {
    this.search_input.addEventListener('keyup', (e) => {
      fetch(`/api/v1/providers?&full_data=${e.target.value}`, {
        method: 'GET',
        headers:{
          'Content-Type': 'application/json'
        }
      })
        .then(response => response.json())
        .then(data => {
          this.search_results.querySelector("ul").innerHTML = this.buildResults(data)
          this.addListenersToOptions()
        });
    })

    this.search_input.addEventListener('focusin', (e) => {
      this.search_results.classList.remove('hidden')
    })

    this.search_input.addEventListener('focusout', (e) => {
      this.search_results.classList.add('hidden')
    })
  }

  thaddListenersToOptions() {
    this.search_results.querySelectorAll("li").forEach( el => el.addEventListener("click", (e) => {
      alert("click")
    }))
  }

  buildResults(providers) {
    let results = ""

    providers.forEach((el) => {
      let element = `<li id="${el.id}">${el.full_name}</li>`
      results += element
    })

    return results
  }
}

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll('#providers_purchases_search_provider').forEach( el => new ProviderSearch(el));
});
