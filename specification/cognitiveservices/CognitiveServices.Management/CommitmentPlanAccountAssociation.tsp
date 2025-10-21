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
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface CommitmentPlanAccountAssociations {
  /**
   * Gets the association of the Cognitive Services commitment plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommitmentPlans_GetAssociation")
  getAssociation is ArmResourceRead<CommitmentPlanAccountAssociation>;

  /**
   * Create or update the association of the Cognitive Services commitment plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommitmentPlans_CreateOrUpdateAssociation")
  createOrUpdateAssociation is ArmResourceCreateOrReplaceAsync<CommitmentPlanAccountAssociation>;

  /**
   * Deletes the association of the Cognitive Services commitment plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("CommitmentPlans_DeleteAssociation")
  deleteAssociation is ArmResourceDeleteWithoutOkAsync<
    CommitmentPlanAccountAssociation,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the associations of the Cognitive Services commitment plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommitmentPlans_ListAssociations")
  listAssociations is ArmResourceListByParent<CommitmentPlanAccountAssociation>;
}

@@doc(CommitmentPlanAccountAssociation.name,
  "The name of the commitment plan association with the Cognitive Services Account"
);
@@encodedName(CommitmentPlanAccountAssociation.eTag,
  "application/json",
  "etag"
);
@@doc(CommitmentPlanAccountAssociation.properties,
  "Properties of Cognitive Services account commitment plan association."
);
@@doc(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "The commitmentPlan properties."
);
