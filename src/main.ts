import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";
import VueDiff from "vue-diff";
import PrimeVue from "primevue/config";
import TabMenu from "primevue/tabmenu";
import Textarea from "primevue/textarea";
import Button from "primevue/button";

import "./assets/main.css";
import "vue-diff/dist/index.css";

const app = createApp(App);

app.use(PrimeVue);
app.use(VueDiff);
app.use(createPinia());
app.use(router);

app.component("TabMenu", TabMenu);
app.component("Textarea", Textarea);
app.component("Button", Button);

app.mount("#app");
