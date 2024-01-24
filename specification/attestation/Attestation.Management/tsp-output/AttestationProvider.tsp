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
/**
 * Attestation service response message.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(StatusResult)
@includeInapplicableMetadataInPayload(false)
model AttestationProvider extends TrackedResourceBase {
  /**
   * Name of the attestation provider.
   */
  @path
  @key("providerName")
  @segment("attestationProviders")
  name: string;

  /**
   * Describes Attestation service status.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StatusResult;
}

@armResourceOperations
interface AttestationProviders {
  /**
   * Get the status of Attestation Provider.
   */
  get is ArmResourceRead<AttestationProvider>;

  /**
   * Creates a new Attestation Provider.
   */
  create is ArmResourceCreateOrReplaceSync<AttestationProvider>;

  /**
   * Updates the Attestation Provider.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    AttestationProvider,
    AttestationServicePatchParams
  >;

  /**
   * Delete Attestation Service.
   */
  delete is ArmResourceDeleteSync<AttestationProvider>;

  /**
   * Returns attestation providers list in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AttestationProviders_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AttestationProvider>;

  /**
   * Returns a list of attestation providers in a subscription.
   */
  list is ArmListBySubscription<AttestationProvider>;

  /**
   * Get the default provider
   */
  listDefault is ArmListBySubscription<AttestationProvider>;

  /**
   * Gets the private link resources supported for the attestation provider.
   */
  // FIXME: PrivateLinkResources_ListByProvider could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByProvider")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateLinkResources")
  @get
  listByProvider is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the attestation provider.
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      providerName: string;

      /**
       * The ID of the target subscription.
       */
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
