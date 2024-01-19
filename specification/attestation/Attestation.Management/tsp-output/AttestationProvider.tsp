import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  update is ArmCustomPatchSync<
    AttestationProvider,
    AttestationServicePatchParams
  >;

  @doc("Delete Attestation Service.")
  delete is ArmResourceDeleteSync<AttestationProvider>;

  @doc("Returns attestation providers list in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AttestationProvider>;

  @doc("Returns a list of attestation providers in a subscription.")
  list is ArmListBySubscription<AttestationProvider>;

  @doc("Get the default provider")
  listDefault is ArmListBySubscription<AttestationProvider>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByProvider")
  @doc("Gets the private link resources supported for the attestation provider.")
  // FIXME: PrivateLinkResources_ListByProvider could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateLinkResources")
  @get
  listByProvider is Azure.Core.Foundations.Operation<
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

@@projectedName(AttestationProviders.create::parameters.resource,
  "json",
  "creationParams"
);
@@extension(AttestationProviders.create::parameters.resource,
  "x-ms-client-name",
  "creationParams"
);
@@doc(AttestationProviders.create::parameters.resource,
  "Client supplied parameters."
);
@@projectedName(AttestationProviders.update::parameters.properties,
  "json",
  "updateParams"
);
@@extension(AttestationProviders.update::parameters.properties,
  "x-ms-client-name",
  "updateParams"
);
@@doc(AttestationProviders.update::parameters.properties,
  "Client supplied parameters."
);
