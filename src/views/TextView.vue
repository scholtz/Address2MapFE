<script lang="ts">
import type { Mode, Theme } from "vue-diff/dist/types";
import axios from "axios";
import { defineComponent } from "vue";

import Map from "../components/Map.vue";
import type IIDataPoint from "@/interface/IIDataPoint";
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
      loaded: false,
      prev: `Základní škola Brána jazyků s rozšířenou výukou matematiky 
!sídlo: Praha 1, Uhelný trh 4/425 
28. října 
Alšovo nábřeží           
Anenská     
Anenské náměstí 
Bartolomějská 
Betlémská 
Betlémské náměstí 
Boršov  
Celetná – sudá č.  
Černá 
Divadelní 
Havelská 
Havelská ulička 
Havířská 
Husova 
Jalovcová 
Jilská 
Jungmannovo náměstí 
Kamzíková 
Kaprova – sudá č. 
Karlova 
Karolíny Světlé 
Konviktská 
Kožná 
Krocínova 
Křemencova 
Křižovnická 
Křižovnické náměstí 
Liliová 
Linhartská 
Malé náměstí   
Mariánské náměstí  
Martinská 
Masarykovo nábřeží - č. 12 – 38 
Melantrichova 
Michalská  
Mikulandská 
Mikulášská   
Myslíkova – lichá č. 
Na Můstku 
Na Perštýně                                                       
Na příkopě – lichá č. 
Na struze 
Na zábradlí 
Náprstkova 
Národní 
Novotného lávka 
Opatovická 
Ostrovní 
Ovocný trh 
Perlová 
Platnéřská 
Provaznická 
Průchodní 
Pštrossova 
Purkyňova 
Rytířská 
Řetězová 
Seminářská 
Skořepka 
Slovanský ostrov 
Smetanovo nábřeží 
Spálená – lichá č. a sudá č. 4 – 18 
Stříbrná 
Šítkova 
U Dobřenských 
U radnice 
Uhelný trh 
V Jirchářích 
V kotcích 
Valentinská - č. 1 – 9, 11 
Vejvodova 
Veleslavínova 
Vojtěšská 
Voršilská 
Zlatá 
Žatecká - č. 1 – 4, 6 
Železná 

Základní škola náměstí Curieových   
!sídlo: Praha 1, náměstí Curieových 2/886 
17. listopadu 
Anežská                                                        
Benediktská 
Bílkova 
Břehová 
Celetná – lichá č. 
Červená 
Dlouhá 
Dušní 
Dvořákovo nábřeží 
Elišky Krásnohorské 
Haštalská 
Haštalské náměstí 
Hradební 
Jáchymova 
Jakubská 
Kaprova – lichá č. 
Klášterská 
Kostečná 
Kozí 
Králodvorská 
Maiselova 
Malá Štupartská 
Masná 
Na Františku 
Na Rejdišti 
náměstí Curieových
Nám. Franze Kafky
náměstí Jana Palacha 
náměstí Republiky – č. p. 1081, 660, 1090 
Pařížská 
Rámová 
Revoluční – lichá č. 
Rybná 
Řásnovka 
Salvátorská 
Staroměstské náměstí 
Široká 
Štupartská 
Templová 
Týn 
Týnská 
Týnská ulička 
U Milosrdných 
U Obecního domu 
U obecního dvora 
U Prašné brány 
U staré školy 
U starého hřbitova 
U Svatého ducha 
V kolkovně 
Valentinská – č. 10, 12 – 14 
Vězeňská 
Za Haštalem 
Žatecká – č. 5, 7 – 10, 12, 14 `,
      current: "" as string,
      notes: "" as string,
      folding: true,
      dataPoints: [] as IIDataPoint[],
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
          this.loaded = true;
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
        const data = JSON.parse(JSON.stringify(result.data)) as IIDataPoint[];

        if (data) {
          console.log("data", data);
          this.dataPoints = data;
          console.log("this.dataPoints", this.dataPoints);
        }
      }
    },
    toClipboard() {
      navigator.clipboard.writeText(this.current);
    },
  },
});
</script>

<template>
  <div class="about flex flex-grow-1 flex-row flex-auto gap-1">
    <div class="m-2 flex-grow-1 flex flex-column">
      <h2>Original with lines</h2>
      <Textarea
        class="m-2 flex flex-column flex-grow-1"
        v-model="prev"
        style="min-height: 600px"
      ></Textarea>
    </div>
    <div
      class="m-2 flex-grow-1 flex flex-column"
      v-if="notes.trim() && prev.trim()"
    >
      <h2>Original with lines</h2>
      <Diff
        :theme="theme"
        :language="language"
        :input-delay="10"
        :prev="prevEmpty"
        :current="prev"
        :folding="folding"
        :mode="modeunified"
        :virtual-scroll="{ height: 600, lineMinHeight: 24, delay: 100 }"
      />
    </div>
    <div v-if="loaded" class="m-2 flex-grow-1 flex flex-column">
      <h2>Diff</h2>
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
    <div
      class="m-2 flex-grow-1 flex flex-column"
      v-if="loaded && notes.trim() && prev.trim()"
    >
      <h2>Proposal</h2>
      <Button v-if="loaded" class="p-button-primary mb-2" @click="toClipboard"
        >Copy to cliboard proposed text</Button
      >
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
    <div
      v-if="loaded && !(notes.trim() && prev.trim())"
      class="m-2 flex-grow-1 flex flex-column"
    >
      <h2>Display map</h2>
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
