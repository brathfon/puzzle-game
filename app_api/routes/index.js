var express = require('express');
var router = express.Router();
var jwt = require('express-jwt');
var auth = jwt({
  secret: process.env.JWT_SECRET,
  userProperty: 'payload'
});

//var ctrlExample = require('../controllers/exampleData');
var ctrlPuzzleGame = require('../controllers/puzzleGame');
var ctrlAuth = require('../controllers/authentication');
var logging = require('../controllers/logging');
var lookup = require('../controllers/lookupInformation');

/* water quality apis */
router.get('/getPuzzlePieces', ctrlPuzzleGame.getPuzzlePieces);
router.get('/getPuzzlePiece/:puzzle_piece_id', ctrlPuzzleGame.getPuzzlePiece);
router.put('/updatePuzzlePiece', auth, ctrlPuzzleGame.updatePuzzlePiece);
router.put('/buyPuzzlePiece', ctrlPuzzleGame.buyPuzzlePiece);

/* authentication */
router.post('/login', ctrlAuth.login);
router.post('/setPassword', auth, ctrlAuth.setPassword);
router.post('/createNewUser', ctrlAuth.createNewUser);

// lookup information
router.get('/getRoles', lookup.getRoles);

// logging
router.post('/insertLogMessage', logging.insertLogMessage);



module.exports = router;
