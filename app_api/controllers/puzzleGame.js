var db = require('../models/db');
var env = require('get-env');
var chalk = require('chalk');
var util = require('util');
var helpers = require('./helpers');


module.exports.getPuzzlePieces = function (req, res) {

  db.pool.query("call get_puzzle_pieces()", function(err, rows, fields) {

  //console.log(chalk.green("err : " + util.inspect(err, false, null)));
  //console.log(chalk.green("rows : " + util.inspect(rows, false, null)));
  //console.log(chalk.green("fields : " + util.inspect(fields, false, null)));

    var data = {};
    data['puzzlePieces'] = [];
    data['errors'] = [];

    if (err) {
      helpers.sendJsonSQLErrorResponse("Error retrieving puzzle pieces from database",
                            "danger",
                            err,
                            data,
                            res);
    } else {
      data['puzzlePieces'] =  rows[0];
      helpers.sendJsonResponse(res, 201, data);
    }
  });
};


module.exports.getPuzzlePiece = function (req, res) {

  var puzzle_piece_id = req.params.puzzle_piece_id;

  db.pool.query("call get_puzzle_piece(?)", [puzzle_piece_id], function(err, rows, fields) {


  //console.log(chalk.green("err : " + util.inspect(err, false, null)));
  //console.log(chalk.green("rows : " + util.inspect(rows, false, null)));
  //console.log(chalk.green("fields : " + util.inspect(fields, false, null)));

    var data = {};
    data['puzzlePiece'] = [];
    data['errors'] = [];

    if (err) {
      helpers.sendJsonSQLErrorResponse("Error retrieving puzzle piece " + puzzle_piece_id + " from database",
                            "danger",
                            err,
                            data,
                            res);
    } else {
      data['puzzlePiece'] =  rows[0];
      helpers.sendJsonResponse(res, 201, data);
    }
  });
};

var checkForNull = function (value){
  return (value === '' ? null : value);
};

module.exports.updatePuzzlePiece = function (req, res) {

  console.log(chalk.green("updatePuzzlePiece req.body : " + util.inspect(req.body, false, null)));

  // this needs to be fixed to test for null and undefined and null or something like that

  if (!req.body.puzzle_piece_id === null)         { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): puzzle_piece_id param not passed"}); return;};
  if (req.body.is_available  === null)            { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): is_available param not passed"}); return;};
  if (!req.body.employer_and_occupation === null) { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): employer_and_occupation param not passed"}); return;};
  if (!req.body.paypal_payment_id === null)       { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): paypal_payment_id param not passed"}); return;};
  if (!req.body.first_name === null)              { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): first_name param not passed"}); return;};
  if (!req.body.last_name === null)               { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): last_name param not passed"}); return;};
  if (!req.body.comments === null)                { helpers.sendJsonResponse(res, 400, {"message": "updatePuzzlePiece(): comments param not passed"}); return;};

  let procArgs = [
    checkForNull( req.body.puzzle_piece_id ),
    checkForNull( req.body.is_available ),
    checkForNull( req.body.employer_and_occupation ),
    checkForNull( req.body.paypal_payment_id ),
    checkForNull( req.body.first_name ),
    checkForNull( req.body.last_name ),
    checkForNull( req.body.comments )
  ];


  db.pool.query("call update_puzzle_piece(?,?,?,?,?,?,?)", procArgs, function(err, rows, fields) {


  //console.log(chalk.green("err : " + util.inspect(err, false, null)));
  //console.log(chalk.green("rows : " + util.inspect(rows, false, null)));
  //console.log(chalk.green("fields : " + util.inspect(fields, false, null)));

    var data = {};
    data['puzzlePiece'] = [];
    data['errors'] = [];

    if (err) {
      helpers.sendJsonSQLErrorResponse("Error retrieving puzzle piece " + puzzle_piece_id + " from database",
                            "danger",
                            err,
                            data,
                            res);
    } else {
      data['puzzlePiece'] =  rows[0];
      helpers.sendJsonResponse(res, 201, data);
    }
  });
};
