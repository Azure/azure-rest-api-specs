# Add Autorest Configuration of Java SDK 

## Parameter Description

- `<ServiceName>`: The RP name, which is usually same as rp name in swagger.
- `<PackageName>`: Java package name.


## Single Client
If you want to generate sdk with single client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-java
``` yaml
output-folder: sdk/<ServiveName>/<PackageName>
require:
 - specification/<RPName>/dataplane/readme.md
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value of relative path of spec readme.md file.

## Multi Client
If you want to generate sdk with multi client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-java
``` yaml
tag: false
output-folder: sdk/<ServiveName>/<PackageName>
require:
 - specification/<ServiveName>/dataplane/readme.md
batch:
 - package-A
 - package-B
```
~~~
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value of relative path of spec readme.md file.
- `package-A` and `package-B` must be defined in swagger `readme.md` file. For samples, please refer to [dataplane samples for multi client](../../samplefiles-dp/samplefiles-dp-for-multi-client).