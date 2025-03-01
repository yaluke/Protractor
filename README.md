Protractor is a device which measure rotation angle and send that measurement via USB to the host. It uses precise encoder to measure angle with 1 degree precision, Raspberry Pi Pico to read the encoder signal with high speed using PIO, and TinyUSB library to share the measurement with the host. Main reason for building Protractor was a need to precisely measure rotation angle of a physical steering wheel used in car driving simulation.

More info: https://hackaday.io/project/202539-protractor

## Hardware components

* Raspberry Pi Pico H (https://www.raspberrypi.com/products/raspberry-pi-pico/)
* Incremental Photoelectric Rotary Encoder - 400P/R (https://www.dfrobot.com/product-1601.html)
* Pico Proto board (https://shop.pimoroni.com/products/pico-proto?variant=32369530110035)
* 4-digit 7-segment display based on TM1637 (https://www.instructables.com/How-to-Use-the-TM1637-Digit-Display-With-Arduino/) (optional)
* Tact switch for reseting angle value (optional)
* Plug/socket, 10 kOhm resistors, cables, etc.

## Software Stack

To provide required functionality, platform need to support fast I/O, and easy USB handling. First experiments with direct GPIO usage for reading encoder signals shown that signal from the encoder can be partially lost when rotating quickly as direct GPIO can handle changes up to ~10kHz. Much better and faster option is to use Programmable Input Output (PIO) functionality available on Raspberry Pi Pico.

Initially I planned to use the simplest software option - MicroPython, but it has no direct support for USB functionality. Circuit Python was the second candidate, but it has no full PIO support. Finally I chose C++ as it has good USB support for RPi Pico (TinyUSB library) as well as PIO.

I based the implementation on hid_composite example from TinyUSB library and removed all the sub-devices from implementation except generic inout device. I’ve also added the code with simple class handling TM1637 based display and Encoder C++ class with PIO custom code, handling encoder signals.

As an IDE I’ve used Microsoft Visual Code with official Raspberry Pi Pico extension (on MacOS and Windows).

List of components:
* Visual Studio Code (https://code.visualstudio.com/)
* Raspberry Pi Pico extension (https://github.com/raspberrypi/pico-vscode) (installed from extensions list in VS Code)
* Raspberry Pi Pico PIO (https://hackspace.raspberrypi.com/articles/what-is-programmable-i-o-on-raspberry-pi-pico)
* TinyUSB library (https://github.com/raspberrypi/tinyusb/blob/pico/docs/getting_started.md) (installed by RPi Pico extension as a part of Pico SDK)

## Encoder Signal Processing

Encoder generates two-phase orthogonal pulse signal, 400 pulses per rotation for each phase. Decoding of this signal is made by PIO program (file encoder.pio) waiting for raising edge on channel A, and then check the value on channel B: for 0 IRQ 0 is generated, for 1 IRQ 1 is generated.  Interrupts are handled by Encoder C class: IRQ 0 means decreasing rotation counter, IRQ 1 - increasing. This configuration generates 400 impulses per rotation and counter value needs to be multiplied by 360/400 = 0.9 to represent value in degrees.

Precision of the measurement can be increased to 1600 pulses per rotation by adding 3 more PIO programs waiting for falling edge on channel A, waiting for raising edge on channel B, and waiting for falling edge on channel B.

## USB Communication

USB handling implementation is based on hid_composite example from TinyUSB library. All device types except generic inout devices were removed from the original code. 

Implementation can be tested on host device using two examples from tests directory: test_hid.py using hid library (https://pypi.org/project/hid/), and test_pyusb.py using pyusb library (https://pypi.org/project/pyusb/).

## Build Instructions

### Connections

Encoder <-> RPi Pico
* VCC (red) <-> VBus [pin 40] (5V)
* GND (black) <-> GND [e.g. pin 38]
* channel A (white) <-> GP2 [pin 4] + 10 kOhm pull-up resistor to 3V3 [pin 36]
* channel B (green) <-> GP3 [pin 5] + 10 kOhm pull-up resistor to 3V3 [pin 36]

TM1637 display <-> RPi Pico
* CLK <-> 5 [pin 7]
* DIO <-> 4 [pin 6]
* VCC <-> 3V3 [pin 36]
* GND <-> GND [e.g. pin 38]

Reset switch <-> RPi Pico
* 3V3 [pin 36]
* GP14 [pin 19]

### Case

Simple device case and plug-in case designed in OpenSCAD are available in case directory.