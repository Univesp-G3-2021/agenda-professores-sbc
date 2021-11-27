var modEscolas = {
    load: function(){
        $("#grid_home_escolas").bootgrid({
            ajax: true,
            ajaxSettings: {
                method: "GET",
                cache: false
            },
            url: "/model/apsbc_model.php?className=Escola&methodName=gridAll&arguments=1,10",
            formatters:{},
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
}


$(function(){
    modEscolas.load();
});