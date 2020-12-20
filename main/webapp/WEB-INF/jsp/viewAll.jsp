<%-- Masthan Swamy --%>

<%@page isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Employee Details</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <script>
            $(document).ready(function(){
/*

                // Placing Attendance Radio Buttons
                let eles = $(".attendance");

                for(i=0;i<eles.length;i++)
                {
                    let ele = eles.get
                    let status = ele.getAttribute("title");

                    if(status=="Present")
                    {
                        alert(ele.firstChild.nodeValue);
                        // ((ele.childNodes[0]).childNodes[0]).setAttribute("checked","checked");
                    }
                    else
                    {
                        // ((ele.childNodes[1]).childNodes[0]).setAttribute("checked","checked");
                    }
                }
*//*
                let stat = $("#attendance").attr("title");

                if(stat=="Present")
                {
                    $("#attendance").find("label input[value='yes']").attr("checked","checked");
                }
                else
                {
                    let no = $("#attendance").find("label input[value='no']");
                    no.attr("checked","checked");
                }
                let yes = $("#attendance label[title='yes'] input");
                let no = $("#attendance label[title='no'] input");

                $(yes).click(function(){

                    let id = yes.attr("name").split("-")[1];

                    $.ajax({
                        url : "attended/"+id,
                        success : function(res){
                            if(res=="attendance taken")
                                console.log("success");
                            else
                                console.log("failed")
                        },
                        error : function(res){
                            alert("Some Error Occurred"+ res.responseText);
                        }
                    });
                });
                $(no).click(function(){

                    let id = no.attr("name").split("-")[1];

                    $.ajax({
                        url: "mistaken/"+id,
                        success: function(res){
                            if(res=="attendance rectified")
                                console.log("Mistake Rectified");
                            else
                                console.log("Sorry Rectification Failed");
                        }
                    });
                });
*/

                // Prechecking
                $(".Present").attr("disabled","disabled");
                $(".Present").html("Attendance Complete");

                $(".attendance").click(function()
                {
                    let id = $(this).attr("title");

                    $.ajax({
                        url : "attended/"+id,
                        success : function(res){
                            if(res=="attendance taken")
                            {
                                $(this).attr("disabled","disabled");
                                $(this).html("Attendance Complete");
                                document.location.reload();
                                console.log("success"+"  "+$(this).attr("title"));
                            }
                            else
                            {
                                console.log("failed"+"   "+res);
                            }
                        },
                        error : function(res){
                            alert("Some Error Occurred"+ res.responseText);
                        }
                    });
                });

            });
        </script>

        <style>
            .thead
            {
                color : white;
            }
            .thead td
            {
                background-color: dimgrey;
            }
            span
            {
                border-bottom: 2px solid;
            }
            .container
            {
                border: 1px solid black;
                border-radius: 7px;
                margin-top: 5%;
            }
            h2
            {
                text-align: center;
                text-decoration: underline;
                margin-bottom: 20px;
            }
        </style>

    </head>
    <body>

        <div class="container">
            <h2>View All Employees</h2>
            <table class="table table-striped table-hover table-condensed text-center">
                <thead class="thead">
                    <td class="text-center">Emp Id</td>
                    <td>Name</td>
                    <td>Attendance</td>
                    <td>Edit</td>
                    <td>Delete</td>
                </thead>

                <c:forEach var="e" items="${employees}">
                    <tr>
                        <td class="text-center">${e.empid}</td>
                        <td>${e.name}</td>
                        <td>
                            <%--<p class="ml-4">Attended</p>
                            <div class="form-group mb-0 pb-0" id="attendance" title="${e.attendance}">
                                <label class="radio-inline" title="yes"><input type="radio" name="attendance-${e.empid}" value="yes" />Yes</label>
                                <label class="radio-inline" title="no"><input type="radio" name="attendance-${e.empid}" value="no"/>No</label>
                            </div>--%>

                            <button class="btn btn-warning attendance ${e.attendance}" title="${e.empid}">Present</button>

                        </td>
                        <td><a class="text-primary" href="get/${e.empid}">Edit</a></td>
                        <td><a class="text-danger"  href="delete/${e.empid}">Delete</a></td>
                    </tr>
                </c:forEach>

            </table>
        </div>

    </body>

</html>