import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A Policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Private.armResourceInternal(PolicyProperties)
@includeInapplicableMetadataInPayload(false)
model Policy extends Resource {
  /**
   * The name of the policy.
   */
  @path
  @key("name")
  @segment("policies")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: PolicyProperties;
}

@armResourceOperations
interface Policies {
  /**
   * Get policy.
   */
  get is ArmResourceRead<
    Policy,
    {
      ...BaseParameters<Policy>;

      /**
       * Specify the $expand query. Example: 'properties($select=description)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Policy>;

  /**
   * Allows modifying tags of policies. All other properties will be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Policy, PolicyFragment>;

  /**
   * Delete policy.
   */
  delete is ArmResourceDeleteSync<Policy>;

  /**
   * List policies in a given policy set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Policies_List")
  list is ArmResourceListByParent<
    Policy,
    {
      ...BaseParameters<Policy>;

      /**
       * Specify the $expand query. Example: 'properties($select=description)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(Policies.createOrUpdate::parameters.resource, "json", "policy");
@@extension(Policies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "policy"
);
@@doc(Policies.createOrUpdate::parameters.resource, "A Policy.");
@@projectedName(Policies.update::parameters.properties, "json", "policy");
@@extension(Policies.update::parameters.properties,
  "x-ms-client-name",
  "policy"
);
@@doc(Policies.update::parameters.properties, "A Policy.");
