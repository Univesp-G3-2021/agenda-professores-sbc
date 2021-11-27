var modSecretaria = {
    load: function(){
        //$('#nav-tabContent').empty().load("/view/secretaria/home_secretaria.html", function(){});
        $("#grid_home_secretaria").bootgrid({
            ajax: true,
            url: "/model/apsbc_model.php?className=Agenda&methodName=gridSolicitacoes&arguments=1,10",
            formatters:{}
        });
    }
}
$(function(){
    modSecretaria.load();
});