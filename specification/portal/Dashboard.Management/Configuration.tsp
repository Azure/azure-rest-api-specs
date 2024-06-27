import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Portal;
/**
 * Tenant configuration.
 */
@tenantResource
model Configuration
  is Azure.ResourceManager.ProxyResource<ConfigurationProperties> {
  /**
   * The configuration name. Value must be 'default'
   */
  @path
  @key("configurationName")
  @segment("tenantConfigurations")
  @visibility("read")
  name: ConfigurationName;
}

@armResourceOperations
interface Configurations {
  /**
   * Gets the tenant configuration.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Create the tenant configuration. If configuration already exists - update it. User has to be a Tenant Admin for this operation.
   */
  create is ArmResourceCreateOrReplaceSync<Configuration>;

  /**
   * Delete the tenant configuration. User has to be a Tenant Admin for this operation.
   */
  delete is ArmResourceDeleteSync<Configuration>;

  /**
   * Gets list of the tenant configurations.
   */
  list is ArmResourceListByParent<Configuration>;
}

@@doc(Configurations.create::parameters.resource,
  "The parameters required to create or update tenant configuration."
);
