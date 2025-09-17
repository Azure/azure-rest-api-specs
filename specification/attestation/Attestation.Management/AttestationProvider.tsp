import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Attestation;
/**
 * Attestation service response message.
 */
model AttestationProvider
  is Azure.ResourceManager.TrackedResource<StatusResult> {
  ...ResourceNameParameter<
    Resource = AttestationProvider,
    KeyName = "providerName",
    SegmentName = "attestationProviders",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AttestationProviders {
  /**
   * Get the status of Attestation Provider.
   */
  get is ArmResourceRead<AttestationProvider>;

  /**
   * Creates or updates an Attestation Provider.
   */
  create is ArmResourceCreateOrReplaceSync<AttestationProvider>;

  /**
   * Updates the Attestation Provider.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AttestationProvider,
    PatchModel = AttestationServicePatchParams
  >;

  /**
   * Delete Attestation Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteSync<
    AttestationProvider,
    Response = ArmDeletedResponse | AcceptedResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns attestation providers list in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AttestationProvider,
    Response = ArmResponse<AttestationProviderListResult>
  >;

  /**
   * Returns a list of attestation providers in a subscription.
   */
  list is ArmListBySubscription<
    AttestationProvider,
    Response = ArmResponse<AttestationProviderListResult>
  >;

  /**
   * Gets the private link resources supported for the attestation provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_ListByProvider")
  @get
  @action("privateLinkResources")
  listByProvider is ArmResourceActionSync<
    AttestationProvider,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.PrivateLinkResourceListResultV5>
  >;
}

@@doc(AttestationProvider.name, "Name of the attestation provider.");
@@doc(AttestationProvider.properties, "Describes Attestation service status.");
@@doc(AttestationProviders.create::parameters.resource,
  "Client supplied parameters."
);
@@doc(AttestationProviders.update::parameters.properties,
  "Client supplied parameters."
);
