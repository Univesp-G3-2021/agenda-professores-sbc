var modEscolas = {
    load: function(){
        $("#grid_home_escolas").bootgrid({
            ajax: true,
            ajaxSettings: {
                method: "GET",
                cache: false
            },
            url: "/model/apsbc_model.php?className=Escola&methodName=listAll&arguments=",
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