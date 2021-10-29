class ClientSearch {
  constructor(search_input){
    this.search_input = search_input
    this.search_results = document.getElementById('sp_search_results')
    this.initListeners()
  }

  initListeners() {
    this.search_input.addEventListener('keyup', (e) => {
      this.searchClients(e)
    })
    this.search_input.addEventListener('focusin', (e) => {
      this.search_results.classList.remove('hidden')
      this.searchClients(e)
    })
  }

  searchClients(e) {
    
    fetch(`/api/v1/clients?&full_data=${e.target.value}`, {
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

  selectClient(id) {
    fetch(`/api/v1/clients/${id}`, {
      method: 'GET',
      heaer: {
        'Content-Type': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      document.getElementById('order_client').dataset.id = data.id
      document.querySelector('.client-name').textContent = data.full_name
      document.querySelector('.client-address').textContent = data.full_address
    })
  }

  appendListenersToNewItems() {
    this.search_results.querySelectorAll('li').forEach((client) => {
      client.addEventListener('click', (e) => {
        this.search_input.value = e.target.textContent.trim()
        this.search_results.classList.add('hidden')
        this.selectClient(e.target.getAttribute('id'))
      })
    })
  }

  clearSearchResults() {
    results_container = this.search_results.querySelector('ul')
    while (results_container.firstChild) {
      results_container.removeChild(results_container.firstChild)
    }
  }

  buildResults(clients) {
    let results = ""

    clients.forEach((el) => {
      let element = `
        <li class='client-item hover:bg-gray-200 cursor-pointer' id="${el.id}">
          ${el.full_name}
        </li>`
        
      results += element
    })

    return results
  }

}

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll('#sp_search_client').forEach( el => new ClientSearch(el));
});
