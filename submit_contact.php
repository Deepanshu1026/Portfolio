<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect and sanitize input data
    $name = htmlspecialchars(strip_tags($_POST['name']));
    $email = htmlspecialchars(strip_tags($_POST['email']));
    $message = htmlspecialchars(strip_tags($_POST['message']));

    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)");
    
    if ($stmt) {
        $stmt->bind_param("sss", $name, $email, $message);

        if ($stmt->execute()) {
            // Success: Redirect back to contact page with success message/alert
            echo "<script>alert('Thank you! Your message has been sent.'); window.location.href='contact.html';</script>";
        } else {
            echo "Error: " . $stmt->error;
        }

        $stmt->close();
    } else {
        echo "Error preparing statement: " . $conn->error;
    }

    $conn->close();
} else {
    // Redirect if accessed directly
    header("Location: contact.html");
    exit();
}
?>
