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
 * A Policy set
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model PolicySet {
  /** Name of the policy set */
  @visibility(Lifecycle.Read)
  @path
  @key // This will use 'name' as the path parameter for the policy set
  name: string;
}

@armResourceOperations
interface PolicySetOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicySet,
        KeyName = "name",
        SegmentName = "policysets",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PolicySets {
  /**
   * Evaluates lab policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @post
  @operationId("PolicySets_EvaluatePolicies")
  evaluatePolicies is PolicySetOps.ActionSync<
    PolicySet,
    EvaluatePoliciesRequest,
    ArmResponse<EvaluatePoliciesResponse>
  >;
}

@@doc(PolicySet.name, "The name of the policy set.");
@@doc(PolicySets.evaluatePolicies::parameters.body,
  "Request body for evaluating a policy set."
);
