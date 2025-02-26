'''
 * The MIT License (MIT)
 *
 * Copyright (c) 2025 Lukasz Ronka
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
'''

import usb.core
import usb.util


def main():
    # Find the device
    device = usb.core.find(idVendor=0xCAFE, idProduct=0x4004)
    if device is None:
        raise ValueError("Device not found")

    # Set the active configuration (usually not necessary)
    device.set_configuration()

    # Get the endpoint for reading
    endpoint = device[0][(0,0)][0]

    try:
        prev_value = 0
        while True:
            try:
                # Read data from the device
                data = device.read(endpoint.bEndpointAddress, endpoint.wMaxPacketSize)
                if data:
                    value = int.from_bytes(data[1:], 'little', signed=True)
                    if value != prev_value:
                        print(value)
                        prev_value = value
            except usb.core.USBError as e:
                if e.args == ('Operation timed out',):
                    continue  # Ignore timeouts
                raise  # Re-raise other USB errors
    except KeyboardInterrupt:
        print("Exiting...")

if __name__ == "__main__":
    main()
