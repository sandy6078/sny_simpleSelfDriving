window.addEventListener('message', (event) => {
    if (event.data.action == 'play_sound') {
        playSound(event.data.type);
    }
})