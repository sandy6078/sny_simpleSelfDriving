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
    if (sound) {
        setSoundVolume(soundName, 0.2);
        currentSound = soundName;
        sound.play();
    }
}

function stopSound(soundName) {
    var sound = document.getElementById(soundName);
    if (sound) {
        sound.pause();
        sound.currentTime = 0;
        currentSound = '';
    }
}

function setSoundVolume(soundName, volumeLevel) {
    var sound = document.getElementById(soundName);
    if (sound) {
        sound.volume = volumeLevel;
    }
}

function isSoundPlaying(soundName) { 
    var sound = document.getElementById(soundName);
    return !sound.paused; 
}