import sys
import asyncio
import ssl
from main_http import *
import override_server as server

sys.modules['server'] = server

CERT_FILE = "/comfy/mnt/certs/cert.pem"
KEY_FILE = "/comfy/mnt/certs/privkey.pem"

async def run(server, address='', port=8188, verbose=True, call_on_start=None):
    ssl_context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    try:
        ssl_context.load_cert_chain(CERT_FILE, KEY_FILE)
    except Exception as e:
        print(f"Error loading SSL certificates: {e}")
        sys.exit(1)

    await asyncio.gather(
        server.start(address, port, verbose, call_on_start, ssl_context),
        server.publish_loop()
    )

with open("main_http.py", 'r') as main_file:
    main_file_lines = main_file.readlines()

start_line = next(
    (len(main_file_lines) - i for i, line in enumerate(reversed(main_file_lines), 1) if "if __name__ ==" in line),
    None
)
if start_line is None:
    raise RuntimeError("Could not find 'if __name__ == '__main__'' block in main_http.py")

import textwrap

code_to_exec = textwrap.dedent("".join(main_file_lines[start_line - 1:])).replace("http://", "https://").replace("ws://", "wss://")
exec(code_to_exec)
