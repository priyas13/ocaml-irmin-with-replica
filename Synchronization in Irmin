# Synchronization
As we know Irmin can be used as a library to design distributed databases. If we have distributed database then we need some kind of synchronization. 
Irmin provide synchronization. 
```
type remote 
```
The type for remote stores. (In our case the type for remote store will be same as the data type we will be working with because we 
want to have replicas containing the same data)
```
val remote_uri : string -> remote 
```
remote_uri s is the remote or replica located at uri represented by string. URI stands for uniform resource identifier is basically 
a string of characters that identifies a particular resource. All the uri should be different. There are various forms of URI. The most common form of URI is URL
which stands for uniform resource locator, frequently referred as web address. [uri](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier). In our work, we need to have multiple
replicas where the uri for each replica will be different and unique. 
