import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services account commitment plan.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy usage decorator required for 'CommitmentPlan' to maintain SDK backward compatibility"
model CommitmentPlan
  is Azure.ResourceManager.ProxyResource<CommitmentPlanProperties> {
  ...ResourceNameParameter<
    Resource = CommitmentPlan,
    KeyName = "commitmentPlanName",
    SegmentName = "commitmentPlans",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'etag' on the resource envelope for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The kind (type) of cognitive service account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'kind' on the resource envelope for backward compatibility"
  kind?: string;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'sku' on the resource envelope for backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface CommitmentPlanOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      {
        /** The name of the commitmentPlan associated with the Cognitive Services Account */
        @path
        @segment("commitmentPlans")
        @key
        commitmentPlanName: string,
      },
      ResourceName = "CommitmentPlan"
    > {}

@armResourceOperations
interface CommitmentPlans {
  /**
   * Gets the specified commitmentPlans associated with the Cognitive Services account.
   */
  get is CommitmentPlanOps.Read<CommitmentPlan>;

  /**
   * Update the state of specified commitmentPlans associated with the Cognitive Services account.
   */
  createOrUpdate is CommitmentPlanOps.CreateOrUpdateSync<CommitmentPlan>;

  /**
   * Deletes the specified commitmentPlan associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes for 'createOrUpdate' match existing service endpoint behavior"
  delete is CommitmentPlanOps.DeleteWithoutOkAsync<
    CommitmentPlan,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the commitmentPlans associated with the Cognitive Services account.
   */
  list is CommitmentPlanOps.List<
    CommitmentPlan,
    Response = CommitmentPlanListResult
  >;
}
@armResourceOperations
interface CommitmentPlanOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** The name of the commitmentPlan associated with the Cognitive Services Account */
        @path
        @segment("commitmentPlans")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        commitmentPlanName: string,
      },
      ResourceName = "CognitiveServicesCommitmentPlan"
    > {}

@armResourceOperations
interface CommitmentPlanOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** The name of the commitmentPlan associated with the Cognitive Services Account */
        @path
        @segment("commitmentPlans")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        commitmentPlanName: string,
      }
    > {}

@armResourceOperations(#{ omitTags: true })
interface CommitmentPlanOperationGroup {
  /**
   * Returns a Cognitive Services commitment plan specified by the parameters.
   */
  @tag("CognitiveServicesCommitmentPlans")
  getPlan is CommitmentPlanOperationGroupOps.Read<CommitmentPlan>;

  /**
   * Create Cognitive Services commitment plan.
   */
  @tag("CognitiveServicesCommitmentPlans")
  createOrUpdatePlan is CommitmentPlanOperationGroupOps.CreateOrUpdateAsync<CommitmentPlan>;

  /**
   * Create Cognitive Services commitment plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "PATCH for 'createOrUpdatePlan' follows existing service implementation pattern"
  @tag("CognitiveServicesCommitmentPlans")
  @patch(#{ implicitOptionality: false })
  updatePlan is CommitmentPlanOperationGroupOps.CustomPatchAsync<
    CommitmentPlan,
    PatchModel = PatchResourceTagsAndSku
  >;

  /**
   * Deletes a Cognitive Services commitment plan from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes for 'updatePlan' match existing service endpoint behavior"
  @tag("CognitiveServicesCommitmentPlans")
  deletePlan is CommitmentPlanOperationGroupOps.DeleteWithoutOkAsync<
    CommitmentPlan,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  @tag("CognitiveServicesCommitmentPlans")
  listPlansByResourceGroup is CommitmentPlanOperationGroupOps.List<
    CommitmentPlan,
    Response = CommitmentPlanListResult
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  @tag("CognitiveServicesCommitmentPlans")
  listPlansBySubscription is CommitmentPlanOperationOps.List<
    CommitmentPlan,
    Response = CommitmentPlanListResult
  >;
}

@@doc(CommitmentPlan.name,
  "The name of the commitmentPlan associated with the Cognitive Services Account"
);
@@encodedName(CommitmentPlan.etag, "application/json", "etag");
@@doc(CommitmentPlan.properties,
  "Properties of Cognitive Services account commitment plan."
);
@@doc(CommitmentPlans.createOrUpdate::parameters.resource,
  "The commitmentPlan properties."
);
@@doc(CommitmentPlanOperationGroup.createOrUpdatePlan::parameters.resource,
  "The parameters to provide for the created commitment plan."
);
@@doc(CommitmentPlanOperationGroup.updatePlan::parameters.properties,
  "The parameters to provide for the created commitment plan."
);
