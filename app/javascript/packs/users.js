class UserSearch {
  constructor(search_input){
    this.search_input = search_input
    this.initListeners()
  }

  initListeners(){
    this.search_input.addEventListener('keyup', (e) => {
      console.log(e.target.value)
    })
  }
}

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll('#input_search_users').forEach( el => new UserSearch(el));
});
