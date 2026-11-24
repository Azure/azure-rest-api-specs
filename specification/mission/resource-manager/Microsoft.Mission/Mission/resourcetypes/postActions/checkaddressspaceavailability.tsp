import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Request to the action call to check address space availability.")
model CheckAddressSpaceAvailabilityRequest {
  @doc("Resource Id of the Community")
  communityResourceId: CommunityResourceId;

  @doc("Information about the enclave virtual network")
  @removed(Microsoft.Mission.Versions.v2026_10_01_preview)
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @minValue(8)
  @maxValue(26)
  @doc("CIDR prefix length (e.g., 22, 23, 24). Determines the size of the address space to check.")
  prefixLength?: int32;

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("Specific CIDR address space to check availability for. If omitted, RP checks for any available space of the given prefixLength.")
  addressSpace?: string;
}

@doc("Response of availability of the requested address space.")
model CheckAddressSpaceAvailabilityResponse {
  @doc("Boolean representing whether the address space is available.")
  value: boolean;
}
