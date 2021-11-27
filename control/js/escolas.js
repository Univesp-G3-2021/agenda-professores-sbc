var modEscolas = {
    load: function(){
        $("#grid_home_escolas").bootgrid({
            ajax: true,
            ajaxSettings: {
                method: "GET",
                cache: false
            },
            url: "/model/apsbc_model.php?className=Escola&methodName=gridAll&arguments=1,10",
            formatters:{}
        }).on("load.rs.jquery.bootgrid", function (e)
        {
            console.log(e);
        });
    }
}


$(function(){
    modEscolas.load();
});