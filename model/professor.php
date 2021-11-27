<?php
header('Content-Type: application/json; charset=utf-8');
include_once '../includes/mysql.php';

$res = MySQL->query('SELECT * FROM professores');
echo json_encode($res);
?>