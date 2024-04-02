window.onload = function () {

    var port = document.getElementById("port").value;

    var deleteBtns = document.getElementsByClassName("deleteBtn");
    for (let i = 0; i < deleteBtns.length; i++) {
        deleteBtns[i].onclick = function () {
            var result = confirm("Are you sure to delete this user?");
            if (!result) {
                return;
            }
            var user = this.getAttribute("user");
            $.get("http://localhost:" + port + "/admin/deleteUser/" + user,
                function (data, status) {
                    alert(status);
                    window.location.reload();
                });
        }

    }

    var resetButtons = document.getElementsByClassName("resetBtn");
    for(let i = 0; i< resetButtons.length ; i++){
        resetButtons[i].onclick = function () {
            var user = this.getAttribute("user");
            var result = confirm("Are you sure to change the password of" + user +"?");
            if (!result) {
                return;
            }
            var newPassword = prompt("Please enter new password");
            var newPasswordcheck = prompt("Please enter new password again");
            if (newPassword != newPasswordcheck){
                alert("Passwords entered do not match, please try again");
                return;
            }
            $.get("http://localhost:" + port + "/resetPassword/" + user +"/" + newPassword,
                function (data, status) {
                    alert(status);
                    window.location.reload();
                });

        }
    }



}