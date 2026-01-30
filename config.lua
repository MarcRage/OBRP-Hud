Config = {}

------------------------------------------------------------
-- HUD POSITIONING
------------------------------------------------------------
Config.Position = {
    bottom = 0.04,     -- distance from bottom of screen (4%)
    centerX = true,    -- keep HUD centered horizontally
    offsetX = 0.0,     -- horizontal offset (negative = left, positive = right)
}

------------------------------------------------------------
-- HUD SCALING
------------------------------------------------------------
Config.Scale = {
    hud = 1.0,         -- scale entire HUD frame
    blocks = 1.0,      -- scale individual blocks
    pills = 1.0,       -- scale vehicle pills
}

------------------------------------------------------------
-- UPDATE SPEEDS
------------------------------------------------------------
Config.UpdateRates = {
    player = 300,      -- ms between player HUD updates
    vehicle = 100,     -- ms between vehicle HUD updates
}

------------------------------------------------------------
-- KEYBINDS
------------------------------------------------------------
Config.Keys = {
    seatbelt = 29,     -- B key
    cruise = 137,      -- CAPSLOCK (optional)
}

------------------------------------------------------------
-- COLOR THEME OVERRIDES
-- Leave nil to use default cyber‑aqua theme
------------------------------------------------------------
Config.Theme = {
    frameBorder = nil,     -- e.g. "rgba(0,255,200,0.35)"
    frameGlow = nil,       -- e.g. "rgba(0,255,200,0.25)"
    blockBackground = nil, -- e.g. "rgba(0,20,35,0.85)"
    labelColor = nil,      -- e.g. "rgba(180,255,245,0.8)"
    valueColor = nil,      -- e.g. "#e9ffff"
}

------------------------------------------------------------
-- VEHICLE HUD OPTIONS
------------------------------------------------------------
Config.Vehicle = {
    hideWhenStopped = false,   -- hide speed block at 0 km/h
    hidePillsWhenOff = false,  -- hide seatbelt/lights/etc when engine off
    showGear = true,           -- toggle gear display
    showRPM = true,            -- toggle RPM display
}

------------------------------------------------------------
-- PLAYER HUD OPTIONS
------------------------------------------------------------
Config.Player = {
    showStress = true,
    showStamina = true,
    showArmor = true,
    showHunger = true,
    showThirst = true,
}

------------------------------------------------------------
-- DEBUG MODE
------------------------------------------------------------
Config.Debug = false