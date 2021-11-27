var loadPrecisoVolanteGrid = function(){
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
}

var loadSelectClasses = function(_esc_codigo){
    $.get("/model/apsbc_model.php?className=Classe&methodName=listByEscola&arguments="+_esc_codigo,{},function(data){
        $("#sel_cls_codigo").empty();
        $("#sel_cls_codigo").append("<option value='' disabled>-- escolha uma turma</option>");
        for(var doc of data){
            $("#sel_cls_codigo").append("<option value='"+doc.cls_codigo+"'>"+doc.cls_descricao+" - "+doc.cls_turno+" (Prof. "+doc.prf_nome+")</option>");
        }
    });
    $("#sel_cls_codigo").on("change", function(){
        var _cls_codigo = $("#sel_cls_codigo option:selected").val();
        console.log(_esc_codigo);
    });
}