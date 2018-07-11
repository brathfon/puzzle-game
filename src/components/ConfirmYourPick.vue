<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3>For Iruri</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
        <PayPal
          amount="10.00"
          currency="USD"
          :client="credentials"
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

    getExampleData: function() {

      console.log("LOADING EXAMPLE DATA");
      var msg = {
        method: 'get',
        url: '/api/getExampleData',
        data: {}
      }

      this.$http(msg)
        .then((response) => {
          if (response.data.exampleData ){
            this.exampleData = response.data.exampleData;
          }
        })
        .catch((error) => {
          errorMsgs.handleHttpErrors.call(this, error);
        });
    }


  },  // end of methods
  created() {
    this.getExampleData();
  }
}
</script>
