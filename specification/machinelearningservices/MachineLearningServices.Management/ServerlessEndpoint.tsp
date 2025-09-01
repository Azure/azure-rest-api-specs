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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface ServerlessEndpoints {
  /**
   * Get Serverless Endpoint.
   */
  get is ArmResourceRead<ServerlessEndpoint>;

  /**
   * Create or update Serverless Endpoint (asynchronous).
   */
  @Azure.Core.useFinalStateVia("original-uri")
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
  update is ArmCustomPatchAsync<
    ServerlessEndpoint,
    PatchModel = PartialMinimalTrackedResourceWithSkuAndIdentity,
    Response = ArmResourceUpdatedResponse<ServerlessEndpoint> | (ArmAcceptedLroResponse & {
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
  listKeys is ArmResourceActionSync<ServerlessEndpoint, void, EndpointAuthKeys>;

  /**
   * Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).
   */
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
