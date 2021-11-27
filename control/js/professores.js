var modProfessores = {
    load: function(){
        $('#nav-tabContent').empty().load("/view/professores/professores.html", function(){

        });
    }
}