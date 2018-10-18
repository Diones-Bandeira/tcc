//*** Executa Server CALLBACK e retorna resultado
function CallServerFunction(StrPriUrl, ObjPriData, CallBackFunction) {

    $.ajax({
        type: "post",
        url: StrPriUrl,
        contentType: "application/json; charset=utf-8",
        data: ObjPriData,
        dataType: "json",
        success: function (result) {
            if (CallBackFunction !== null && typeof CallBackFunction !== 'undefined') {
                CallBackFunction(result);
            }
        },
        error: function (result) {

            console.log(result);
        },
        async: true
    });
}

//*** Realiza POST através de comando
function DoPost(action, fields)
{
    //*** Cria string para montagem dos elementos do FORM
    var form = '';

    //*** Varre coleção de valores via JQUERY
    $.each(fields, function (index, value)
    {
        //*** Adiciona valor atual
        form += '<input type="hidden" name="' + value.key + '" value="' + value.value + '">';
    });

    //*** Realiza postragem
    $('<form action="' + action + '" method="POST">' + form + '</form>').appendTo('body').submit();
}
