import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.Portal;
/**
 * Tenant configuration.
 */
@doc("The tenant configuration resource definition.")
@tenantResource
model Configuration
  is Azure.ResourceManager.ProxyResource<ConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = Configuration,
    KeyName = "configurationName",
    SegmentName = "tenantConfigurations",
    NamePattern = "^(?!con$|prn$|aux$|nul$|com[1-9]$)(?!.*[._-]{2,})[a-zA-Z0-9]([a-zA-Z0-9-._]*[a-zA-Z0-9])?$"
  >;
}

@armResourceOperations
interface TenantConfigurations {
  /**
   * Gets the tenant configuration.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Create the tenant configuration. If configuration already exists - update it. User has to be a Tenant Admin for this operation.
   */
  create is ArmResourceCreateOrReplaceSync<Configuration, TenantBaseParameters>;

  /**
   * Delete the tenant configuration. User has to be a Tenant Admin for this operation.
   */
  delete is ArmResourceDeleteSync<Configuration, TenantBaseParameters>;

  /**
   * Gets list of the tenant configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("TenantConfigurations_List")
  list is ArmResourceListByParent<Configuration, TenantBaseParameters>;
}

@armResourceOperations
interface ListTenantConfigurationViolationsOperations {
  /**
   * Gets list of items that violate tenant's configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @route("/providers/Microsoft.Portal/listTenantConfigurationViolations")
  @armResourceCollectionAction
  @post
  @operationId("ListTenantConfigurationViolations_List")
  list(...ApiVersionParameter): ArmResponse<ViolationsList> | ErrorResponse;
}

@@doc(TenantConfigurations.create::parameters.resource,
  "The parameters required to create or update tenant configuration."
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(TenantConfigurations.create::parameters.resource,
  "application/json",
  "tenantConfiguration"
);
