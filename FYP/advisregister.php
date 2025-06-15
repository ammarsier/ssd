<?php
session_start(); // Start the session

// Prevent back button access after logout
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$host = "localhost";
$user = "root";
$pass = "";
$db = "fyp";

// Establish a connection to the database
$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $advisor_name = $_POST['advisor_name'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $advisor_id = $_POST['advisor_id'];

    // Prepare the SQL query to insert advisor details
    $query = "INSERT INTO advisor (advisor_id, advisor_name, email, password) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ssss", $advisor_id, $advisor_name, $email, $password);

    if ($stmt->execute()) {
        // Clear any existing session variables
        session_unset();

        // Set advisor_id and advisor_name in the session
        $_SESSION['advisor_id'] = $advisor_id;
        $_SESSION['advisor_name'] = $advisor_name;

        // Redirect to login page
        header("Location: login.html");
        exit();
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
}

$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduConsult</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #FFF);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('wave.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            color: #fff;
        }

        .register-container {
            background: #4782c5;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .register-container h1 {
            margin-bottom: 20px;
            font-size: 2rem;
            color: #FFF;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #ddd;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            outline: none;
            font-size: 1rem;
        }

        .form-group input:focus {
            box-shadow: 0 0 5px #A32753;
        }

        .register-btn {
            background: #000;
            color: #fff;
            border: none;
            padding: 10px;
            font-size: 1rem;
            font-weight: bold;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .register-btn:hover {
            background: #801E40;
        }

        .footer-text {
            margin-top: 15px;
            font-size: 0.9rem;
            color: #bbb;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h1>Sign up as Advisor</h1>
        <form action="" method="POST">
            <div class="form-group">
                <label for="advisor_name">Full Name</label>
                <input type="text" id="advisor_name" name="advisor_name" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="advisor_id">ID</label>
                <input type="text" id="advisor_id" name="advisor_id" placeholder="Enter your ID" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
            </div>
            <button type="submit" class="register-btn">Register</button>
            <br></br>
            <p>
                Already have an account? <a href="login.html"> Please Login</a>
            </p>
        </form>
    </div>
</body>
</html>