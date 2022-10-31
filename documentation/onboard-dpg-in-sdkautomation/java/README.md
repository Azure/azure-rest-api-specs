# Add Autorest Configuration of Java SDK 

## Parameter Description

- `<ServiceName>`: The RP name, which is usually same as rp name in swagger.
- `<PackageName>`: Java package name.
- `<Namespace>`: It should start with `com.`, and the remaining part can be got from `<PackageName>` by replacing `- with `.'. For example, if `<PackageName>` is `azure-analytics-purview-administration`, then `<Namespace>` is `com.azure.analytics.purview.administration`.


## Single Client
If you want to generate sdk with single client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-java
``` yaml
output-folder: sdk/<ServiceName>/<PackageName>
namespace: <Namespace>
data-plane: true
require:
 - specification/<RPName>/data-plane/readme.md
```
~~~
- `namespace`: The namespace of generated sdk.
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.

## Multi Client
If you want to generate sdk with multi client, please copy the following configuration into spec PR comment.
~~~
# azure-sdk-for-java
``` yaml
tag: false
output-folder: sdk/<ServiceName>/<PackageName>
namespace: <Namespace>
data-plane: true
require:
 - specification/<ServiceName>/data-plane/readme.md
batch:
 - package-A: true
 - package-B: true
```
~~~
- `namespace`: The namespace of generated sdk.
- `output-folder`: The relative path of destination to generate SDK.
- `require`: The item of the value is the relative path of spec readme.md file.
- `package-A` and `package-B` must be defined in swagger `readme.md` file. For samples, please refer to [dataplane samples for multi client](../../samplefiles-dp/samplefiles-dp-for-multi-client).
