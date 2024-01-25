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
 * A Streaming Policy resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MediaService)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(StreamingPolicyProperties)
model StreamingPolicy extends ProxyResourceBase {
  /**
   * The Streaming Policy name.
   */
  @path
  @key("streamingPolicyName")
  @segment("streamingPolicies")
  @visibility("read")
  name: string;

  /**
   * Class to specify properties of Streaming Policy
   */
  @extension("x-ms-client-flatten", true)
  properties?: StreamingPolicyProperties;
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
  create is ArmResourceCreateOrReplaceSync<StreamingPolicy>;

  /**
   * Deletes a Streaming Policy in the Media Services account
   */
  delete is ArmResourceDeleteSync<StreamingPolicy>;

  /**
   * Lists the Streaming Policies in the account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StreamingPolicies_List")
  list is ArmResourceListByParent<
    StreamingPolicy,
    {
      ...BaseParameters<StreamingPolicy>;

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
