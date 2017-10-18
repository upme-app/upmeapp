document.addEventListener("turbolinks:load", function() {
    if (is_on_screen("registrations", "new")) {
        var step_1 = $('#registration-step-1');
        var step_2 = $('#registration-step-2');
        var step_3 = $('#registration-step-3');
        var current_step = step_1;

        step_1.hide();
        step_2.hide();
        step_3.hide();

        function toggle_step(step_from, step_to) {
            step_from.hide().hide();
            step_to.show().animateCss('fadeIn');
            current_step = step_to;
        }

        step_1.show().animateCss('fadeIn');

        setTimeout(function () {
            toggle_step(step_1, step_2);
        }, 2500);

        step_2.hide();


        $('#btn-continue-registration-step-2').click(function() {
            if(is_step_2_valid()) {
                toggle_step(step_2, step_3);
            }
        });

        $('#btn-back-registration-step-3').click(function() {
            toggle_step(step_3, step_2);
        });

        $('#registration-form').on('keyup keypress', function(e) {
            if(current_step == step_2) {
                var keyCode = e.keyCode || e.which;
                if (keyCode === 13) {
                    if(is_step_2_valid()) {
                        toggle_step(step_2, step_3);
                    }
                    e.preventDefault();
                    return false;
                }
            }
        });

        function is_step_2_valid() {
            var first_name = document.getElementById('registration_first_name').validity.valid;
            var last_name = document.getElementById('registration_last_name').validity.valid;
            var user_type = document.getElementById('radio-aluno').validity.valid;

            //var nome_empresa = document.getElementById('registration_nome_empresa').validity.valid;
            //if(!$('#radio-empresa').is(':checked')) {
            //    nome_empresa = true;
            //}

            if(first_name && last_name && user_type) {
                return true;
            }
            return false;
        }

        toggle_to_alunoprof_form();

        function toggle_to_empresa_form() {
            $('#col-nome-da-empresa').show();
            $('#col-sobreonme').removeClass('s12').addClass('s6');
            $('#col-primeiro-nome').removeClass('s12').addClass('s6');
        }

        function toggle_to_alunoprof_form() {
            $('#col-nome-da-empresa').hide()
            $('#col-sobreonme').removeClass('s6').addClass('s12');
            $('#col-primeiro-nome').removeClass('s6').addClass('s12');
        }

        $('#radio-aluno, #radio-prof, #radio-empresa').change(function() {
            if($(this).val() == 'empresa') {
                toggle_to_empresa_form();
            } else {
                toggle_to_alunoprof_form();
            }
        });
    }
});