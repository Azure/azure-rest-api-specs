import "../common/custom-types.tsp";
import "../common/service.tsp";
import "../sdk-common/error.default.tsp";
import "../connections/routes.tsp";
import "../datasets/routes.tsp";
import "../indexes/routes.tsp";
import "../deployments/routes.tsp";
import "../red-teams/routes.tsp";
import "../evaluation-rules/routes.tsp";
import "../evaluation-taxonomies/routes.tsp";
import "../evaluators/routes.tsp";
import "../insights/routes.tsp";
import "../schedules/routes.tsp";
import "../memory-stores/routes.tsp";
import "../toolboxes/routes.tsp";

using Azure.ClientGenerator.Core;
namespace Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "Client");

// For Go, keep feature opt-in headers as strings so request and fake-server header handling agree.
@@alternateType(FoundryFeaturesOptInKeys, string);

// For Go, keep the memory inputs light instead of expanding the full OpenAI input-item model graph.
@@alternateType(OpenAI.InputItem, Record<unknown>);

@@usage(MemoryStoreUpdateCompletedResult, Usage.output);
@@access(MemoryStoreUpdateCompletedResult, Access.public);
@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);
@@access(MemoryStoreSearchResponse, Access.public);

@@clientName(MemoryStoreSearchResponse, "MemoryStoreSearchResult");
@@clientName(MemoryStoreUpdateResponse, "MemoryStoreUpdateResult");
@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult");
@@clientName(MemoryStoreDeleteScopeResponse, "MemoryStoreDeleteScopeResult");
@@clientName(MemorySearchOptions, "MemorySearchResultOptions");
@@clientDoc(
  MemoryStoreUpdateRequest.items,
  "A list of messages to store in memory. Each item is represented as a map with keys such as `type`, `role`, and `content`, similar to OpenAI response input items. Only message items are currently processed; other item types are ignored.",
  DocumentationMode.replace,
  "go"
);
@@clientDoc(
  MemoryStoreSearchRequest.items,
  "A list of messages used to search for relevant memories. Each item is represented as a map with keys such as `type`, `role`, and `content`, similar to OpenAI response input items. Only message items are currently processed; other item types are ignored.",
  DocumentationMode.replace,
  "go"
);

// --------------------------------------------------------------------------------
// Model and property names
// --------------------------------------------------------------------------------

// More accurate naming.
@@clientName(AssetCredentialResponse, "DatasetCredential");
@@clientName(SasCredential, "BlobReferenceSasCredential");

// These OpenAI/toolbox properties use @oneOf or unnamed union shapes that typespec-go
// cannot adapt yet. Keep the service wire shapes intact and expose broad Go types.
@@alternateType(OpenAI.Filters, Record<unknown>);
@@alternateType(OpenAI.MCPTool.allowed_tools, unknown);
@@alternateType(OpenAI.MCPTool.require_approval, string);
@@alternateType(OpenAI.NamespaceToolParam.tools, Record<unknown>[]);
@@alternateType(FabricIQPreviewTool.require_approval, string);

// Make these two internal, since SDKs hand-write a single public method with a boolean includeCredentials input parameter.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// EvaluatorVersion datetime fields are typed as strings in the service model but carry ISO 8601 timestamps.
@@alternateType(EvaluatorVersion.created_at, utcDateTime);
@@alternateType(EvaluatorVersion.modified_at, utcDateTime);

// Schedule trigger datetime fields are typed as strings in the service model but carry ISO 8601 timestamps.
@@alternateType(RecurrenceTrigger.startTime, utcDateTime);
@@alternateType(RecurrenceTrigger.endTime, utcDateTime);
@@alternateType(OneTimeTrigger.triggerAt, utcDateTime);
@@alternateType(CronTrigger.startTime, utcDateTime);
@@alternateType(CronTrigger.endTime, utcDateTime);
@@alternateType(ScheduleRun.triggerTime, utcDateTime);

// --------------------------------------------------------------------------------
// Schedules models
// --------------------------------------------------------------------------------
@@clientName(SchedulesCreateOrUpdateParams.resource, "Schedule");
@@clientName(Schedule.id, "ScheduleID");
