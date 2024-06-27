import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../Common/models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Portal;
/**
 * Tenant configuration.
 */
@doc("The configuration resource definition.")
@tenantResource
model TenantConfiguration
  is Azure.ResourceManager.ProxyResource<TenantConfigurationPropertiesWithProvisioningState> {
  /**
   * The configuration name. Value must be 'default'
   */
  @path
  @pattern("^(?!con$|prn$|aux$|nul$|com[1-9]$)(?!.*[._-]{2,})[a-zA-Z0-9]([a-zA-Z0-9-._]*[a-zA-Z0-9])?$")
  @key("configurationName")
  @segment("tenantConfigurations")
  @visibility("read")
  name: ConfigurationName;
}

@armResourceOperations
interface TenantConfigurations {
  /**
   * Gets the tenant configuration.
   */
  get is ArmResourceRead<TenantConfiguration>;

  /**
   * Create the tenant configuration. If configuration already exists - update it. User has to be a Tenant Admin for this operation.
   */
  create is ArmResourceCreateOrReplaceSync<TenantConfiguration>;

  /**
   * Delete the tenant configuration. User has to be a Tenant Admin for this operation.
   */
  delete is ArmResourceDeleteSync<TenantConfiguration>;

  /**
   * Gets list of the tenant configurations.
   */
  list is ArmResourceListByParent<TenantConfiguration>;
}

@@doc(TenantConfigurations.create::parameters.resource,
  "The parameters required to create or update tenant configuration."
);
