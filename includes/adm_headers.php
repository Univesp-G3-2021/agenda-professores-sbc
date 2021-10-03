<?php
session_start();

$isIndex = ($_SERVER['SCRIPT_FILENAME']==$_SERVER['DOCUMENT_ROOT']."/admin" || $_SERVER['SCRIPT_FILENAME']==($_SERVER['DOCUMENT_ROOT']."/admin/index.php"));
$req_id = isset($_REQUEST["id"]) ? "?id=".$_REQUEST["id"] : "";
if($isIndex){
	if(is_null(sessionGet("uid"))) {
		header("Location: /admin/auth");
	}else{
		header("Location: /admin/settings");
	}
	die();
}
$POSTDATA = json_decode(file_get_contents("php://input"),true);
header('Content-type:application/json;charset=utf-8');

if(substr($_SERVER['SCRIPT_NAME'], 0, 11)!="/admin/auth" && is_null(sessionGet("uid"))){
	echo json_encode(array("status"=>-1));
	die();
}

function logout(){
	$_SESSION["admin"] = array();
}
function sessionSet($key, $value){
	if(!isset($_SESSION["admin"])) logout();
	$_SESSION["admin"][$key]=$value;
}
function sessionGet($key){
	if(!isset($_SESSION["admin"])) logout();
	if(!isset($_SESSION["admin"][$key])) return null;
	return $_SESSION["admin"][$key];
}
function _log($msg){
	$db = new DBConn();
	$log  = addslashes(date("c")."|".$_SERVER['REMOTE_ADDR']."|".sessionGet("uid")."|ADMIN - ".$msg).PHP_EOL;
	$q = "INSERT INTO syslog (uid, log) VALUES ('".sessionGet("uid")."', '$log')";
	if (!$db->getConn()->query($q)) file_put_contents('../../logs/log_'.date("Ym").'.log', $log, FILE_APPEND);
}

include_once 'mysql.php';
?>