// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// To access by assetp_pack_tag
function importAll(r) {
 r.keys().forEach(r);
}
// Add relevant file extensions as needed below.
// I'm sure there is a better way :shrug:
importAll(require.context('../images/', true, /\.(svg|jpg|png)$/));

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
