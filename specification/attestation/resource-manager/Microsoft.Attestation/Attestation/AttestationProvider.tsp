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
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

@armResourceOperations
interface AttestationProvidersOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {},
      {}
    > {}

@armResourceOperations
interface AttestationProvidersResourceGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {},
      {}
    > {}

@armResourceOperations
interface AttestationProviders {
  /**
   * Get the status of Attestation Provider.
   */
  get is ArmResourceRead<AttestationProvider, Error = CloudError>;

  /**
   * Creates or updates an Attestation Provider.
   */
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    AttestationProvider,
    Request = AttestationServiceCreationParams,
    Error = CloudError
  >;

  /**
   * Updates the Attestation Provider.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AttestationProvider,
    PatchModel = AttestationServicePatchParams,
    Error = CloudError
  >;

  /**
   * Delete Attestation Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    AttestationProvider,
    Response = ArmDeletedResponse | AcceptedResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns attestation providers list in a resource group.
   */
  listByResourceGroup is AttestationProvidersResourceGroupOps.ListSinglePage<
    AttestationProvider,
    Response = ArmResponse<AttestationProviderListResult>,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns a list of attestation providers in a subscription.
   */
  list is AttestationProvidersOps.ListSinglePage<
    AttestationProvider,
    Response = ArmResponse<AttestationProviderListResult>,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the private link resources supported for the attestation provider.
   */
  @get
  @action("privateLinkResources")
  listByProvider is ArmResourceActionSync<
    AttestationProvider,
    void,
    ArmResponse<ResourceListResult<PrivateLinkResource>>,
    Error = CloudError
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
