
<p style="text-align:center;"><img src="https://raw.githubusercontent.com/dfinke/PSYamlQuery/master/media/food.jpg" width=275/></p>

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

### Results 

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


### Results 

```
a: Easy! as one two three
b:
  c: 2
  d:
    - 3
    - 4
```

## Compare-Yaml

Deeply compare two yaml documents.

Compares the matching yaml nodes at path expression in the two yaml documents. See path expression for more details. Difference calculated line by line, and is printed out line by line where the first character of each line is either:

- a `space`, indicating no change at this line
- `-` a minus ,indicating the line is not present in the second document (it's removed)
- `+` a plus, indicating that the line is not present in the first document (it's added)
If there are differences then yq will print out the differences and exit with code 1. If there are no differences, then nothing will be printed and the exit code will be 0.

`animal.yml`

```yaml
animals:
    - cats
    - dog
    - cheetah
```

`different-animals.yml`

```yaml
animals:
    - cats
    - bird
    - cheetah
```

Do the comparison.

```powershell
Compare-Yaml animal.yml different-animals.yml
```

### Result

- `cats` and `cheetah` no change
- `dog` not present in the second file
- `bird` not present in the first file, and was added

```
 animals:
   - cats
-  - dog
+  - bird
   - cheetah
```

## Merge-Yaml

Merge multiple yaml files into a one.

Yaml files can be merged using the 'merge' command. Each additional file merged with the first file will set values for any key not existing already or where the key has no value.

`data1.yml`

```yaml
a: simple
b: [1, 2]
```

`data2.yml`

```yaml
a: other
c:
  test: 1
```

```powershell
Merge-Yaml data1.yaml data2.yaml
```

### Result

```
a: simple
b: [1, 2]
c:
  test: 1
```

## Merge-Yaml : Append values with arrays

`data1.yml`

```yaml
a: simple
b: [1, 2]
d: hi
```

`data2.yml`

```yaml
a: something
b: [3, 4]
c:
  test: 2
  other: true
```

```powershell
Merge-Yaml data1Append.yml data2Append.yml -Append
```

### Results

```
a: simple
b: [1, 2, 3, 4]
d: hi
c:
  test: 2
  other: true
```