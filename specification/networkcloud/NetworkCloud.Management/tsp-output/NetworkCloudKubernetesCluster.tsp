import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("KubernetesCluster represents the Kubernetes cluster hosted on Network Cloud.")
model NetworkCloudKubernetesCluster
  is TrackedResource<KubernetesClusterProperties> {
  @doc("The name of the Kubernetes cluster.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("kubernetesClusterName")
  @segment("kubernetesClusters")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudKubernetesClusters {
  @doc("Get properties of the provided the Kubernetes cluster.")
  get is ArmResourceRead<NetworkCloudKubernetesCluster>;
  @doc("Create a new Kubernetes cluster or update the properties of the existing one.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudKubernetesCluster>;
  @doc("Patch the properties of the provided Kubernetes cluster, or update the tags associated with the Kubernetes cluster. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<
    NetworkCloudKubernetesCluster,
    KubernetesClusterProperties
  >;
  @doc("Delete the provided Kubernetes cluster.")
  delete is ArmResourceDeleteAsync<NetworkCloudKubernetesCluster>;
  @doc("Get a list of Kubernetes clusters in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkCloudKubernetesCluster>;
  @doc("Get a list of Kubernetes clusters in the provided subscription.")
  listBySubscription is ArmListBySubscription<NetworkCloudKubernetesCluster>;
  @doc("Restart a targeted node of a Kubernetes cluster.")
  restartNode is ArmResourceActionNoResponseContentAsync<
    NetworkCloudKubernetesCluster,
    KubernetesClusterRestartNodeParameters
  >;
}
