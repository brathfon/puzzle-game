<template>
  <div class="container">

    <div class="row">
      <div class="col-lg-12">
        <h1>We are all a piece of the puzzle.</h1>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <h3>Help contribute to Tamara'a campaign by sponsoring a piece of the puzzle.</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <h3>Make a difference by selecting the amount below that you would like to donate.</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <h3>Green are available. Gray are taken.</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <table class="table-cell-hover">
          <tbody>
            <tr v-for="(puzzlePieceRow) in puzzlePieceRows">
              <PuzzlePiece v-for="(puzzlePiece, id) in puzzlePieceRow" :key="id" v-bind:puzzlePiece="puzzlePiece"></PuzzlePiece>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</template>

<script>

import PuzzlePiece from "./PuzzlePiece.vue";

var errorMsgs = require('../util/errorMessages');

export default {
  data() {
    return {  puzzlePieces : [],
              puzzlePieceRows : [], // organized by rows of defaultNumColumns
              defaultNumColumns : 10
    }
  },
  components: {
    PuzzlePiece
  },
  computed: {
  },
  methods: {

    beginRow : function(index) {
      return ((index % this.defaultNumColumns) === 0) ? true : false;
    },

    endRow : function(index) {
      return ((index % (this.defaultNumColumns - 1)) === 0) ? true : false;
    },
    availableOrTaken: (status) => status ? "Available" : "Taken",

    organizeByRows: function() {
      let row = -1;
      let i = 0;
      for (i = 0; i < this.puzzlePieces.length; ++i) {
        if (this.beginRow(i)) {
          ++row;
          //console.log("NEW ROW ", row);
          this.puzzlePieceRows.push([]);
        }
        this.puzzlePieceRows[row].push(this.puzzlePieces[i]);
      }
    },

    getPuzzlePieces: function() {

      console.log("LOADING Puzzle Pieces");
      var msg = {
        method: 'get',
        url: '/api/getPuzzlePieces',
        data: {}
      }

      this.$http(msg)
        .then((response) => {
          if (response.data.puzzlePieces ){
            this.puzzlePieces = response.data.puzzlePieces;
            this.organizeByRows();
          }
        })
        .catch((error) => {
          errorMsgs.handleHttpErrors.call(this, error);
        });
    }


  },  // end of methods
  created() {
    this.getPuzzlePieces();
  }
}
</script>
