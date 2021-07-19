<template>
  <div class="">
    <input
      type="text"
      placeholder="Buscar Usuario"
      class="rounded-lg px-4 py-1.5 w-1/2 shadow-lg"
    />
    <div class="bg-white">
      <table class="table w-full">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Cargo</th>
            <th>Estado</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  name: "UsersList",
  props: ["users"],
};
</script>