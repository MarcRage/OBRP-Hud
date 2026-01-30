// Listen for all HUD updates from client.lua
window.addEventListener('message', function (event) {
    const data = event.data;
    if (!data) return;

    // Main HUD container
    const hud = document.getElementById('hex-hud');

    // Show or hide entire HUD
    if (data.action === 'toggleHud') {
        if (data.show) hud.classList.remove('hidden');
        else hud.classList.add('hidden');
        return;
    }

    // PLAYER HUD UPDATE
    if (data.action === 'updatePlayerHud') {
        const row = document.getElementById('player-row');
        row.classList.remove('hidden');

        // Update values
        setText('health', data.health);
        setText('armor', data.armor);
        setText('hunger', data.hunger);
        setText('thirst', data.thirst);
        setText('stress', data.stress);
        setText('stamina', data.stamina);
    }

    // VEHICLE HUD UPDATE
    if (data.action === 'updateVehicleHud') {
        const row = document.getElementById('vehicle-row');

        if (data.show) {
            row.classList.remove('hidden');
        } else {
            row.classList.add('hidden');
            return;
        }

        // Update vehicle values
        setText('speed', data.speed);
        setText('fuel', data.fuel + "%");
        setText('engine', data.engine + "%");
        setText('rpm', data.rpm);
        setText('gear', data.gear);

        // Pills
        setPill('seatbelt-pill', data.seatbelt, true);
        setPill('cruise-pill', data.cruise, false);
        setPill('lights-pill', data.lights, false);
        setPill('highbeams-pill', data.highbeams, false);
    }
});

// Utility: update text content
function setText(id, value) {
    const el = document.getElementById(id);
    if (el) el.textContent = value;
}

// Utility: update pill state
function setPill(id, state, warning) {
    const el = document.getElementById(id);
    if (!el) return;

    el.classList.remove('active', 'warning');

    if (state) {
        el.classList.add(warning ? 'warning' : 'active');
    }
}