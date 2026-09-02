import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A Policy.
 */
model Policy is Azure.ResourceManager.ProxyResource<PolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = Policy,
    KeyName = "policyName",
    SegmentName = "policies",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface PolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** labs */
        @path @segment("labs") labName: string,

        /** policysets */
        @path @segment("policysets") policySetName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Policy,
        KeyName = "name",
        SegmentName = "policies",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Policies {
  /**
   * Get policy.
   */
  get is PolicyOps.Read<
    Policy,
    Parameters = {
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
  createOrUpdate is PolicyOps.CreateOrUpdateSync<Policy>;

  /**
   * Allows modifying tags of policies. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is PolicyOps.CustomPatchSync<Policy, PatchModel = PolicyFragment>;

  /**
   * Delete policy.
   */
  delete is PolicyOps.DeleteSync<Policy>;

  /**
   * List policies in a given policy set.
   */
  list is PolicyOps.List<
    Policy,
    Parameters = {
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
    },
    Response = ArmResponse<PolicyList>
  >;
}

@@doc(Policy.name, "The name of the policy.");
@@doc(Policy.properties, "The properties of the resource.");
@@doc(Policy.location, "The location of the resource.");
@@doc(Policy.tags, "The tags of the resource.");
@@doc(Policies.createOrUpdate::parameters.resource, "A Policy.");
@@doc(Policies.update::parameters.properties, "A Policy.");
