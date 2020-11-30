<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaat</title>
</head>
<body>
<table id="listaus">
    <thead>
        <tr>
            <th colspan="5" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
        </tr>
        <tr>
            <th class="oikealle">Hakusana:</th>
            <th colspan="3"><input type="text" id="hakusana" placeholder="Kirjoita hakusana..."></th>
            <th class="vasemmalle"><input type="button" value="Hae" id="hakunappi"></th>
        </tr>
        <tr>
            <th class="vasemmalle">Etunimi</th>
            <th class="vasemmalle">Sukunimi</th>
            <th class="vasemmalle">Puhelin</th>
            <th class="vasemmalle">Sähköposti</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<script>
$(document).ready(function() {
    $("#uusiAsiakas").click(function() {
        document.location="lisaaasiakas.jsp";
    });
    
    haeAsiakkaat();
    $("#hakunappi").click(function(){
        haeAsiakkaat();
    });

    $(document.body).on("keydown", function(event) {
        if (event.which == 13) {
            haeAsiakkaat();
        }
    });
    $("#hakusana").focus();
});

function haeAsiakkaat() {
    $("#listaus tbody").empty();
    $.ajax({url:"asiakkaat/" + $("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {
            $.each(result.asiakkaat, function(i, field) {
                var htmlStr;
                htmlStr += "<tr>";
                htmlStr += "<td>" + field.etunimi + "</td>";
                htmlStr += "<td>" + field.sukunimi + "</td>";
                htmlStr += "<td>" + field.puhelin + "</td>";
                htmlStr += "<td>" + field.sposti + "</td>";
                htmlStr += "<tr>";
                $("#listaus tbody").append(htmlStr);    
            });
        }});
}
</script>
</body>
</html>