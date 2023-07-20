<?php 
header('Content-Type: application/json');
require_once('config.php');

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//array to return

if(isset($_POST['statusimg'])){
    
    if($_POST['statusimg']=="null"){
        
        $stmt = $db->prepare( 'UPDATE Meal SET mealTitle = :mealTitle, CategoryID = :CategoryID, Description = :Description, foodCalorie = :foodCalorie, UserID = :UserID WHERE mealID = :mealID' ); 

$stmt->bindValue( ':mealTitle', $_POST['mealTitle'] );
$stmt->bindValue( ':CategoryID', $_POST['CategoryID'] );
$stmt->bindValue( ':Description', $_POST['Description'] );
$stmt->bindValue( ':foodCalorie', $_POST['foodCalorie'] );
$stmt->bindValue( ':UserID', $_POST['UserID'] );
        $stmt->bindValue( ':mealID', $_POST['mealID'] );
        
            if($stmt->execute()){
        
        $return["error"] = false;
        $return["msg"] =  "Successfull Update Record";//$_POST["remark"];
        $return["success"] = true;
     
   }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving data .";//$_POST["remark"];
        $return["success"] = true;
            }
        
    }else{
        $kpi_id=uniqid();
$filename   = uniqid() . "-" . time(); // 5dab1961e93a7-1571494241
$extension  = pathinfo( $_FILES["image"]["name"], PATHINFO_EXTENSION ); // jpg
$basename   = $filename . "." . $extension; 
$target_dir = "upload/"; 
    $savefile = "$target_dir.$basename";
    if(move_uploaded_file($_FILES["image"]["tmp_name"], $savefile)) {
        
        $stmt = $db->prepare( 'UPDATE Meal SET mealTitle = :mealTitle, CategoryID = :CategoryID, pictureCode = :pictureCode, Description = :Description, foodCalorie = :foodCalorie, UserID = :UserID WHERE mealID = :mealID' ); 

$stmt->bindValue( ':mealTitle', $_POST['mealTitle'] );
$stmt->bindValue( ':CategoryID', $_POST['CategoryID'] );
$stmt->bindValue( ':pictureCode', $basename );
$stmt->bindValue( ':Description', $_POST['Description'] );
$stmt->bindValue( ':foodCalorie', $_POST['foodCalorie'] );
$stmt->bindValue( ':UserID', $_POST['UserID'] );
        $stmt->bindValue( ':mealID', $_POST['mealID'] );
        
            if($stmt->execute()){
        
        $return["error"] = false;
        $return["msg"] =  "Successfull Update Record.";//$_POST["remark"];
        $return["success"] = true;
     
   }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving data .";//$_POST["remark"];
        $return["success"] = true;
            }
        
        
        
       
    }else{
        $return["error"] = true;
        $return["msg"] =  "Error during upload image.";
        $return["success"] = false;
    }
        
    }

}else{
    $return["error"] = true;
    $return["msg"] =  "No file is sublitted.";
    $return["success"] = false;
}

//header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>