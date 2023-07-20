<?php 
header('Content-Type: application/json');
require_once('config.php');

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//array to return

if(isset($_FILES["image"])){
    $kpi_id=uniqid();
    
   // $newfilename= "xxxxxx".$_FILES["image"]["name"];//str_replace(" ", "", basename($_FILES["image"]["name"]));
$filename   = uniqid() . "-" . time(); // 5dab1961e93a7-1571494241
$extension  = pathinfo( $_FILES["image"]["name"], PATHINFO_EXTENSION ); // jpg
$basename   = $filename . "." . $extension; // 5dab1961e93a7_1571494241.jpg
    //directory to upload file
    $target_dir = "upload/"; //create folder files/ to save file
    //$filename = $_FILES["file"]["name"]; 
    //name of file
    //$_FILES["file"]["size"] get the size of file
    //you can validate here extension and size to upload file.

    $savefile = "$target_dir.$basename";
    //complete path to save file
//meal_auto_id	mealID	mealTitle	CategoryID	pictureCode	Description	foodCalorie	UserID	

    if(move_uploaded_file($_FILES["image"]["tmp_name"], $savefile)) {
        

         $sql = "INSERT INTO Meal (mealID, mealTitle,CategoryID,pictureCode,Description,foodCalorie,UserID) VALUES (?,?,?,?,?,?,?)";
            $stmt = $db->prepare($sql);
            if($stmt->execute([$kpi_id, $_POST['mealTitle'], $_POST['CategoryID'],$basename,$_POST['Description'], $_POST['foodCalorie'],$_POST['UserID']])){
        
        $return["error"] = false;
        $return["msg"] =  "Successfull Upload file.";//$_POST["remark"];
        $return["success"] = true;
     
   }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving data .";//$_POST["remark"];
        $return["success"] = true;
            }
        
        
        
       
    }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving file.";
        $return["success"] = false;
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