import Login from '../components/Login.vue';
//import LandingPage from '../components/LandingPage.vue';
import AdminOverview from '../components/AdminOverview.vue';
import EditPuzzlePiece from '../components/EditPuzzlePiece.vue';
import ConfirmYourPick from '../components/ConfirmYourPick.vue';
import MakePayment from '../components/MakePayment.vue';
import Mahalo from '../components/Mahalo.vue';
import SelectYourPiece from '../components/SelectYourPiece.vue';




export default [
  {path: '/', component: SelectYourPiece, name: 'selectYourPiece'},
  {path: '/login', component: Login, name: 'login'},
  {path: '/adminOverview', component: AdminOverview, name: 'adminOverview'},
  {path: '/editPuzzlePiece/:puzzle_piece_id', component: EditPuzzlePiece, name: 'editPuzzlePiece'},
  {path: '/confirmYourPick/:puzzle_piece_id/:price', component: ConfirmYourPick, name: 'confirmYourPick'},
  {path: '/makePayment/:puzzle_piece_id/:price/:employer_and_occupation', component: MakePayment, name: 'makePayment'},
  {path: '/mahalo', component: Mahalo, name: 'mahalo'},
  {path: '/selectYourPiece', component: SelectYourPiece, name: 'SelectYourPiece'}

];
