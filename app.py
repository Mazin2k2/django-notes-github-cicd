#!/usr/bin/python3
import web

urls = (
    '/(.*)', 'hello'
)
app = web.application(urls, globals())

class hello:
    def GET(self, name):
        if not name:
            name = 'World'
        return 'Hello CICD was done by Mazin, ' + name + '!'

if __name__ == "__main__":
    app.run()
