import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@doc("The top level management resource for Application Discovery.")
model DiscoveryHub is TrackedResource<DiscoveryHubProperties> {
  ...ResourceNameParameter<
    Resource = DiscoveryHub,
    KeyName = "discoveryHubName",
    SegmentName = "discoveryHubs",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@doc("The properties of the DiscoveryHub resource.")
model DiscoveryHubProperties {
  @doc("The status of the DiscoveryHub resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
