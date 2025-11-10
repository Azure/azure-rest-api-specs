import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Monitor;

/**
 * The resource for Azure Monitor Cross Tenant Permissions, including system data and tags.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource must use a constant name 'default', pattern is not applicable."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-lookup-property" "Singleton resource name is fixed as 'default'."
@tenantResource
model CrossTenantPermissionsResource
  is ProxyResource<CrossTenantPermissionsProperties> {
  /**
   * The name of the Cross Tenant Permissions resource.
   */
  @key("name")
  @segment("crossTenantPermissions")
  @path
  name: "default";
}

/**
 * Cross tenant permission enforcement type.
 */
@doc("Cross tenant permission enforcement type.")
union CrossTenantPermissionEnforcementType {
  @doc("No enforcement of cross-tenant permissions.")
  None: "None",

  @doc("Strict enforcement of cross-tenant permissions.")
  Strict: "Strict",

  string,
}

/**
 * The properties for Cross Tenant Permissions.
 */
@doc("The properties for Cross Tenant Permissions.")
model CrossTenantPermissionsProperties {
  @doc("The list of tenants any Azure resource can send the monitoring data it owns or generates to.")
  @identifiers(#["tenantId"])
  allowedOutbound: AllowedOutboundTenant[];

  @doc("The enforcement type for cross-tenant permissions.")
  enforcementType: CrossTenantPermissionEnforcementType;

  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "@visibility(Lifecycle.Read) causes errors in this TypeSpec environment."
  ...DefaultProvisioningStateProperty;
}

/**
 * Represents an allowed outbound tenant.
 */
@doc("Represents an allowed outbound tenant.")
model AllowedOutboundTenant {
  @doc("The tenant ID that is allowed for outbound monitoring data. The value must be a GUID.")
  tenantId: Azure.Core.uuid;
}

@armResourceOperations
@doc("Defines operations for managing Cross Tenant Permissions resources.")
interface CrossTenantPermissionsOperations {
  @doc("Gets the Cross Tenant Permissions resource.")
  get is ArmResourceRead<CrossTenantPermissionsResource>;

  @doc("Creates or updates the Cross Tenant Permissions resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<CrossTenantPermissionsResource>;

  @doc("Deletes the Cross Tenant Permissions resource.")
  delete is ArmResourceDeleteSync<CrossTenantPermissionsResource>;
}
