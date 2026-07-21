@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request to the action call to check address space availability.")
model CheckAddressSpaceAvailabilityRequest {
  @doc("Resource Id of the Community")
  communityResourceId: CommunityResourceId;

  @doc("Information about the enclave virtual network")
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response of availability of the requested address space.")
model CheckAddressSpaceAvailabilityResponse {
  @doc("Boolean representing whether the address space is available.")
  value: boolean;
}
