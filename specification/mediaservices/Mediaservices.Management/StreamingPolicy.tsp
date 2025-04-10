import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Streaming Policy resource
 */
model StreamingPolicy
  is Azure.ResourceManager.ProxyResource<StreamingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = StreamingPolicy,
    KeyName = "streamingPolicyName",
    SegmentName = "streamingPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StreamingPolicies {
  /**
   * Get the details of a Streaming Policy in the Media Services account
   */
  get is ArmResourceRead<StreamingPolicy>;

  /**
   * Create a Streaming Policy in the Media Services account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    StreamingPolicy,
    Response = ArmResourceCreatedSyncResponse<StreamingPolicy>
  >;

  /**
   * Deletes a Streaming Policy in the Media Services account
   */
  delete is ArmResourceDeleteSync<StreamingPolicy>;

  /**
   * Lists the Streaming Policies in the account
   */
  list is ArmResourceListByParent<
    StreamingPolicy,
    Parameters = {
      /**
       * Restricts the set of items returned.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned from a collection. The service returns the number of available items up to but not greater than the specified value n.
       */
      @query("$top")
      $top?: int32;

      /**
       * Specifies the key by which the result collection should be ordered.
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<StreamingPolicyCollection>
  >;
}

@@doc(StreamingPolicy.name, "The Streaming Policy name.");
@@doc(StreamingPolicy.properties,
  "Class to specify properties of Streaming Policy"
);
@@doc(StreamingPolicies.create::parameters.resource, "The request parameters");
