### what is [socket](http://en.wikipedia.org/wiki/Network_socket) ?

**A network socket is network interface an endpoint of an inter-process communication flow across a computer network.** Today, most communication between computers is based on the Internet Protocol; therefore most network sockets are Internet sockets.

A socket API is an application programming interface (API), usually provided by the operating system, that allows application programs to control and use network sockets. Internet socket APIs are usually based on the Berkeley sockets standard.

**A socket address is the combination of an IP address and a port number, much like one end of a telephone connection is the combination of a phone number and a particular extension.** Based on this address, internet sockets deliver incoming data packets to the appropriate application process or thread.

### overview

An Internet socket is characterized by a unique combination of the following:
* Local socket address: Local IP address and port number
* Remote socket address: Only for established TCP sockets. As discussed in the client-server section below, this is necessary since a TCP server may serve several clients concurrently. The server creates one socket for each client, and these sockets share the same local socket address.
* Protocol: A transport protocol (e.g., TCP, UDP, raw IP, or others). TCP port 53 and UDP port 53 are consequently different, distinct sockets.

Within the operating system and the application that created a socket, a socket is referred to by a unique integer number called socket identifier or socket number. The operating system forwards the payload of incoming IP packets to the corresponding application by extracting the socket address information from the IP and transport protocol headers and stripping the headers from the application data.

In IETF Request for Comments, Internet Standards, in many textbooks, as well as in this article, the term socket refers to an entity that is uniquely identified by the socket number. In other textbooks, the socket term refers to a local socket address, i.e. a "combination of an IP address and a port number". In the original definition of socket given in RFC 147, as it was related to the ARPA network in 1971, "the socket is specified as a 32 bit number with even sockets identifying receiving sockets and odd sockets identifying sending sockets." Today, however, socket communications are bidirectional.

On Unix-like and Microsoft Windows based operating systems the netstat command line tool may be used to list all currently established sockets and related information.

### how socket

* socket with nodejs

```js
// sudo apt-get install nodejs
// nodejs node-example.js # maby node node-example.js

var net = require('net');

var server = net.createServer(function (socket) {
  socket.write('Echo server\r\n');
  socket.pipe(socket);
});

server.listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
```

* [socket.io ](http://socket.io/)

Socket.IO aims to make realtime apps possible in every browser and mobile device, blurring the differences between the different transport mechanisms. It's care-free realtime 100% in JavaScript.

* socket with python

    * [SocketServer](http://docs.python.org/2/library/socketserver.html) — A framework for network servers

* [socket with ruby](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/index.html)

### socket push

sources from http://www.iteye.com/topic/19089

我们都知道, 涉及到网络双方通讯的程序, 必然会有一个server一个client. 从谁是消息的发起者这个角度看, 通讯模型分为`server-push`和`client-pull`两种.

`server-push`的好处是及时性好, 所以大量被应用在要求及时性的软件上, 比如IM, 网游, IRC聊天等. 而`client-pull`的好处是对服务器压力小, 所有`TCP/IP`连接都是短暂的, 服务规模大, 所以大量被应用在大流量应用上, 如WEB, Email.

本来呢, `server-push`和`client-pull`是井水不犯河水, 两者共同生存于网络世界相安无事, 突然有一天, 有好事者试图将`server-push`概念引入WEB应用中, 于是引发叻一系列的讨论. 以下我们只讨论WEB.


但是这样做之后, 有一个非常重要的问题, 那就是如果用户狠多，每个人连上来都是一个长连接, 服务器会吃不消. 我们知道, 一般的服务器, 操作系统内核最多只支持 65535 个socket, 实际上受限于网络带宽, CPU内存以及I/O等处理能力, 最多最多大概也就 1-2 万个socket能够同时处理. 这一点, 跟网络游戏狠像, 好一点的网游, 一台服务器能够接受4000个以上的连接同时处理, 已经是狠不错叻.

对于中小规模的WEB而言, 没什么大不了的. 但是, 我们做个比方, 假设一台服务器, 没有 server-push 这样的东西, 它每秒钟能够接收5000个请求, 那么10秒钟之内, 就能接收50000个请求. 在极端情况下, 我们假设所有这些请求都来自不同的人, 那么我们就可以大概地说, 这台服务器能撑住5万个人去浏览页面, 没什么大问题. 但是如果是server-push, 假如有3000个人在长连接上, 基本上就没有余量给其它人叻. 再加上WEB应用本身又要去不断地刷新后台数据, 所以整个应用给人的表现就是非常吃服务器资源.
