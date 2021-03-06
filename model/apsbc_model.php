<?php
header('Content-Type: application/json; charset=utf-8');
include_once '../includes/mysql.php';

class Escola{

    public static function listAll(){
        $res = MySQL::query("SELECT * FROM escolas");
        echo json_encode($res);
    }

    public static function gridAll($page=1, $limit=10, $searchPhrase=""){
        $offset = ($page-1) * $limit;
        
        $fullTxtSrch = "";
        if(strlen(trim($searchPhrase))>3) $fullTxtSrch = "WHERE esc_nome LIKE '%$searchPhrase%'"; 
        
        $ct = MySQL::query("SELECT count(esc_codigo) as quant FROM escolas");
        $res = MySQL::query("SELECT * FROM escolas $fullTxtSrch ORDER BY esc_codigo LIMIT $offset, $limit");
        echo json_encode(
            array(
                "current"=>$page, 
                "rowCount"=>$limit, 
                "rows"=>$res, 
                "total"=>$ct[0]["quant"]
            )
        );
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
        $res = MySQL::query("SELECT * FROM classe_detalhe WHERE cls_codigo='$cls_codigo'");
        echo json_encode($res[0]);
    }

    public static function gridAll($page=1, $limit=10, $searchPhrase=""){
        $offset = ($page-1) * $limit;
        
        $qLimit = " LIMIT $offset, $limit";
        if($limit == -1) $qLimit = "";
        
        $fullTxtSrch = "";
        if(strlen(trim($searchPhrase))>3) $fullTxtSrch = "WHERE esc_nome LIKE '%$searchPhrase%'"; 
        
        $ct = MySQL::query("SELECT count(cls_codigo) as quant FROM classe_detalhe");
        $res = MySQL::query("SELECT * FROM classe_detalhe $fullTxtSrch ORDER BY esc_nome $qLimit");
        echo json_encode(
            array(
                "current"=>$page, 
                "rowCount"=>$limit, 
                "rows"=>$res, 
                "total"=>$ct[0]["quant"]
            )
        );
    }

    public static function listByEscola($esc_codigo){
        $res = MySQL::query("SELECT * FROM classe_detalhe WHERE esc_codigo='$esc_codigo'");
        echo json_encode($res);
    }

    public static function getByProfessor($prf_codigo){
        $res = MySQL::query("SELECT * FROM classe_detalhe WHERE prf_codigo='$prf_codigo'");
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

    public static function gridVolantesLivres($page=1, $limit=10, $searchPhrase="", $sol_agenda_inicio, $sol_agenda_termino){
        $offset = ($page-1) * $limit;
        
        $fullTxtSrch = "";
        if(strlen(trim($searchPhrase))>3) $fullTxtSrch = "WHERE prf_nome LIKE '%$searchPhrase%'"; 
        
        $ct = MySQL::query("SELECT count(prf_codigo) as quant FROM professores WHERE prf_condicao='volante'");
        $res = MySQL::query("SELECT * FROM professor_escola WHERE prf_condicao='volante' AND prf_codigo NOT IN (SELECT prf_volante FROM agenda WHERE sol_agenda_inicio>='$sol_agenda_inicio' AND sol_agenda_inicio<'$sol_agenda_termino')");
        echo json_encode(
            array(
                "current"=>$page, 
                "rowCount"=>$limit, 
                "rows"=>$res, 
                "total"=>$ct[0]["quant"]
            )
        );
    }

}

class Solicitacao{

    public static function get($sol_codigo){
        $res = MySQL::query("SELECT * FROM agenda_solicitacoes_abertas WHERE sol_codigo='$sol_codigo'");
        echo json_encode($res[0]);
    }

    public static function createSolicitacao($payload){
        $body = json_decode($payload, true);
        $q = "INSERT INTO solicitacoes (sol_codigo,prf_codigo,sol_datahora,sol_agenda_inicio,sol_agenda_termino,cls_codigo,sol_motivo,sol_comprovante,sol_atendida,sol_ativa) VALUES (NULL,'".$body["prf_codigo"]."',NOW(),'".$body["sol_agenda_inicio"]."','".$body["sol_agenda_termino"]."','".$body["cls_codigo"]."','".$body["sol_motivo"]."','',0,1)";
        $res = MySQL::update($q);
        error_log($res);
        error_log($q);
        if($res==1) echo json_encode(array("status"=>"created"));
        else echo json_encode(array("status"=>"failed"));
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
    try{
        $payload = file_get_contents('php://input');
    }catch(Exception $e){
        unset($payload);
    }
    if(isset($payload) && !empty($payload)){
        doIt($_REQUEST["className"], $_REQUEST["methodName"], array($payload));    
    }else if(isset($_REQUEST["current"])){
        doIt($_REQUEST["className"], $_REQUEST["methodName"], array_merge(array($_REQUEST["current"], $_REQUEST["rowCount"], $_REQUEST["searchPhrase"]),explode(",", $_REQUEST["arguments"])));    
    }else{
        doIt($_REQUEST["className"], $_REQUEST["methodName"], explode(",", $_REQUEST["arguments"]));
    }
}catch(Exception $e){
    http_response_code(400);
    echo json_encode($e);
}

?>