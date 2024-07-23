import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./actions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.PortalServices;

@doc("Request object to the assistant")
model AssistantRequest {
  @doc("User question to the assistant")
  userInput: string;

  @doc("Name of the scenario that can assist in determining the focus of the user's question.")
  scenarioName: string;

  @doc("Start window for assistant to run analysis on. Formatted as an ISO 8601 UTC timestamp, e.g. YYYY-MM-DDTHH:mm:ss.sssZ")
  windowStartTimestamp?: utcDateTime;

  @doc("End window for assistant to run analysis on. Formatted as an ISO 8601 UTC timestamp, e.g. YYYY-MM-DDTHH:mm:ss.sssZ")
  windowEndTimestamp?: utcDateTime;

  @doc("Fully qualified resource IDs of Azure resources that can help the assistant in it's analysis (e.g. analyzing virtual machine performance issues by looking at its disks). Formatted as a fully qualified Azure Resource ID. e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{storageAccountName}")
  azureResourceIds?: armResourceIdentifier[];

  @doc("The Azure Portal context from which the assistant was invoked")
  bladeContext?: PortalBladeContext;

  @doc("Past conversation history between the user and the assistant")
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["index", "userInput", "assistantResult"]
  )
  conversationHistory?: ConversationHistoryContext[];
}

@doc("Use to provide the previous conversation history as added context for this particular user request")
model ConversationHistoryContext {
  @doc("Ordered index of this conversation piece in the overall history")
  @minValue(0)
  index: int64;

  @doc("The user input")
  userInput: string;

  @doc("The assistant response")
  assistantResult: string;
}

@doc("The corresponding Azure Portal blade context from which the assistant was invoked")
model PortalBladeContext {
  @doc("Name of the Portal blade the assistant was invoked from")
  bladeName: string;
}

@doc("Response object from the assistant")
model AssistantResponse {
  @doc("The response message from the assistant")
  assistantResult?: string;

  @doc("Recommended actions the user can take in the Azure Portal")
  recommendedActions?: string[];
}
