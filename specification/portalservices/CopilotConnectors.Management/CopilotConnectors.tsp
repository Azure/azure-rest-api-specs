import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Rest;
using Http;
using Azure.ResourceManager;

namespace Microsoft.PortalServices;

@doc("The copilot connector tracked resource definition.")
model CopilotConnectorResource is TrackedResource<CopilotConnectorProperties> {
  @doc("The name of the copilot connector.")
  @maxLength(64)
  @minLength(1)
  @pattern("^(?!con$|prn$|aux$|nul$|com[1-9]$)(?!.*[._-]{2,})[a-zA-Z0-9]([a-zA-Z0-9-._]*[a-zA-Z0-9])?$")
  @key("name")
  @segment("copilotConnectors")
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations(CopilotConnectorResource)
interface CopilotConnectors {
  get is ArmResourceRead<CopilotConnectorResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<CopilotConnectorResource>;
  update is ArmCustomPatchSync<
    CopilotConnectorResource,
    PatchableCopilotConnectorProperties
  >;
  delete is ArmResourceDeleteSync<CopilotConnectorResource>;
  listByResourceGroup is ArmResourceListByParent<CopilotConnectorResource>;
  listBySubscription is ArmListBySubscription<CopilotConnectorResource>;
}
