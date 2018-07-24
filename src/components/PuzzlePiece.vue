<template>
  <td v-bind:class="background()"
      v-on:click="wasSelected()"
      class="puzzle-piece center-align-table-cell">
    ${{puzzlePiece.price}}
  </td>
</template>

<script>

//${{puzzlePiece.price}}
export default {

  methods: {
    background: function() {
      var returnValue = "";
      // use the id from the database like an index to generate a number
      // to specify one of the 4 rotated puzzle piece images.  The id starts
      // with 1, not 0, so subtract one.

      var puzzleNum = (this.puzzlePiece.puzzle_piece_id - 1) % 4;
      if (this.puzzlePiece.is_available) {
        returnValue = "puzzle-piece-available-" + puzzleNum;
      }
      else {
        returnValue = "puzzle-piece-taken-" + puzzleNum;
      }
      return returnValue;
    },

    wasSelected: function() {
      console.log("Select puzzle piece with id ", this.puzzlePiece.puzzle_piece_id);
      if (this.puzzlePiece.is_available) {
        var params = {};
        params["puzzle_piece"] = this.puzzlePiece;

        this.$router.push({name: 'confirmYourPick', params: params});
      }
    }


  }, // end of methods
  props: ['puzzlePiece']
}
</script>
