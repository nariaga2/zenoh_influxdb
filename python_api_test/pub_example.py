import zenoh, random, time

random.seed()

def read_temp():
    return random.randint(15, 30)

if __name__ == "__main__":
    with zenoh.open(zenoh.Config.from_file("example_conf.json5")) as session:
        key = 'demo/example/zenoh_example/temp'
        pub = session.declare_publisher(key)
        while True:
            t = read_temp()
            buf = f"{t}"
            print(f"Putting Data ('{key}': '{buf}')...")
            pub.put(buf)
            time.sleep(1)