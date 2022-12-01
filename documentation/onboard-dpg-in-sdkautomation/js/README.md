# Add Autorest Configuration of JS SDK

## Parameter Description

- `<ServiceName>`: The RP name, which is usually same as folder name in swagger.
- `<PackageFolder>`: Python package folder name, which must ends with `-rest`. For example: `purview-administration-rest`.
- `<SubFolderName>`: The sub-folder name in the package. It's only used by multi-client scenario. 

## Single Client
If you want to generate sdk with single client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-js
``` yaml
output-folder: sdk/<ServiceName>/<PackageFolder>
require:
 - specification/<ServiceName>/data-plane/readme.md
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.

## Multi Client
If you want to generate sdk with multi client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-js
``` yaml $(multi-client)
tag: false
require:
 - specification/<RPName>/data-plane/readme.md
batch:
 - package-A: true
 - package-B: true
```

``` yaml $(package-A)
output-folder: sdk/<ServiceName>/<PackageFolder>/src/<SubFolderName>
```

``` yaml $(package-B)
output-folder: sdk/<ServiceName>/<PackageFolder>/src/<SubFolderName>
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.
- `package-A` and `package-B` must be defined in swagger `readme.md` file. For samples, please refer to [dataplane samples for multi client](../../samplefiles-dp/samplefiles-dp-for-multi-client).
