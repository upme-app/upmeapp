document.addEventListener("turbolinks:load", function() {
    if (is_on_screen("areas_de_interesse", "view") || is_on_screen("explore", "index")) {
        refresh_shortcuts();

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
                    found = true;
                }
            });
            return found;
        }

        function add_tag(tag) {
            if(!exist_tag(tag)) {
                tags.append(html_tag(tag));
                refresh_shortcuts();
            }
            $('.close').click(function() {
                setTimeout(function () {
                    refresh_shortcuts();
                }, 10);
            });
        }

        $.ajax({
            url: "areas-de-interesse/nomes"
        }).done(function(json) {
            var data = {};
            for(var i = 0; i < json.length; i++) {
                data[json[i]] = null;
            }

            $('#input-add-tag').autocomplete({
                data: data,
                limit: 999,
                onAutocomplete: function(val) {
                    add_tag(val);
                    $('#input-add-tag').val('');
                },
                minLength: 1
            });

            $.ajax({
                url: "areas-de-interesse/minhas-areas"
            }).done(function(areas) {
                $('.upme-loading').remove();
                for(var i = 0; i < areas.length; i++) {
                    add_tag(areas[i]);
            }
            });
        });

        $('.tag-shortcut').click(function() {
            var tag = $(this).attr('data-tag');
            add_tag(tag);
        });

        $('#btn-save-areas-de-interesse').click(function() {
            var areas = [];
            $('.chip').each(function (index, value) {
                areas.push($(this).attr('data-value'));
            });
            $.post("areas-de-interesse", {
                areas: areas
            }).done(function(result) {
            });
        });

        function refresh_shortcuts() {
            $('.tag-shortcut').each(function(index, value) {
               if(exist_tag($(this).attr('data-tag'))) {
                   $(this).css("background-image", "url(" + $(this).attr('data-btn-img-selected') + ")");
                   $(this).next().css("color", "#00C7FF");
               } else {
                   $(this).css("background-image", "url(" + $(this).attr('data-btn-img') + ")");
                   $(this).next().css("color", "#BDBDBD");
               }
            });
        }

    }
});