/* Copyright 2020 tominabox1
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H

enum layers {
	_COLEMAK,        // default
	_QWERTY,         // default
	_LAY1,           // vim
	_LAY2,           // programming
	_LAY3,           // numlock
	_LAY4,           // mouse
	_LAY5,           // rgb
	_LAY6,           // slovak
	_LAY7            // slovak-colemak
};

// enum my_keycodes {
//     LIS1, // listener
// };

#define _DEF TO(0)
#define _VIM LT(_LAY1, KC_LBRC)
#define _PROG LT(_LAY2, KC_RBRC)
#define _SPACE KC_SPC
#define _MOUSE TO(_LAY4)
#define _RGB TO(_LAY5)
#define _SVK MO(_LAY6)
#define _SVKC MO(_LAY7)
// #define LIS1 MO(_LAY6)
#define ___ KC_NO

enum slovak_unicode {
	_EACU,
	_TEACU,
	_YACU,
	_TYACU,
	_AACU,
	_TAACU,
	_IACU,
	_TIACU,
	_UACU,
	_TUACU,
	_OACU,
	_TOACU,

	_OKVO,
	_TOKVO,
	_ACAR,
	_TACAR,

	_LCAR,
	_TLCAR,
	_SCAR,
	_TSCAR,
	_CCAR,
	_TCCAR,
	_TCAR,
	_TTCAR,
	_DCAR,
	_TDCAR,
	_ZCAR,
	_TZCAR,
	_NCAR,
	_TNCAR,
	_RACU,
	_TRACU
};

const uint32_t PROGMEM unicode_map[] = {
    [_EACU] = 0x00E9, [_TEACU] = 0x00C9, [_YACU] = 0x00FD, [_TYACU] = 0x00DD,
    [_AACU] = 0x00E1, [_TAACU] = 0x00C1, [_IACU] = 0x00ED, [_TIACU] = 0x00CD,
    [_LCAR] = 0x013E, [_TLCAR] = 0x013D, [_SCAR] = 0x0161, [_TSCAR] = 0x0160,
    [_CCAR] = 0x010D, [_TCCAR] = 0x010C, [_ZCAR] = 0x017E, [_TZCAR] = 0x017D,
    [_UACU] = 0x00FA, [_TUACU] = 0x00DA, [_OACU] = 0x00F3, [_TOACU] = 0x00D3,
    [_OKVO] = 0x00F4, [_TOKVO] = 0x00D4, [_ACAR] = 0x00E4, [_TACAR] = 0x00C4,
    [_NCAR] = 0x0148, [_TNCAR] = 0x0147, [_TCAR] = 0x0165, [_TTCAR] = 0x0164,
    [_DCAR] = 0x010F, [_TDCAR] = 0x010E, [_RACU] = 0x0155, [_TRACU] = 0x0154,
};

/* _____ _   _ _   _  ____ _____ ___ ___  _   _ ____  */
/*|  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___| */
/*| |_  | | | |  \| | |     | |  | | | | |  \| \___ \ */
/*|  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |*/
/*|_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/ */
/*                                                    */
/**/
/**/
/**/

const key_override_t delete_key_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSPC, KC_DEL);

// This globally defines all key overrides to be used
const key_override_t *key_overrides[] = {&delete_key_override};
// PROBABLY OUTDATED
// const key_override_t delete_key_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSPC,
// KC_DEL);
//
//// This globally defines all key overrides to be used
// const key_override_t **key_overrides = (const key_override_t *[]){
//     &delete_key_override,
//     NULL        // Null terminate the array of overrides!
// };

/* ____   ____ ____  */
/*|  _ \ / ___| __ ) */
/*| |_) | |  _|  _ \ */
/*|  _ <| |_| | |_) |*/
/*|_| \_\\____|____/ */
/*                   */
/**/
/**/
/**/

// mid barr
void set_color(int r, int g, int b) {
	rgb_matrix_set_color(5, r, g, b);
	rgb_matrix_set_color(6, r, g, b);
	rgb_matrix_set_color(17, r, g, b);
	rgb_matrix_set_color(18, r, g, b);
	rgb_matrix_set_color(29, r, g, b);
	rgb_matrix_set_color(30, r, g, b);
	rgb_matrix_set_color(41, r, g, b);
}

bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
	switch (get_highest_layer(layer_state)) {
	case 0:
		// set_color(244,14,35);
		break;
	case _LAY2:
		rgb_matrix_set_color(25, 255, 76, 0);           // KC_LINX
		rgb_matrix_set_color(26, 51, 77, 255);          // KC_WIN
		rgb_matrix_set_color(27, 255, 255, 255);        // KC_MAC
		rgb_matrix_set_color(43, 255, 76, 0);           // KO_TOGG
		break;
	}

	// every configured button lay4, lay5
	if (get_highest_layer(layer_state) == _LAY4 || get_highest_layer(layer_state) == _LAY5) {
		uint8_t layer = get_highest_layer(layer_state);

		for (uint8_t row = 0; row < MATRIX_ROWS; ++row) {
			for (uint8_t col = 0; col < MATRIX_COLS; ++col) {
				uint8_t index = g_led_config.matrix_co[row][col];

				if (index >= led_min && index <= led_max && index != NO_LED &&
				    keymap_key_to_keycode(layer, (keypos_t){col, row}) >
				        KC_TRNS) {
					rgb_matrix_set_color(index, RGB_PINK);
				}
			}
		}
	}

	if (get_highest_layer(layer_state) > 0) {
		uint8_t layer = get_highest_layer(layer_state);

		for (uint8_t row = 0; row < MATRIX_ROWS; ++row) {
			for (uint8_t col = 0; col < MATRIX_COLS; ++col) {
				uint8_t index = g_led_config.matrix_co[row][col];

				// def layer switch
				if (index >= led_min && index <= led_max && index != NO_LED &&
				    keymap_key_to_keycode(layer, (keypos_t){col, row}) == _DEF) {
					rgb_matrix_set_color(index, 140, 0, 43);
				}

				// caps-lock
				//            if (g_led_config.flags[i] &
				//            LED_FLAG_KEYLIGHT) {
				//                rgb_matrix_set_color(i, RGB_RED);
				//            }

				// macro
				if (index >= led_min && index <= led_max && index != NO_LED &&
				    (keymap_key_to_keycode(layer, (keypos_t){col, row}) == DM_REC1 ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) ==
				         DM_REC2)) {
					rgb_matrix_set_color(index, RGB_RED);
				}
				if (index >= led_min && index <= led_max && index != NO_LED &&
				    (keymap_key_to_keycode(layer, (keypos_t){col, row}) == DM_PLY1 ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) ==
				         DM_PLY2)) {
					rgb_matrix_set_color(index, RGB_ORANGE);
				}

				// prnt
				if (index >= led_min && index <= led_max && index != NO_LED &&
				    keymap_key_to_keycode(layer, (keypos_t){col, row}) ==
				        KC_PSCR) {
					rgb_matrix_set_color(index, RGB_YELLOW);
				}

				// pgup/dn
				if (index >= led_min && index <= led_max && index != NO_LED &&
				    (keymap_key_to_keycode(layer, (keypos_t){col, row}) == KC_PGUP ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) ==
				         KC_PGDN)) {
					rgb_matrix_set_color(index, RGB_WHITE);
				}

				// media keys
				if (index >= led_min && index <= led_max && index != NO_LED &&
				    (keymap_key_to_keycode(layer, (keypos_t){col, row}) == KC_PWR ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) == QK_BOOT ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) == KC_MNXT ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) == KC_MPRV ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) == KC_BRID ||
				     keymap_key_to_keycode(layer, (keypos_t){col, row}) ==
				         KC_BRIU)) {
					rgb_matrix_set_color(index, RGB_RED);
				}
			}
		}
	}

	return false;
}

