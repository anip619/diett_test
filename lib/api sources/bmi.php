<?php
header('Content-Type: application/json');
require_once('config.php');

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);



 
    //check if login form is submitted
  //  if(isset($_POST['action']) && $_POST['action']=="login"){
        //assign variables to post values
        //$user_email = $_POST['user_phone'];
        //$user_password =$_POST['user_password'];
        $data = array();
 
       
 
        //get the user with email
        $stmt = $db->prepare('SELECT * FROM calculateBMI WHERE UserID="'.$_POST['UserID'].'" ORDER BY bmiDate DESC
LIMIT 1');
        //echo $stmt;
 
       
            $stmt->execute();
         
 
            //check if email exist
            if($stmt->rowCount() > 0){
              
                //get the row
                $user = $stmt->fetch();
 
                //validate inputted password with $user password
            //$hash=password_hash($password, PASSWORD_DEFAULT);
            //$a=$user_password;
            //$b=$user['user_password'];
               
                  
                    //action after a successful login
                    //for now just message a successful login
                        if($stmt->execute()){
                          while ($row = $stmt->fetchAll(PDO::FETCH_ASSOC)) {
                                $data= $row;
                            }
                          }else{
                    $status=false;
                     $record_no="false";
                    $message="unsuccessful";
                    $msglog="list unsuccessful";
                    $msgtxt="list bmi fail";
            }
                    
                    
                    
                    
                    
                    $status=true;
                    $record_no="true";
                    $message="successful";
                    $msglog="list successful";
                    $msgtxt="list babyhatch done";
             
                
            }
            else{
                    $status=true;
                    $record_no="false";
                    $message="no record";
                    $msglog="list no record";
                    $msgtxt="list bmi no record";
            }
 
      
        
         echo json_encode([
                    'status' =>$status,
                    'message' =>$message,
                    'mesejlog' =>$msglog,
                    'record_no' =>$record_no,
                    'msgtxt' =>$msgtxt,
                    'count_result' =>$stmt->rowCount(),
                    'data' =>$data
                    ], JSON_PRETTY_PRINT);

 
   /* }
    else{
        
        
         echo json_encode([
                    'status' => false,
                    'message' =>"Invalid token Api access",
                    'mesejlog' =>"Invalid token Api access",
                    'msgtxt' =>"Invalid token Api access",
                    'count_result' => 0,
                    'data' =>[]
                    ], JSON_PRETTY_PRINT);

        
    }*/

















?>