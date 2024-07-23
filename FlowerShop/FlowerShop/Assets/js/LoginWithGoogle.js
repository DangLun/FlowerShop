//const CLIENT_ID = "320419221419-qfrh91ng5v4drk9e201clndas6s88sj5.apps.googleusercontent.com";

//const LINK_GET_TOKEN = `https://accounts.google.com/o/oauth2/v2/auth?
//scope=https%3A//www.googleapis.com/auth/userinfo.email%20https%3A//www.googleapis.com/auth/userinfo.profile&
//response_type=token&
//redirect_uri=https://localhost:44383/Sign/Login&
//client_id=${CLIENT_ID}`

//$(function () {
//    const getToken = () => {
//        const url = new URLSearchParams(window.location.hash.substring(1))
//        const token = url.get("access_token")
//        return token;
//    }

//    const getUserInfo = async () => {
//        const access_token = getToken()
//        if (access_token != null) {
//            const response = await fetch(`https://www.googleapis.com/oauth2/v3/userinfo?access_token=${access_token}`)
//            const data = await response.json()
//            $.post({
//                url: '/Sign/HandleLoginWithGoogle',
//                type: 'POST',
//                contentType: 'application/json',
//                data: JSON.stringify(data),
//                success: function (response) {
//                    console.log('Success:', response);
//                },
//                error: function (error) {
//                    console.log('Error:', error);
//                }
//            });
//        }
//    }

//    getUserInfo();
//    $(".btn-loginWithGoogle").click(function () {
//        window.location.href = LINK_GET_TOKEN;
//        getUserInfo();
//    })

//})


