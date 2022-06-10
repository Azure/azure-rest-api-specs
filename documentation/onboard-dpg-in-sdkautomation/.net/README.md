# Add Autorest Configuration of .Net SDK

## Parameter Description

- `<ServiceName>`: The RP name, which is usually same as folder name in swagger.
- `<NameSpace>`: Python package name.
- `<Title>`: SDK Client Name. It's optional if there is a title defined in spec readme.md file.

## Autorest Configuration
Please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-net-track2
``` yaml
title: <Title>
output-folder: sdk/<ServiveName>/<NameSpace>
require:
 - specification/<RPName>/dataplane/readme.md
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.
