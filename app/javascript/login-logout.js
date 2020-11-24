// ログアウト処理
// TODD: headerにまとめる際に消す。
var firebaseConfig = {
  apiKey: "AIzaSyDfZ0p6ysbml7IByXoXC-2-1BGmRlS-61k",
  authDomain: "comm-list.firebaseapp.com",
  databaseURL: "https://comm-list.firebaseio.com",
  projectId: "comm-list",
  storageBucket: "comm-list.appspot.com",
  messagingSenderId: "383913072943",
  appId: "1:383913072943:web:94089ff7b73cf69c8529da",
  measurementId: "G-1LYEQJK8LQ"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// firebase.jsで対応
firebase.analytics();

const firebaseLogin = () => {
  const ui = firebaseui.auth.AuthUI.getInstance() || new firebaseui.auth.AuthUI(firebase.auth());
  const uiConfig = {
    callbacks: {
      signInSuccessWithAuthResult: (authResult, redirectUrl) => {
        authResult.user.getIdToken(true)
        .then((idToken) => { railsLogin(authResult.additionalUserInfo.isNewUser, idToken, authResult.additionalUserInfo) })
        .catch((error)  => { console.log(`Firebase getIdToken failed!: ${error.message}`) });
        return false; // firebase側にログイン後はリダイレクトせず、railsへajaxでリクエストを送る
      },
      uiShown: () => { document.getElementById('loader').style.display = 'none' }
    },
    signInFlow: 'redirect',
    signInOptions: [
      firebase.auth.TwitterAuthProvider.PROVIDER_ID, // Google認証
    ],
  };
  // ログイン画面表示
  ui.start('#firebaseui-auth-container', uiConfig);
}
  
const csrfTokenObj = () => {
  return { "X-CSRF-TOKEN": $('meta[name="csrf-token"]').attr('content') };
}
  
const authorizationObj = (idToken) => {
  return { "Authorization": `Bearer ${idToken}` };
}
  
const railsLogin = (isNewUser, idToken, userInfo) => {
  const url = isNewUser ? "/accounts" : "/login";
  const headers = Object.assign(csrfTokenObj(), authorizationObj(idToken));
  $.ajax({url: url, type: "POST", headers: headers, data: {
    twitter_user: {
      screen_name: userInfo.username
    }}
  }).done((data) => { console.log("Rails login!")      })
    .fail((data) => { console.log("Rails login failed!") });
}

const railsLogout = () => {
  $.ajax({url: "/logout", type: "DELETE", headers: csrfTokenObj()})
    .done((data) => { 
      console.log("Rails logout!")
    })
    .fail((data) => { console.log("Rails logout failed!") });
}

  const firebaseLogout = () => {
  firebase.auth().signOut()
    .then(()       => { railsLogout() })
    .catch((error) => { console.log(`Firebase logout failed!: ${error.message}`) });
}

// firebaseLogin()

