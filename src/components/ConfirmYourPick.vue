<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h1>We Are all a Piece of the Puzzle</h1>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <h3>Help support Tamara by sponsoring a piece of the puzzle</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
        <form v-on:submit.prevent="makePayment">

          <div class="form-group">
            <label>Employer and Occupation (Required)</label>
            <input v-model="puzzlePiece.employer_and_occupation" type="text" class="form-control" placeholder="Employer and Occupation (required)">
          </div>

          <button class="btn btn-primary">Sponsor the ${{puzzlePiece.price}} Piece</button>
        </form>

      </div>
    </div>
  </div>
</template>

<script>
var errorMsgs = require('../util/errorMessages');

export default {
  data() {
    return {
      puzzlePiece: null
    }
  },
  components: {
  },
  computed: {
  },
  methods: {

    // this field must be filled in.  Do not go to the payment field without it filled in
    verifyEmployerAndOccupation: function() {
      console.log("THIS WOULD BE VERIFICATION OF EMPLOYER");
    },

    makePayment: function() {
      console.log("THIS WOULD BE MAKING THE PAYMENT");
      var params = {};
      params["puzzle_piece"] = this.puzzlePiece;

      this.$router.push({name: 'makePayment', params: params});
    }

  },  // end of methods
  created() {
    this.puzzlePiece = this.$route.params.puzzle_piece;
  }
}
</script>
