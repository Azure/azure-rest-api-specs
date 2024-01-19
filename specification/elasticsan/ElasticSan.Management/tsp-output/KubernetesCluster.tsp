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
@doc("KubernetesCluster represents the Kubernetes cluster hosted on Network Cloud.")
model KubernetesCluster is TrackedResource<KubernetesClusterProperties> {
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
interface KubernetesClusters {
  @doc("Get properties of the provided the Kubernetes cluster.")
  get is ArmResourceRead<KubernetesCluster>;

  @doc("Create a new Kubernetes cluster or update the properties of the existing one.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    KubernetesCluster,
    BaseParameters<KubernetesCluster>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch the properties of the provided Kubernetes cluster, or update the tags associated with the Kubernetes cluster. Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<
    KubernetesCluster,
    KubernetesClusterPatchParameters,
    BaseParameters<KubernetesCluster>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete the provided Kubernetes cluster.")
  delete is ArmResourceDeleteAsync<
    KubernetesCluster,
    BaseParameters<KubernetesCluster>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of Kubernetes clusters in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<KubernetesCluster>;

  @doc("Get a list of Kubernetes clusters in the provided subscription.")
  listBySubscription is ArmListBySubscription<KubernetesCluster>;

  @doc("Restart a targeted node of a Kubernetes cluster.")
  restartNode is ArmResourceActionNoResponseContentAsync<
    KubernetesCluster,
    KubernetesClusterRestartNodeParameters,
    BaseParameters<KubernetesCluster>,
    ArmLroLocationHeader
  >;
}

@@projectedName(KubernetesClusters.createOrUpdate::parameters.resource,
  "json",
  "kubernetesClusterParameters"
);
@@extension(KubernetesClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "kubernetesClusterParameters"
);
@@doc(KubernetesClusters.createOrUpdate::parameters.resource,
  "The request body."
);
@@projectedName(KubernetesClusters.update::parameters.properties,
  "json",
  "kubernetesClusterUpdateParameters"
);
@@extension(KubernetesClusters.update::parameters.properties,
  "x-ms-client-name",
  "kubernetesClusterUpdateParameters"
);
@@doc(KubernetesClusters.update::parameters.properties, "The request body.");
@@projectedName(KubernetesClusters.restartNode::parameters.body,
  "json",
  "kubernetesClusterRestartNodeParameters"
);
@@extension(KubernetesClusters.restartNode::parameters.body,
  "x-ms-client-name",
  "kubernetesClusterRestartNodeParameters"
);
@@doc(KubernetesClusters.restartNode::parameters.body, "The request body.");
