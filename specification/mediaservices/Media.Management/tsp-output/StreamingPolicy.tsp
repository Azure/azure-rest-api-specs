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
@doc("A Streaming Policy resource")
@parentResource(MediaService)
model StreamingPolicy is ProxyResource<StreamingPolicyProperties> {
  @doc("The Streaming Policy name.")
  @path
  @key("streamingPolicyName")
  @segment("streamingPolicies")
  name: string;
}

@armResourceOperations
interface StreamingPolicies {
  @doc("Get the details of a Streaming Policy in the Media Services account")
  get is ArmResourceRead<StreamingPolicy>;

  @doc("Create a Streaming Policy in the Media Services account")
  create is ArmResourceCreateOrReplaceSync<StreamingPolicy>;

  @doc("Deletes a Streaming Policy in the Media Services account")
  delete is ArmResourceDeleteSync<StreamingPolicy>;

  @doc("Lists the Streaming Policies in the account")
  list is ArmResourceListByParent<
    StreamingPolicy,
    {
      ...BaseParameters<StreamingPolicy>;

      @doc("Restricts the set of items returned.")
      @query("$filter")
      $filter?: string;

      @doc("Specifies a non-negative integer n that limits the number of items returned from a collection. The service returns the number of available items up to but not greater than the specified value n.")
      @query("$top")
      $top?: int32;

      @doc("Specifies the key by which the result collection should be ordered.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(StreamingPolicies.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(StreamingPolicies.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StreamingPolicies.create::parameters.resource, "The request parameters");
