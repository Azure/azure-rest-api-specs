import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kubernetes;
@doc("Represents a connected cluster.")
model ConnectedCluster is TrackedResource<ConnectedClusterProperties> {
  @doc("The name of the Kubernetes cluster on which get is called.")
  @key("clusterName")
  @segment("connectedClusters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
@projectedName("client", "ConnectedCluster")
interface ConnectedClusters_ConnectedCluster {
  @doc("Returns the properties of the specified connected cluster, including name, identity, properties, and additional cluster details.")
  get is ArmResourceRead<ConnectedCluster>;

  @doc("API to register a new Kubernetes cluster and create a tracked resource in Azure Resource Manager (ARM).")
  create is ArmResourceCreateOrUpdateAsync<ConnectedCluster>;

  @doc("API to update certain properties of the connected cluster resource")
  update is ArmCustomPatchSync<ConnectedCluster, ConnectedClusterPatch>;

  @doc("Delete a connected cluster, removing the tracked resource in Azure Resource Manager (ARM).")
  delete is ArmResourceDeleteAsync<ConnectedCluster>;

  @doc("API to enumerate registered connected K8s clusters under a Resource Group")
  listByResourceGroup is ArmResourceListByParent<ConnectedCluster>;

  @doc("API to enumerate registered connected K8s clusters under a Subscription")
  listBySubscription is ArmListBySubscription<ConnectedCluster>;

  @doc("Gets cluster user credentials of the connected cluster with a specified resource group and name.")
  listClusterUserCredential is ArmResourceActionSync<
    ConnectedCluster,
    ListClusterUserCredentialProperties,
    CredentialResults
  >;
}
