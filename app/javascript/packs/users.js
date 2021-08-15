class UserSearch {
  constructor(){
    this.search_input = document.getElementById('input_search_users')
    this.initListeners()
  }

  initListeners(){
    this.search_input.addEventListener('keyup', (e) => {
      console.log(e.target.value)
    })
  }
}

document.addEventListener("turbolinks:load", () => {
  new UserSearch
});
