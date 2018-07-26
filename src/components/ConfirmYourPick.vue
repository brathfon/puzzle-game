<template>
  <div class="container">

    <div class="row">
      <div class="col-lg-12">
        <h1>We are all a piece of the puzzle.</h1>
      </div>
    </div>


    <div class="row">
      <div class="col-md-12">
        <form v-on:submit.prevent="makePayment">

          <div class="form-group" v-bind:class="jobInfoWarningClass()">
            <label class="control-label">Employer and Occupation (Required)</label>
            <input v-model="employer_and_occupation" type="text" class="form-control" placeholder="Employer and Occupation">
            <div v-if="jobInfoBlankUponSubmission()" class="text-danger">You must include your Employer and Occupation</div>
          </div>

          <button class="btn btn-primary">Sponsor the ${{price}} Piece</button>
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
      puzzle_piece_id: null,
      price: null,
      employer_and_occupation: "",
      jobInfoFilledOut: "NOT_YET",
    }
  },
  components: {
  },
  computed: {

  },
  methods: {

    jobInfoBlankUponSubmission: function () {
      return this.jobInfoFilledOut === "NO";
    },

    jobInfoWarningClass: function () {
      return this.jobInfoFilledOut === "NO" ? "has-error" : "";
    },

    makePayment: function() {
      console.log("THIS WOULD BE MAKING THE PAYMENT");
      if (this.employer_and_occupation === null ||
          this.employer_and_occupation === "") {
          this.jobInfoFilledOut = "NO";
      }
      else {
        this.jobInfoFilledOut = "YES";
        var params = {};
        params["puzzle_piece_id"] = this.puzzle_piece_id;
        params["price"] = this.price;
        params["employer_and_occupation"] = this.employer_and_occupation;


        this.$router.push({name: 'makePayment', params: params});
      }
    }

  },  // end of methods
  created() {
    this.puzzle_piece_id = this.$route.params.puzzle_piece_id;
    this.price = this.$route.params.price;
  }
}
</script>
