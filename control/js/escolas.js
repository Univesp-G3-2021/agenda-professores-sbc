var loadGridEscolas = function(){
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
    }).on("load.rs.jquery.bootgrid", function (e){
        console.log(e);
    });

};

var loadSelectEscolas = function(){
    $.get("/model/apsbc_model.php?className=Escola&methodName=listAll&arguments=0",{},function(data){
        $("#sel_esc_codigo").empty();
        $("#sel_esc_codigo").append("<option value='' disabled>-- escolha uma escola</option>");
        for(var doc of data){
            $("#sel_esc_codigo").append("<option value='"+doc.esc_codigo+"'>"+doc.esc_nome+"</option>");
        }
    });
    $("#sel_esc_codigo").on("change", function(){
        var _esc_codigo = $("#sel_esc_codigo option:selected").val();
        loadSelectClasses(_esc_codigo);
    });
}