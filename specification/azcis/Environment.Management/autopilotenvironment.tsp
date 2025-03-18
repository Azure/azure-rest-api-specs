import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("environment properties")
model EnvironmentResourceProperties {
  @doc("The source environment and the source cluster from which you want to clone the environment.")
  @madeRequired(Versions.v2024_06_24_preview)
  modelEnvironment: string;

  @doc("The name of the target environment to be created.")
  environmentName?: string;

  @doc("The name of the target cluster where the new environment is supposed to be created.")
  clusterName?: string;

  @doc("The mode property indicates which files will be cloned to the new environment. There are two options. All: Will clone all the files including customer files to the new environment. Basic: Will clone only the environment basic files which is deployment.ini, allocation.ini, environment.ini, VirtualEnvironment.ini, UserProperty.ini, Machines.csv, owners.txt, access.txt.")
  @madeRequired(Versions.v2024_06_24_preview)
  @visibility(Lifecycle.Read)
  mode: EnvironmentMode;

  @doc("The Azure location")
  @added(Versions.v2024_06_24_preview)
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EnvironmentProvisioningState;
}

@doc("Environment Resource")
model EnvironmentResource
  is ProxyResource<EnvironmentResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("autopilotEnvironments") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface Environment {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    EnvironmentResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<EnvironmentResource>;
  listByResourceGroup is ArmResourceListByParent<EnvironmentResource>;
  get is ArmResourceRead<EnvironmentResource>;
}

@doc("The EnvironmentMode indicates which files will be cloned to the new environment.")
union EnvironmentMode {
  string,

  @doc("On the Basic mode only the environment basic files will be cloned to the new environment. The environment basic files are deployment.ini, allocation.ini, environment.ini, VirtualEnvironment.ini, UserProperty.ini, Machines.csv, owners.txt, access.txt.")
  Basic: "Basic",

  @doc("On the All mode all the files including customer files will be copied to the new environment.")
  All: "All",
}

@@visibility(EnvironmentResource.properties, Lifecycle.Read, Lifecycle.Create);
