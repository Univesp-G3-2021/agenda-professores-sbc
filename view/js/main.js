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
            // implementar login
        });
    }
    _loadHome();
});
