<?php
require_once('conn.php');

function jsonResponse($status, $message, $data = null) {
    $response = array('status' => $status, 'message' => $message);
    if ($data !== null) {
        $response['userDetails'] = $data;
    }
    header('Content-Type: application/json; charset=UTF-8');
    echo json_encode($response);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'd_id' is set
    if (isset($_POST['user_id'])) {
        // Get the d_id from the POST data
        $d_id = trim($_POST['user_id']);

        // SQL query to retrieve doctor information based on d_id
        $sql = "SELECT * FROM disciples WHERE user_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $d_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Fetch doctor details as an associative array
            $userDetails = $result->fetch_assoc();

            // Add image URL to doctor details if the image path is set and not empty
            if (!empty($userDetails['img'])) {
                $userDetails['img_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/' . $userDetails['img'];
            } else {
                // If no image path is set, use a default image URL or set it to null
                $userDetails['img_url'] = null; // Or you could use a default image URL
                // Example: $doctorDetails['img_url'] = 'http://' . $_SERVER['HTTP_HOST'] . '/path/to/default/image.jpg';
            }

            // Return doctor details as JSON with proper Content-Type header
            jsonResponse(true, "user details retrieved successfully.", $userDetails);
        } else {
            // No doctor found with the provided d_id
            jsonResponse(false, "No user found with the provided user_id.");
        }
    } else {
        // 'd_id' not provided
        jsonResponse(false, "Please provide a user_id.");
    }
} else {
    // Handle non-POST requests (e.g., return an error response)
    jsonResponse(false, "Invalid request method.");
}

// Close the database connection
$conn->close();
?>
