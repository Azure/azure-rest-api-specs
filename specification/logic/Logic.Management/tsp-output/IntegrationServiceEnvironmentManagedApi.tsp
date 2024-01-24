import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationServiceEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The integration service environment managed api.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IntegrationServiceEnvironment)
@Azure.ResourceManager.Private.armResourceInternal(
  IntegrationServiceEnvironmentManagedApiProperties
)
@includeInapplicableMetadataInPayload(false)
model IntegrationServiceEnvironmentManagedApi extends Resource {
  /**
   * The api name.
   */
  @path
  @key("apiName")
  @segment("managedApis")
  name: string;

  /**
   * The integration service environment managed api properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IntegrationServiceEnvironmentManagedApiProperties;
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
  put is ArmResourceCreateOrReplaceAsync<IntegrationServiceEnvironmentManagedApi>;

  /**
   * Deletes the integration service environment managed Api.
   */
  delete is ArmResourceDeleteWithoutOkAsync<IntegrationServiceEnvironmentManagedApi>;

  /**
   * Gets the integration service environment managed Apis.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentManagedApis_List")
  list is ArmResourceListByParent<IntegrationServiceEnvironmentManagedApi>;

  /**
   * Gets the managed Api operations.
   */
  // FIXME: IntegrationServiceEnvironmentManagedApiOperations_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentManagedApiOperations_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/managedApis/{apiName}/apiOperations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group.
       */
      @path
      resourceGroup: string;

      /**
       * The integration service environment name.
       */
      @path
      integrationServiceEnvironmentName: string;

      /**
       * The api name.
       */
      @path
      apiName: string;
    },
    ApiOperationListResult
  >;
}

@@projectedName(IntegrationServiceEnvironmentManagedApis.put::parameters.resource,
  "json",
  "integrationServiceEnvironmentManagedApi"
);
@@extension(IntegrationServiceEnvironmentManagedApis.put::parameters.resource,
  "x-ms-client-name",
  "integrationServiceEnvironmentManagedApi"
);
@@doc(IntegrationServiceEnvironmentManagedApis.put::parameters.resource,
  "The integration service environment managed api."
);
