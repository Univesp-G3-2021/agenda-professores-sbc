var loadGridSolicitacoes = function(){
    $("#grid_home_secretaria").bootgrid({
        ajax: true,
        ajaxSettings: {
            method: "GET",
            cache: false
        },
        url: "/model/apsbc_model.php?className=Agenda&methodName=gridSolicitacoes&arguments=1,10",
        formatters:{},
        selection: true,
        rowSelect: true,
        labels:{
            noResults: "sem registros",
            infos: "exibindo {{ctx.start}} a {{ctx.end}} de {{ctx.total}} registro(s)",
            loading: "carregando do banco de dados...",
            all: "todos",
            refres: "recarregar",
            search: "localizar"
        }
    }).on("click.rs.jquery.bootgrid", function (evt,cols,row){
        window.location.href="/view/secretaria/solicitacoes.html?sol="+row.sol_codigo;
    });
}

var loadSolicitacao = function(){
    const urlParams = new URLSearchParams(window.location.search);
    const sol_codigo = urlParams.get('sol');
    $.get("/model/apsbc_model.php?className=Solicitacao&methodName=get&arguments="+sol_codigo,{},function(res){
        $("#esc_nome").html(res.esc_nome);
        $("#prf_nome").html(res.prf_nome);
        $("#sol_agenda_inicio").html(res.sol_agenda_inicio);
        $("#sol_agenda_termino").html(res.sol_agenda_termino);
        $("#cls_turno").html(res.cls_turno);
        $("#cls_descricao").html(res.cls_descricao);
        $("#sol_motivo").html(res.sol_motivo);
        $("#sol_comprovante").html(res.sol_comprovante);
        $("#sol_obs").html(res.sol_obs);
    });
}