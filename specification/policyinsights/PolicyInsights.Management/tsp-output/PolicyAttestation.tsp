import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PolicyInsights;
@doc("An attestation resource.")
model PolicyAttestation is ExtensionResource<AttestationProperties> {
  @doc("The name of the attestation.")
  @path
  @key("attestationName")
  @segment("attestations")
  name: string;
}

@armResourceOperations
interface PolicyAttestations {
  @doc("Gets an existing attestation at resource scope.")
  getAtResource is ArmResourceRead<PolicyAttestation>;
  @doc("Creates or updates an attestation at resource scope.")
  createOrUpdateAtResource is ArmResourceCreateOrUpdateAsync<PolicyAttestation>;
  @doc("Deletes an existing attestation at individual resource scope.")
  deleteAtResource is ArmResourceDeleteSync<PolicyAttestation>;
  @doc("Gets all attestations for a resource.")
  listForResource is ArmResourceListByParent<
    PolicyAttestation,
    {
      ...BaseParameters<PolicyAttestation>;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    }
  >;
}
