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
 * A Content Key Policy resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MediaService)
@Azure.ResourceManager.Private.armResourceInternal(ContentKeyPolicyProperties)
@includeInapplicableMetadataInPayload(false)
model ContentKeyPolicy extends ProxyResourceBase {
  /**
   * The Content Key Policy name.
   */
  @path
  @key("contentKeyPolicyName")
  @segment("contentKeyPolicies")
  name: string;

  /**
   * The properties of the Content Key Policy.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ContentKeyPolicyProperties;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ContentKeyPolicy, ContentKeyPolicy>;

  /**
   * Deletes a Content Key Policy in the Media Services account
   */
  delete is ArmResourceDeleteSync<ContentKeyPolicy>;

  /**
   * Lists the Content Key Policies in the account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContentKeyPolicies_List")
  list is ArmResourceListByParent<
    ContentKeyPolicy,
    {
      ...BaseParameters<ContentKeyPolicy>;

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

  /**
   * Get a Content Key Policy including secret values
   */
  getPolicyPropertiesWithSecrets is ArmResourceActionSync<
    ContentKeyPolicy,
    void,
    ContentKeyPolicyProperties
  >;
}

@@projectedName(ContentKeyPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ContentKeyPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ContentKeyPolicies.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@projectedName(ContentKeyPolicies.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ContentKeyPolicies.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ContentKeyPolicies.update::parameters.properties,
  "The request parameters"
);
