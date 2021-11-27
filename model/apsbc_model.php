<?php
header('Content-Type: application/json; charset=utf-8');
include_once '../includes/mysql.php';

class Escola{

    public static function listAll(){
        $res = MySQL::query("SELECT * FROM escolas");
        echo json_encode($res);
    }

    public static function get($esc_codigo){
        $res = MySQL::query("SELECT * FROM escolas WHERE esc_codigo='$esc_codigo'");
        echo json_encode($res[0]);
    }

    public static function listByNome($esc_nome){
        $res = MySQL::query("SELECT * FROM escolas WHERE esc_nome LIKE '%$esc_nome%'");
        echo json_encode($res);
    }

    public static function listByBairro($esc_bairro){
        $res = MySQL::query("SELECT * FROM escolas WHERE esc_bairro LIKE '%$esc_bairro%'");
        echo json_encode($res);
    }

    public static function getByClasse($cls_codigo){
        $res = MySQL::query("SELECT escolas.* FROM classe,escolas WHERE classe.cls_codigo='$cls_codigo' AND classe.esc_codigo=escolas.esc_codigo");
        echo json_encode($res[0]);
    }

    public static function listContatos($esc_codigo){
        $res = MySQL::query("SELECT * FROM contatos WHERE esc_codigo='$esc_codigo'");
        echo json_encode($res);
    }

}

class Professor{

    public static function listAll(){
        $res = MySQL::query("SELECT * FROM professores");
        echo json_encode($res);
    }

    public static function get($prf_codigo){
        $res = MySQL::query("SELECT * FROM professores WHERE prf_codigo='$prf_codigo'");
        echo json_encode($res[0]);
    }

    public static function listByNome($prf_nome){
        $res = MySQL::query("SELECT * FROM professores WHERE prf_nome LIKE '%$prf_nome%'");
        echo json_encode($res);
    }

    public static function listByEscola($esc_codigo){
        $res = MySQL::query("SELECT * FROM professores WHERE esc_codigo='$esc_codigo'");
        echo json_encode($res);
    }

    public static function listByCondicao($prf_condicao){
        $res = MySQL::query("SELECT * FROM professores WHERE prf_condicao='$prf_condicao'");
        echo json_encode($res);
    }

    public static function listByCondicaoByEscola($prf_condicao, $esc_codigo){
        $res = MySQL::query("SELECT * FROM professores WHERE esc_codigo='$esc_codigo' AND prf_condicao='$prf_condicao'");
        echo json_encode($res);
    }

    public static function getByClasse($cls_codigo){
        $res = MySQL::query("SELECT professores.* FROM classe,professores WHERE classe.cls_codigo='$cls_codigo' AND classe.prf_codigo=professores.prf_codigo");
        echo json_encode($res[0]);
    }

}

class Classe{

    public static function get($cls_codigo){
        $res = MySQL::query("SELECT * FROM classe WHERE cls_codigo='$cls_codigo'");
        echo json_encode($res[0]);
    }

    public static function listByEscola($esc_codigo){
        $res = MySQL::query("SELECT * FROM classe WHERE esc_codigo='$esc_codigo'");
        echo json_encode($res);
    }

    public static function getByProfessor($prf_codigo){
        $res = MySQL::query("SELECT * FROM classe WHERE prf_codigo='$prf_codigo'");
        echo json_encode($res[0]);
    }

}

class Agenda{

    public static function listSolicitacoesByDate($sol_agenda_inicio, $sol_agenda_termino){
        $res = MySQL::query("SELECT * FROM agenda_solicitacoes_abertas WHERE sol_agenda_inicio>='$sol_agenda_inicio' AND sol_agenda_inicio<'$sol_agenda_termino'");
        echo json_encode($res);
    }

    public static function gridSolicitacoes($page=1, $limit=10, $searchPhrase=""){
        $offset = ($page-1) * $limit;
        
        $fullTxtSrch = "";
        if(strlen(trim($searchPhrase))>3) $fullTxtSrch = "WHERE esc_nome LIKE '%$searchPhrase%'"; 
        
        $ct = MySQL::query("SELECT count(sol_codigo) as quant FROM agenda_solicitacoes_abertas");
        $res = MySQL::query("SELECT * FROM agenda_solicitacoes_abertas $fullTxtSrch ORDER BY sol_agenda_inicio LIMIT $offset, $limit");
        echo json_encode(
            array(
                "current"=>$page, 
                "rowCount"=>$limit, 
                "rows"=>$res, 
                "total"=>$ct[0]["quant"]
            )
        );
    }

    public static function listMovimentosByDate($sol_agenda_inicio, $sol_agenda_termino){
        $res = MySQL::query("SELECT * FROM agenda_volantes WHERE sol_agenda_inicio>='$sol_agenda_inicio' AND sol_agenda_inicio<'$sol_agenda_termino'");
        echo json_encode($res);
    }

    public static function listMovimentosByDateByVolante($sol_agenda_inicio, $sol_agenda_termino, $prf_volante){
        $res = MySQL::query("SELECT * FROM agenda_volantes WHERE sol_agenda_inicio>='$sol_agenda_inicio' AND sol_agenda_inicio<'$sol_agenda_termino' AND prf_volante='$prf_volante'");
        echo json_encode($res);
    }
    
    public static function listVolantesLivres($sol_agenda_inicio, $sol_agenda_termino){
        $res = MySQL::query("SELECT * FROM professores WHERE prf_condicao='volante' AND prf_codigo NOT IN (SELECT prf_volante FROM agenda WHERE sol_agenda_inicio>='$sol_agenda_inicio' AND sol_agenda_inicio<'$sol_agenda_termino')");
        echo json_encode($res);
    }

}

/*****************************
 *  REFLECTION METHOD CALL
 ****************************/

function doIt($className, $methodName, $arguments = []){
    $ref = new ReflectionMethod($className, $methodName);
    $ref->invokeArgs(NULL, $arguments);
}

try{
    error_log(json_encode($_REQUEST));
    if(isset($_REQUEST["current"])){
        doIt($_REQUEST["className"], $_REQUEST["methodName"], array($_REQUEST["current"], $_REQUEST["rowCount"], $_REQUEST["searchPhrase"]));    
    }else{
        doIt($_REQUEST["className"], $_REQUEST["methodName"], explode(",", $_REQUEST["arguments"]));
    }
}catch(Exception $e){
    http_response_code(400);
    echo json_encode($e);
}

?>