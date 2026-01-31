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
model OnlineEndpoint
  is Azure.ResourceManager.TrackedResource<OnlineEndpointProperties, false> {
  ...ResourceNameParameter<
    Resource = OnlineEndpoint,
    KeyName = "endpointName",
    SegmentName = "onlineEndpoints",
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
interface OnlineEndpoints {
  /**
   * Get Online Endpoint.
   */
  @summary("Get Online Endpoint.")
  get is ArmResourceRead<OnlineEndpoint>;

  /**
   * Create or update Online Endpoint (asynchronous).
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update Online Endpoint (asynchronous).")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OnlineEndpoint,
    Response = ArmResourceUpdatedResponse<OnlineEndpoint> | (ArmResourceCreatedResponse<
      OnlineEndpoint,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = OnlineEndpoint>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Update Online Endpoint (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update Online Endpoint (asynchronous).")
  update is ArmCustomPatchAsync<
    OnlineEndpoint,
    PatchModel = PartialMinimalTrackedResourceWithIdentity,
    Response = OnlineEndpoint | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OnlineEndpoint>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete Online Endpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete Online Endpoint (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    OnlineEndpoint,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List Online Endpoints.
   */
  @summary("List Online Endpoints.")
  list is ArmResourceListByParent<
    OnlineEndpoint,
    Parameters = {
      /**
       * Name of the endpoint.
       */
      @query("name")
      name?: string;

      /**
       * Number of endpoints to be retrieved in a page of results.
       */
      @query("count")
      count?: int32;

      /**
       * EndpointComputeType to be filtered by.
       */
      @query("computeType")
      computeType?: EndpointComputeType;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * A set of tags with which to filter the returned models. It is a comma separated string of tags key or tags key=value. Example: tagKey1,tagKey2,tagKey3=value3 .
       */
      @query("tags")
      tags?: string;

      /**
       * A set of properties with which to filter the returned models. It is a comma separated string of properties key and/or properties key=value Example: propKey1,propKey2,propKey3=value3 .
       */
      @query("properties")
      properties?: string;

      /**
       * The option to order the response.
       */
      @query("orderBy")
      orderBy?: OrderString;
    },
    Response = ArmResponse<OnlineEndpointTrackedResourceArmPaginatedResult>
  >;

  /**
   * List EndpointAuthKeys for an Endpoint using Key-based authentication.
   */
  @summary("List EndpointAuthKeys for an Endpoint using Key-based authentication.")
  listKeys is ArmResourceActionSync<OnlineEndpoint, void, EndpointAuthKeys>;

  /**
   * Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).
   */
  @summary("Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).")
  regenerateKeys is ArmResourceActionAsync<
    OnlineEndpoint,
    RegenerateEndpointKeysRequest,
    Response = {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Retrieve a valid AML token for an Endpoint using AMLToken-based authentication.
   */
  @action("token")
  @summary("Retrieve a valid AML token for an Endpoint using AMLToken-based authentication.")
  getToken is ArmResourceActionSync<
    OnlineEndpoint,
    void,
    ArmResponse<EndpointAuthToken>
  >;
}

@@doc(OnlineEndpoint.name, "Online Endpoint name.");
@@doc(OnlineEndpoint.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(OnlineEndpoints.createOrUpdate::parameters.resource,
  "Online Endpoint entity to apply during operation."
);
@@doc(OnlineEndpoints.update::parameters.properties,
  "Online Endpoint entity to apply during operation."
);
@@doc(OnlineEndpoints.regenerateKeys::parameters.body,
  "RegenerateKeys request ."
);
@@doc(OnlineEndpoint.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(OnlineEndpoint.sku,
  "Sku details required for ARM contract for Autoscaling."
);
