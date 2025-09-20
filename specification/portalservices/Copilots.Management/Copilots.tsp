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

@doc("A copilot that manages AI agent usage, spending limits, and access controls for users within an organization. Copilots enable usage tracking, cost management, and agent governance for Azure AI-powered assistance services.")
model CopilotResource is TrackedResource<CopilotProperties> {
  @doc("The name of the copilot.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,63}$")
  @key("copilotName")
  @segment("copilots")
  @path
  name: string;
}

@armResourceOperations
interface Copilots {
  get is ArmResourceRead<CopilotResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<CopilotResource>;
  update is ArmCustomPatchSync<CopilotResource, CopilotUpdate>;
  delete is ArmResourceDeleteSync<CopilotResource>;
  listByResourceGroup is ArmResourceListByParent<CopilotResource>;
  listBySubscription is ArmListBySubscription<CopilotResource>;
}
