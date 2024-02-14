# nvim-redis
A nvim plugin to query Redis. Current supported commands are `KEYS`, `GET` and `HGET`
# Installation
Requires redis-cli command line tool installed.
## Packer
```
use {
    'recap/nvim-redis'
    config = function()
        require('redis').setup()
    end
}
```

# Usage
To set Redis host, port, user and password use:
```
:RSetParams -db <dbnumber> -host <host> -port <port> -user <user> -pass <password>
```
Default host and port are localhost and 6379, default db is 0
### List keys
List all keys in Redis
```
:RListKeys <pattern>
```
### Get key value
```
:RGetKey <key>
```

### HGet key field value
```
:RHGetKey <key> <field>
```
