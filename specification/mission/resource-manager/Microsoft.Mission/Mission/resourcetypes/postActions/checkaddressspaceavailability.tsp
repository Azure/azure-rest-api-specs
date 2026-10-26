@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Request to the action call to check address space availability.")
model CheckAddressSpaceAvailabilityRequest {
  @doc("Resource Id of the Community")
  communityResourceId: CommunityResourceId;

  @doc("Information about the enclave virtual network")
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;
}

@doc("Response of availability of the requested address space.")
model CheckAddressSpaceAvailabilityResponse {
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Back compat: Existing CheckAddressSpaceAvailabilityResponse.value has a boolean wire value; preserve the published property contract."
  @doc("Boolean representing whether the address space is available.")
  value: boolean;
}
