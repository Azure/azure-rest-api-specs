# quantum

> see https://aka.ms/autorest

This is the AutoRest configuration file for quantum.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the quantum.

``` yaml
openapi-type: data-plane
tag: package-2024-03-01-preview
suppressions:
  - code: OperationId
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}"].put.operationId
    reason:
      A Quantum Workspace job can only be created via the PUT method (can't be updated or replaced). 
  - code: DeleteInOperationName
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}"].delete.operationId
    reason:
      A Quantum Workspace job cannot be deleted, only cancelled. Ideally it should have been
      done via a custom POST action, but to avoid breaking changes we decided to keep it using the
      DELETE method.
  - code: OperationId
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}"].delete.operationId
    reason:
      A Quantum Workspace job cannot be deleted, only cancelled. Ideally it should have been
      done via a custom POST action, but to avoid breaking changes we decided to keep it using the
      DELETE method.
  - code: OperationId
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions/{sessionId}"].put.operationId
    reason:
      A Quantum Workspace session has an intentional pattern of `open` (with a PUT) and `close` (with a POST action). 
  - code: PutInOperationName
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/sessions/{sessionId}"].put.operationId
    reason:
      A Quantum Workspace session has an intentional pattern of `open` (with a PUT) and `close` (with a POST action). 
  - code: PatchContentType
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Quantum/workspaces/{workspaceName}/jobs/{jobId}"].patch.consumes
    reason:
      For historical reasons and backward compatibility, the Job Update operation
      uses a JsonPatchDocument. 
```

### Tag: package-2024-03-01-preview

These settings apply only when `--tag=package-2024-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview'
input-file:
  - Microsoft.Quantum/preview/2024-03-01-preview/quantum.json
```
### Tag: package-2019-11-04-preview

These settings apply only when `--tag=package-2019-11-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-04-preview'
input-file:
  - Microsoft.Quantum/preview/2019-11-04-preview/quantum.json
```

### Tag: package-2021-05-06-preview

These settings apply only when `--tag=package-2021-05-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-06-preview'
input-file:
  - Microsoft.Quantum/preview/2021-05-06-preview/quantum.json
```

### Tag: package-2021-11-01-preview

These settings apply only when `--tag=package-2021-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-11-01-preview'
input-file:
  - Microsoft.Quantum/preview/2021-11-01-preview/quantum.json
```

### Tag: package-2022-09-12-preview

These settings apply only when `--tag=package-2022-09-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-09-12-preview'
input-file:
  - Microsoft.Quantum/preview/2022-09-12-preview/quantum.json
```

### Tag: package-2023-11-13-preview

These settings apply only when `--tag=package-2023-11-13-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-13-preview'
input-file:
  - Microsoft.Quantum/preview/2023-11-13-preview/quantum.json
```

---

# Code Generation

## Python

See configuration in [readme.python.md](./readme.python.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
