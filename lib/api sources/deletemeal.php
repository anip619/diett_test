<?php
header('Content-Type: application/json');
require_once('config.php');

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


    $mealID = $_POST['mealID'];

   // $statement = $db->prepare("select * from planperkara WHERE kpi_id='".$param."'");
/* $statement = $db->prepare("SELECT planperkara.id_planperkara, planperkara.kpi_id, planperkara.id_kategori, planperkara.remainderdate,kategori.kpi_title AS title FROM planperkara INNER JOIN kategori ON kategori.kpi_id=planperkara.id_kategori where planperkara.kpi_id='".$param."'");
*/
 $statement = $db->prepare("DELETE FROM Meal where mealID='".$mealID."'");

//$statement->bindParam(':plan2_id', $plan2_id);
//$statement->bindParam(':kategori_id', $kategori_id);
$statement->execute();


					

//$statement->execute();
//$row = $statement->fetch(); 

$countx=0;
 $data = array();
        if($statement->execute()){
          
           
         
        header("Access-Control-Allow-Origin: *");//this allows cors
        header('Content-Type: application/json');
       //$data= json_encode($data);



//$uu = 
//echo $result;
echo json_encode([
'status' => true,
'message' => "",
'mesejlog' => "deletesuccessfull",
'mesejayat' => "Successfull Delete Data.",
'count_result' => count($data),
'data' =>$data
], JSON_PRETTY_PRINT);

    }else{
         echo json_encode([
'status' => false,
'message' => "",
'mesejlog' => "",
'mesejayat' => "No record.x",
'count_result' => count($data),
'data' =>$data
], JSON_PRETTY_PRINT); 
    }


















?>