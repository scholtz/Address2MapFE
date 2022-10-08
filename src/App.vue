<script setup lang="ts">
import { RouterLink, RouterView } from "vue-router";
import Menu from "./components/Menu.vue";
</script>

<template>
  <div class="App flex-grow-1 flex flex-column flex-auto">
    <Menu />
    <RouterView />
  </div>
</template>
