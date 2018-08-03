<template>
  <div v-if="isLoggedIn()" class="container">

    <div class="row">
      <div class="col-lg-12">
        <h3>Puzzle Pieces Administration</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-offset-10 col-lg-2 col-md-offset-10 col-md-2 col-sm-offset-6 col-sm-6">
        <button v-on:click="logout()" class="btn btn-sm btn-default">Log Out {{userFullName()}}</button>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
        <table class="table table-striped table-hover">
          <thead>
            <tr>
              <th class="center-align-table-cell">PuzzlePiece ID</th>
              <th class="center-align-table-cell">price</th>
              <th class="center-align-table-cell">Available</th>
              <th class="center-align-table-cell">Last Update</th>
              <th class="center-align-table-cell">Employer and Occupation</th>
              <th class="center-align-table-cell">PayPal Payment ID</th>
              <th class="center-align-table-cell">First Name</th>
              <th class="center-align-table-cell">Last Name</th>
              <th class="center-align-table-cell">Comments</th>
              <th class="center-align-table-cell">Edit</th>
            </tr>
          </thead>
          <tbody>

            <tr v-for="puzzlePiece in puzzlePieces">
              <td class="center-align-table-cell">{{puzzlePiece.puzzle_piece_id}}</td>
              <td class="center-align-table-cell">${{puzzlePiece.price}}</td>
              <td class="center-align-table-cell">{{availableOrTaken(puzzlePiece.is_available)}}</td>
              <td class="center-align-table-cell">{{puzzlePiece.last_update}}</td>
              <td class="center-align-table-cell">{{puzzlePiece.employer_and_occupation}}</td>
              <td class="center-align-table-cell">{{puzzlePiece.paypal_payment_id}}</td>
              <td class="center-align-table-cell">{{puzzlePiece.first_name}}</td>
              <td class="center-align-table-cell">{{puzzlePiece.last_name}}</td>
              <td class="center-align-table-cell">{{puzzlePiece.comments}}</td>
              <td>
                <button v-on:click="goToEditPuzzlePiece(puzzlePiece)" class="btn btn-sm btn-info">Edit</button>
              </td>

            </tr>

          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div v-else class="container">
    <div class="row">
      <div class="col-lg-12">
        <h1>ACCESS DENIED</h1>
      </div>
    </div>
  </div>

</template>

<script>
var errorMsgs = require('../util/errorMessages');

export default {
  data() {
    return {  puzzlePieces : []
    }
  },
  components: {
  },
  computed: {
  },
  methods: {

    isLoggedIn: function() { return this.$store.state.auth.isLoggedIn; },

    userFullName: function() {
      return this.$store.state.auth.firstName + " " + this.$store.state.auth.lastName;
    },

    logout: function() {
      this.$store.dispatch('auth/resetAuth');
      // unset the token to axios to make sure no unauthorized things happen
      this.$http.defaults.headers.common['Authorization'] = '';
      this.$router.push({name: "login"});  // redirect to the landing page
    },

    availableOrTaken: (status) => status ? "Available" : "Taken",

    goToEditPuzzlePiece: function (puzzlePiece){
      var params = {};
      params["puzzle_piece_id"] = puzzlePiece.puzzle_piece_id;

      this.$router.push({name: 'editPuzzlePiece', params: params});
    },


    getPuzzlePieces: function() {

      //console.log("LOADING Puzzle Pieces");
      var msg = {
        method: 'get',
        url: '/api/getPuzzlePieces',
        data: {}
      }

      this.$http(msg)
        .then((response) => {
          if (response.data.puzzlePieces ){
            this.puzzlePieces = response.data.puzzlePieces;
          }
        })
        .catch((error) => {
          errorMsgs.handleHttpErrors.call(this, error);
        });
    }


  },  // end of methods
  created() {
    this.getPuzzlePieces();
  }
}
</script>
