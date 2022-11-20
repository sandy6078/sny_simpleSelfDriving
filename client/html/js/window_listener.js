window.addEventListener('message', (event) => {
    if (event.data.action == 'play_enable_sound') {
        playSound('enable');
    } else if (event.data.action == 'play_disable_sound') {
        playSound('disable');
    }
})