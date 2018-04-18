# API Profile 

## Description

The files in the folder describe the map of each resource provider's resource types and their supported api versions in the api profile.

## Basics
An API profile represents a map of resource provider namespaces and their API versions. It is a representation of an Azure Platform declaring a set of APIs to be supported across all our clouds.Instead of specifying individual api-versions for each resource type across each namespace, the developer can just align the application to a profile and the tools/SDKs will themselves revert to the right api-versions as directed by the profile. With API Profiles developers can specify a profile version that applies to an entire template and, at runtime, ARM will pick the right versions of the resources. This way, the customers don’t have to worry about which are the right resource versions to specific clouds. 


<<Insert detailed documentation link here>>

## File Structure
<<Todo: Define a json schema file if it helps>>

The profile is an one to one map. The api version specified is a single version for the resource type, although the reource type could support other older api versions as well.

1. **Resource manager map**: The top level node `resource-manager` defines the map for the management plane of the resource provider and  api version of the resource type

1. **Data plane map**: The top level node `data-plane` defines the map for the data plane of the resource provider and  api version of the resource type

1. **Resource provider namespace **: Each RP will have a node under the top level nodes. If an RP is not specified in the profile, it means that the profile does not support the RP. Only the supported RP will have an entry in the profile.
    - The `types` node under the namespace specifies the api version supported for the resource type in this profile.
        - The name should match the resource type name mentioned in the resource provider manifest and in the REST API spec.
        - The types could have a nested types defined under if they differ in supported api version from the parent resource type.
        - The api version specified at the parent resource type is applicable for the child resource types as well, if they do not have a specific entry

    - The `version` node under the namespace specifies the api version for all the resource types that are not specified under the `types` node
        - If the `types` node is empty, it means that all the resource types under the RP namespace follows the api version specified in the `version` node.

The structure should appear like below:
```bash
{
\---"resource-manager": {
|    +---"rp-namespace1": {
|    |   +---"version":"xxxx-xx-xx",
|    |   +---"types":{
|    |        +---"resourcetype1":"xxxx-xx-xx",
|    |        +---"resourcetype2":"xxxx-xx-xx"
|    |   \---},
|    \---},
\---},
|    ----"rp-namespace2": {
|    |   +---"version":"xxxx-xx-xx",
|    |   +---"types":{
|    |        +---"resourcetype3":"xxxx-xx-xx",
|    |        +---"resourcetype4":"xxxx-xx-xx"
|    |   \---},
|    +
|    +
|    +
+---"data-plane": {
|    ----"rp-namespace1": {
|    |   +---"version":"xxxx-xx-xx",
|    |   +---"types":{
|    |        +---"resourcetype1":"xxxx-xx-xx",
|    |        +---"resourcetype2":"xxxx-xx-xx"
|    |   \---}
|    |   \---},
|    \---},
\---}
}
```