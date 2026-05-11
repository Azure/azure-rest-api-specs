import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model CapabilityHost
  is Azure.ResourceManager.ProxyResource<CapabilityHostProperties, false> {
  ...ResourceNameParameter<
    Resource = CapabilityHost,
    KeyName = "name",
    SegmentName = "capabilityHosts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CapabilityHosts {
  /**
   * Get capabilityHost.
   */
  @summary("Get capabilityHost.")
  get is ArmResourceRead<CapabilityHost>;

  /**
   * Create or update capabilityHost.
   */
  @summary("Create or update capabilityHost.")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CapabilityHost,
    Response = ArmResourceUpdatedResponse<CapabilityHost> | (ArmResourceCreatedResponse<
      CapabilityHost,
      LroHeaders = ArmAsyncOperationHeader
    > &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete capabilityHost.
   */
  @summary("Delete capabilityHost.")
  delete is ArmResourceDeleteWithoutOkAsync<
    CapabilityHost,
    Response = (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;
}

@@doc(CapabilityHost.name, "CapabilityHost name.");
@@doc(CapabilityHost.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(CapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
