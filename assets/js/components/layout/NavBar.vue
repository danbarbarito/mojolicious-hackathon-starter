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
      <div :class="{'is-active': openMenu}" id="navbarMenu" class="navbar-menu">
        <div class="navbar-end">
          <div class="tabs is-right">
            <ul>
              <li :class="{'is-active': activeRoute == '/'}"><a href='/'>Home</a></li>
              <li v-if="!user" :class="{'is-active': activeRoute == '/login'}"><a href="/login">Login</a></li>
              <li v-if="!user" :class="{'is-active': activeRoute == '/signup'}"><a href="/signup">Sign Up</a></li>
              <li v-if="user" :class="{'is-active': activeRoute == '/logout'}"><a href="/logout">Logout</a></li>
            </ul>
            <span class="navbar-item">
              <a class="button is-primary is-outlined" href="https://github.com/danielbarbarito/mojolicious-hackathon-starter">
                <span class="icon">
                  <i class="fab fa-github"></i>
                </span>
                <span title="Hello from the other side">View Source</span>
              </a>
            </span>
            <span v-if="user" class="navbar-item">
              Hi, {{user.email}}
            </span>
          </div>
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