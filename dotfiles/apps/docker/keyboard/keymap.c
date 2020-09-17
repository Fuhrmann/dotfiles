#include QMK_KEYBOARD_H
#include <print.h>

// Define the rgb matrix effects we want to cycle
uint8_t rgb_matrix_effects[] = {
    RGB_MATRIX_GRADIENT_UP_DOWN,
    RGB_MATRIX_RAINDROPS,
    RGB_MATRIX_JELLYBEAN_RAINDROPS,
    RGB_MATRIX_CYCLE_UP_DOWN,
    RGB_MATRIX_DUAL_BEACON,
    RGB_MATRIX_SOLID_REACTIVE_MULTINEXUS,
};

LEADER_EXTERNS();

// Tap Dance declarations
enum {
    TD_TILD_RGB_OFF,
};

// Keycodes declarations
enum alt_keycodes {
    //USB Extra Port Toggle Auto Detect / Always Active
    U_T_AUTO = SAFE_RANGE,
    //USB Toggle Automatic GCR control
    U_T_AGCR,
    //DEBUG Toggle On / Off
    DBG_TOG,
    //DEBUG Toggle Matrix Prints
    DBG_MTRX,
    //DEBUG Toggle Keyboard Prints
    DBG_KBD,
    //DEBUG Toggle Mouse Prints
    DBG_MOU,
    //Restart into bootloader after hold timeout
    MD_BOOT,
    //Complety turn off rgb
    RGB_TOG_ALL,
    // RGB matrix effects
    RGB_M_GRADIENT_UP_DOWN,
    RGB_M_RAINDROPS,
    RGB_M_JELLYBEAN_RAINDROPS,
    RGB_M_CYCLE_UP_DOWN,
    RGB_M_DUAL_BEACON,
    RGB_M_SOLID_RNEXUS
};

// Leader actions
void matrix_scan_user(void) {
    LEADER_DICTIONARY() {
        leading = false;
        leader_end();

        // When I press KC_LEAD and then T, this sends CTRL + SHIFT + T
        SEQ_ONE_KEY(KC_T) {
            SEND_STRING(SS_LCTRL(SS_LSFT("t")));
        }

        // When I press KC_LEAD and then R, this sends CTRL + R
        SEQ_ONE_KEY(KC_R) {
            SEND_STRING(SS_LCTRL("r"));
        }
    }
}

// Toggle the RGB leds on/off
void toogle_rgb_led(void) {
    if (rgb_matrix_get_flags() == LED_FLAG_NONE) {
        rgb_matrix_set_flags(LED_FLAG_ALL);
        rgb_matrix_enable_noeeprom();
    } else {
        rgb_matrix_set_flags(LED_FLAG_NONE);
        rgb_matrix_disable_noeeprom();
    }
}

// Send KC_TILD or toggle RGB on/off
void tild_or_toggle_rgb(qk_tap_dance_state_t *state, void *user_data) {
    if (state->count <= 1) {
        register_code16  (KC_TILD);
        unregister_code16(KC_TILD);
    } else {
        toogle_rgb_led();
        reset_tap_dance(state);
    }
}

// All the tap dancing definitions
qk_tap_dance_action_t tap_dance_actions[] = {
    // Tap once for Tild, twice for toggle RGB leds
    [TD_TILD_RGB_OFF] = ACTION_TAP_DANCE_FN(tild_or_toggle_rgb)
};

// Taken from 'g_led_config' in config_led.c
#define CAPS_LOCK_LED_ID 30

// Friendly layer names
enum alt_layers {
    DEF = 0,
    FUNC,
    SUPR,
    RGBLEDS,
    NAV,
};

// Define the layouts
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [DEF] = LAYOUT_65_ansi_blocker(
        TD(TD_TILD_RGB_OFF),  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_BSPC, KC_DEL,
        KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSLS, KC_LEAD,
        MT(MOD_LCTL, KC_ESC), KC_A,    KC_S,    KC_D,    LT(SUPR, KC_F),    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,          KC_ENT,  KC_PGUP,
        KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,          KC_UP,   KC_PGDN,
        KC_LCTL, KC_LGUI, KC_LALT,                           KC_SPC,                             MO(RGBLEDS), MO(FUNC), KC_LEFT, KC_DOWN, KC_RGHT
    ),
    [FUNC] = LAYOUT_65_ansi_blocker(
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,  KC_MUTE,
        _______, RGB_SPD, RGB_VAI, RGB_SPI, RGB_HUI, RGB_SAI, _______, U_T_AUTO, U_T_AGCR,_______, KC_PSCR, KC_SLCK, KC_PAUS, _______, KC_END,
        KC_CAPS, RGB_RMOD,RGB_VAD, RGB_MOD, RGB_HUD, RGB_SAD, _______, _______, _______, _______, _______, KC_GRV,          _______,   KC_VOLU,
        _______, RGB_TOG, RGB_TOG_ALL, _______, _______, MD_BOOT, NK_TOGG, DBG_TOG, DBG_MTRX, DBG_KBD, _______, _______,      KC_PGUP,  KC_VOLD,
        _______, _______, _______,                            _______,                            _______, _______, KC_HOME, KC_PGDN,  KC_END
   ),
    [SUPR] = LAYOUT_65_ansi_blocker(
        _______,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______, _______,
        _______, _______, _______,                            _______,                            _______, _______, _______, _______, _______
    ),
    [RGBLEDS] = LAYOUT_65_ansi_blocker(
        _______, RGB_M_GRADIENT_UP_DOWN, RGB_M_RAINDROPS, RGB_M_JELLYBEAN_RAINDROPS, RGB_M_CYCLE_UP_DOWN, RGB_M_DUAL_BEACON, RGB_M_SOLID_RNEXUS, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,        _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______, _______,
        _______, _______, _______,                            _______,                            _______, _______, _______, _______, _______
    ),
    [NAV] = LAYOUT_65_ansi_blocker(
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_HOME, KC_UP, KC_END, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_LEFT, KC_DOWN, KC_RGHT,        _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______, _______,
        _______, _______, _______,                            _______,                            _______, _______, _______, _______, _______
    )
};

