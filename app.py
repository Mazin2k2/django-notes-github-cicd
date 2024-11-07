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
        return 'Hello CICD was done on GitHub Maiz And Mazin and Github Action was connected to an EC2, ' + name + '!'

if __name__ == "__main__":
    app.run()
