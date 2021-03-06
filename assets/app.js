
import axios from "axios";
import Vue from 'vue/dist/vue.js';
import Buefy from 'buefy';

import App from './js/App.vue';
import NavBar from './js/components/layout/NavBar.vue';

import "./sass/main.scss";


Vue.use(Buefy);

Vue.component('nav-bar', NavBar);

Vue.component('my-app', App);


const defaultState = {

};

axios.get('/global-vars').then((resp) => {
  window.global_vars = resp.data;
  new Vue({
    el: '#vue_app',
  
    data: defaultState
  });  
});