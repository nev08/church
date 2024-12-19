<?php
include("conn.php");

// Check if POST data is received
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Retrieve data from the POST request
    $sql = "SELECT user_id, Name, img FROM disciples ORDER BY user_id";
    
    $result = $conn->query($sql);

    if ($result === false) {
        // Handle query execution error
        echo json_encode(array('status' => 'failure', 'message' => 'Query execution error: ' . $conn->error));
    } else {
        if ($result->num_rows > 0) {
            $users = array();

            while ($row = $result->fetch_assoc()) {
                $imgPath = $row['img'];

                // Check if the image path is valid and not empty
                if (!empty($imgPath) && file_exists($imgPath)) {
                    // Read the image file and encode it as base64
                    $imgData = file_get_contents($imgPath);
                    $base64Img = base64_encode($imgData);
                    $row['img'] = $base64Img;
                } else {
                    // Set a default base64 image (you can adjust this path to your default image)
                    $row['img'] = ''; // or provide a default base64 image
                }

                $users[] = $row;
            }

            echo json_encode(array('status' => 'success', 'users' => $users));
        } else {
            echo json_encode(array('status' => 'failure', 'message' => 'No recent users found'));
        }
    }
} else {
    echo json_encode(array('status' => 'failure', 'message' => 'Invalid request method'));
}
?>
