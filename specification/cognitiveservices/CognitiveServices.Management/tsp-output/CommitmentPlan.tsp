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
@doc("Cognitive Services account commitment plan.")
@parentResource(Account)
model CommitmentPlan is TrackedResource<CommitmentPlanProperties> {
  @doc("The name of the commitmentPlan associated with the Cognitive Services Account")
  @path
  @key("commitmentPlanName")
  @segment("commitmentPlans")
  name: string;

  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface CommitmentPlans {
  @doc("Gets the specified commitmentPlans associated with the Cognitive Services account.")
  get is ArmResourceRead<CommitmentPlan>;

  @doc("Update the state of specified commitmentPlans associated with the Cognitive Services account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<CommitmentPlan>;

  @doc("Deletes the specified commitmentPlan associated with the Cognitive Services account.")
  delete is ArmResourceDeleteAsync<CommitmentPlan>;

  @doc("Gets the commitmentPlans associated with the Cognitive Services account.")
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
