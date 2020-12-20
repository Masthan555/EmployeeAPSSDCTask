<!-- Masthan Swamy -->

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

        <script>
            function datevalidate()
            {
                cur = new Date().getFullYear();

                let dob = document.getElementById("DOB").value;
                let doj = document.getElementById("DOB").value;

                dob = new Date(dob).getFullYear();
                doj = new Date(doj).getFullYear();

                if(((cur-dob)>50) || ((cur-doj)>50))
                {
                    alert("Sorry you are not eligible.");
                    return false;
                }

                return true;
            }
        </script>

        <style>
            body,html
            {
                height: 100%;
            }
            body
            {
                background-image: url("WEB-INF/background-2462431_1920.jpg");
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: relative;
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
        <div class="container" style="width:60%;">
            <h2> Save Employee Details </h2>

            <form action="/EmployeeProject/insert" onsubmit="datevalidate()" method="post">

                <h3 style="margin-bottom: 15px" class="text-primary">Enter Following Details: </h3>

                <div class="form-group">
                    <label for="Name">Name: </label>
                    <input type="text" class="form-control" id="Name" name="name" placeholder="Enter Name..." required>
                </div>
                <div class="form-group">
                    <label for="DOB">DOB: </label>
                    <input type="date" class="form-control" id="DOB" name="DOB" required>
                </div>
                <div class="form-group">
                    <label for="Qual">Graduation: </label>
                    <select class="form-control" id="Qual" name="Qual">
                        <option>Select your Qualification</option>
                        <option>BE/BTech</option>
                        <option>BCA</option>
                        <option>BSc</option>
                        <option>MCA</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="Gender">Gender: </label>
                    <div id="Gender">
                        <label class="radio-inline"><input type="radio" name="gender" value="Male" checked> Male </label>
                        <label class="radio-inline"><input type="radio" name="gender" value="Female"> Female </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="DOJ">Date of Joining: </label>
                    <input type="date" class="form-control" id="DOJ" name="DOJ" required>
                </div>
                <div class="form-group">
                    <label for="PAN">PAN: </label>
                    <input type="text" class="form-control" id="PAN" placeholder="Enter PAN Number..." pattern=".....1234." name="PAN" required>
                </div>

                <button type="submit" class="btn btn-primary pt-3">Submit</button>

            </form>

        </div>
    </body>

</html>