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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface OnlineEndpoints {
  /**
   * Get Online Endpoint.
   */
  get is ArmResourceRead<OnlineEndpoint>;

  /**
   * Create or update Online Endpoint (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OnlineEndpoint>;

  /**
   * Update Online Endpoint (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OnlineEndpoint,
    PatchModel = PartialMinimalTrackedResourceWithIdentity
  >;

  /**
   * Delete Online Endpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    OnlineEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Online Endpoints.
   */
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
  listKeys is ArmResourceActionSync<
    OnlineEndpoint,
    void,
    ArmResponse<EndpointAuthKeys>
  >;

  /**
   * Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).
   */
  regenerateKeys is ArmResourceActionAsync<
    OnlineEndpoint,
    RegenerateEndpointKeysRequest,
    OkResponse
  >;

  /**
   * Retrieve a valid AML token for an Endpoint using AMLToken-based authentication.
   */
  @action("token")
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
