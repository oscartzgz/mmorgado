var toCurrency = require('./utils').toCurrency

class Order {
  constructor(button){
    this.button = button
    this.search_results = document.getElementById('sp_search_product_results')
    this.table = document.getElementById('sale_products_list')
    this.add_freight_button = document.getElementById('add_freight')
    this.extra_import_input = document.getElementById('extra_import_input')
    this.initListeners()
    this.code = ""
    this.client = ""
    this.payment_type = ""
    this.seller = ""
    this.order_items = []

    this.csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  }

  initListeners() {
    this.button.addEventListener('click', (e) => {
      this.createOrder(e)
    })

    this.add_freight_button.addEventListener('click', (e) => {
      e.preventDefault()
      this.addFreight()
    })
  }

  addFreight() {
    if (this.validateExtraImporInputValue()) {
      price = this.extra_import_input.value

      let tr = `
        <tr data-code="FLT"
            data-name="Flete"
            data-price="${price}"
            data-kind="freight"
            data-payment_type=""
            data-orderable-type="Freight"
            data-orderable-id="">
          <td class="px-4 py-1">
            <small></small>
          </td>
          <td class="px-4 py-1">Flete</td>
          <td class="px-4 py-1 text-center">
            <select class="item-quantity">
              <option value="1" selected>1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
            </select>
          </td>
          <td class="px-4 py-1">${toCurrency(price)}</td>
          <td class="import px-4 py-1">${toCurrency(price)}</td>
          <td class="px-4 py-1 text-center">
            <button class="bg-red-500 text-white px-2 py-0.5 rounded text-sm">Eliminar</button>
          </td>
        </tr>
      `
      tbody = document.getElementById('sale_products_list').querySelector('tbody')
      tbody.insertAdjacentHTML('beforeend', tr)
      this.appendListenersToNewSaleProduct()
    } else {
      alert("SOLO NUMEROS ENTEROS")
    }
  }

  validateExtraImporInputValue(){
    return !isNaN(this.extra_import_input.value) && Number.isInteger(parseFloat(this.extra_import_input.value));
  }

  appendListenersToNewSaleProduct() {
    let tr = this.table.querySelector('tbody tr:last-child')
    let cost_price = tr.dataset.price
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

  createOrder(e) {
    if (this.validateData()) {

      let object = {
        order: {
          code: this.code,
          client_id: this.client,
          payment_type: this.payment_type,
          seller_id: this.seller,
          order_items_attributes: this.order_items
        }
      }

      fetch(`/api/v1/orders`, {
        method: 'POST',
        headers:{
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.csrf
        },
        body: JSON.stringify(object)
      })
      .then(response => response.json())
      .then(data => {
        alert("LA ORDEN SE GENERO CORRECTAMENTE")
        if (!data.errors) Turbolinks.visit(`/orders/${data.id}`)
      })
    }
  }

  validateData() {
    this.code = document.getElementById('order_code').value
    this.client = document.getElementById('order_client').dataset.id
    this.payment_type = document.getElementById('order_payment_type').value
    this.seller = document.getElementById('order_seller').value

    this.order_items = []

    this.table.querySelectorAll('tbody tr').forEach((item) => {
      let itemData = {
        code: item.dataset.code,
        name: item.dataset.name,
        quantity: item.querySelector('.item-quantity').value,
        price: item.dataset.price,
        kind: item.dataset.kind,
        payment_type: "",
        orderable_id: item.dataset.orderableId, 
        orderable_type: item.dataset.orderableType
      }

      this.order_items.push(itemData)
    })

    not_finded = []

    if (!this.code) not_finded.push("Código")
    if (!this.client) not_finded.push("Cliente")
    if (!this.payment_type) not_finded.push("Tipo de Pago").value
    if (!this.seller) not_finded.push("Vendedor")
    if (this.order_items == 0) not_finded.push("FALTAN PRODUCTOS")

    if (not_finded.length > 0) {
      alert(`FALTAN DATOS: ${not_finded.join(", ")}`)
      return false
    } else {
      return true
    }
  }

}

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll('#create_order').forEach( el => new Order(el));
});
