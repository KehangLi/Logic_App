
window.onload = function() {

    var port = document.getElementById("port").value;


    var addBtn = document.getElementById("addRow");
    addBtn.onclick = function(){
        var tab = document.getElementById("questionTable");
        var tabRows = tab.rows;
        var newTr = tab.insertRow(tabRows.length);
        var newTd0 = newTr.insertCell(0);
        var newTd1 = newTr.insertCell(1);
        var newTd2 = newTr.insertCell(2);
        var newTd3 = newTr.insertCell(3);
        var newTd4 = newTr.insertCell(4);
        var newTd5 = newTr.insertCell(5);
        var newTd6 = newTr.insertCell(6);
        var newTd7 = newTr.insertCell(7);
        var newTd8 = newTr.insertCell(8);
        var newTd9 = newTr.insertCell(9);
        var newTd10 = newTr.insertCell(10);
        var newTd11 = newTr.insertCell(11);


        //creat ID
        var i = tab.rows.length - 1;
        newTr.id = "question" + i;
        var ID = "ID" + i;
        var questionText = "questionText" + i;
        var answerA = "answerA" + i;
        var answerB = "answerB" + i;
        var answerC = "answerC" + i;
        var answerD = "answerD" + i;
        var correctAnswer = "correctAnswer" + i;
        var difficultyLevel = "difficultyLevel" + i;
        var totalTryNum = "totalTryNum" + i;
        var correctTryNum = "correctTryNum" + i;
        var totalTime = "totalTime" + i;


        newTd0.innerHTML = '<input type="number" class="ID" id="' + ID + '"/>';
        newTd1.innerHTML = '<input type="text" class="questionText" id="' + questionText + '"/>';
        newTd2.innerHTML = '<input type="text" class="answerA" id="' + answerA + '"/>';
        newTd3.innerHTML = '<input type="text" class="answerB" id="' + answerB + '"/>';
        newTd4.innerHTML = '<input type="text" class="answerC" id="' + answerC + '"/>';
        newTd5.innerHTML = '<input type="text" class="answerD" id="' + answerD + '"/>';
        newTd6.innerHTML ='<select class="correctAnswer" id="' + correctAnswer + '">\n' +
            '  <option value ="A">A</option>\n' +
            '  <option value ="B">B</option>\n' +
            '  <option value="C">C</option>\n' +
            '  <option value="D">D</option>\n' +
            '</select>';
        newTd7.innerHTML ='<select class="difficultyLevel" id="' + difficultyLevel + '">\n' +
            '  <option value ="Easy">Easy</option>\n' +
            '  <option value ="Medium">Medium</option>\n' +
            '  <option value="Hard">Hard</option>\n' +
            '</select>';
        newTd8.innerHTML = '<input type="text" value="0" class="totalTryNum" id="' + totalTryNum + '" readonly="readonly"/>';
        newTd9.innerHTML = '<input type="text" value="0" class="correctTryNum" id="' + correctTryNum + '" readonly="readonly"/>';
        newTd10.innerHTML = '<input type="text" value="0" class="totalTime" id="' + totalTime + '" readonly="readonly"/>';

        var newAddButton = document.createElement("button")
        newAddButton.setAttribute("id","add" + i)
        newAddButton.setAttribute("class","add")
        newAddButton.innerHTML = 'creat';   //显示名字
        newAddButton.onclick = function (){
            var id = this.id.slice(3)
            // check  input, it should not be empty
            if(document.getElementById("questionText"+id).value == ""){
                alert("Please input Question Text!");
                return
            }
            // bind event
            $.post("http://localhost:" + port + "/createQuestion",
                {
                    ID:document.getElementById("ID" + id).value,
                    questionText:document.getElementById("questionText" + id).value,
                    answerA:document.getElementById("answerA" + id).value,
                    answerB:document.getElementById("answerB" + id).value,
                    answerC:document.getElementById("answerC" + id).value,
                    answerD:document.getElementById("answerD" + id).value,
                    correctAnswer:document.getElementById("correctAnswer" + id).value,
                    difficultyLevel: document.getElementById("difficultyLevel" + id).value,
                    totalTryNum:document.getElementById("totalTryNum" + id).value,
                    correctTryNum:document.getElementById("correctTryNum" + id).value,
                    totalTime:document.getElementById("totalTime" + id).value,
                },
                function (data,status) {
                //check result contains duplicate entry? check repeated questions?
                    if (data["result"].indexOf("Duplicate entry") !== -1 ){
                        alert("Duplicate ID!");
                        return;
                    }
                    if (data["result"].indexOf("Repeated Question!") !== -1 ){
                        alert("Repeated Question!");
                        return;
                    }
                    alert("Add success!");
                    window.location.reload();
                }

            )


        }
        newTd11.appendChild(newAddButton);
    }

    var deleteButtons = document.getElementsByClassName('deleteBtn')
    // we have to use loop to bind click event to each deleteButtons
    for (let i=0; i<deleteButtons.length; i++){
        deleteButtons[i].onclick = function (){
            var result = confirm("Confirm to Delete this question?")
            if(!result){
                return;
            }
            var questionId = this.getAttribute("questionId");
            $.get("http://localhost:" + port +"/admin/deleteQuestion/" + questionId,
                function(data,status){
                    alert(status);
                    window.location.reload();
                });
        }

    }


}


// ref: https://blog.csdn.net/a2868221132/article/details/129796512