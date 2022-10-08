<script lang="ts">
import type { Mode, Theme } from "vue-diff/dist/types";
import axios from "axios";
import { defineComponent } from "vue";

interface ITextResponse {
  input: string;
  output: string;
  notes: string;
}

export default defineComponent({
  data() {
    return {
      mode: "split" as Mode,
      modeunified: "unified" as Mode,
      theme: "dark" as Theme,
      language: "text",
      prevEmpty: "",
      prev: "111",
      current: "22222" as string,
      notes: "333" as string,
      folding: true,
    };
  },
  watch: {
    async prev() {
      const formData = new FormData();
      formData.append("input", this.prev + "");
      const result = await axios.post(
        "https://address2map.h1.scholtz.sk/Address/CheckAddresses/554782",
        formData
      );
      if (result.status == 200) {
        const data = result.data as ITextResponse;
        if (data) {
          this.current = data.output + "";
          this.notes = data.notes + "";
        }
      }
      console.log("result", result);
    },
  },
});
</script>

<template>
  <div class="about flex flex-grow-1 flex-row flex-auto gap-1">
    <Textarea class="m-2 flex-grow-1 flex" v-model="prev"></Textarea>
    <div class="m-2 flex-grow-1 flex">
      <Diff
        :theme="theme"
        :language="language"
        :input-delay="10"
        :prev="prev"
        :current="current"
        :folding="folding"
        :virtual-scroll="{ height: 600, lineMinHeight: 24, delay: 100 }"
      />
    </div>
    <div class="m-2 flex-grow-1 flex">
      <Diff
        :theme="theme"
        :language="language"
        :input-delay="10"
        :prev="prevEmpty"
        :current="notes"
        :folding="folding"
        :mode="modeunified"
        :virtual-scroll="{ height: 600, lineMinHeight: 24, delay: 100 }"
      />
    </div>
    <!---->
  </div>
</template>
