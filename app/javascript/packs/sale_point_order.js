var toCurrency = require('./utils').toCurrency

class Order {
  constructor(button){
    this.button = button
    this.search_results = document.getElementById('sp_search_product_results')
    this.table = document.getElementById('sale_products_list')
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
    // this.search_input.addEventListener('focusin', (e) => {
    //   this.search_results.classList.remove('hidden')
    //   this.searchProducts(e)
    // })
  }

  createOrder(e) {
    console.log(`validation is: ${this.validateData()}`)
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
