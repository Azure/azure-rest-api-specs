## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"ClassicAdministrators"},{"name":"ElevateAccess"}]` |

### Changes for `x-ms-azure-rbac-permissions-required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Authorization/elevateAccess'].post['x-ms-azure-rbac-permissions-required__deleted']` | deleted | `{"actions":"Microsoft.Authorization/elevateAccess/action","dataActions":"","rolesWithThesePermission...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClassicAdministratorListResult.required__added` | added | `["value"]` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/providers/microsoft.Authorization/elevateAccess'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Authorization/classicAdministrators'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

