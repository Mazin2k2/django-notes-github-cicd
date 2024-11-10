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
        return 'Hello CICD was done on GitHub Maiz Mazin, Github Action was connected to an EC2 and commands in EC2 where run by deploy.sh, ' + name + '!'

if __name__ == "__main__":
    app.run()
