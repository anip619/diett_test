<?php
define('BASEPATH', true);
require_once('config.php');


$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


        $user_tnc ="true";


    //check if login form is submitted
    if(isset($_POST['action']) && $_POST['action']=="register"){
         $Name  = $_POST['Name'];
        $UserEmail  = $_POST['UserEmail'];
        $UserName =$_POST['UserName'];
        $UserPassword =$_POST['UserPassword'];
       // echo $user_tnc;
        if($Name!="" && $UserEmail!="" && $UserName!="" && $UserPassword!=""){
                 try {

          $hash=password_hash($UserPassword, PASSWORD_DEFAULT);
         $stmt = $db->prepare("SELECT COUNT(UserEmail) AS num FROM Users WHERE UserEmail = :UserEmail");

         $stmt->bindValue(':UserEmail', $UserEmail);
         $stmt->execute();
         $row = $stmt->fetch(PDO::FETCH_ASSOC);
         if($row['num'] > 0){
             if($user_tnc){}
                    $status=false;
                    $message="unsuccessful";
                    $msglog="User register unsuccessful";
                    $msgtxt="Email already exists";
        }
        
       else{
           $six_digit= random_int(100000, 999999);
          //$json = sms_verification($user_phone,$six_digit);
           //$keys = array_keys(json_decode($json, TRUE));
           $keysx="success";
    //print_r($json);
           
           if($keysx=="success"){
               
               $sql = "INSERT INTO Users (UserID, UserName,Name, UserPassword, UserEmail, UserDatatype) VALUES (?,?,?,?,?,?)";
            $stmt = $db->prepare($sql);
            if($stmt->execute([uniqid(), $UserName,$Name, $UserPassword, $UserEmail, "0"])){
                    $status=true;
                    $message="successful";
                    $msglog="User register successful";
                   // $msgtxt="User register successful.\nOTP will send to this $user_phone number for reset password";
                $msgtxt="User register successful.";
     
   }
            else{
                    $status=false;
                    $message="unsuccessful";
                    $msglog="User register server error";
                    $msgtxt="Error server : contact technical department";
   }
           }
           
           else{
               $status=false;
                    $message="unsuccessful";
                    $msglog="sms verification error";
                    $msgtxt="Phone number is invalid for the region.";
               
           }
           
           
           
           
           
           
}
}
           catch(PDOException $e){
                    $status=0;
                    $message=$e->getMessage();
                    $msglog=$e->getMessage();
                    $msgtxt=$e->getMessage();
        }
        
       echo json_encode([
                    'status' =>$status,
                    'message' =>$message,
                    'mesejlog' =>$msglog,
                    'msgtxt' =>$msgtxt,
                    'count_result' =>$stmt->rowCount(),
                    'data' =>[]
                    ], JSON_PRETTY_PRINT);
            
        }
        else{
             $status=false;
                    $message="unsuccessful";
                    $msglog="User register unsuccessful cz not fill all detail";
                    $msgtxt="Please fill all detail and tnc ";
            
             echo json_encode([
                    'status' =>$status,
                    'message' =>$message,
                    'mesejlog' =>$msglog,
                    'msgtxt' =>$msgtxt,
                    'count_result' =>0,
                    'data' =>[]
                    ], JSON_PRETTY_PRINT);
        }
   
        
          

 
    }
    else{
        
        
         echo json_encode([
                    'status' => false,
                    'message' =>"Invalid token Api access",
                    'mesejlog' =>"Invalid token Api access",
                    'msgtxt' =>"Invalid token Api access",
                    'count_result' => 0,
                    'data' =>[]
                    ], JSON_PRETTY_PRINT);

        
    }

















?>