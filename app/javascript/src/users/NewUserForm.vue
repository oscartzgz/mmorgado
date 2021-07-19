<template>
  <div
    class="
      flex
      items-center
      justify-center
      fixed
      top-0
      right-0
      bottom-0
      left-0
      bg-black bg-opacity-50
    "
  >
    <div class="container bg-white max-w-3xl rounded-md shadow-lg">
      <div class="header flex justify-between px-5 py-4 border-b">
        <div class="font-bold">Agregar Usuario</div>
        <button
          class="
            border border-red-500
            text-red-500
            rounded-md
            px-5
            font-bold
            shadow
          "
        >
          Cerrar
        </button>
      </div>
      <div class="body p-5">
        <form action="">
          <div class="flex gap-3">
            <div class="flex-1">
              <label for="">Nombre</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <label for="">Apellido Paterno</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <label for="">Apellido Materno</label>
              <input type="text" />
            </div>
          </div>

          <div class="flex gap-3">
            <div class="flex-1">
              <label for="">Código Postal</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <label for="">Estado</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <label for="">Municipio/Alcaldía</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <label for="">No Teléfono Móvil</label>
              <input type="text" />
            </div>
          </div>

          <div class="flex gap-3">
            <div class="flex-1">
              <label for="">Colonia</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <label for="">Calle</label>
              <input type="text" />
            </div>
            <div class="flex-1">
              <div class="flex gap-3">
                <div class="flex-1">
                  <label for="">No Ext</label>
                  <input type="text" />
                </div>
                <div class="flex-1">
                  <label for="">No Int</label>
                  <input type="text" />
                </div>
              </div>
            </div>
            <div class="flex-1">
              <label for="">Telefono Fijo</label>
              <input type="text" />
            </div>
          </div>

          <hr />
          <br />

          <div class="flex gap-3">
            <div class="flex-1 text-center">
              <label for="">¿Utilizará el sistema?</label>
              <input type="checkbox" name="" id="" />

              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="icon icon-tabler icon-tabler-user"
                width="120"
                height="120"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="#2c3e50"
                fill="none"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <circle cx="12" cy="7" r="4" />
                <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
              </svg>
            </div>

            <div class="flex-1">
              <select name="" id="">
                <option value="">CARGO</option>
              </select>
            </div>

            <div class="flex-1 text-right">
              <div class="flex-column system-user text-left">
                <div>
                  <label for="" class="text-sm">Nombre de Usuario</label>
                  <input type="text" />
                </div>

                <div>
                  <label for="" class="text-sm">Contraseña</label>
                  <input type="password" />
                </div>
                <div>
                  <label for="" class="text-sm">Repetir Contraseña</label>
                  <input type="password" />
                </div>
              </div>

              <button
                class="
                  mt-3
                  border border-green-600
                  text-green-700
                  px-7
                  py-1
                  font-bold
                  rounded
                  shadow
                  hover:bg-green-600
                  hover:text-white
                "
              >
                Agregar
              </button>
            </div>
          </div>
        </form>
      </div>
      <div class="footer"></div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.icon-tabler-user {
  fill: blue;
  stroke: blue;
  margin: 0 auto;
}
</style>