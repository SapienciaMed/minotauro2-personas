//= require jquery
//= require bootstrap-sprockets
//= require jquery.remotipart
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require autonumeric
//= require moment
//= require moment/es
//= require bootstrap-datetimepicker
//= require pickers
//= require plugins/select2/select2.full.min
//= require plugins/iCheck/icheck.min
//= require highcharts
//= require simple_form_autocomplete
//= require highcharts/highcharts-more
//= require highcharts/highcharts-3d.js
//= require highcharts/modules/annotations
//= require highcharts/modules/data
//= require highcharts/modules/drilldown
//= require highcharts/modules/exporting
//= require highcharts/modules/funnel
//= require highcharts/modules/heatmap
//= require highcharts/modules/no-data-to-display
//= require highcharts/modules/offline-exporting
//= require Chart.min
//= require dist/js/app.min
//= require bootstrap-wysihtml5
//= require underscore
//= require gmaps/google
//= require datatables
//= require_tree .

function cambiopropuesta(f) {
    if (f.solicitud_propuesta.value == "AMPLIACION DE PLAZO") {
        var elElemento1 = document.getElementById("mostrar1");
        var elElemento2 = document.getElementById("mostrar2");
        elElemento2.style.display = 'none';
        elElemento1.style.display = 'block';
    } else if (f.solicitud_propuesta.value == "DISMINUCION DE PLAZO") {
        var elElemento1 = document.getElementById("mostrar1");
        var elElemento2 = document.getElementById("mostrar2");
        elElemento2.style.display = 'none';
        elElemento1.style.display = 'block';
    } else if (f.solicitud_propuesta.value == "REESTRUCTURACION") {
        var elElemento1 = document.getElementById("mostrar1");
        var elElemento2 = document.getElementById("mostrar2");
        elElemento2.style.display = 'block';
        elElemento1.style.display = 'none';
    } else {
        var elElemento1 = document.getElementById("mostrar1");
        var elElemento2 = document.getElementById("mostrar2");
        elElemento1.style.display = 'none';
        elElemento2.style.display = 'none';
    }
}

$(function () {
    $(".select2").select2();
    $('.wysihtml5').wysihtml5();
    $('[data-toggle="popover"]').popover();
});

function copiarAlPortapapeles(id_elemento) {
    var aux = document.createElement("input");
    aux.setAttribute("value", document.getElementById(id_elemento).innerHTML);
    document.body.appendChild(aux);
    aux.select();
    document.execCommand("copy");
    document.body.removeChild(aux);
}

$("a[data-popover-title]").each(function (e, elem) {
    var _this = this;
    $(this).popover({
        title: $(this).data('popover-title'),
        content: $(this).data('popover-content'),
        trigger: "manual",
        animation: false
    }).on("mouseenter", function () {
        $(_this).popover("show");
    }).parent().on("mouseleave", function () {
        $(_this).popover("hide");
    })
});
$(function () {
    const datep = new Date()
    $('.datepicker').datepicker({
        dayNamesMin: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sáb"],
        monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        dateFormat: "yy-mm-dd",
        yearRange: '1900:2050',
        changeMonth: true,
        changeYear: true,
    });
    $('.datepickermoretime').datepicker({
        dayNamesMin: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sáb"],
        monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        dateFormat: "yy-mm-dd",
        yearRange: '1900:2040',
        changeMonth: true,
        changeYear: true,
    });
    $("#idforminit").submit(function () {
        $("#user_username").val();
        $("#user_password").val();
    });
    $(".datetimepicker").datetimepicker({
        showClear: true
    });
    $(".datetimepickerres").datetimepicker({
        showClear: true,
        minDate: new Date(),
        maxDate: datep.setMonth(datep.getMonth() + 1)
    });
});

function SINO(cual) {
    var elElemento = document.getElementById(cual);
    if (elElemento.style.display == 'block') {
        elElemento.style.display = 'none';
    } else {
        elElemento.style.display = 'block';
    }
}

