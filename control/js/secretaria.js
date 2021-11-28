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
    }).on("load.rs.jquery.bootgrid", function (e)
    {
        console.log(e);
    });
}