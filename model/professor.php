<?php
header('Content-Type: application/json; charset=utf-8');
include_once '../includes/mysql.php';

class Professor{

    public static function listAll(){
        $res = MySQL::query('SELECT * FROM professores');
        echo json_encode($res);
    }

    public static function listByEscola($esc_codigo){
        $res = MySQL::query("SELECT * FROM professores WHERE esc_codigo='$esc_codigo'");
        echo json_encode($res);
    }

    public static function getByClasse($cls_codigo){
        $res = MySQL::query("SELECT professores.* FROM professores,classe WHERE classe.cls_codigo='$cls_codigo' AND professores.prf_codigo=classe.prf_codigo");
        //$prf_codigo = $cls[0]['prf_codigo'];
        //$res = MySQL::query("SELECT * FROM professores WHERE prf_codigo='$prf_codigo'");
        echo json_encode($res);
    }

}

?>