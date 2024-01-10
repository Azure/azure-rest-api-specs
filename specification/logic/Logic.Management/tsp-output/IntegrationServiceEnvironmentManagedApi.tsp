import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationServiceEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Logic;
@doc("The integration service environment managed api.")
@parentResource(IntegrationServiceEnvironment)
model IntegrationServiceEnvironmentManagedApi
  is TrackedResource<IntegrationServiceEnvironmentManagedApiProperties> {
  @doc("The api name.")
  @key("apiName")
  @segment("managedApis")
  name: string;
}

@armResourceOperations
interface IntegrationServiceEnvironmentManagedApis {
  @doc("Gets the integration service environment managed Api.")
  get is ArmResourceRead<IntegrationServiceEnvironmentManagedApi>;

  @doc("Puts the integration service environment managed Api.")
  put is ArmResourceCreateOrUpdateAsync<IntegrationServiceEnvironmentManagedApi>;

  @doc("Deletes the integration service environment managed Api.")
  delete is ArmResourceDeleteWithoutOkAsync<IntegrationServiceEnvironmentManagedApi>;

  @doc("Gets the integration service environment managed Apis.")
  list is ArmResourceListByParent<IntegrationServiceEnvironmentManagedApi>;
}

@armResourceOperations
@projectedName("client", "IntegrationServiceEnvironmentManagedApiOperations")
interface IntegrationServiceEnvironmentManagedApis_IntegrationServiceEnvironmentManagedApiOperations {
  @doc("Gets the managed Api operations.")
  // FIXME: IntegrationServiceEnvironmentManagedApiOperations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/managedApis/{apiName}/apiOperations")
  @get
  List is Azure.Core.Foundations.Operation<
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

      @doc("The api name.")
      @path
      apiName: string;
    },
    ApiOperationListResult
  >;
}
