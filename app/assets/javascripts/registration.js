document.addEventListener("turbolinks:load", function() {
    if (is_on_screen("registrations", "new")) {
        var step_1 = $('#registration-step-1');
        var step_2 = $('#registration-step-2');
        var step_3 = $('#registration-step-3');

        step_1.hide();
        step_2.hide();
        step_3.hide();

        function toggle_step(step_from, step_to) {
            step_from.hide().hide();
            step_to.show().animateCss('fadeIn');
        }

        step_1.show().animateCss('fadeIn');

        setTimeout(function () {
            toggle_step(step_1, step_2);
        }, 2500);

        step_2.hide();


        $('#btn-continue-registration-step-2').click(function() {
            toggle_step(step_2, step_3);
        });

        $('#btn-back-registration-step-3').click(function() {
            toggle_step(step_3, step_2);
        });
    }
});