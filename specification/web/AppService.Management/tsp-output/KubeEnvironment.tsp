import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("A Kubernetes cluster specialized for web workloads by Azure App Service")
model KubeEnvironment is TrackedResource<KubeEnvironmentProperties> {
  @doc("Name of the Kubernetes Environment.")
  @key("name")
  @segment("kubeEnvironments")
  name: string;

  @doc("Extended Location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubeEnvironments {
  @doc("Description for Get the properties of a Kubernetes Environment.")
  get is ArmResourceRead<KubeEnvironment>;
  @doc("Description for Creates or updates a Kubernetes Environment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KubeEnvironment>;
  @doc("Description for Creates or updates a Kubernetes Environment.")
  update is ArmCustomPatchSync<KubeEnvironment, KubeEnvironmentPatchResource>;
  @doc("Description for Delete a Kubernetes Environment.")
  delete is ArmResourceDeleteAsync<KubeEnvironment>;
  @doc("Description for Get all the Kubernetes Environments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<KubeEnvironment>;
  @doc("Description for Get all Kubernetes Environments for a subscription.")
  listBySubscription is ArmListBySubscription<KubeEnvironment>;
}
