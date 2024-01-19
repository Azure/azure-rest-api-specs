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
@doc("The streaming endpoint.")
@parentResource(MediaService)
model StreamingEndpoint is TrackedResource<StreamingEndpointProperties> {
  @doc("The name of the streaming endpoint, maximum length is 24.")
  @maxLength(24)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @path
  @key("streamingEndpointName")
  @segment("streamingEndpoints")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface StreamingEndpoints {
  @doc("Gets a streaming endpoint.")
  get is ArmResourceRead<StreamingEndpoint>;

  @doc("Creates a streaming endpoint.")
  create is ArmResourceCreateOrUpdateAsync<
    StreamingEndpoint,
    {
      ...BaseParameters<StreamingEndpoint>;

      @doc("The flag indicates if the resource should be automatically started on creation.")
      @query("autoStart")
      autoStart?: boolean;
    }
  >;

  @doc("Updates a existing streaming endpoint.")
  update is ArmCustomPatchAsync<StreamingEndpoint, StreamingEndpoint>;

  @doc("Deletes a streaming endpoint.")
  delete is ArmResourceDeleteAsync<StreamingEndpoint>;

  @doc("Lists the streaming endpoints in the account.")
  list is ArmResourceListByParent<StreamingEndpoint>;

  @doc("Starts an existing streaming endpoint.")
  start is ArmResourceActionAsync<StreamingEndpoint, void, void>;

  @doc("Stops an existing streaming endpoint.")
  stop is ArmResourceActionAsync<StreamingEndpoint, void, void>;

  @doc("Scales an existing streaming endpoint.")
  scale is ArmResourceActionAsync<
    StreamingEndpoint,
    StreamingEntityScaleUnit,
    void
  >;

  @summary("List StreamingEndpoint skus")
  @doc("List streaming endpoint supported skus.")
  // FIXME: StreamingEndpoints_Skus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Media/mediaservices/{accountName}/streamingEndpoints/{streamingEndpointName}/skus")
  @get
  skus is Azure.Core.Foundations.Operation<
    {
      @doc("The unique identifier for a Microsoft Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the Azure subscription.")
      @path
      resourceGroupName: string;

      @doc("The Media Services account name.")
      @path
      accountName: string;

      @doc("The name of the streaming endpoint, maximum length is 24.")
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
