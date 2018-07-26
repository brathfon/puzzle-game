<template>
      <div>
        <form v-on:submit.prevent="simulate">
          <button class="btn btn-primary">Simulate PayPal Payment</button>
        </form>
      </div>
</template>

<script>
var errorMsgs = require('../util/errorMessages');

export default {
  data() {
    return {
      last_name: "Simulated Last Name",
      first_name: "Simulated First Name",
      paypal_payment_id: "SIM_PAYPAL_ID"
    }
  },
  components: {
  },
  computed: {

  },
  methods: {

    simulate: function() {
      console.log("BEGIN SIMULATION");
      this.$emit('payment-authorized', {payload: "simulated"});
      let authPayload = {};
      authPayload['transactions'] = [];
      authPayload['transactions'].push({});
      authPayload.transactions[0]['related_resources'] = [];
      authPayload.transactions[0].related_resources.push({});
      authPayload.transactions[0].related_resources[0]['sale'] = {};
      authPayload.transactions[0].related_resources[0].sale['id'] = this.paypal_payment_id;

      // add in payer information
      authPayload['payer'] = {};
      authPayload.payer['payer_info'] = {};
      authPayload.payer.payer_info['first_name'] = this.first_name;
      authPayload.payer.payer_info['last_name'] = this.last_name

      this.$emit('payment-completed', authPayload);
    }

  },  // end of methods
  created() {
  }
}
</script>
