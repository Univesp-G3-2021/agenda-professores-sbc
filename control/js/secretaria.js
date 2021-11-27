var modSecretaria = {
    load: function(){
        //$('#nav-tabContent').empty().load("/view/secretaria/home_secretaria.html", function(){});
        $("#grid_home_secretaria").bootgrid({
            ajax: true,
            ajaxSettings: {
                method: "GET",
                cache: false
            },
            url: "/model/apsbc_model.php?className=Agenda&methodName=gridSolicitacoes&arguments=1,10",
            formatters:{}
        }).on("load.rs.jquery.bootgrid", function (e)
        {
            console.log(e);
        });
    }
}


$(function(){
    modSecretaria.load();
});