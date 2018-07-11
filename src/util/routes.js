import Login from '../components/Login.vue';
import LandingPage from '../components/LandingPage.vue';
import ExampleDataPage from '../components/ExampleDataPage.vue';
import ConfirmYourPick from '../components/ConfirmYourPick.vue';



export default [
  {path: '/', component: LandingPage, name: 'landingPage'},
  {path: '/login', component: Login, name: 'login'},
  {path: '/exampleDataPage', component: ExampleDataPage, name: 'exampleDataPage'},
  {path: '/confirmYourPick', component: ConfirmYourPick, name: 'confirmYourPick'}
];
