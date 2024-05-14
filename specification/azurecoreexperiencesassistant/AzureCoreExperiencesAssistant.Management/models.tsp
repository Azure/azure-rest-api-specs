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

namespace Microsoft.AzureCoreExperiencesAssistant;

@doc("Request object to the assistant")
model AssistantRequest {
  @doc("User question to the assistant")
  userInput: string;

  @doc("Scenario ID that is relevant to the user question")
  scenarioId: ScenarioIds;

  @doc("Start date for assistant to run analysis on")
  analysisStartDate?: utcDateTime;

  @doc("End date for assistant to run analysis on")
  analysisEndDate?: utcDateTime;

  @doc("Sub-resource ARM Ids to help the assistant in it's analysis (e.g. analyzing virtual machine performance issues by looking at its disks)")
  subResourceIds?: string[];

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
}

@doc("Resource info context")
model ResourceContext {
  @doc("Azure resource Id")
  resourceId: string;
}

@doc("Supported scenario Ids")
union ScenarioIds {
  DiskPerformance: "DiskPerformance",
  StorageDataMigration: "StorageDataMigration",
  string,
}
