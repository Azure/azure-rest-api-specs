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
output-folder: sdk/<ServiceName>/<NameSpace>
require:
 - specification/<RPName>/data-plane/readme.md
```
~~~
- `title`: If it's already defined in spec readme.md, you don't need to define it here again. (By default, there is no `title` defined in spec readme.md in multi client scenario.)
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.
