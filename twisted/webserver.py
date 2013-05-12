#Twisted includes an event-driven web server. Here's a sample web application; notice how the resource object persists in memory, rather than being recreated on each request:
from twisted.web import server, resource
from twisted.internet import reactor

class HelloResource(resource.Resource):
    isLeaf = True
    numberRequests = 0
    
    def render_GET(self, request):
        self.numberRequests += 1
        request.setHeader("content-type", "text/plain")
        return "I am request #" + str(self.numberRequests) + "\n"

reactor.listenTCP(8080, server.Site(HelloResource()))
reactor.run()

#
# Learn more about [web application development](http://twistedmatrix.com/documents/current/web/howto/web-in-60/index.html),  [templates](http://twistedmatrix.com/documents/current/web/howto/twisted-templates.html) and Twisted's  [HTTP client](http://twistedmatrix.com/documents/current/web/howto/client.html).
