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
        console.log(res);
    });
}