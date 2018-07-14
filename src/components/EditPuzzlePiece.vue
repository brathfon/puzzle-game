<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3>Edit Puzzle Piece ID of {{puzzle_piece_id}}, ${{puzzlePiece.price}}</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
      </div>
    </div>

    <form>

      <fieldset class="form-group">
        <legend>Status</legend>
        <div class="form-check">
          <label class="form-check-label">
            <input type="radio" v-model="puzzlePiece.is_available" value="1" class="form-check-input" name="statusRadios" id="statusRadio1">
            Available
          </label>
        </div>
        <div class="form-check">
          <label class="form-check-label">
            <input type="radio" v-model="puzzlePiece.is_available" value="0" class="form-check-input" name="statusRadios" id="statusRadio2">
            Taken
          </label>
        </div>
      </fieldset>


      <div class="form-group">
        <label>Employer and Occupation (Required)</label>
        <input v-model="puzzlePiece.employer_and_occupation" type="text" class="form-control" placeholder="Employer and Occupation (required)">
      </div>
      <div class="form-group">
        <label>First Name</label>
        <input v-model="puzzlePiece.first_name" type="text" class="form-control" placeholder="First Name">
      </div>
      <div class="form-group">
        <label>Last Name</label>
        <input v-model="puzzlePiece.last_name" type="text" class="form-control" placeholder="Last Name">
      </div>

      <div class="form-group">
        <label>PayPal Payment ID</label>
        <input v-model="puzzlePiece.paypal_payment_id" type="text" class="form-control" aria-describedby="paypalNote" placeholder="PayPal Payment ID">
        <small id="paypalNote" class="form-text text-muted">Usually filled in automatically after PayPal payment</small>
      </div>


    </form>

  </div>
</template>

<script>
var errorMsgs = require('../util/errorMessages');

export default {
  data() {
    return {  puzzle_piece_id :null,
              puzzlePiece : {}
    }
  },
  components: {
  },
  computed: {
  },
  methods: {

    goToEditPuzzlePiece: function (puzzlePiece){
      var params = {};
      params["puzzle_piece_id"] = puzzlePiece.puzzle_piece_id;

      this.$router.push({name: 'samplesForSession', params: params});
    },


    getPuzzlePiece: function() {

      console.log("Editing Puzzle Piece");
      var msg = {
        method: 'get',
        url: '/api/getPuzzlePiece/' + this.puzzle_piece_id,
        data: {}
      }

      this.$http(msg)
        .then((response) => {
          if (response.data.puzzlePiece){
            this.puzzlePiece = response.data.puzzlePiece[0];  // returns array of length 1, so grap first element
          }
        })
        .catch((error) => {
          errorMsgs.handleHttpErrors.call(this, error);
        });
    }


  },  // end of methods
  created() {
    this.puzzle_piece_id = this.$route.params.puzzle_piece_id;
    this.getPuzzlePiece();
  }
}
</script>
