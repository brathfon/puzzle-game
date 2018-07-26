<template>
  <div class="navbar navbar-inverse navbar-fixed-top puzzle-banner">
   <div class="container">
     <div class="navbar-header">
       <a href="/" class="navbar-brand puzzle-banner-text " >Tamara Paltin</a>
     </div>
     <div id="navbar-main" class="navbar-collapse collapse">
       <ul class="nav navbar-nav navbar-right">
         <li v-if="showLogout">
           <a href="/#" class="puzzle-banner-text" v-on:click="logout">Logout {{userFullName}}</a>
         </li>
       </ul>
     </div>
   </div>
 </div>
</template>

<script>
  export default {
    computed: {
      showLogout() { return this.$store.state.auth.isLoggedIn; },
      userFullName() {
        return this.$store.state.auth.firstName + " " + this.$store.state.auth.lastName;
      }
    },
    methods: {
      logout: function() {
        this.$store.dispatch('auth/resetAuth');
        // unset the token to axios to make sure no unauthorized things happen
        this.$http.defaults.headers.common['Authorization'] = '';
        this.$router.push({name: "login"});  // redirect to the landing page
      }
    }
  }
</script>
