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

#include "hardware/pio.h"
#include "encoder.pio.h"

//Rotary Encoder model RT3806-AB-400N
//interface
void Encoder_init(uint, uint, uint);
int Encoder_get_angle();
void Encoder_reset_angle();
void Encoder_mod_counter();

//data
PIO Encoder_pio0;
uint Encoder_sm0;
uint Encoder_sm1;
uint Encoder_pin0;  //default 2
uint Encoder_pin1;  //default 3
uint Encoder_freq;  //default 1_000_000
volatile int Encoder_counter = 0;

//initialization
void Encoder_init(uint pin0, uint pin1, uint freq)
{
    Encoder_pin0 = pin0;
    Encoder_pin1 = pin1;
    Encoder_freq = freq;
    Encoder_pio0 = pio0;

    uint offset_0 = pio_add_program(Encoder_pio0, &wait_raising_and_0_program);
    uint offset_1 = pio_add_program(Encoder_pio0, &wait_raising_and_1_program);
    Encoder_sm0 = pio_claim_unused_sm(Encoder_pio0, true);
    Encoder_sm1 = pio_claim_unused_sm(Encoder_pio0, true);

    encoder_program_init(Encoder_pio0, Encoder_sm0, Encoder_sm1, offset_0, offset_1, Encoder_pin0, Encoder_pin1, Encoder_freq);

    pio_set_irq0_source_enabled(Encoder_pio0, pis_interrupt0, true);
    pio_set_irq1_source_enabled(Encoder_pio0, pis_interrupt1, true);

    irq_set_exclusive_handler(PIO0_IRQ_0, Encoder_mod_counter);
    irq_set_exclusive_handler(PIO0_IRQ_1, Encoder_mod_counter);

    irq_set_enabled(PIO0_IRQ_0, true);
    irq_set_enabled(PIO0_IRQ_1, true);
}

int Encoder_get_angle()
{
    return Encoder_counter*0.9;
}

void Encoder_reset_angle()
{
    Encoder_counter = 0;
}

void Encoder_mod_counter()
{
    if(pio_interrupt_get(Encoder_pio0, 0))
    {
        pio_interrupt_clear(Encoder_pio0, 0);
        Encoder_counter++;
    }
    else if (pio_interrupt_get(Encoder_pio0, 1))
    {
        pio_interrupt_clear(Encoder_pio0, 1);
        Encoder_counter--;   
    }
}