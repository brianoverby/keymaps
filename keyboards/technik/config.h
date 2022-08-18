#pragma once

// clang-format off
#define LAYOUT_brove( \
    L01,    L02,    L03,    L04,    L05,                      R01,    R02,    R03,    R04,    R05, \
    L11,    L12,    L13,    L14,    L15,                      R11,    R12,    R13,    R14,    R15, \
    L21,    L22,    L23,    L24,    L25,                      R21,    R22,    R23,    R24,    R25, \
                            L31,    L32,                      R31,    R32                          \
    ) \
    LAYOUT_ortho_4x12( \
    L01,    L02,    L03,    L04,    L05,    KC_NO,  KC_NO,    R01,    R02,    R03,    R04,    R05, \
    L11,    L12,    L13,    L14,    L15,    KC_NO,  KC_NO,    R11,    R12,    R13,    R14,    R15, \
    L21,    L22,    L23,    L24,    L25,    KC_NO,  KC_NO,    R21,    R22,    R23,    R24,    R25, \
    KC_NO,  KC_NO,  KC_NO,  L31,    L32,    KC_NO,  KC_NO,    R31,    R32     KC_NO,  KC_NO,  KC_NO \
    
    )

// clang-format on