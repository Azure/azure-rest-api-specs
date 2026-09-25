import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Request to the action call to check address space availability.")
model CheckAddressSpaceAvailabilityRequest {
  @doc("Resource Id of the Community")
  communityResourceId: CommunityResourceId;

  @removed(Microsoft.Mission.Versions.v2026_07_01_preview)
  @doc("Information about the enclave virtual network")
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;

  @added(Microsoft.Mission.Versions.v2026_07_01_preview)
  @minValue(8)
  @maxValue(26)
  @doc("The CIDR prefix length for the address space to check.")
  prefixLength?: int32;

  @added(Microsoft.Mission.Versions.v2026_07_01_preview)
  @doc("The specific CIDR address space to check for availability.")
  addressSpace?: string;
}

@doc("Response of availability of the requested address space.")
model CheckAddressSpaceAvailabilityResponse {
  @doc("Boolean representing whether the address space is available.")
  value: boolean;
}
