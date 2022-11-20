var currentSound = '';

function getAllSounds() {
    let sounds = document.getElementsByTagName('audio');
    for (let i = 0; i < sounds.length; i++) {
        console.log(sounds[i]);
    }
    return sounds;
}

function playSound(soundName) {
    if (currentSound != '') {
        stopSound(currentSound);
    }
    var sound = document.getElementById(soundName);
    setSoundVolume(soundName, 0.1);
    currentSound = soundName;
    sound.play();
}

function stopSound(soundName) {
    var sound = document.getElementById(soundName);
    sound.pause();
    sound.currentTime = 0;
    currentSound = '';
}

function setSoundVolume(soundName, volume) {
    var sound = document.getElementById(soundName);
    sound.volume(volume);
}

function isSoundPlaying(soundName) { 
    var sound = document.getElementById(soundName);
    return !sound.paused; 
}