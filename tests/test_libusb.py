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
