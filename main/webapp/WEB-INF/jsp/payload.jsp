<%-- Masthan Swamy --%>

<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

    <head>
        <title>Add Employee Details</title>

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
            .thead
            {
                color : white;
            }
            .thead td
            {
                background-color: dimgrey;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Employee Pay Slip</h2>

            <table class="table table-striped table-hover table-condensed table-responsive text-center">
                <thead>
                    <td>EmpID</td>
                    <td>Name</td>
                    <td>No of days Present</td>
                    <td>PAN</td>
                    <td>Basic Pay</td>
                    <td>DA</td>
                    <td>HRA</td>
                    <td>MA</td>
                    <td>Gross Total</td>
                    <td>PF</td>
                    <td>PT</td>
                    <td>Net Salary</td>
                </thead>

                <c:forEach var="slip" items="${payslips}">
                    <tr>
                        <td>${slip.get("id")}</td>
                        <td>${slip.get("name")}</td>
                        <td>${slip.get("attended_days")}</td>
                        <td>${slip.get("pan")}</td>
                        <td>${slip.get("basicpay")}</td>
                        <td>${slip.get("da")}</td>
                        <td>${slip.get("hra")}</td>
                        <td>${slip.get("ma")}</td>
                        <td>${slip.get("gross")}</td>
                        <td>${slip.get("pf")}</td>
                        <td>${slip.get("pt")}</td>
                        <td>${slip.get("net")}</td>
                    </tr>
                </c:forEach>

            </table>

        </div>
    </body>

</html>