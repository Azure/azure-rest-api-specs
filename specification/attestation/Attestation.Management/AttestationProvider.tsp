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
  @doc("Creates or updates an Attestation Provider.")
  create is ArmResourceCreateOrReplaceSync<AttestationProvider>;
  @doc("Updates the Attestation Provider.")
  update is ArmResourcePatchSync<AttestationProvider, StatusResult>;
  @doc("Delete Attestation Service.")
  delete is ArmResourceDeleteSync<AttestationProvider>;
  @doc("Returns attestation providers list in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AttestationProvider>;
  @doc("Returns a list of attestation providers in a subscription.")
  // list is ArmListBySubscription<AttestationProvider>;
  @doc("Get the default provider")
  // listDefault is ArmListBySubscription<AttestationProvider>;
  @doc("Gets the private link resources supported for the attestation provider.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateLinkResources")
  @get
  ListByProvider is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the attestation provider.")
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      providerName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}
