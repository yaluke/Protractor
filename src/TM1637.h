/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2025 Lukasz Ronka (for modifications)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#pragma once

#include "pico/stdlib.h" 
#include "hardware/pio.h"

//TM1637 display
//interface
void TM1637_init(uint, uint, uint);
void TM1637_showNumber(int num);
void TM1637_setBrightness(uint);
void TM1637_start();
void TM1637_stop();
void TM1637_writeByte(uint8_t);
void TM1637_display(uint8_t*, uint8_t, uint8_t);

//data
uint TM1637_clk_pin;    // default = 5
uint TM1637_dio_pin;    // default = 4
uint TM1637_brightness; // default = 2
const uint8_t TM1637_digitToSegment[16] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 
    0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
};

void TM1637_init(uint clk_pin, uint dio_pin, uint brightness)
{
    TM1637_clk_pin = clk_pin;
    TM1637_dio_pin = dio_pin;
    TM1637_brightness = brightness;
    gpio_init(TM1637_clk_pin);
    gpio_init(TM1637_dio_pin);
    gpio_set_dir(TM1637_clk_pin, GPIO_OUT);
    gpio_set_dir(TM1637_dio_pin, GPIO_OUT);
    gpio_put(TM1637_clk_pin, 1);
    gpio_put(TM1637_dio_pin, 1);
    TM1637_setBrightness(TM1637_brightness);
}

void TM1637_showNumber(int num) 
{
    if (num < -999 || num > 999)
    {
        return;
    }

    uint8_t digits[4] = {0};
    uint8_t negative = 0;

    if (num < 0) {
        negative = 1;
        num = -num;
    }

    int i = 3;
    do {
        digits[i] = TM1637_digitToSegment[num % 10];
        num /= 10;
        i--;
    } while (num > 0 && i >= 0);

    if (negative) {
        digits[i] = 0x40; // Display minus sign
    }

    TM1637_display(digits, 4, 0);
}


void TM1637_setBrightness(uint b) 
{
    uint8_t brightness = b & 0x07;
    TM1637_start();
    TM1637_writeByte(0x88 | brightness);
    TM1637_stop();
}

void TM1637_start() 
{
    gpio_put(TM1637_dio_pin, 0);
    sleep_us(50);
    gpio_put(TM1637_clk_pin, 0);
    sleep_us(50);
}

void TM1637_stop() 
{
    gpio_put(TM1637_dio_pin, 0);
    sleep_us(50);
    gpio_put(TM1637_clk_pin, 1);
    sleep_us(50);
    gpio_put(TM1637_dio_pin, 1);
    sleep_us(50);
}

void TM1637_writeByte(uint8_t b) 
{
    for (int i = 0; i < 8; ++i) {
        gpio_put(TM1637_clk_pin, 0);
        sleep_us(50);
        gpio_put(TM1637_dio_pin, (b & 1) ? 1 : 0);
        sleep_us(50);
        gpio_put(TM1637_clk_pin, 1);
        sleep_us(50);
        b >>= 1;
    }
    gpio_put(TM1637_clk_pin, 0);
    sleep_us(50);
    gpio_put(TM1637_dio_pin, 1);
    sleep_us(50);
    gpio_put(TM1637_clk_pin, 1);
    sleep_us(50);
    gpio_init_mask((1 << TM1637_dio_pin));
    gpio_set_dir(TM1637_dio_pin, GPIO_IN);
    while (gpio_get(TM1637_dio_pin));
    gpio_set_dir(TM1637_dio_pin, GPIO_OUT);
    gpio_put(TM1637_clk_pin, 0);
}

void TM1637_display(uint8_t* segments, uint8_t length, uint8_t pos) 
{
    TM1637_start();
    TM1637_writeByte(0x40);
    TM1637_stop();
    TM1637_start();
    TM1637_writeByte(0xC0 | (pos & 0x03));
    for (uint8_t k = 0; k < length; k++) 
        TM1637_writeByte(segments[k]);
    TM1637_stop();
}
