document.addEventListener("turbolinks:load", function() {

    if(is_on_screen("visitors", "landing_page")) {
        var quem = "";
        var ns_form_s1 = $('.ns-form-s1');
        var ns_form_s2 = $('.ns-form-s2');
        var ns_form_s3 = $('.ns-form-s3');

        // step 1
        ns_form_s1.show().animateCss("fadeIn");

        $('.ns-form-s1-btn').click(function() {
            ns_form_s1.hide();
            ns_form_s2.show().animateCss("fadeIn");
            quem = $(this).attr('data-quem');
            $('.ns-form-s2-input').focus();
        });

        // step 2
        $.get('/cursos-superiores').done(function(data) {
            $("#ns_form_s2_sel_curso_input").autocomplete({
                source: data
            });

            $('.ui-autocomplete').on('click', '.ui-menu-item', function(){
                step3();
            });
        });

        $('body').keypress(function(event) {
            if (event.keyCode == 13) {
                if(ns_form_s2.is(":visible")) {
                    step3();
                }
                if(ns_form_s3.is(":visible") && $('.ns-form-s3-input').val() != "") {
                    ns_submit();
                }
            }
        })

        $('.ns-submit-btn').click(function() {
            ns_submit();
        });

        function ns_submit() {
            $.post('/save_quiz', {
                quem: quem,
                email: $('.ns-form-s3-input').val(),
                curso: $('.ns-form-s2-input').val()
            }, function(data) {
                ns_form_s3.hide();
                if(data == "success") {
                    show_success_finish();
                } else {
                    show_error_finish();
                }
            });
        }

        function step3() {
            ns_form_s2.hide();
            ns_form_s3.show().animateCss("fadeIn");
            $('.ns-form-s3-input').focus();
        }

        function show_success_finish() {
            $('.ns-form-success').show().animateCss("fadeIn");
        }

        function show_error_finish() {
            $('.ns-form-error').show().animateCss("fadeIn");
        }
    }

});