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
@doc("The integration service environment managed api.")
@parentResource(IntegrationServiceEnvironment)
model IntegrationServiceEnvironmentManagedApi
  is TrackedResource<IntegrationServiceEnvironmentManagedApiProperties> {
  @doc("The api name.")
  @path
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationServiceEnvironmentManagedApiOperations_List")
  @doc("Gets the managed Api operations.")
  // FIXME: IntegrationServiceEnvironmentManagedApiOperations_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Logic/integrationServiceEnvironments/{integrationServiceEnvironmentName}/managedApis/{apiName}/apiOperations")
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

      @doc("The api name.")
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
