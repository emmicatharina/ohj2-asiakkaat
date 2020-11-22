<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
#listaus {
    font-family: Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#listaus td, #listaus th {
    border: 1px, solid #ddd;
    padding: 6px;
}

#listaus tr:ntn-child(even){background-color: #f2f2f2;}

#listaus tr:hover {background-color: #ddd;}

#listaus th {
    padding-top: 8px;
    padding-bottom: 8px;
    text-align: left;
    background-color: #E78CC5;
    color: white;
}
</style>
<title>Asiakkaat</title>
</head>
<body>
<table id="listaus">
    <thead>
        <tr>
            <th class="oikealle">Hakusana:</th>
            <th colspan="2"><input type="text" id="hakusana"></th>
            <th><input type="button" value="hae" id="hakunappi"></th>
        </tr>
        <tr>
            <th>Etunimi</th>
            <th>Sukunimi</th>
            <th>Puhelin</th>
            <th>Sähköposti</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<script>
    $(document).ready(function() {
        haeAsiakkaat();
        $("#hakunappi").click(function(){
            console.log($("#hakusana").val());
            haeAsiakkaat();
        });
        $(document.body).on("keydown", function(event) {
            if(event.which == 13) {
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