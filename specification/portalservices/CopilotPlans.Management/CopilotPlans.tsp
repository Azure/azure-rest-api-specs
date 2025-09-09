import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.PortalServices;

@doc("A copilot plan that manages AI agent usage, spending limits, and access controls for users within an organization. Plans enable usage tracking, cost management, and agent governance for Azure AI-powered assistance services.")
model CopilotPlanResource is TrackedResource<CopilotPlanProperties> {
  @doc("The name of the copilot plan.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,63}$")
  @key("copilotPlanName")
  @segment("copilotPlans")
  @path
  name: string;
}

@armResourceOperations
interface CopilotPlans {
  get is ArmResourceRead<CopilotPlanResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<CopilotPlanResource>;
  update is ArmCustomPatchSync<CopilotPlanResource, CopilotPlanUpdate>;
  delete is ArmResourceDeleteSync<CopilotPlanResource>;
  listByResourceGroup is ArmResourceListByParent<CopilotPlanResource>;
  listBySubscription is ArmListBySubscription<CopilotPlanResource>;
}
