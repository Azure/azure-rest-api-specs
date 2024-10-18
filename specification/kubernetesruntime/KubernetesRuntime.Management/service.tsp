import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@doc("Properties for the service resource")
model ServiceProperties {
  @doc("The object id of the service principal of the RP provisioned in the tenant")
  @visibility("read")
  rpObjectId?: uuid;

  @doc("Resource provision state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Service resource for an Arc connected cluster (Microsoft.Kubernetes/connectedClusters)")
model ServiceResource is ExtensionResource<ServiceProperties> {
  @doc("The name of the the service")
  @key("serviceName")
  @segment("services")
  @pattern("^(storageclass|networking)$")
  @path
  name: string;
}

@armResourceOperations(ServiceResource)
interface Services {
  get is ArmResourceRead<ServiceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceResource>;
  delete is ArmResourceDeleteSync<ServiceResource>;
  list is ArmResourceListByParent<ServiceResource>;
}
