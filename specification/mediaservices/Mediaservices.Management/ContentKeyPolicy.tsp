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
 * A Content Key Policy resource.
 */
model ContentKeyPolicy
  is Azure.ResourceManager.ProxyResource<ContentKeyPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ContentKeyPolicy,
    KeyName = "contentKeyPolicyName",
    SegmentName = "contentKeyPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContentKeyPolicies {
  /**
   * Get the details of a Content Key Policy in the Media Services account
   */
  get is ArmResourceRead<ContentKeyPolicy>;

  /**
   * Create or update a Content Key Policy in the Media Services account
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContentKeyPolicy>;

  /**
   * Updates an existing Content Key Policy in the Media Services account
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ContentKeyPolicy, PatchModel = ContentKeyPolicy>;

  /**
   * Deletes a Content Key Policy in the Media Services account
   */
  delete is ArmResourceDeleteSync<ContentKeyPolicy>;

  /**
   * Lists the Content Key Policies in the account
   */
  list is ArmResourceListByParent<
    ContentKeyPolicy,
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
    Response = ArmResponse<ContentKeyPolicyCollection>
  >;

  /**
   * Get a Content Key Policy including secret values
   */
  getPolicyPropertiesWithSecrets is ArmResourceActionSync<
    ContentKeyPolicy,
    void,
    ArmResponse<ContentKeyPolicyProperties>
  >;
}

@@doc(ContentKeyPolicy.name, "The Content Key Policy name.");
@@doc(ContentKeyPolicy.properties, "The properties of the Content Key Policy.");
@@doc(ContentKeyPolicies.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@doc(ContentKeyPolicies.update::parameters.properties,
  "The request parameters"
);
