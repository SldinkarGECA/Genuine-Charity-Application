// const loginForm = document.getElementById("login-form");
// const loginButton = document.getElementById("button");

// loginButton.addEventListener("click", (e) => {
//     e.preventDefault();
//     var username = document.getElementById("user").value;
//     var password = document.getElementById("pass").value;

//     if (username === "u" && password === "web") {
//         alert("You have successfully logged in.");
//         location.replace("admin/index.html")
//     } 
//     // else {
//     //     loginErrorMsg.style.opacity = 1;
//     // }
// })



function login () {
    var loginInfo = [
        {
            username: "admin",
            password: "gc_1234"
        }
    ]
    var username = document.getElementById("user").value;
    var password = document.getElementById("pass").value;
    // console.log ("username is " + username + " password is " + password);
    for (i=0; i<loginInfo.length; i++) {
        if (username == loginInfo[i].username  && password == loginInfo[i].password) {
            // console.log (username + " logged in!")
            location.reload("admin/index.html")
            return
        }
    }
}