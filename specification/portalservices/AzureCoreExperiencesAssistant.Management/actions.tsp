import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.PortalServices;

@armResourceOperations
interface Operations extends Azure.ResourceManager.Operations {}

@singleton
model Assistant
  is ExtensionResource<{
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
  }> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "There is no defined pattern. The only value can be 'assistant'."
  @doc("The name of the assistant")
  @key("name")
  @path
  @segment("assistant")
  name: "assistant";
}

@armResourceOperations
interface AzureCoreExperiencesAssistant {
  @doc("Send chat data to the assistant")
  sendChat is ArmResourceActionSync<
    Assistant,
    AssistantRequest,
    AssistantResponse
  >;
}
