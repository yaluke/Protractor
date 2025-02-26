import hid

def main():
    try:
        with hid.Device(0xcafe, 0x4004) as device:
            print(f"Connected to {device.manufacturer} {device.product}")
            prev_value = 0
            while True:
                report = device.read(16, timeout=1000)
                value = int.from_bytes(report[1:], 'little', signed=True)
                if(value != prev_value):
                    print(value)
                    prev_value = value
    except KeyboardInterrupt:
        print("Exiting...")


if __name__ == "__main__":
    main()
