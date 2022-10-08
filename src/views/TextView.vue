<script lang="ts">
import type { Mode, Theme } from "vue-diff/dist/types";
import axios from "axios";
import { defineComponent } from "vue";

import Map from "../components/Map.vue";
import type IDataPoint from "@/interface/IDataPoint";
import type ITextResponse from "@/interface/ITextResponse";

export default defineComponent({
  components: { Map },
  data() {
    return {
      mode: "split" as Mode,
      modeunified: "unified" as Mode,
      theme: "dark" as Theme,
      language: "text",
      prevEmpty: "",
      prev: "Zlatá ulička u Daliborky",
      current: "22222" as string,
      notes: "333" as string,
      folding: true,
      dataPoints: [] as IDataPoint[],
    };
  },
  watch: {
    async prev() {
      const formData = new FormData();
      formData.append("input", this.prev);
      const result = await axios.post(
        "https://address2map.h1.scholtz.sk/Address/CheckAddresses/554782",
        formData
      );
      if (result.status == 200) {
        const data = result.data as ITextResponse;
        if (data) {
          this.current = data.output;
          this.notes = data.notes;
          this.dataPoints = [];
        }
      }
    },
  },
  computed: {
    showMap() {
      const ret = this.dataPoints && this.dataPoints.length > 0;
      console.log("showmap", ret);
      return ret;
    },
  },
  methods: {
    async showMapClick() {
      const formData = new FormData();
      formData.append("input", this.prev + "");
      const result = await axios.post(
        "https://address2map.h1.scholtz.sk/Address/AddressesDataPoints/554782",
        formData
      );
      if (result.status == 200) {
        console.log("result.data", result.data);
        const data = JSON.parse(JSON.stringify(result.data)) as IDataPoint[];

        if (data) {
          console.log("data", data);
          this.dataPoints = data;
          console.log("this.dataPoints", this.dataPoints);
        }
      }
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
    <div class="m-2 flex-grow-1 flex" v-if="notes.trim() && prev.trim()">
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
    <div v-else class="m-2 flex-grow-1 flex flex-column">
      <Button
        v-if="!showMap"
        class="p-button-success mb-2"
        @click="showMapClick"
        >Your text is filled in correctly. Show it on the map</Button
      >
      <Map v-if="showMap" :datapoints="dataPoints"></Map>
    </div>
  </div>
</template>
