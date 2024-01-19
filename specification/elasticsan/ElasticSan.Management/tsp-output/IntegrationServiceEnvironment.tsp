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
@doc("The integration service environment.")
model IntegrationServiceEnvironment
  is TrackedResource<IntegrationServiceEnvironmentProperties> {
  @doc("The integration service environment name.")
  @path
  @key("integrationServiceEnvironmentName")
  @segment("integrationServiceEnvironments")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface IntegrationServiceEnvironments {
  @doc("Gets an integration service environment.")
  get is ArmResourceRead<IntegrationServiceEnvironment>;

  @doc("Creates or updates an integration service environment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IntegrationServiceEnvironment>;

  @doc("Updates an integration service environment.")
  update is ArmCustomPatchAsync<
    IntegrationServiceEnvironment,
    IntegrationServiceEnvironment
  >;

  @doc("Deletes an integration service environment.")
  delete is ArmResourceDeleteSync<IntegrationServiceEnvironment>;

  @doc("Gets a list of integration service environments by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationServiceEnvironment,
    {
      ...BaseParameters<IntegrationServiceEnvironment>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Gets a list of integration service environments by subscription.")
  listBySubscription is ArmListBySubscription<IntegrationServiceEnvironment>;

  @doc("Restarts an integration service environment.")
  restart is ArmResourceActionSync<IntegrationServiceEnvironment, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentSkus_List")
  @doc("Gets a list of integration service environment Skus.")
  // FIXME: IntegrationServiceEnvironmentSkus_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group.")
      @path
      resourceGroup: string;

      @doc("The integration service environment name.")
      @path
      integrationServiceEnvironmentName: string;
    },
    IntegrationServiceEnvironmentSkuList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentNetworkHealth_Get")
  @doc("Gets the integration service environment network health.")
  // FIXME: IntegrationServiceEnvironmentNetworkHealth_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/health/network")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group.")
      @path
      resourceGroup: string;

      @doc("The integration service environment name.")
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
