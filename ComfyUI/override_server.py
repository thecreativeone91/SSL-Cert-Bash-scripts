from aiohttp import web

with open("server.py", "r") as f:
    code = f.read().replace("http://", "https://").replace("ws://", "wss://")
    try:
        compiled = compile(code, "server.py", "exec")
        exec(compiled, globals())
    except Exception as e:
        print(f"Error executing server.py: {e}")
        sys.exit(1)

print("Loading override_server.py")

@web.middleware
async def security_headers_middleware(request: web.Request, handler):
    response = await handler(request)
    response.headers['Content-Security-Policy'] = "default-src 'self' 'unsafe-inline' 'unsafe-eval' data: blob: wss:"
    response.headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains"
    return response

class PromptServer(PromptServer):
    def __init__(self, loop):
        super().__init__(loop)
        self.app.middlewares.append(security_headers_middleware)

    async def start(self, address, port, verbose=True, call_on_start=None, ssl_context=None):
        runner = web.AppRunner(self.app, access_log=None)
        await runner.setup()
        site = web.TCPSite(runner, address, port, ssl_context=ssl_context)
        await site.start()

        if verbose:
            print("Starting server\n")
            print(f"To see the GUI go to: https://{address}:{port}")
        if call_on_start is not None:
            call_on_start(address, port)
