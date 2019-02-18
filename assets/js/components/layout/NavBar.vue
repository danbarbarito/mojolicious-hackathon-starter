<template>
  <nav class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item" href="/">
        <img src="../../../img/logo.png" />
      </a>

      <a :class="{'is-active': openMenu}" @click="openMenu = !openMenu" role="button" class="navbar-burger burger"
        aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>

    <div :class="{'is-active': openMenu}" id="navbarBasicExample" class="navbar-menu">
      <div class="navbar-start">

        <!-- <a :class="{'is-active': activeRoute == '/'}" class="navbar-item">
          Home
        </a> -->

      </div>

      <div class="navbar-end">
        <div v-if="!user" :class="{'is-active': activeRoute == '/'}" class="navbar-item">
          <div class="buttons">
            <a :class="{'is-active': activeRoute == '/signup'}" href="/signup" class="button is-primary">
              <strong>Sign up</strong>
            </a>
            <a :class="{'is-active': activeRoute == '/login'}" href="/login" class="button is-light">
              Log in
            </a>
          </div>
        </div>
        <div v-if="user" class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link">
            Profile
          </a>

          <div class="navbar-dropdown">
            <a href="/logout" class="navbar-item">
              Logout
            </a>
          </div>
        </div>

        <div class="navbar-item">
            <a class="button is-primary is-outlined" href="https://github.com/danielbarbarito/mojolicious-hackathon-starter">
              <span class="icon">
                <i class="fab fa-github"></i>
              </span>
              <span title="Hello from the other side">View Source</span>
            </a>
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