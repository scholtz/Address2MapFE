<script lang="ts">
export default {
  data() {
    return {
      items: [
        { label: "Home", icon: "pi pi-fw pi-home", to: "/" },
        { label: "Text", icon: "pi pi-fw pi-pencil", to: "/text" },
      ],
    };
  },
};
</script>
<template>
  <TabMenu :model="items" />
</template>
