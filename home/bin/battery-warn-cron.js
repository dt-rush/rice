#!/usr/bin/env node
const fs = require('fs');
const { exec } = require('child_process');

const SECONDS = 1000;
const threshold = {
    warn: 10,
    critical: 5
};

const readBattery = (property) => fs.readFileSync(`/sys/class/power_supply/BAT0/${property}`).toString();

const throttle = (f, time) => {
    let active = false;
    return () => {
        if (!active) {
            active = true;
            f();
            setTimeout(() => {
                active = false;
            }, time);
        }
    };
};

const BatteryMonitor = () => ({
    runMusic: function() {
        this.musicProcess = exec('cvlc --play-and-exit ~/Music/final_countdown.mp3');
    },
    ok: function() {
        if (this.musicProcess) {
            this.musicProcess.kill();
            this.musicProcess = undefined;
        }
    },
    notify: function(func) {
        if (!this.notifying) {
            exec('notify-send "DUNST_COMMAND_RESUME"');
            this.notifying = true;
            func.bind(this)();
            setTimeout(() => {
                this.notifying = false;
            }, 60 * SECONDS);
        }
    },
    warn: function() {
        exec(`dunstify --urgency=critical "battery < ${threshold.warn} %"`);
    },
    critical: function () {
        exec(`dunstify --urgency=critical "/!\\ battery < ${threshold.critical} % /!\\ "`);
        // TODO: HOW CAN WE KILL THE SUBPROCESS SPAWNED BY CVLC?
        // this.runMusic();
    },
    check: function() {
        const status = readBattery('status');
        if (/Charging/.test(readBattery('status'))) {
            this.ok();
        } else {
            const capacity = parseInt(readBattery('capacity'), 10);
            if (capacity < threshold.critical) {
                this.notify(this.critical);
            } else if (capacity < threshold.warn) {
                this.notify(this.warn);
            }
        }
    },
    run: function() {
        this.checkInterval = setInterval(() => this.check(), 1 * SECONDS);
    }
});

BatteryMonitor().run();