#define MODS_SHIFT  (get_mods() & MOD_BIT(KC_LSHIFT) || get_mods() & MOD_BIT(KC_RSHIFT))
#define MODS_CTRL  (get_mods() & MOD_BIT(KC_LCTL) || get_mods() & MOD_BIT(KC_RCTRL))
#define MODS_ALT  (get_mods() & MOD_BIT(KC_LALT) || get_mods() & MOD_BIT(KC_RALT))

void suspend_power_down_user(void) {
    rgb_matrix_set_suspend_state(true);
}

void suspend_wakeup_init_user(void) {
    rgb_matrix_set_suspend_state(false);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    static uint32_t key_timer;

    switch (keycode) {
        case U_T_AUTO:
            if (record->event.pressed && MODS_SHIFT && MODS_CTRL) {
                TOGGLE_FLAG_AND_PRINT(usb_extra_manual, "USB extra port manual mode");
            }
            return false;
        case U_T_AGCR:
            if (record->event.pressed && MODS_SHIFT && MODS_CTRL) {
                TOGGLE_FLAG_AND_PRINT(usb_gcr_auto, "USB GCR auto mode");
            }
            return false;
        case DBG_TOG:
            if (record->event.pressed) {
                TOGGLE_FLAG_AND_PRINT(debug_enable, "Debug mode");
            }
            return false;
        case DBG_MTRX:
            if (record->event.pressed) {
                TOGGLE_FLAG_AND_PRINT(debug_matrix, "Debug matrix");
            }
            return false;
        case DBG_KBD:
            if (record->event.pressed) {
                TOGGLE_FLAG_AND_PRINT(debug_keyboard, "Debug keyboard");
            }
            return false;
        case MD_BOOT:
            if (record->event.pressed) {
                key_timer = timer_read32();
            } else {
                if (timer_elapsed32(key_timer) >= 500) {
                    reset_keyboard();
                }
            }
            return false;
        case RGB_TOG_ALL:
            if (record->event.pressed) {
                toogle_rgb_led();
            }
            return false;
        case RGB_TOG:
            if (record->event.pressed) {
                switch (rgb_matrix_get_flags()) {
                    case LED_FLAG_ALL: {
                        rgb_matrix_set_flags(LED_FLAG_KEYLIGHT | LED_FLAG_MODIFIER);
                        rgb_matrix_set_color_all(0, 0, 0);
                    }
                    break;
                    case LED_FLAG_KEYLIGHT | LED_FLAG_MODIFIER: {
                        rgb_matrix_set_flags(LED_FLAG_UNDERGLOW);
                        rgb_matrix_set_color_all(0, 0, 0);
                    }
                    break;
                    case LED_FLAG_UNDERGLOW: {
                        rgb_matrix_set_flags(LED_FLAG_NONE);
                        rgb_matrix_disable_noeeprom();
                    }
                    break;
                    default: {
                        rgb_matrix_set_flags(LED_FLAG_ALL);
                        rgb_matrix_enable_noeeprom();
                    }
                    break;
                }
            }
            return false;
        case RGB_M_GRADIENT_UP_DOWN:
            if (record->event.pressed) {
                rgb_matrix_mode(RGB_MATRIX_GRADIENT_UP_DOWN);
            }
            return false;
        case RGB_M_RAINDROPS:
            if (record->event.pressed) {
                rgb_matrix_mode(RGB_MATRIX_RAINDROPS);
            }
            return false;
        case RGB_M_JELLYBEAN_RAINDROPS:
            if (record->event.pressed) {
                rgb_matrix_mode(RGB_MATRIX_JELLYBEAN_RAINDROPS);
            }
            return false;
        case RGB_M_CYCLE_UP_DOWN:
            if (record->event.pressed) {
                rgb_matrix_mode(RGB_MATRIX_CYCLE_UP_DOWN);
            }
            return false;
        case RGB_M_DUAL_BEACON:
            if (record->event.pressed) {
                rgb_matrix_mode(RGB_MATRIX_DUAL_BEACON);
            }
            return false;
        case RGB_M_SOLID_RNEXUS:
            if (record->event.pressed) {
                rgb_matrix_mode(RGB_MATRIX_SOLID_REACTIVE_MULTINEXUS);
            }
            return false;
        default:
            return true; // Process all other keycodes normally
    }
}

