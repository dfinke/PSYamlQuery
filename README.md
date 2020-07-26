## PS Yaml Query

PowerShell wrapper for `yq`, enables a better PowerShell pipeline experience.

[yq](https://github.com/mikefarah/yq) - a lightweight and portable command-line YAML processor, whose aim is to be the [jq](https://github.com/stedolan/jq) or `sed` of yaml files.

- GitHub - https://github.com/mikefarah/yq
- GitBook - https://mikefarah.gitbook.io/yq/

## Note

> Not all of the `yq` features are wrapped in PowerShell yet.

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