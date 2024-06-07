# Uniform versioning

> [!NOTE]
> This article uses terminology defined in the [glossary], like `service` or `service group`.

A `service` **must version uniformly**. 

In brief, it means:

> The service, its set of operation endpoints (typically HTTP REST API endpoints), its documentation, and any SDK referencing it, all must version in lockstep.
> If a new service API version is released, also a new documentation reference must be released to describe it.
> Similarly, a new version of given SDK package must be released to refer to the new service version.

Each `service` within a `service group` can version independently of each other.

## Uniform versioning rules

All of the rules listed here apply both for OpenAPI specs emitted from TypeSpec as well as for hand-written OpenAPI specs.

**Uniform versioning** prescribes the following

1. Any deployed service operation endpoint must belong to an API version. An API version once deployed is immutable.
   Its behavior or constituent operations cannot be changed.
2. Any given service API version can be composed only of HTTP API operations and ARM resource types (if applicable)
   that have the same API version. 
3. Any documentation pertaining to the service and any SDKs generated from the service must pertain to only
   one service version.
4. The service version must be always represented in its entirety; any SDK or documentation referring to the service
   must encompass all of it.
5. The `common-types` OpenAPI definition shared across multiple services can version independently of the service.
   However, the rule that API version is immutable still must be observed.
  As such,  when versioning `common-types`, previous API versions will remain immutable because new API versions must be created.

## Uniform versioning implications

The **uniform versioning** has several implications and implementation decisions supporting it.

### API versions

- The service is effectively defined as a series of consecutive API versions.
- Each API version is represented by a pair of folders representing its lifecycle stage and a date, 
  like `stable/2024-03-05` or `preview/2024-05-15-preview`.
- Each API version date must be later than the previous date.
- `stable` and `preview` API versions cannot have the same date. This would prevent API users from knowing
    which one is later one.
- Moving to `stable` from `preview` by removing `-preview` suffix is not allowed. 
  In such case, at least one day must be added to the `stable` API version.

### Directory structure 

- The entirety of given API service specification must be placed inside its folder, e.g. `stable/2024-03-05`.
  The service consists of operation endpoints defined in OpenAPI spec `.json` files placed in its API version folder.
- Learn more in [directory structure article].

### No API version mixing within a service

- Nowhere within a service, documentation for it, or SDK referencing it,
  can multiple service API versions be mixed. as such:
  - `preview` API versions cannot be mixed with `stable` API versions.
  - No HTTP API endpoint for given API version can have any kind of dependency on service endpoint from any other API version.
  - The above apply to a stand-alone service as well as to a service that is a member of a `service group`.

### API version mixing across services in a service group

- Each `service` within a `service group` can version independently of each other.
- Each `service` within a `service group` must observe the **uniform versioning rules** within its own scope.

### AutoRest configuration for SDK generation (`README.md` files)

- Any [AutoRest config `README.md` file] definition for the service must have tags corresponding to the API versions
  present in the directory structure. 
- Each of the API version tags must include **all** OpenAPI spec `.json` files for given API version.
- Each of the API version tags must include **only** OpenAPI spec `.json` files for given API version.
- Each `README.md` describes a single `service` and is used as an SDK package and documentation for each version of the service.
- All OpenAPI specs for given `service` API version (i.e. the list of paths in given `input-file:` block for given API version tag in the `README.md`)
  must have the same service version, which also means being in the same [API version lifecycle stage].

### Versioning of `common-types`

- All the shared OpenAPI definitions (i.e. `common-types`) the service depends on must have the same version, 
  [e.g. `v6`][common-types v6], but it can be different from the version of the service.
- Updating `common-types` version requires updating the API version.
  For example, if `common-types` published an updated version of `v7`,
  then if the service wants to take dependency on it, it can only do it in
  a new version. For example, `2024-04-17`.
  Because the service version is now `2024-04-17`, all the OpenAPI specification `.json` files the service is composed
  of must have the same version of `2024-04-17` and the `info.version` property must say `2024-04-17`.
  In addition, a new SDK must be generated from the service, and new documentation published, both tagged with
  service version `2024-04-17`.

[API version lifecycle stage]: https://aka.ms/azsdk/api-versions
[AutoRest config `README.md` file]: https://aka.ms/azsdk/autorest
[common-types v6]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/common-types/resource-management/
[directory structure article]: ./directory-structure.md
[glossary]: ./glossary.md