function soloNumeros(e) {
    var key = window.Event ? e.which : e.keyCode
    return (key >= 48 && key <= 57)
}

function mostrar(selc) {
    if (selc.value == "per") {
        document.getElementById('persona').style.display = 'block'
        document.getElementById('nuevo').style.display = 'none'
    } else {
        document.getElementById('persona').style.display = 'none'
        document.getElementById('nuevo').style.display = 'block'
    }
}

function mostraralianza(selc) {
    if (selc.value == "sia") {
        document.getElementById('alianzasi').style.display = 'block'
    } else {
        document.getElementById('alianzasi').style.display = 'none'
    }
}

function mostrarconvenio(selc) {
    if (selc.value == "sic") {
        document.getElementById('conveniosi').style.display = 'block'
    } else {
        document.getElementById('conveniosi').style.display = 'none'
    }
}

function countChar(val) {
    var len = val.value.length;
    if (len >= 4000) {
        val.value = val.value.substring(0, 4000);
    } else {
        $('#charNum').text(4000 - len);
    }
};

function countChar2(val) {
    var len = val.value.length;
    if (len >= 500) {
        val.value = val.value.substring(0, 500);
    } else {
        $('#charNum').text(500 - len);
    }
};

function countChar3(val) {
    var len = val.value.length;
    if (len >= 500) {
        val.value = val.value.substring(0, 255);
    } else {
        $('#charNum').text(255 - len);
    }
};

function countChar4(val) {
    var len = val.value.length;
    if (len >= 4000) {
        val.value = val.value.substring(0, 4000);
    } else {
        $('#charNum').text(4000 - len);
    }
};

function countChar5(val) {
    var len = val.value.length;
    if (len >= 255) {
        val.value = val.value.substring(0, 255);
    } else {
        $('#charNum').text(255 - len);
    }
};
$(function () {
    return $('.select2Ciudad').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Seleccionar Ciudad... ]",
        ajax: {
            url: '/personas/search.json',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function (data) {
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name,
                            id: item.id
                        };
                    })
                };
            }
        }
    });
});


/// buscador paera nav - ul - li
$(document).ready(function () {
    $("#filter").keyup(function () {

        // Retrieve the input field text and reset the count to zero
        var filter = $(this).val(), count = 0;

        // Loop through the comment list
        $("nav ul li.filtro-search").each(function () {

            // If the list item does not contain the text phrase fade it out
            if ($(this).text().search(new RegExp(filter, "i")) < 0) {
                $(this).fadeOut();

                // Show the list item if the phrase matches and increase the count by 1
            } else {
                $(this).show();
                count++;
            }
        });

        // Update the count
        var numberItems = count;
        $("#filter-count").text("Number of Filter = " + count);
    });
});


$(document).ready(function () {
    $("#dttb").dataTable(
        {
            "language": {
                "sSearch": "Buscar",
                "lengthMenu": "Mostrar _MENU_ registros por página",
                "zeroRecords": "No se encontró nada - lo siento",
                "info": "Mostrando página _PAGE_ de _PAGES_",
                "infoEmpty": "No hay registros disponibles",
                "infoFiltered": "(filtrado de _MAX_ total registros)",
                "paginate": {
                    "previous": "Anterior",
                    "next": "Siguiente"
                },
                "decimal": ",",
                "thousands": "."
            }

        }
    );
});


$(function () {
    return $('.select2Perumunicipio').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Seleccionar Ciudad... ]",
        ajax: {
            url: '/perumunicipios/search.json',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function (data) {
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name,
                            id: item.id
                        };
                    })
                };
            }
        }
    });
});


$(function () {
    return $('.select2Municipio').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Seleccionar Ciudad... ]",
        ajax: {
            url: '/municipios/search.json',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function (data) {
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name,
                            id: item.id
                        };
                    })
                };
            }
        }
    });
});

$(function () {
    return $('.select2Persona').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Seleccionar Identificación... ]",
        ajax: {
            url: '/personasoblrecibos/search.json',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function (data) {
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name,
                            id: item.id
                        };
                    })
                };
            }
        }
    });
});