window.addEventListener('message', (event) => {
    if (event.data.action == 'play_sound') {
        playSound(event.data.type);
    } else if (event.data.action == 'open_ui') {

    } else if (event.data.action == 'close_ui') {
        
    }
})