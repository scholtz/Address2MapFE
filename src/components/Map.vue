<template>
  <GoogleMap
    api-key="AIzaSyBPoqoXyye1-ndAe15SNDda2aeyMbkk4Uc"
    style="width: 100%; height: 800px"
    :center="center"
    :zoom="15"
  >
    <Marker
      v-for="pointer in pointers"
      :key="pointer.title"
      :options="{
        position: {
          lat: pointer.lat,
          lng: pointer.lng,
        },
      }"
    />
    <Button @click="tmpClick"></Button>
  </GoogleMap>
</template>

<script lang="ts">
import type IDataPoint from "@/interface/IDataPoint";
import { defineComponent, type PropType } from "vue";
import { GoogleMap, Marker } from "vue3-google-map";
interface IPointer {
  lat: number;
  lng: number;
  title: string;
  icon: any;
}
export default defineComponent({
  props: {
    datapoints: {
      type: Object as PropType<IDataPoint[]>,
      required: true,
    },
  },
  components: { GoogleMap, Marker },
  setup(props) {
    console.log("props.datapoints", props.datapoints);
    const center = {
      lat: props.datapoints[0].lat,
      lng: props.datapoints[0].lng,
    };
    const pointers = props.datapoints.map((dt) => {
      const point = {
        lat: dt.lat,
        lng: dt.lng,
        title: dt.address,
      } as IPointer;
      return point;
    });
    return { center, pointers };
  },
  watch: {},
  methods: {
    tmpClick() {
      console.log(this);
    },
  },
});
</script>
