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

namespace Microsoft.NetworkCloud;
@doc("ClusterManager represents a control-plane to manage one or more on-premises clusters.")
model ClusterManager is TrackedResource<ClusterManagerProperties> {
  @doc("The name of the cluster manager.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("clusterManagerName")
  @segment("clusterManagers")
  name: string;
}

@armResourceOperations
interface ClusterManagers {
  @doc("Get the properties of the provided cluster manager.")
  get is ArmResourceRead<ClusterManager>;

  @doc("Create a new cluster manager or update properties of the cluster manager if it exists.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ClusterManager,
    BaseParameters<ClusterManager>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch properties of the provided cluster manager, or update the tags assigned to the cluster manager. Properties and tag updates can be done independently.")
  update is ArmCustomPatchSync<ClusterManager, ClusterManagerPatchParameters>;

  @doc("Delete the provided cluster manager.")
  delete is ArmResourceDeleteAsync<
    ClusterManager,
    BaseParameters<ClusterManager>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of cluster managers in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<ClusterManager>;

  @doc("Get a list of cluster managers in the provided subscription.")
  listBySubscription is ArmListBySubscription<ClusterManager>;
}

@@projectedName(ClusterManagers.createOrUpdate::parameters.resource,
  "json",
  "clusterManagerParameters"
);
@@extension(ClusterManagers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "clusterManagerParameters"
);
@@doc(ClusterManagers.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(ClusterManagers.update::parameters.properties,
  "json",
  "clusterManagerUpdateParameters"
);
@@extension(ClusterManagers.update::parameters.properties,
  "x-ms-client-name",
  "clusterManagerUpdateParameters"
);
@@doc(ClusterManagers.update::parameters.properties, "The request body.");
