var loadPrecisoVolanteGrid = function(){
    $("#grid_preciso_volante").bootgrid({
        ajax: true,
        ajaxSettings: {
            method: "GET",
            cache: false
        },
        url: "/model/apsbc_model.php?className=Classe&methodName=gridAll&arguments=1,10",
        formatters:{},
        navigation: 0,
        rowCount: -1,
        selection: true,
        labels:{
            noResults: "sem registros",
            infos: "exibindo {{ctx.start}} a {{ctx.end}} de {{ctx.total}} registro(s)",
            loading: "carregando do banco de dados...",
            all: "todos",
            refres: "recarregar",
            search: "localizar"
        }
    }).on("load.rs.jquery.bootgrid", function (e)
    {
        console.log(e);
    });
}

var loadSelectClasses = function(_esc_codigo){
    $.get("/model/apsbc_model.php?className=Classe&methodName=listByEscola&arguments="+_esc_codigo,{},function(data){
        $("#sel_cls_codigo").empty();
        $("#sel_cls_codigo").append("<option value='' disabled selected>Turma / Período / Professor</option>");
        for(var doc of data){
            $("#sel_cls_codigo").append($("<option value='"+doc.cls_codigo+"'>"+doc.cls_descricao+" - "+doc.cls_turno+" (Prof. "+doc.prf_nome+")</option>").prop("doc",doc));
        }
    });
}

var novaSolicitacao = function(){
    var solicitacao = $("#sel_cls_codigo option:selected").prop("doc") || {};
    solicitacao.sol_agenda_inicio = $("#sol_data_inicio").val();
    solicitacao.sol_agenda_termino = $("#sol_data_fim").val();
    solicitacao.sol_motivo = $("#sol_motivo option:selected").val();
    solicitacao.sol_obs = $("#sol_obs").text().trim()+" ";
    if(!!solicitacao.prf_codigo && solicitacao.sol_motivo!="" && solicitacao.sol_agenda_inicio!="" && solicitacao.sol_agenda_termino!=""){
        $.post("/model/apsbc_model.php?className=Solicitacao&methodName=createSolicitacao&arguments=1",JSON.stringify(solicitacao),function(res){
            if(res.status=="created") window.location.href='/view/secretaria/home_secretaria.html';
            else alert("Erro ao criar solicitação!");
        });
    }else alert("Por favor, preencha os campos obrigatórios!");
}