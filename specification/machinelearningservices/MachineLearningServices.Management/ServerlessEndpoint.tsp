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

@parentResource(Workspace)
model ServerlessEndpoint
  is Azure.ResourceManager.TrackedResource<
    ServerlessEndpointProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ServerlessEndpoint,
    KeyName = "name",
    SegmentName = "serverlessEndpoints",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface ServerlessEndpoints {
  /**
   * Get Serverless Endpoint.
   */
  @summary("Get Serverless Endpoint.")
  get is ArmResourceRead<ServerlessEndpoint>;

  /**
   * Create or update Serverless Endpoint (asynchronous).
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update Serverless Endpoint (asynchronous).")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerlessEndpoint,
    Response = ArmResourceUpdatedResponse<ServerlessEndpoint> | (ArmResourceCreatedResponse<
      ServerlessEndpoint,
      LroHeaders = ArmAsyncOperationHeader<ServerlessEndpoint>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Update Serverless Endpoint (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update Serverless Endpoint (asynchronous).")
  update is ArmCustomPatchAsync<
    ServerlessEndpoint,
    PatchModel = PartialMinimalTrackedResourceWithSkuAndIdentity,
    Response = ArmResourceUpdatedResponse<ServerlessEndpoint> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServerlessEndpoint>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete Serverless Endpoint (asynchronous).
   */
  @summary("Delete Serverless Endpoint (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerlessEndpoint,
    Response = (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List Serverless Endpoints.
   */
  @summary("List Serverless Endpoints.")
  list is ArmResourceListByParent<
    ServerlessEndpoint,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<ServerlessEndpointTrackedResourceArmPaginatedResult>
  >;

  /**
   * List EndpointAuthKeys for an Endpoint using Key-based authentication.
   */
  @summary("List EndpointAuthKeys for an Endpoint using Key-based authentication.")
  listKeys is ArmResourceActionSync<ServerlessEndpoint, void, EndpointAuthKeys>;

  /**
   * Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).
   */
  @summary("Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).")
  regenerateKeys is ArmResourceActionAsync<
    ServerlessEndpoint,
    RegenerateEndpointKeysRequest,
    EndpointAuthKeys
  >;
}

@@doc(ServerlessEndpoint.name, "Serverless Endpoint name.");
@@doc(ServerlessEndpoint.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ServerlessEndpoints.createOrUpdate::parameters.resource,
  "Serverless Endpoint entity to apply during operation."
);
@@doc(ServerlessEndpoints.update::parameters.properties,
  "Serverless Endpoint entity to apply during operation."
);
@@doc(ServerlessEndpoints.regenerateKeys::parameters.body,
  "RegenerateKeys request ."
);
@@doc(ServerlessEndpoint.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(ServerlessEndpoint.sku,
  "Sku details required for ARM contract for Autoscaling."
);
