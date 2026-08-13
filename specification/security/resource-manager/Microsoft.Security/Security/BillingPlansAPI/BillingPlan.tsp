import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace BillingPlansAPI;

/** A Microsoft Defender for Cloud billing plan. */
model BillingPlan is TrackedResource<BillingPlanProperties> {
  ...ResourceNameParameter<
    Resource = BillingPlan,
    KeyName = "billingPlanName",
    SegmentName = "billingPlans",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface BillingPlans {
  /** Gets a billing plan. */
  get is ArmResourceRead<BillingPlan>;

  /** Creates or replaces a billing plan. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BillingPlan>;

  /** Updates a billing plan. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<BillingPlan, BillingPlanUpdate>;

  /** Deletes a billing plan. */
  delete is ArmResourceDeleteWithoutOkAsync<BillingPlan>;

  /** Lists billing plans in a resource group. */
  listByResourceGroup is ArmResourceListByParent<BillingPlan>;

  /** Lists billing plans in a subscription. */
  listBySubscription is ArmListBySubscription<BillingPlan>;
}
