<!-- Masthan Swamy -->

<%@page isELIgnored="false" %>

<html>
<head>
    <title>Update Employee Details</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
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

    <script>
        $(document).ready(function(){
            let qual = "${employee.qual}";
            let gender = "${employee.gender}";

            console.log("Before Updating Qual");
            // Updating Qualification
            $("#Qual").find("option[value='"+qual+"']").attr("selected","selected");

            console.log("After Updating Qual");


            console.log("Before Updating Gender");
            // Updating Gender Radio Button
            if(gender=="Male")
            {
                console.log("Gender is Male");
                $("#Male").attr("checked","checked");
            }
            else
            {
                console.log("Gender is Female");
                $("#Female").attr("checked","checked");
            }

        });
    </script>

</head>

<body>
<div class="container" style="width:50%;">
    <h2>Update Employee Data</h2>
    <form action="/EmployeeProject/update/${employee.empid}" method="post">

        <h3 style="margin-bottom: 15px" class="text-primary">Enter Following Details: </h3>

        <div class="form-group">
            <label for="Name">Name: </label>
            <input type="text" class="form-control" value="${employee.name}" id="Name" name="name" placeholder="Enter Name..." required>
        </div>
        <div class="form-group">
            <label for="DOB">DOB: </label>
            <input type="date" class="form-control" value="${employee.dob}" id="DOB" name="DOB" required>
        </div>
        <div class="form-group">
            <label for="Qual">Graduation: </label>
            <select class="form-control" id="Qual" name="Qual">
                <option>Select your Qualification</option>
                <option value="BE/BTech">BE/BTech</option>
                <option value="BCA">BCA</option>
                <option value="BSc">BSc</option>
                <option value="MCA">MCA</option>
            </select>
        </div>
        <div class="form-group">
            <label for="Gender">Gender: </label>
            <div id="Gender">
                <label class="radio-inline"><input type="radio" id="Male" name="gender" value="Male"> Male </label>
                <label class="radio-inline"><input type="radio" id="Female" name="gender" value="Female"> Female </label>
            </div>
        </div>
        <div class="form-group">
            <label for="DOJ">Date of Joining: </label>
            <input type="date" class="form-control" value="${employee.doj}" id="DOJ" name="DOJ" required>
        </div>
        <div class="form-group">
            <label for="PAN">PAN: </label>
            <input type="text" class="form-control" id="PAN" value="${employee.pan}" placeholder="Enter PAN Number..." pattern=".....1234." name="PAN" required>
        </div>

        <button type="submit" class="btn btn-success pt-3 pl-3 pr-3">Update</button>

    </form>

</div>
</body>

</html>