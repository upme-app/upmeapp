document.addEventListener("turbolinks:load", function() {
    if (is_on_screen("areas_de_interesse", "view")) {
        var tags = $('.tag-list');

        function html_tag(tag) {
            return "<div class=\"chip\" data-value=\""+tag+"\">\n" +
                   tag +
                   "<i class=\"close material-icons\">close</i>" +
                   "</div>"
        }

        function exist_tag(tag) {
            var found = false;
            $('.chip').each(function (index, value) {
                var value = $(this).attr('data-value');
                if (value == tag) {
                    console.log('RETORNOU TRUE');
                    found = true;
                }
            });
            return found;
        }

        function add_tag(tag) {
            if(!exist_tag(tag)) {
                tags.append(html_tag(tag));
            }
        }

        $('#input-add-tag').autocomplete({
            data: {
                "Apple": null,
                "Microsoft": null,
                "Google": null
            },
            limit: 20,
            onAutocomplete: function(val) {
                add_tag(val);
                $('#input-add-tag').val('');
            },
            minLength: 1
        });

        $('.tags-hotkey').click(function() {
            var tag = $(this).attr('data-tag');
            add_tag(tag);
        });

    }
});