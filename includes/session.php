<?php
session_start();
$isIndex = ($_SERVER['SCRIPT_FILENAME']==$_SERVER['DOCUMENT_ROOT'] || $_SERVER['SCRIPT_FILENAME']==($_SERVER['DOCUMENT_ROOT']."/index.php"));
$req_id = isset($_REQUEST["id"]) ? "?id=".$_REQUEST["id"] : "";
if($isIndex){
	if(is_null(sessionGet("uid"))) {
		header("Location: /auth".$req_id);
	}else{
		header("Location: /profile".$req_id);
	}
	die();
}
$POSTDATA = json_decode(file_get_contents("php://input"),true);
header('Content-type:application/json;charset=utf-8');

if(substr($_SERVER['SCRIPT_NAME'], 0, 5)!="/auth" && is_null(sessionGet("uid"))){
	echo json_encode(array("status"=>-1));
	die();
}

function principal(){
	$usr = array("id"=>null, "name"=>"anonymous");
	if(sessionGet("uid")!=null)	{
		$usr = json_decode(DB::selectId("users", sessionGet("uid"))[0][1], true);
		$usr["id"] = sessionGet("uid");
	}
	return array("usr"=>$usr);
}

function logout(){
	$_SESSION["singleton"] = array();
}
function sessionSet($key, $value){
	if(!isset($_SESSION["singleton"])) logout();
	$_SESSION["singleton"][$key]=$value;
	if($value==null) unset($_SESSION["singleton"][$key]);
}
function sessionGet($key){
	if(!isset($_SESSION["singleton"])) logout();
	if(!isset($_SESSION["singleton"][$key])) return null;
	return $_SESSION["singleton"][$key];
}

function _log($msg){
	$db = new DBConn();
	$log  = addslashes(date("c")."|".$_SERVER['REMOTE_ADDR']."|".sessionGet("uid")."|".$msg).PHP_EOL;
	$q = "INSERT INTO syslog (uid, log) VALUES ('".sessionGet("uid")."', '$log')";
	if (!$db->getConn()->query($q)) file_put_contents('../../logs/log_'.date("Ym").'.log', $log, FILE_APPEND);
}

include_once 'mysql.php';

?>