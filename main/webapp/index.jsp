<%-- Masthan Swamy --%>

<html>
    <head>
        <title>Employee Index Page</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <style>
            body,html
            {
                height: 100%;
            }
            body{
                width: 100%;
                background-image: url("WEB-INF/background-2462431_1920.jpg");
                background-repeat: repeat-x;
            }
            .container
            {
                border: 1px dashed black;
                border-radius: 7px;
                margin-top: 4%;
                padding : 9%;
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
        <h2>Employees Record Management</h2>
        <div class="container">
            <div class="row" style="margin-left:15%">
                <button class="col btn btn-primary" onclick="window.location.href='/EmployeeProject/insert.jsp'">Insert Employee Details</button>
                <button class="col btn btn-success" onclick="window.location.href='/EmployeeProject/listAll'">View All Employees</button>
                <button class="col btn btn-info" onclick="window.location.href='/EmployeeProject/listAll'">Update Employee Details</button>
            </div>
            <div class="row" style="margin-left: 25%;margin-top:10px">
                <button class="col btn btn-danger" onclick="window.location.href='/EmployeeProject/listAll'">Employee Attendance</button>
                <button class="col btn btn-dark" onclick="window.location.href='/EmployeeProject/payslip'">View Employee Pay Slip</button>
            </div>
        </div>

    </body>
</html>