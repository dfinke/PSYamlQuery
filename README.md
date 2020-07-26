## PS Yaml Query

PowerShell wrapper for `yq`, enables a better PowerShell pipeline experience.

[yq](https://github.com/mikefarah/yq) - a lightweight and portable command-line YAML processor, whose aim is to be the [jq](https://github.com/stedolan/jq) or `sed` of yaml files.

- GitHub - https://github.com/mikefarah/yq
- GitBook - https://mikefarah.gitbook.io/yq/

## Note

> Not all of the `yq` features are wrapped in PowerShell yet.

# Install

`yq` needs to be installed. You can install it using: `choco install yq`.

Or, check here for other install options: https://mikefarah.gitbook.io/yq/#install

# Try it Out
## Import-Yaml

`docker-compose.yml`

```yaml
version: '3'
services:
    powershellmicroservice:
        build: .\powershell
        ports:
            - 8080:8080
    pythonmicroservice:
        build: .\python
        ports:
            - 8081:8081
    denomicroservice:
        build: .\deno
        ports:
            - 8082:8082
    dotnetcoremicroservice:
        build: .\dotnetcore
        ports:
            - 3000:80
```

Do the `Import-Yaml`, and print the `services` property.

```powershell
$r = Import-Yaml docker-compose.yml

$r.services
```

## Results 

```
denomicroservice       : @{build=.\deno; ports=System.Object[]}
dotnetcoremicroservice : @{build=.\dotnetcore; ports=System.Object[]}
powershellmicroservice : @{build=.\powershell; ports=System.Object[]}
pythonmicroservice     : @{build=.\python; ports=System.Object[]}
```

## Path Expression 

`yq` also supports a path expression and returns the matching nodes the given yaml file.

Using the `docker-compose.yml` example above, and the path expression `services.dotnetcoremicroservice`.

```powershell
Import-Yaml docker-compose.yml services.dotnetcoremicroservice
```

## Then

```
build        ports
-----        -----
.\dotnetcore {3000:80}
```

This is equivalent to to `(Import-Yaml .\sample-docker-compose.yml).services.dotnetcoremicroservice` in PowerShell, but the PoweShell approach is more typing.

## ConvertTo-Yaml

```powershell
ConvertTo-Yaml '{"a":"Easy! as one two three","b":{"c":2,"d":[3,4]}}' 
```

- Or 

```powershell
'{"a":"Easy! as one two three","b":{"c":2,"d":[3,4]}}' | ConvertTo-Yaml 
```


## Results 

```
a: Easy! as one two three
b:
  c: 2
  d:
    - 3
    - 4
```