<template>
  <nav class="navbar">
    <div class="container">
      <div class="navbar-brand">
        <a class="navbar-item" href="../">
          <img src="../../../img/logo.png" />
        </a>
        <span :class="{'is-active': openMenu}" @click="openMenu = !openMenu" class="navbar-burger burger" data-target="navbarMenu">
          <span></span>
          <span></span>
          <span></span>
        </span>
      </div>
      <div :class="{'is-active': openMenu}" id="navbarMenu" class="navbar-menu ">
        <div class="navbar-end">

          <a class="navbar-item" href='/'>Home</a>
          <a v-if="!user" :class="{'is-active': activeRoute == '/login'}" class="navbar-item" href='/login'>Login</a>
          <a v-if="!user" :class="{'is-active': activeRoute == '/signup'}" class="navbar-item" href='/signup'>Sign Up</a>
          <div style="align-items: center" v-if="user" class="navbar-item has-dropdown">
           <b-dropdown>
              <a slot="trigger" class="navbar-link" href="#">Profile</a>
              <b-dropdown-item><a href="/logout">Logout</a></b-dropdown-item>
            </b-dropdown>
          </div>
          <span class="navbar-item">
            <a class="button is-primary is-outlined" href="https://github.com/danielbarbarito/mojolicious-hackathon-starter">
              <span class="icon">
                <i class="fab fa-github"></i>
              </span>
              <span title="Hello from the other side">View Source</span>
            </a>
          </span>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
  export default {
    data() {
      return {
        user: window.global_vars['current-user'],
        openMenu: false,
        activeRoute: window.location.pathname
      }
    }
  }
</script>