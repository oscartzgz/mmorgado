<template>
  <div>
    <!-- <add-user-button></add-user-button>
    <users-list></users-list> -->
    <new-user-form></new-user-form>
  </div>
</template>
<script>
import AddUserButton from "./AddUserButton.vue";
import UsersList from "./UsersList.vue";
import NewUserForm from "./NewUserForm.vue";

export default {
  components: {
    AddUserButton,
    UsersList,
    NewUserForm,
  },
  name: "Index",
  data: function () {
    return {};
  },
};
</script>