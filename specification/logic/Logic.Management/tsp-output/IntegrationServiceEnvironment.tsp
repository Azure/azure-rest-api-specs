import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The integration service environment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  IntegrationServiceEnvironmentProperties
)
@includeInapplicableMetadataInPayload(false)
model IntegrationServiceEnvironment extends Resource {
  /**
   * The integration service environment name.
   */
  @path
  @key("integrationServiceEnvironmentName")
  @segment("integrationServiceEnvironments")
  name: string;

  /**
   * The sku.
   */
  sku?: IntegrationServiceEnvironmentSku;

  /**
   * Managed service identity properties.
   */
  identity?: ManagedServiceIdentity;

  /**
   * The integration service environment properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IntegrationServiceEnvironmentProperties;
}

@armResourceOperations
interface IntegrationServiceEnvironments {
  /**
   * Gets an integration service environment.
   */
  get is ArmResourceRead<IntegrationServiceEnvironment>;

  /**
   * Creates or updates an integration service environment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IntegrationServiceEnvironment>;

  /**
   * Updates an integration service environment.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    IntegrationServiceEnvironment,
    IntegrationServiceEnvironment
  >;

  /**
   * Deletes an integration service environment.
   */
  delete is ArmResourceDeleteSync<IntegrationServiceEnvironment>;

  /**
   * Gets a list of integration service environments by resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationServiceEnvironment,
    {
      ...BaseParameters<IntegrationServiceEnvironment>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a list of integration service environments by subscription.
   */
  listBySubscription is ArmListBySubscription<IntegrationServiceEnvironment>;

  /**
   * Restarts an integration service environment.
   */
  restart is ArmResourceActionSync<IntegrationServiceEnvironment, void, void>;

  /**
   * Gets a list of integration service environment Skus.
   */
  // FIXME: IntegrationServiceEnvironmentSkus_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentSkus_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/skus")
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
    },
    IntegrationServiceEnvironmentSkuList
  >;

  /**
   * Gets the integration service environment network health.
   */
  // FIXME: IntegrationServiceEnvironmentNetworkHealth_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentNetworkHealth_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/health/network")
  @get
  get is Azure.Core.Foundations.Operation<
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
    },
    void
  >;
}

@@projectedName(IntegrationServiceEnvironments.createOrUpdate::parameters.resource,
  "json",
  "integrationServiceEnvironment"
);
@@extension(IntegrationServiceEnvironments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "integrationServiceEnvironment"
);
@@doc(IntegrationServiceEnvironments.createOrUpdate::parameters.resource,
  "The integration service environment."
);
@@projectedName(IntegrationServiceEnvironments.update::parameters.properties,
  "json",
  "integrationServiceEnvironment"
);
@@extension(IntegrationServiceEnvironments.update::parameters.properties,
  "x-ms-client-name",
  "integrationServiceEnvironment"
);
@@doc(IntegrationServiceEnvironments.update::parameters.properties,
  "The integration service environment."
);
