import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NeuroShield.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace NeuroShield.Management;

@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface NeuroShieldProtectedResources {
  /**
   * Gets a protected resource under a NeuroShield resource.
   */
  @summary("Get a protected resource")
  get is ArmResourceRead<
    NeuroShieldProtectedResource,
    Response = ArmResponse<NeuroShieldProtectedResource> &
      Azure.Core.EtagResponseEnvelope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Creates or updates a protected resource under a NeuroShield resource.
   */
  @summary("Create or update a protected resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NeuroShieldProtectedResource,
    Parameters = {
      /** The entity tag that makes the request conditional. */
      @header("If-Match")
      @added(Versions.v2026_10_01_preview)
      ifMatch?: string;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = NeuroShieldProtectedResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Deletes a protected resource under a NeuroShield resource.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @summary("Delete a protected resource")
  delete is ArmResourceDeleteWithoutOkAsync<
    NeuroShieldProtectedResource,
    Parameters = {
      /** The entity tag that makes the request conditional. */
      @header("If-Match")
      @added(Versions.v2026_10_01_preview)
      ifMatch?: string;
    },
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists all protected resources under a NeuroShield resource.
   */
  @summary("List protected resources")
  list is ArmResourceListByParent<
    NeuroShieldProtectedResource,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Requests a fresh inventory upload from the Neuron agents associated with a protected resource.
   */
  @summary("Trigger an inventory upload")
  @action("triggerInventoryUpload")
  triggerInventoryUpload is ArmResourceActionSync<
    NeuroShieldProtectedResource,
    void,
    ArmResponse<NeuroShieldInventoryUploadRequestResult>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;
}

@@doc(NeuroShieldProtectedResource.name, "The name of the protected resource.");
@@doc(
  NeuroShieldProtectedResource.properties,
  "Properties of the protected resource."
);
@@doc(
  NeuroShieldProtectedResources.createOrUpdate::parameters.resource,
  "The create or update request body for a protected resource."
);
