/*************************************************************************
 * 
 *   PJI110 Projeto Integrador Em Computação I 
 * 
 *   Software de identificação de disponibilidade de professores volantes
 *   para cobrir faltas de professores titulares da rede municipal de São
 *   Bernardo do Campo utilizando framework web, banco de dados e versio-
 *   namento. 
 * 
 * 
 *   GRUPO 3
 * 
 *   Andre de Oliveira Mendes Casanova <2000839@aluno.univesp.br> 
 *   Bruna Martins Rogante <2014481@aluno.univesp.br>
 *   Emerson de Mattos Reis <2009360@aluno.univesp.br>
 *   Guilherme Padilha Batista <2011386@aluno.univesp.br>
 *   Marcos Lohmann <2006775@aluno.univesp.br>
 *   Rodrigo Henrique Machado da Silva <1402332@aluno.univesp.br> 
 *   Victoria Sayuri Ishibaru da Silva <2007625@aluno.univesp.br>
 * 
 *************************************************************************/

var _userPrincipalData = "";
var _userPrincipal = function(){ return JSON.parse(atob(atob(_userPrincipalData))); }
var _getUptkn = function(){ return _userPrincipalData; }

$(function(){
    loading_bar = $("<img src='/view/imgs/loading.gif'>");
    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader("uptkn", _getUptkn());
        },
        complete: function(xhr,sts){
            if(xhr.status==403 || xhr.status==0) _loadHome();
        }
    });
    var _loadHome = function(){
        $('body').empty().load('/view/home.html',{},function(){
            $("#agenda").fullCalendar({
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
                windowResize: function(view) {
                    $("#agenda").fullCalendar('option', 'height', $("#nav-tabContent").innerHeight()-5);                        
                },
                eventSources: [],
                events:[{
                    id: "999",
                    title: "Sample Event",
                    start: "2021-10-06T09:30:00",
                    end: "2021-10-06T10:30:00"
                }]
            });
        });
    }
    _loadHome();
});
