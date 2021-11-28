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
        $("#esc_bairro").html(res.esc_bairro);
        $("#prf_nome").html(res.prf_nome);
        $("#sol_agenda_inicio").html(new Date(res.sol_agenda_inicio).toLocaleDateString());
        $("#sol_agenda_termino").html(new Date(res.sol_agenda_termino).toLocaleDateString());
        $("#cls_turno").html(res.cls_turno);
        $("#cls_descricao").html(res.cls_descricao);
        $("#sol_motivo").html(res.sol_motivo);
        $("#sol_comprovante").html(res.sol_comprovante);
        $("#sol_obs").html(res.sol_obs);
        $("#input_sol_agenda_inicio").val(res.sol_agenda_inicio);
        $("#input_sol_agenda_termino").val(res.sol_agenda_termino);

        $("#grid_volantes_disponiveis").bootgrid({
            ajax: true,
            ajaxSettings: {
                method: "GET",
                cache: false
            },
            url: "/model/apsbc_model.php?className=Agenda&methodName=gridVolantesLivres&arguments="+$("#input_sol_agenda_inicio").val()+","+$("#input_sol_agenda_termino").val(),
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
            //window.location.href="/view/secretaria/solicitacoes.html?sol="+row.sol_codigo;
        });
    
    });


}