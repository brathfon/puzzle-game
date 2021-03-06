var logging = require('./logging');

var createSimpleErrorMsg = function(title, level) {
  var errorMsg = {};
  errorMsg['title'] = title;
  errorMsg['level'] = level;
  errorMsg['text'] = [];
  return errorMsg;
};

var commitMsgAndLogIt = function(error) {
  this.$store.commit('systemErrors/addError', error, {
    root: true
  });
  logging.sendLogMessage.call(this, error);
};

var displayAndLogSimpleErrorMessage = function(title, level) {
  var msgObj = createSimpleErrorMsg(title, level);
  commitMsgAndLogIt.call(this, msgObj);
}

var handleHttpErrors = function(error) {
  var errorMsgText;
  var errorMsgObj;
  var i;
  if (error.response) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx
    errorMsgText = '';
    // is error is known, generated by API. 500 level are sql errors and
    // could come with an array of errors, but usually only one.
    if ((error.response.status === 500) && (error.response.data.errors)) {
      for (i = 0; i < error.response.data.errors.length; ++i) {
        commitMsgAndLogIt.call(this, error.response.data.errors[i]);
      }
    } else if ((error.response.status === 400) && (error.response.data.message)) {
      errorMsgText += error.response.data.message;
      errorMsgObj = createSimpleErrorMsg(errorMsgText, "danger");
      commitMsgAndLogIt.call(this, errorMsgObj);
    } else { // not known from the API
      errorMsgText += "Error";
      if (error.response.status) {
        errorMsgText += " status = " + error.response.status;
      }
      if (error.response.statusText) {
        errorMsgText += " " + error.response.statusText;
      }
      errorMsgObj = createSimpleErrorMsg(errorMsgText, "danger");
      commitMsgAndLogIt.call(this, errorMsgObj);
    }
  } else if (error.request) {
    // The request was made but no response was received
    // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
    // http.ClientRequest in node.js
    errorMsgObj = createSimpleErrorMsg("The request was made but no response was received", "danger");
    commitMsgAndLogIt.call(this, errorMsgObj);
  } else {
    // Something happened in setting up the request that triggered an Error
    console.log('error.message', error.message);
    errorMsgObj = createSimpleErrorMsg("Error handling API request: " + error.message, "danger");
    commitMsgAndLogIt.call(this, errorMsgObj);

  }

};

export {
  createSimpleErrorMsg,
  handleHttpErrors,
  displayAndLogSimpleErrorMessage
};
