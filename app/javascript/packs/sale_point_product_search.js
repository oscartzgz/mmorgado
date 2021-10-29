var toCurrency = require('./utils').toCurrency

class ProductSearch {
  constructor(search_input){
    this.search_input = search_input
    this.search_results = document.getElementById('sp_search_product_results')
    this.table = document.getElementById('sale_products_list')
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
      tr = `
        <tr data-cost-price="${data.cost_price}">
          <td class="px-4 py-1">
            <small>${data.code}</small>
          </td>
          <td class="px-4 py-1">
            ${data.name}
            <i>${data.model}</i>
          </td>
          <td class="px-4 py-1 text-center">
            <select>
              <option selected>1</option>
              <option>2</option>
              <option>3</option>
              <option>4</option>
              <option>5</option>
              <option>6</option>
              <option>7</option>
              <option>8</option>
            </select>
          </td>
          <td class="px-4 py-1">${toCurrency(data.cost_price)}</td>
          <td class="import px-4 py-1">${toCurrency(data.cost_price)}</td>
          <td class="px-4 py-1 text-center">
            <button class="bg-red-500 text-white px-2 py-0.5 rounded text-sm">Eliminar</button>
          </td>
        </tr>
      `
      tbody = document.getElementById('sale_products_list').querySelector('tbody')
      tbody.insertAdjacentHTML('beforeend', tr)
      this.appendListenersToNewSaleProduct()
    })

  }

  appendListenersToNewSaleProduct() {
    let tr = this.table.querySelector('tbody tr:last-child')
    let cost_price = tr.dataset.costPrice
    let col_import = tr.querySelector('.import')

    tr.querySelector('select').addEventListener('change', (e) => {
      let import_calc = cost_price * e.target.value
      col_import.textContent = toCurrency(import_calc)
    })

    tr.querySelector('button').addEventListener('click', (e) => {
      e.preventDefault()
      tr.remove()
    })
  }

  appendListenersToNewItems() {
    this.search_results.querySelectorAll('li button.add-product-button').forEach((product) => {
      product.addEventListener('click', (e) => {
        e.preventDefault()
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
            <strong>Precio: ${toCurrency(product.cost_price)}</strong>
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
