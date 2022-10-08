<script lang="ts">
export default {
  data() {
    return {
      items: [
        { label: "Home", icon: "pi pi-fw pi-home", to: "/" },
        { label: "Text", icon: "pi pi-fw pi-pencil", to: "/text" },
        {
          label: "Documentation",
          icon: "pi pi-fw pi-file",
          to: "/tabmenu/documentation",
        },
        { label: "Settings", icon: "pi pi-fw pi-cog", to: "/tabmenu/settings" },
      ],
    };
  },
};
</script>
<template>
  <TabMenu :model="items" />
</template>
