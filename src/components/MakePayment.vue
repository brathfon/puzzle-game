<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3>For Iruri</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12" v-on:click="verifyEmployerAndOccupation()">
        <PayPal
          :amount="amount"
          currency="USD"
          :client="credentials"
          :invoice-number="invoice"
          v-on:payment-cancelled="paymentCancelled"
          v-on:payment-authorized="paymentAuthorized"
          v-on:payment-completed="paymentCompleted"
          env="sandbox">
        </PayPal>
      </div>
    </div>
  </div>
</template>

<script>
var errorMsgs = require('../util/errorMessages');
import PayPal from 'vue-paypal-checkout';

export default {
  data() {
    return {
      puzzlePiece: null,
      amount: null,
      invoice: null,
      isAuthorized: false,
      isCompleted: false,
      credentials: {
        sandbox: 'AQAjpL_QO1SFdti6tx7S6ajcIitqQjZiAhpJhRIQNxQ5xgB19-0p8KORtFWL0jel_QgdFUJnrmTZdxBS',
        production: 'prod-credentials-do-no-know-yet'
      }
    }
  },
  components: {
    PayPal
  },
  computed: {
  },
  methods: {

    updatePuzzlePiece: function(){

      this.$http.put('/api/updatePuzzlePiece/', this.puzzlePiece)
        .then((response) => {
          //console.log("INITIAL response ->  for " + index, response);
            this.$router.push({name: 'mahalo'});
        })
        .catch((error) => {
          //console.log("ERROR updating -> ", this.samples[index].long_name);
          errorMsgs.handleHttpErrors.call(this, error);
          this.$router.push({name: 'mahalo'});
        });
      },


    paymentCancelled: function(payload) {
      console.log("Payment was cancelled. Payload: ", payload);
    },

    paymentAuthorized: function(payload) {
      console.log("Payment was authorized. Payload: ", payload);
      this.isAuthorized = true;
    },

    paymentCompleted: function(payload) {
      console.log("Payment was completed. Payload: ", payload);
      this.isCompleted = true;
      this.puzzlePiece.paypal_payment_id = payload.transactions[0].related_resources[0].sale.id;
      this.puzzlePiece.first_name = payload.payer.payer_info.first_name;
      this.puzzlePiece.last_name = payload.payer.payer_info.last_name;
      this.puzzlePiece.is_available = 0;
      if (this.isAuthorized && this.isCompleted){
        this.updatePuzzlePiece();
        //this.$router.push({name: 'mahalo'});
      }
      else {
        this.$router.push({name: 'selectYourPiece'})
      }
    },

    goBack: function() {
      console.log("IN GOBACK");
      return;
      var params = {};
      params["puzzle_piece"] = this.puzzlePiece;

      this.$router.push({name: 'confirmYourPick', params: params});
    }

  },  // end of methods
  created() {
    console.log("VUE : ", this);
    console.log("process : ", process.env);

    this.puzzlePiece = this.$route.params.puzzle_piece;
    this.amount = this.puzzlePiece.price + ".00";
    this.invoice = "PUZZLE_ID_" + this.puzzlePiece.puzzle_piece_id + "_AMT_" + this.puzzlePiece.price;

    document.addEventListener("backbutton", this.goBack, false);
  },

  beforeDestroy () {
    document.removeEventListener("backbutton", this.goBack);
  }
}
</script>
