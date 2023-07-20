<?php
header('Content-Type: application/json');
require_once('config.php');

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    


$stmt = $db->prepare( 'UPDATE Users SET UserName = :UserName, Name = :Name, UserPassword = :UserPassword, UserEmail = :UserEmail WHERE UserID = :UserID' ); 

$stmt->bindValue( ':UserName', $_POST['UserName'] );
$stmt->bindValue( ':Name', $_POST['Name'] );
$stmt->bindValue( ':UserPassword', $_POST['UserPassword'] );
$stmt->bindValue( ':UserEmail', $_POST['UserEmail'] );
$stmt->bindValue( ':UserID', $_POST['UserID'] );

// more binds here
$result =$stmt->execute();
echo json_encode([
'status' => $result,
'message' => "",
'mesejlog' => "",
'mesejayat' => "Successfull Update data, login again for retrive new session",
'count_result' => "1",
'data' => []
]);

















?>