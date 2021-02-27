
# Web services intro

- offline vs online applications
    - 86% of all android apps are using internet (random statistic from random site)
    - real world applications are not only UI - they create data and interact with data - Facebook, Health App, Games, etc.
- storing data options
    - on the device - for small data that won't be shared or used by another system
    - on remote server (cloud) - for big amount of data that will be shared or used by another system. This is the "go-to" approach for all modern applications.
- web servers
    - definition - "A web server is software and hardware that uses HTTP (Hypertext Transfer Protocol) and/or other protocols to respond to client requests made over the World Wide Web."
    - IPs and DNS
        - The Domain Name System (DNS) is a central part of the internet, providing a way to match names (a website you’re seeking) to numbers (the address for the website)
        - find ip - https://www.site24x7.com/find-ip-address-of-web-site.html
    - where do severs lived before the cloud
    - where most servers live now - cloud
    - web server clients
        - web browser
        - mobile application
        - another server
- hosting providers (cloud providers)
    - google platform vs azure vs amazon
    - what services they provide
    - paas vs saas vs iaas
        - saas
            - targeting the end user
            - all software that is delivered as a service - mail clients, video streaming, online storage platforms, social networks, etc
        - paas
            - targeting developers
            - encapsulates environment where users can build, compile and run their programs
            - can include operation system, language execution environment, web server, database - everything you need is provided
            - this is like having a server but not worrying about maintenance 
            - this are apps where you just send your code and you  have an up-and-running application - aws elastic beanstack, google app engine, azure, heroku
        - iaas
            - targeting devops or sysadmin
            - provides an infrastructure where you can do whatever you want
            - aws, azure, google, IBM Cloud
        - daas
- databases
    - types - SQL - relational, NO SQL
    - famous DBs - MySQL (Oracle), MS SQL (Micorsoft), MongoDB, Cassandra
- API
    - from wikipedia - "An application programming interface (API), is a computing interface that defines interactions between multiple software intermediaries."
    - RadCalendar API
- Web API
    - how a web server communicates with the rest of the world
    - optional - some servers doesn't have API
    - communication - HTTP protocol
- Serialization - "The process of converting an Object into stream of bytes so that it can be transferred over a network or stored in a persistent storage".
    - Deserialization - the opposite process
    - XML
    - JSON `{ "title": "todo1", "description": "desc 1" }`
- Authentication
    - register, login
- famous web APIs
    - twitter, facebook
    - Skyscanner Flight Search
    - Open Weather Map
    - Google Maps
- APIs tooling
    - postman
    - fiddler by Telerik Progress
- our own API
    - I've created an API especially for the TODO app
    - it's hosted on heroku (because they have free tier)
    - it's connected to real database - MongoDB
- call API demo
    - CRUD - todos
    - read all todos
    - read single todo by id
    - create new todo
    - update todo by id
    - delete todo by id

## Next
- Call web API from a flutter app
- Integrate our API in our TODO app



