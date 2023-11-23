import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Attestation;
@doc("Attestation service response message.")
model AttestationProvider is TrackedResource<StatusResult> {
  @doc("Name of the attestation provider.")
  @path
  @key("providerName")
  @segment("attestationProviders")
  name: string;
}

@armResourceOperations
interface AttestationProviders {
  @doc("Get the status of Attestation Provider.")
  get is ArmResourceRead<AttestationProvider>;
  @doc("Creates a new Attestation Provider.")
  create is ArmResourceCreateOrReplaceSync<AttestationProvider>;
  @doc("Updates the Attestation Provider.")
  update is ArmTagsPatchSync<AttestationProvider>;
  @doc("Delete Attestation Service.")
  delete is ArmResourceDeleteSync<AttestationProvider>;
  @doc("Returns attestation providers list in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AttestationProvider>;
  @doc("Returns a list of attestation providers in a subscription.")
  list is ArmListBySubscription<AttestationProvider>;
  @doc("Get the default provider")
  listDefault is ArmListBySubscription<AttestationProvider>;
}
