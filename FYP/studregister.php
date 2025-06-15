<?php
session_start(); // Start the session

// Prevent back button access after logout
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$host = "localhost";
$user = "root";
$pass = "";  // Enter your DB password if any
$db = "fyp";  // Database name

// Create a connection with the database
$conn = new mysqli($host, $user, $pass, $db);

// Check if the connection was successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Retrieve form data
    $student_name = $_POST['student_name'];
    $email = $_POST['email'];
    $student_id = $_POST['student_id']; // Changed from 'username' to 'id'
    $password = $_POST['password']; // Using plain text password

    // Prepare SQL query to insert data into student table
    $query = "INSERT INTO student (student_id, student_name, email, pass) VALUES (?, ?, ?, ?)";

    // Prepare the statement
    $stmt = $conn->prepare($query);

    // Bind parameters (s for string, s for string, s for string, s for string)
    $stmt->bind_param("ssss", $student_id, $student_name, $email, $password);
    // Storing password in plain text

    // Execute the query
    if ($stmt->execute()) {
        // Clear any existing session variables
        session_unset();

        // Set student_id and student_name in the session
        $_SESSION['student_id'] = $student_id;
        $_SESSION['student_name'] = $student_name;

        // Redirect to the login page if registration is successful
        header("Location: login.html");
        exit();
    } else {
        // Output error if registration fails
        echo "Error: " . $stmt->error;
    }

    // Close the statement
    $stmt->close();
}

// Close the database connection
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
            background-image: url('wave.png'); /* Path to your image */
            background-size: cover; /* Ensures the image covers the entire screen */
            background-position: center; /* Centers the image */
            background-repeat: no-repeat; /* Prevents the image from repeating */
            height: 100vh; /* Makes the body take up the full viewport height */
            margin: 0; /* Removes default margin */
            color: #fff; /* Text color for better visibility */
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
        <h1>Sign up as Student</h1>
        <!-- The form now sends data to the same page (PHP script will handle the form) -->
        <form action="" method="POST">
            <div class="form-group">
                <label for="student_name">Full Name</label>
                <input type="text" id="student_name" name="student_name" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="student_id">ID</label>
                <input type="text" id="student_id" name="student_id" placeholder="Enter your ID" required> <!-- Changed to ID field -->
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
            </div>
            <button type="submit" class="register-btn">Register</button>
            <br><br>
            <p>
                Already have an account? <a href="login.html"> Please Login</a>
            </p>
        </form>
    </div>
</body>
</html>
