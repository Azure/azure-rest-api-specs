import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * The streaming endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MediaService)
@Azure.ResourceManager.Private.armResourceInternal(StreamingEndpointProperties)
@includeInapplicableMetadataInPayload(false)
model StreamingEndpoint extends TrackedResourceBase {
  /**
   * The name of the streaming endpoint, maximum length is 24.
   */
  @maxLength(24)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @path
  @key("streamingEndpointName")
  @segment("streamingEndpoints")
  name: string;

  /**
   * The streaming endpoint properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StreamingEndpointProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface StreamingEndpoints {
  /**
   * Gets a streaming endpoint.
   */
  get is ArmResourceRead<StreamingEndpoint>;

  /**
   * Creates a streaming endpoint.
   */
  create is ArmResourceCreateOrReplaceAsync<
    StreamingEndpoint,
    {
      ...BaseParameters<StreamingEndpoint>;

      /**
       * The flag indicates if the resource should be automatically started on creation.
       */
      @query("autoStart")
      autoStart?: boolean;
    }
  >;

  /**
   * Updates a existing streaming endpoint.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<StreamingEndpoint, StreamingEndpoint>;

  /**
   * Deletes a streaming endpoint.
   */
  delete is ArmResourceDeleteAsync<StreamingEndpoint>;

  /**
   * Lists the streaming endpoints in the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StreamingEndpoints_List")
  list is ArmResourceListByParent<StreamingEndpoint>;

  /**
   * Starts an existing streaming endpoint.
   */
  start is ArmResourceActionAsync<StreamingEndpoint, void, void>;

  /**
   * Stops an existing streaming endpoint.
   */
  stop is ArmResourceActionAsync<StreamingEndpoint, void, void>;

  /**
   * Scales an existing streaming endpoint.
   */
  scale is ArmResourceActionAsync<
    StreamingEndpoint,
    StreamingEntityScaleUnit,
    void
  >;

  /**
   * List streaming endpoint supported skus.
   */
  // FIXME: StreamingEndpoints_Skus could not be converted to a resource operation
  @summary("List StreamingEndpoint skus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaservices/{accountName}/streamingEndpoints/{streamingEndpointName}/skus")
  @get
  skus is Azure.Core.Foundations.Operation<
    {
      /**
       * The unique identifier for a Microsoft Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group within the Azure subscription.
       */
      @path
      resourceGroupName: string;

      /**
       * The Media Services account name.
       */
      @path
      accountName: string;

      /**
       * The name of the streaming endpoint, maximum length is 24.
       */
      @maxLength(24)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
      @path
      streamingEndpointName: string;
    },
    StreamingEndpointSkuInfoListResult
  >;
}

@@projectedName(StreamingEndpoints.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(StreamingEndpoints.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StreamingEndpoints.create::parameters.resource,
  "Streaming endpoint properties needed for creation."
);
@@projectedName(StreamingEndpoints.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(StreamingEndpoints.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(StreamingEndpoints.update::parameters.properties,
  "Streaming endpoint properties needed for creation."
);
@@projectedName(StreamingEndpoints.scale::parameters.body,
  "json",
  "parameters"
);
@@extension(StreamingEndpoints.scale::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(StreamingEndpoints.scale::parameters.body,
  "Streaming endpoint scale parameters"
);
