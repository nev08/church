<?php
// Include your database connection file
require "conn.php";

// Check if the necessary parameters are provided
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the JSON input
    $jsonInput = file_get_contents("php://input");

    // Decode JSON data into an associative array
    $postData = json_decode($jsonInput, true);

    // Check if JSON decoding was successful
    if ($postData !== null) {
        // Sanitize input data to prevent SQL injection
        $id = $postData['user_id'];
        $name = $postData['Name'];
        $age = $postData['Age'];
        $dob = $postData['DOB'];
        $gender = $postData['Gender'];
        $zone = $postData['Zone'];
        $fgl = $postData['Fgl'];
        $sector = $postData['Sector'];
        $ms = $postData['Marital_status'];
        $phn = $postData['Phn'];
        $pass=$postData['Password'];

        // Directory to save uploaded profile pictures
        $uploadDirectory = "img/" . $id . '.jpg';

        // Get the uploaded file details
        $profilePicBase64 = $postData['img'];
        $profilePicBinary = base64_decode($profilePicBase64);

        // Save the image
        if (file_put_contents($uploadDirectory, $profilePicBinary)) {
            // Update the database with the new information including the profile picture path
            $profilePicPath = $uploadDirectory;
            //$timestamp = date('Y-m-d H:i:s');
            $query = "INSERT INTO disciples (user_id, Name, Age, DOB, Gender, Zone, Fgl, Sector, Marital_status, Phn, Password, img)
                      VALUES ('$id', '$name', '$age', '$dob', '$gender', '$zone', '$fgl', '$sector','$ms','$phn','$pass','$uploadDirectory')";

            if (mysqli_query($conn, $query)) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error', 'message' => mysqli_error($conn)]);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to save the image']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid JSON format']);    
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

// Close the database connection
mysqli_close($conn);
?>
