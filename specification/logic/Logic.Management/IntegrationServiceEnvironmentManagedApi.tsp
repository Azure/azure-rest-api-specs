import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationServiceEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The integration service environment managed api.
 */
@parentResource(IntegrationServiceEnvironment)
model IntegrationServiceEnvironmentManagedApi
  is Azure.ResourceManager.TrackedResource<IntegrationServiceEnvironmentManagedApiProperties> {
  ...ResourceNameParameter<
    Resource = IntegrationServiceEnvironmentManagedApi,
    KeyName = "apiName",
    SegmentName = "managedApis",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IntegrationServiceEnvironmentManagedApis {
  /**
   * Gets the integration service environment managed Api.
   */
  get is ArmResourceRead<IntegrationServiceEnvironmentManagedApi>;

  /**
   * Puts the integration service environment managed Api.
   */
  put is ArmResourceCreateOrReplaceAsync<
    IntegrationServiceEnvironmentManagedApi,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the integration service environment managed Api.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IntegrationServiceEnvironmentManagedApi>;

  /**
   * Gets the integration service environment managed Apis.
   */
  list is ArmResourceListByParent<IntegrationServiceEnvironmentManagedApi>;

  /**
   * Gets the managed Api operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("apiOperations")
  @operationId("IntegrationServiceEnvironmentManagedApiOperations_List")
  integrationServiceEnvironmentManagedApiOperationsList is ArmResourceActionSync<
    IntegrationServiceEnvironmentManagedApi,
    void,
    ArmResponse<ResourceListResult<ApiOperation>>
  >;
}

@@doc(IntegrationServiceEnvironmentManagedApi.name, "The api name.");
@@doc(IntegrationServiceEnvironmentManagedApi.properties,
  "The integration service environment managed api properties."
);
@@doc(IntegrationServiceEnvironmentManagedApis.put::parameters.resource,
  "The integration service environment managed api."
);
