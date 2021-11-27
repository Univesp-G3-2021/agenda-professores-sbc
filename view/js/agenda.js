var modAgenda = {
    load: function(){
        $('#nav-tabContent').empty().html("<div id='agenda'></div>");
        $("#nav-tabContent #agenda").fullCalendar({
            header: {
                left: "prev,next today",
                center: "title",
                right: "month,agendaWeek,agendaDay,listMonth"
            },
            height: function(){return $("#nav-tabContent").innerHeight()-5;},
            defaultView: "agendaWeek",
            selectable: true,
            locale: "pt-br",
            buttonIcons: true,
            weekNumbers: true,
            navLinks: true, 
            editable: true,
            eventLimit: true, 
            minTime: "00:00:00",
            maxTime: "23:59:59",
            scrollTime: "07:00:00",
            slotEventOverlap: false,
            businessHours: {
                daysOfWeek: [ 1, 2, 3, 4, 5 ],
                startTime: '07:00',
                endTime: '17:00',
            },
            windowResize: function(v) {
                $("#nav-tabContent #agenda").fullCalendar('option', 'height', $("#nav-tabContent").innerHeight()-5);                        
            },
            eventSources: [
/*                {
                    events: function(start, end, timezone, callback){
                        var d0 = start._d.toISOString().split('T')[0];
                        var d1 = end._d.toISOString().split('T')[0];
                        $.ajax({
                            type: "GET",
                            url: "/model/apsbc_model.php?className=Agenda&methodName=listMovimentosByDate&arguments="+d0+","+d1,
                            success: function(res){
                                var fs = [];
                                for(var doc of res){
                                    fs.push({
                                        start: new Date(doc.sol_agenda_inicio).toISOString(),
                                        end: new Date(doc.sol_agenda_termino).toISOString(),
                                        title: doc.esc_nome + "\n" + doc.cls_descricao + "\n" + doc.prf_volante_nome
                                    });
                                }
                                callback(fs);
                            },
                            error: function(e){}
                        });
                    },
                    color: 'yellow',
                    textColor: 'black'
                }
            */            ],
            events:[{
                id: "999",
                title: "Sample Event",
                start: "2021-10-06T09:30:00",
                end: "2021-10-06T10:30:00"
            }]
        });
    }
}