# API Profile

## Description

The files in the folder describe the map of each resource provider's resource types and their supported api versions in the api profile.

## Basics
An API profile represents a map of resource provider namespaces and their API versions. It is a representation of an Azure Platform declaring a set of APIs to be supported across all our clouds. Instead of specifying individual api-versions for each resource type across each namespace, the developer can just align the application to a profile and the tools/SDKs will themselves select the right api-versions as directed by the profile. With API Profiles developers can specify a profile version that applies to an entire template and, at runtime, ARM will pick the right versions of the resources. This way, the customers don’t have to worry about which are the right resource versions to specific clouds.

https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-version-profiles

## File Structure
The profile is a one to one map. The api version specified is a single version for the resource type, although the resource type could support other older api versions as well.

1. **Resource manager map**: The top level node `resource-manager` defines the map for the management plane of the resource provider and  api version of the resource type

1. **Data plane map**: The top level node `data-plane` defines the map for the data plane of the resource provider and  api version of the resource type

1. **Resource provider namespace **: Each RP will have a node under the top level nodes. If an RP is not specified in the profile, it means that the profile does not support the RP. Only the supported RP will have an entry in the profile.
    - Under the namespace, all the supported api versions for the namespace is specified
    - The api version should have a array value of all the resource types belong to that api version
    - The array value is empty for the data plane, as they do not have the concept of clearly defined resource types
    - The name should match the resource type name mentioned in the resource provider manifest and in the REST API spec.


The structure should appear like below:
```bash
{
+---"info":{
|    |    "name":"xxxx-xx-xx-profile",
|    |    "description":"description of profile"
\----},
+---"resource-manager": {
|    +---"rp-namespace1": {
|    |   +---"api-version1":[
|    |        +---"resourcetype1",
|    |        +---"resourcetype2"
|    |        ],
|    |   +---"api-version1":[
|    |        +---"resourcetype3",
|    |        +---"resourcetype4"
|    |        ]
|    \---},
|    +---"rp-namespace2": {
|    |   +---"api-version1":[
|    |        +---"resourcetype1",
|    |        +---"resourcetype2",
|    |        +---"resourcetype3"
|    |        ],
|    \---},
\---},
|    +
|    +
|    +
+---"data-plane": {
|    ----"rp-namespace1": {
|    |   +---"api-version1":[]
|    |   \---},
|    \---},
\---}
}
```
