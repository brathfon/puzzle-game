<template>
  <div class="container">

    <div class="row">
       <div class="col-md-offset-3 col-md-6">
       <error-alerts v-if="haveErrors" v-bind:errors="envErrors" v-on:reset-error="resetError"></error-alerts>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <h1 class="text-center">We are all a piece of the puzzle.</h1>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-offset-5 col-lg-2 paypal-button">
        <PayPal
          :amount="amount"
          currency="USD"
          :client="credentials"
          :invoice-number="invoice"
          v-on:payment-cancelled="paymentCancelled"
          v-on:payment-authorized="paymentAuthorized"
          v-on:payment-completed="paymentCompleted"
          :env="paypalEnv">
        </PayPal>
      </div>
    </div>

    <div v-if="showPayPalSimulator()" class="row">
      <div class="col-lg-offset-5 col-lg-2 col-md-offset-5 col-md-2 paypal-simu-button">
        <PayPalSimulator
          v-on:payment-cancelled="paymentCancelled"
          v-on:payment-authorized="paymentAuthorized"
          v-on:payment-completed="paymentCompleted">
        </PayPalSimulator>
      </div>
    </div>

  </div>
</template>

<script>
var errorMsgs = require('../util/errorMessages');
import PayPal from 'vue-paypal-checkout';
import PayPalSimulator from './PayPalSimulator.vue';
import ErrorAlerts from './ErrorAlerts.vue';


export default {
  data() {
    return {
      puzzle_piece_id: null,
      price: null,
      employer_and_occupation: null,

      paypal_payment_id: null,
      first_name: null,
      last_name: null,
      amount: null,  // for display
      invoice: null,  // passed to PayPal to make things easier to track on invoices
      isAuthorized: false,
      isCompleted: false,
      paypalEnv: "",
      credentials: {
        sandbox: 'AQAjpL_QO1SFdti6tx7S6ajcIitqQjZiAhpJhRIQNxQ5xgB19-0p8KORtFWL0jel_QgdFUJnrmTZdxBS',
        production: 'prod-credentials-do-no-know-yet'
      },
      envErrors: []
    }
  },
  components: {
    PayPal, PayPalSimulator, ErrorAlerts
  },
  computed: {
    haveErrors : function() {
      return this.envErrors.length > 0;
    }
  },
  methods: {

    showPayPalSimulator: function() {
      return (process.env.SIMULATE_PAYPAL_SANDBOX !== undefined &&
              process.env.SIMULATE_PAYPAL_SANDBOX === "yes");
    },

    buyPuzzlePiece: function(){

      console.log("Buying the puzzle piece now");

      var params = {};
      params["puzzle_piece_id"] = this.puzzle_piece_id;
      params["employer_and_occupation"] = this.employer_and_occupation;
      params["paypal_payment_id"] = this.paypal_payment_id;
      params["first_name"] = this.first_name;
      params["last_name"] = this.last_name;



      this.$http.put('/api/buyPuzzlePiece/', params)
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
      this.paypal_payment_id = payload.transactions[0].related_resources[0].sale.id;
      this.first_name = payload.payer.payer_info.first_name;
      this.last_name = payload.payer.payer_info.last_name;
      if (this.isAuthorized && this.isCompleted){
        this.buyPuzzlePiece();
      }
      else {
        this.$router.push({name: 'selectYourPiece'})
      }
    },

    resetError : function(id) {
      this.envErrors.splice(id, 1);
    },

    // resets all errors by assigning an empty array
    resetErrors : function() {
     this.envErrors = [];
   },

   checkEnvVar: function (envVar) {
     var msg = "";
     var returnValue = false;
     if (process.env[envVar] === null || process.env[envVar] === undefined) {
       msg = envVar + " is null or undefined";
       this.envErrors.push(errorMsgs.createSimpleErrorMsg(msg, "danger"));
     }
     else if (process.env[envVar] === "UNSET"){
       msg = envVar + " is \'UNSET\'";
       this.envErrors.push(errorMsgs.createSimpleErrorMsg(msg, "danger"));
     }
     else if (process.env[envVar].length > 0) {
       returnValue = true;
     }
     return returnValue;
   }

  },  // end of methods
  created() {
    console.log("VUE : ", this);
    console.log("process : ", process.env);
    // params past in
    this.puzzle_piece_id = this.$route.params.puzzle_piece_id;
    this.price = this.$route.params.price;
    this.employer_and_occupation = this.$route.params.employer_and_occupation;

    // derived for display
    this.amount = this.price + ".00";

    // sent to Paypal to make things easyer to track on invoices
    this.invoice = "PUZZLE_ID_" + this.puzzle_piece_id + "_AMT_" + this.price;

    if (this.checkEnvVar("PAYPAL_ENV")) {
      this.paypalEnv = process.env.PAYPAL_ENV;
    }

    if (this.checkEnvVar("PAYPAL_PRODUCTION_CREDENTIALS")) {
      this.credentials.production = process.env.PAYPAL_PRODUCTION_CREDENTIALS;
    }

    if (this.checkEnvVar("PAYPAL_SANDBOX_CREDENTIALS")) {
      this.credentials.sandbox = process.env.PAYPAL_SANDBOX_CREDENTIALS;
    }

    // now check to see if the environmental variables are set.

  }

}
</script>
