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

  @doc("Scenario type that is relevant to the user question")
  scenarioType: ScenarioType;

  @doc("Start window for assistant to run analysis on. Formatted as an ISO 8601 UTC timestamp, e.g. YYYY-MM-DDTHH:mm:ss.sssZ")
  windowStartTimestamp?: utcDateTime;

  @doc("End window for assistant to run analysis on. Formatted as an ISO 8601 UTC timestamp, e.g. YYYY-MM-DDTHH:mm:ss.sssZ")
  windowEndTimestamp?: utcDateTime;

  @doc("Sub-resource ARM Ids to help the assistant in it's analysis (e.g. analyzing virtual machine performance issues by looking at its disks). Formatted as an arm-id. e.g. /subscriptions/{guid}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{storageAccountName}")
  subResourceIds?: armResourceIdentifier[];

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

  @doc("Information about the resource associated with the response")
  resourceContext?: ResourceContext;

  @doc("Recommended actions the user can take in the Azure Portal")
  recommendedActions?: string[];
}

@doc("Resource info context")
model ResourceContext {
  @doc("Azure resource Id. Formatted as an arm-id. e.g. /subscriptions/{guid}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{storageAccountName}")
  resourceId: armResourceIdentifier;
}

@doc("Supported scenario types")
union ScenarioType {
  /**
   * The disk performance analysis scenario
   */
  DiskPerformance: "DiskPerformance",

  /**
   * The storage failover analysis scenario
   */
  StorageFailover: "StorageFailover",

  string,
}
