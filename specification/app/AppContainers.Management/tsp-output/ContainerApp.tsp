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

namespace Microsoft.App;
@doc("Container App.")
model ContainerApp is TrackedResource<ContainerAppProperties> {
  @doc("Name of the Container App.")
  @path
  @key("containerAppName")
  @segment("containerApps")
  name: string;

  @doc("The complex type of the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface ContainerApps {
  @doc("Get the properties of a Container App.")
  get is ArmResourceRead<ContainerApp>;

  @doc("Create or update a Container App.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmAsyncOperationHeader
  >;

  @doc("Patches a Container App using JSON Merge Patch")
  update is ArmCustomPatchAsync<ContainerApp, ContainerApp>;

  @doc("Delete a Container App.")
  delete is ArmResourceDeleteAsync<
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmLroLocationHeader
  >;

  @doc("Get the Container Apps in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<ContainerApp>;

  @doc("Get the Container Apps in a given subscription.")
  listBySubscription is ArmListBySubscription<ContainerApp>;

  @doc("Analyzes a custom hostname for a Container App")
  listCustomHostNameAnalysis is ArmResourceActionSync<
    ContainerApp,
    void,
    CustomHostnameAnalysisResult,
    {
      ...BaseParameters<ContainerApp>;

      @doc("Custom hostname.")
      @query("customHostname")
      customHostname?: string;
    }
  >;

  @doc("List secrets for a container app")
  listSecrets is ArmResourceActionSync<ContainerApp, void, SecretsCollection>;

  @doc("Get auth token for a container app")
  getAuthToken is ArmResourceActionSync<
    ContainerApp,
    void,
    ContainerAppAuthToken
  >;

  @doc("Start a container app")
  start is ArmResourceActionAsync<
    ContainerApp,
    void,
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmLroLocationHeader
  >;

  @doc("Stop a container app")
  stop is ArmResourceActionAsync<
    ContainerApp,
    void,
    ContainerApp,
    BaseParameters<ContainerApp>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ContainerApps.createOrUpdate::parameters.resource,
  "json",
  "containerAppEnvelope"
);
@@extension(ContainerApps.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "containerAppEnvelope"
);
@@doc(ContainerApps.createOrUpdate::parameters.resource,
  "Properties used to create a container app"
);
@@projectedName(ContainerApps.update::parameters.properties,
  "json",
  "containerAppEnvelope"
);
@@extension(ContainerApps.update::parameters.properties,
  "x-ms-client-name",
  "containerAppEnvelope"
);
@@doc(ContainerApps.update::parameters.properties,
  "Properties of a Container App that need to be updated"
);
