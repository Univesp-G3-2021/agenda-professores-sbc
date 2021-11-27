//$(function(){

    $("#grid_preciso_volante").one("load", function(){
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
    });

//});