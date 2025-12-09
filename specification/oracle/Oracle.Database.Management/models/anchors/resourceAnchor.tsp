using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20250401_preview)
@doc("Resource Anchor model.")
model ResourceAnchor is TrackedResource<ResourceAnchorProperties> {
  ...ResourceNameParameter<ResourceAnchor>;
}

@added(Versions.v20250401_preview)
@doc("Resource Anchor properties.")
model ResourceAnchorProperties {
  @doc("ResourceAnchor provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("Oracle Cloud Infrastructure compartment Id (ocid) which was created or linked by customer with resource anchor. This compartmentId is different from where resource Anchor lives")
  @visibility(Lifecycle.Read)
  linkedCompartmentId?: Ocid;
}
