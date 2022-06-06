# Add Autorest Configuration of .Net SDK

## Parameter Description

- `<ServiceName>`: The RP name, which is usually same as folder name in swagger.
- `<NameSpace>`: Python package name.
- `<Title>`: SDK Client Name

## Autorest Configuration

~~~
# azure-sdk-for-python
``` yaml
title: <Title>
output-folder: sdk/<ServiveName>/<NameSpace>
require:
 - specification/<RPName>/dataplane/readme.md
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value of relative path of spec readme.md file.
