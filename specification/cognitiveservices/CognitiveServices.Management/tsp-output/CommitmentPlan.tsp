import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services account commitment plan.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Account)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CommitmentPlanProperties)
model CommitmentPlan extends TrackedResourceBase {
  /**
   * The name of the commitmentPlan associated with the Cognitive Services Account
   */
  @path
  @key("commitmentPlanName")
  @segment("commitmentPlans")
  @visibility("read")
  name: string;

  /**
   * Resource Etag.
   */
  @visibility("read")
  etag?: string;

  /**
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * Properties of Cognitive Services account commitment plan.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CommitmentPlanProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface CommitmentPlans {
  /**
   * Gets the specified commitmentPlans associated with the Cognitive Services account.
   */
  get is ArmResourceRead<CommitmentPlan>;

  /**
   * Update the state of specified commitmentPlans associated with the Cognitive Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<CommitmentPlan>;

  /**
   * Deletes the specified commitmentPlan associated with the Cognitive Services account.
   */
  delete is ArmResourceDeleteAsync<CommitmentPlan>;

  /**
   * Gets the commitmentPlans associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommitmentPlans_List")
  list is ArmResourceListByParent<CommitmentPlan>;
}

@@projectedName(CommitmentPlans.createOrUpdate::parameters.resource,
  "json",
  "commitmentPlan"
);
@@extension(CommitmentPlans.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "commitmentPlan"
);
@@doc(CommitmentPlans.createOrUpdate::parameters.resource,
  "The commitmentPlan properties."
);
