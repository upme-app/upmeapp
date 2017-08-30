function is_on_screen(controller, action) {
    if($('body').attr('data-current-screen') == controller + '_' + action) {
        return true;
    }
    return false;
}