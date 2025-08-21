# Add Autorest Configuration of Python SDK

## Parameter Description

- `<ServiceName>`: The RP name, which is usually same as folder name in swagger.
- `<PackageName>`: Python package name.
- `<Title>`: SDK Client Name

## Single Client
If you want to generate sdk with single client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-python
``` yaml
output-folder: sdk/<ServiceName>/<PackageName>
require:
 - specification/<RPName>/data-plane/readme.md
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.

## Multi Client
If you want to generate sdk with multi client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-python
``` yaml
tag: false
output-folder: sdk/<ServiceName>/<PackageName>
require:
 - specification/<ServiceName>/data-plane/readme.md
batch:
 - package-A: true
 - package-B: true
```

~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.
- `package-A` and `package-B` must be defined in swagger `readme.md` file. For samples, please refer to [dataplane samples for multi client](../../samplefiles-dp/samplefiles-dp-for-multi-client).
