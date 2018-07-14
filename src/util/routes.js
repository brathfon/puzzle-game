import Login from '../components/Login.vue';
import LandingPage from '../components/LandingPage.vue';
import AdminOverview from '../components/AdminOverview.vue';
import EditPuzzlePiece from '../components/EditPuzzlePiece.vue';
import ConfirmYourPick from '../components/ConfirmYourPick.vue';



export default [
  {path: '/', component: LandingPage, name: 'landingPage'},
  {path: '/login', component: Login, name: 'login'},
  {path: '/adminOverview', component: AdminOverview, name: 'adminOverview'},
  {path: '/editPuzzlePiece', component: EditPuzzlePiece, name: 'editPuzzlePiece'},
  {path: '/confirmYourPick', component: ConfirmYourPick, name: 'confirmYourPick'}
];
