<template>
  <GoogleMap
    api-key="AIzaSyBPoqoXyye1-ndAe15SNDda2aeyMbkk4Uc"
    style="width: 100%; height: 600px"
    :center="center"
    :zoom="15"
  >
    <Marker
      v-for="pointer in pointers"
      :key="pointer.title"
      :options="{
        position: { lat: pointer.lat, lng: pointer.lng },
        icon: pointer.icon,
      }"
    />
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
    //       path: "M10.453 14.016l6.563-6.609-1.406-1.406-5.156 5.203-2.063-2.109-1.406 1.406zM12 2.016q2.906 0 4.945 2.039t2.039 4.945q0 1.453-0.727 3.328t-1.758 3.516-2.039 3.070-1.711 2.273l-0.75 0.797q-0.281-0.328-0.75-0.867t-1.688-2.156-2.133-3.141-1.664-3.445-0.75-3.375q0-2.906 2.039-4.945t4.945-2.039z",

    const svgMarker = {
      path: "M 1 1 H 9 V 9 H 1 L 1 1",
      fillColor: "red",
      fillOpacity: 0.5,
      strokeWeight: 0,
      rotation: 0,
      scale: 1,
    };
    const pointers = props.datapoints.map((dt) => {
      const point = {
        lat: dt.lat,
        lng: dt.lng,
        title: dt.address,
        icon: svgMarker,
      } as IPointer;
      return point;
    });
    return { center, pointers };
  },
  watch: {},
});
</script>
