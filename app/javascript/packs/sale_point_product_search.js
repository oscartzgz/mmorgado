class ProductSearch {
  constructor(search_input){
    this.search_input = search_input
    this.search_results = document.getElementById('sp_search_product_results')
    this.initListeners()
  }

  initListeners() {
    this.search_input.addEventListener('keyup', (e) => {
      this.searchProducts(e)
    })
    this.search_input.addEventListener('focusin', (e) => {
      this.search_results.classList.remove('hidden')
      this.searchProducts(e)
    })
  }

  searchProducts(e) {
    
    fetch(`/api/v1/products?&full_data=${e.target.value}`, {
      method: 'GET',
      headers:{
        'Content-Type': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      this.clearSearchResults()
      this.search_results.querySelector('ul').insertAdjacentHTML('afterbegin', this.buildResults(data) )
      this.appendListenersToNewItems()
    });

  }

  selectProduct(id) {
    fetch(`/api/v1/products/${id}`, {
      method: 'GET',
      header: {
        'Content-Type': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      // document.querySelector('.product-name').textContent = data.name
      // document.querySelector('.product-address').textContent = data.full_address
    })
  }

  appendListenersToNewItems() {
    this.search_results.querySelectorAll('li button.add-product-button').forEach((product) => {
      product.addEventListener('click', (e) => {
        console.log(e.target)
        e.preventDefault()
        // this.search_input.value = 'e.target.dataset.text'
        this.search_results.classList.add('hidden')
        this.selectProduct(e.target.dataset.value)
      })
    })
  }

  clearSearchResults() {
    results_container = this.search_results.querySelector('ul')
    while (results_container.firstChild) {
      results_container.removeChild(results_container.firstChild)
    }
  }

  buildResults(products) {
    let results = ""

    products.forEach((product) => {
      let element = `
        <li id="${product.id}"
            class="product-item rounded-lg border-2 p-2"
            data-text="${product.code} - ${product.name}">
          <div>${product.name}</div>
          <small>${product.code}</small>
          <div>
            <strong>Precio: 4000</strong>
          </div>

          <div>
            <button data-value="${product.id}"
                    class="add-product-button bg-yellow-300 text-sm text-gray-800 px-5 py-1 rounded font-bold w-full">
              Añadir
            </button>
          <div>
        </li>`
        
      results += element
    })

    return results
  }

}

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll('#sp_search_product').forEach( el => new ProductSearch(el));
});
