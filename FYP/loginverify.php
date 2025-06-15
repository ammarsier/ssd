<?php
session_start(); // Start the session

// Prevent back button access after logout
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

// Retrieve form inputs
$userID = $_POST['id'];      // Retrieve the user ID from the form
$userPWD = $_POST['pass'];   // Retrieve the password from the form

// Declare DB connection variables
$host = "localhost";
$user = "root";
$pass = "";  // Enter your password if any
$db = "fyp";  // Database name

// Create connection with the database
$conn = new mysqli($host, $user, $pass, $db);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to verify user credentials
function verifyUser($conn, $query, $userID, $userPWD, $userRole, $passwordField, $redirectPage) {
    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $userID);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        if ($row[$passwordField] == $userPWD) { // Plain text password comparison
            // Set session variables
            $_SESSION["UserID"] = $row["{$userRole}_id"];
            $_SESSION["UserName"] = $row["{$userRole}_name"];
            $_SESSION["UserRole"] = ucfirst($userRole);
            
            if ($userRole === "admin") {
                $_SESSION["admin_id"] = $row["admin_id"];
            } elseif ($userRole === "advisor") {
                $_SESSION["advisor_id"] = $row["advisor_id"];
            } elseif ($userRole === "student") {
                $_SESSION["student_id"] = $row["student_id"];
                $_SESSION["student_name"] = $row["student_name"];
            }
            
            // Debug: Log session variables
            error_log("Session variables set: " . print_r($_SESSION, true));
            
            $stmt->close();
            header("Location: $redirectPage");
            exit();
        } else {
            echo "<p style='color:red;'>Wrong password for $userRole!</p>";
        }
    } else {
        echo "<p style='color:red;'>No such $userRole found!</p>";
    }
    
    $stmt->close();
}

// Verify student credentials
verifyUser($conn, "SELECT * FROM student WHERE student_id = ?", $userID, $userPWD, "student", "pass", "mainpage.php
");

// Verify advisor credentials
verifyUser($conn, "SELECT * FROM advisor WHERE advisor_id = ?", $userID, $userPWD, "advisor", "password", "advismainpage.php");

// Verify admin credentials
verifyUser($conn, "SELECT * FROM admin WHERE admin_id = ?", $userID, $userPWD, "admin", "password", "adminmainpage.php");

// If no matching user is found
echo "<p style='color:red;'>User does not exist!</p>";

// Close the connection
$conn->close();
?>