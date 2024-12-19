<?php
// Assuming you have already connected to the database
include 'conn.php';

$query = "SELECT user_id FROM disciples ORDER BY user_id DESC LIMIT 1"; // Get the last user_id
$result = mysqli_query($conn, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $lastUserId = $row['user_id'];
    echo json_encode(['lastUserId' => $lastUserId]);
} else {
    echo json_encode(['lastUserId' => '0000']); // If no users exist, return 0000
}
?>
