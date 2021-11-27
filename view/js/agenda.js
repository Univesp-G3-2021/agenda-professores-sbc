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
            eventSources: [],
            events:[{
                id: "999",
                title: "Sample Event",
                start: "2021-10-06T09:30:00",
                end: "2021-10-06T10:30:00"
            }]
        });
    }
}