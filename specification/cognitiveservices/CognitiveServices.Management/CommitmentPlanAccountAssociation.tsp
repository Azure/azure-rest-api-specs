import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CommitmentPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * The commitment plan association.
 */
@parentResource(CommitmentPlan)
model CommitmentPlanAccountAssociation
  is Azure.ResourceManager.ProxyResource<CommitmentPlanAccountAssociationProperties> {
  ...ResourceNameParameter<
    Resource = CommitmentPlanAccountAssociation,
    KeyName = "commitmentPlanAssociationName",
    SegmentName = "accountAssociations",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface CommitmentPlanAccountAssociationsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the commitmentPlan associated with the Cognitive Services Account
         */
        @path
        @segment("commitmentPlans")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        commitmentPlanName: string,
      },
      {
        /**
         * The name of the commitment plan association with the Cognitive Services Account
         */
        @path
        @segment("accountAssociations")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        commitmentPlanAssociationName: string,
      }
    > {}

@armResourceOperations
interface CommitmentPlanAccountAssociations {
  /**
   * Gets the association of the Cognitive Services commitment plan.
   */
  getAssociation is CommitmentPlanAccountAssociationsOps.Read<CommitmentPlanAccountAssociation>;

  /**
   * Create or update the association of the Cognitive Services commitment plan.
   */
  createOrUpdateAssociation is CommitmentPlanAccountAssociationsOps.CreateOrUpdateAsync<CommitmentPlanAccountAssociation>;

  /**
   * Deletes the association of the Cognitive Services commitment plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteAssociation is CommitmentPlanAccountAssociationsOps.DeleteWithoutOkAsync<
    CommitmentPlanAccountAssociation,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the associations of the Cognitive Services commitment plan.
   */
  listAssociations is CommitmentPlanAccountAssociationsOps.List<
    CommitmentPlanAccountAssociation,
    Response = CommitmentPlanAccountAssociationListResult
  >;
}

@@doc(CommitmentPlanAccountAssociation.name,
  "The name of the commitment plan association with the Cognitive Services Account"
);
@@encodedName(CommitmentPlanAccountAssociation.etag,
  "application/json",
  "etag"
);
@@doc(CommitmentPlanAccountAssociation.properties,
  "Properties of Cognitive Services account commitment plan association."
);
@@doc(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "The commitmentPlan properties."
);