/* _  _________   ______   ___    _    ____  ____  */
/*| |/ / ____\ \ / / __ ) / _ \  / \  |  _ \|  _ \ */
/*| ' /|  _|  \ V /|  _ \| | | |/ _ \ | |_) | | | |*/
/*| . \| |___  | | | |_) | |_| / ___ \|  _ <| |_| |*/
/*|_|\_\_____| |_| |____/ \___/_/   \_\_| \_\____/ */
/*                                                 */
/**/
/**/
/**/

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_QWERTY] = LAYOUT_planck_mit(
        KC_TAB, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_BSPC,
        KC_ESC, KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOT,
        KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH, RSFT_T(KC_ENT),
        KC_LCTL, KC_LGUI, KC_NO, KC_LALT, _VIM, _SPACE, _PROG, KC_NO, _RGB, _MOUSE, RCTL_T(KC_BSLS)
    ),

    [_COLEMAK] = LAYOUT_planck_mit(
        KC_TAB, KC_Q, KC_W, KC_F, KC_P, KC_B, KC_J, KC_L, KC_U, KC_Y, KC_SCLN, KC_BSPC,
        KC_ESC, KC_A, KC_R, KC_S, KC_T, KC_G, KC_M, KC_N, KC_E, KC_I, KC_O, KC_QUOT,
        KC_LSFT, KC_Z, KC_X, KC_C, KC_D, KC_V, KC_K, KC_H, KC_COMM, KC_DOT, KC_SLSH, RSFT_T(KC_ENT),
        KC_LCTL, KC_LGUI, KC_NO, KC_LALT, _VIM, _SPACE, _PROG, _SVKC, _RGB, _MOUSE, RCTL_T(KC_BSLS)
    ),


    // vim
    //KC_CAPS - bug binds to KC_ESC
    [_LAY1] = LAYOUT_planck_mit(
        KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F6, KC_F7, KC_F8, KC_F9, KC_F10, KC_F11, KC_F12,
        KC_ESC, KC_INS, KC_PSCR, KC_NO, KC_PGDN, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, KC_HOME, KC_END,
        KC_LSFT, KC_MPLY, KC_MUTE, KC_VOLD, KC_VOLU, KC_PGUP, KC_NO, KC_NO, KC_BRID, KC_BRIU, KC_NO, KC_RSFT,
        KC_LCTL, KC_LGUI, KC_DEL, KC_LALT, KC_NO, _SPACE, KC_NO, KC_MPRV, KC_MNXT, KC_PWR, KC_RCTL
    ),

    // programming
    [_LAY2] = LAYOUT_planck_mit(
        KC_GRV, KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0, KC_MINS,
        KC_ESC, KC_EXLM, KC_AT, KC_HASH, KC_DLR, KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_EQL,
        KC_LSFT, UC_LINX, UC_WINC, UC_MAC, DM_REC2, DM_PLY1, DM_PLY2, KC_COMM, KC_DOT, KC_LBRC, KC_RBRC, KC_ENT,
        KC_LCTL, KC_LGUI, KC_DEL, KC_LALT, DM_REC1, _SPACE, KC_NO, KO_TOGG, KC_NO, DF(_QWERTY), DF(_COLEMAK)
    ),

    // mouse
    [_LAY4] = LAYOUT_planck_mit(
        KC_TRNS, KC_NO, KC_NO, KC_MS_U, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
        _DEF, KC_NO, KC_MS_L, KC_MS_D, KC_MS_R, KC_NO, KC_NO, KC_WH_D, KC_WH_U, KC_NO, KC_NO, KC_ESC ,
        KC_TRNS, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_TRNS,
        KC_TRNS, KC_TRNS, _DEF, KC_TRNS, KC_TRNS, KC_BTN1, KC_BTN2, KC_NO, KC_NO, _DEF, KC_TRNS
    ),

    // rgb
    [_LAY5] = LAYOUT_planck_mit(
        RGB_M_P, RGB_M_B, RGB_M_R, RGB_M_SW, RGB_M_SN, RGB_M_K, RGB_M_X, KC_NO, RGB_HUD, RGB_HUI, KC_NO, RGB_TOG,
        RGB_M_G, RGB_M_T, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, RGB_SAD, RGB_SAI, KC_NO, RGB_MOD,
        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, RGB_VAD, RGB_VAI, KC_NO, RGB_RMOD,
        KC_NO, KC_NO, KC_NO, KC_NO, _DEF, KC_NO, KC_NO, RGB_SPD, RGB_SPI, DB_TOGG, QK_BOOT
    ),

    // slovak
    [_LAY6] = LAYOUT_planck_mit(
        KC_TAB, KC_Q, KC_W, UP(_EACU, _TEACU), UP(_RACU, _TRACU), UP(_TCAR, _TTCAR), UP(_YACU, _TYACU), UP(_UACU, _TUACU), UP(_IACU, _TIACU), UP(_OACU, _TOACU), KC_P, KC_BSPC,
        KC_ESC, UP(_AACU, _TAACU), UP(_SCAR, _TSCAR), UP(_DCAR, _TDCAR), KC_F, KC_G, KC_H, KC_J, KC_K, UP(_LCAR, _TLCAR), UP(_OKVO, _TOKVO), UP(_ACAR, _TACAR),
        KC_LSFT, UP(_ZCAR, _TZCAR), KC_X, UP(_CCAR, _TCCAR), KC_V, KC_B, UP(_NCAR, _TNCAR), KC_M, KC_COMM, KC_DOT, KC_SLSH, RSFT_T(KC_ENT),
        KC_LCTL, KC_LGUI, KC_DEL, KC_LALT, _DEF, KC_SPC, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RGHT
    ),

    // slovak colemak-dh matrix
    [_LAY7] = LAYOUT_planck_mit(
        KC_TAB, KC_Q, KC_W, UP(_EACU, _TEACU), UP(_RACU, _TRACU), UP(_TCAR, _TTCAR), UP(_YACU, _TYACU), UP(_UACU, _TUACU), UP(_IACU, _TIACU), UP(_OACU, _TOACU), KC_P, KC_BSPC,
        KC_ESC, UP(_AACU, _TAACU), UP(_SCAR, _TSCAR), UP(_DCAR, _TDCAR), KC_F, KC_G, KC_H, KC_J, KC_K, UP(_LCAR, _TLCAR), UP(_OKVO, _TOKVO), UP(_ACAR, _TACAR),
        KC_LSFT, UP(_ZCAR, _TZCAR), KC_X, UP(_CCAR, _TCCAR), KC_V, KC_B, UP(_NCAR, _TNCAR), KC_M, KC_COMM, KC_DOT, KC_SLSH, RSFT_T(KC_ENT),
        KC_LCTL, KC_LGUI, KC_DEL, KC_LALT, _DEF, KC_SPC, KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RGHT
    ),

    //[X] = LAYOUT_planck_mit(
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
    //),

};
// clang-format on
