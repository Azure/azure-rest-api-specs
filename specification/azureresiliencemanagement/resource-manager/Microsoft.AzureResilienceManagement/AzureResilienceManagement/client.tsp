import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureResilienceManagement;

// @@usage(ChildJobProperties, Usage.input | Usage.output, "go");
@@usage(JobProperties, Usage.input | Usage.output, "go");
@@usage(JobResourceProperties, Usage.input | Usage.output, "go");

@@clientName(DrillResource, "DrillTarget", "csharp");
@@clientName(DrillRunResource, "DrillRunTarget", "csharp");
@@clientName(RecoveryJobResource, "RecoveryJobTarget", "csharp");
@@clientName(ChaosJobResource, "ChaosJobTarget", "csharp");

// CSharp: AZC0030 — *Request -> *Content
@@clientName(DrillRunFailoverRequest, "DrillRunFailoverContent", "csharp");
@@clientName(DrillEndRequest, "DrillEndContent", "csharp");
@@clientName(FailoverRequest, "ResilienceManagementFailoverContent", "csharp");
@@clientName(
  AddOrUpdateResourcesRequest,
  "AddOrUpdateResourcesContent",
  "csharp"
);
@@clientName(DrillStartRequest, "DrillStartContent", "csharp");
@@clientName(DrillRunAddNotesRequest, "DrillRunAddNotesContent", "csharp");
@@clientName(RecommendCapacityRequest, "RecommendCapacityContent", "csharp");
@@clientName(RecoveryActionRequest, "RecoveryActionContent", "csharp");
@@clientName(
  TestFailoverCleanupRequest,
  "TestFailoverCleanupContent",
  "csharp"
);
@@clientName(ReprotectRequest, "ReprotectContent", "csharp");
@@clientName(
  ValidateForOperationRequest,
  "ValidateForOperationContent",
  "csharp"
);
@@clientName(UpdateGoalResourceRequest, "UpdateGoalResourceContent", "csharp");
@@clientName(MarkAsCompleteRequest, "MarkAsCompleteContent", "csharp");
@@clientName(
  UpdateRecoveryResourcesRequest,
  "UpdateRecoveryResourcesContent",
  "csharp"
);
@@clientName(
  ValidateForExecutionRequest,
  "ValidateForExecutionContent",
  "csharp"
);
@@clientName(
  DrillRunTestFailoverCleanupRequest,
  "DrillRunTestFailoverCleanupContent",
  "csharp"
);
@@clientName(
  DrillRunTestFailoverRequest,
  "DrillRunTestFailoverContent",
  "csharp"
);

// CSharp: AZC0030 — *Response -> *Result
@@clientName(
  RecoveryPlanActionBaseResponse,
  "RecoveryPlanActionBaseResult",
  "csharp"
);
@@clientName(
  ValidateForRecoveryOperationBaseResponse,
  "ValidateForRecoveryOperationBaseResult",
  "csharp"
);
@@clientName(
  UpdateRecoveryResourcesResponse,
  "UpdateRecoveryResourcesResult",
  "csharp"
);

// CSharp: AZC0032 — *Data is reserved (collides with auto-generated *Data POCOs)
@@clientName(GoalsData, "GoalsInfo", "csharp");
@@clientName(
  RecommendationsHighAvailabilityData,
  "RecommendationsHighAvailabilityInfo",
  "csharp"
);

// These three are reference/content models and must not use the *Resource suffix.
@@clientName(IncludeOrUpdateResource, "IncludeOrUpdateContent", "csharp");
@@clientName(MoboBrokerResource, "MoboBrokerTarget", "csharp");
@@clientName(ServiceLevelResource, "ServiceLevelTarget", "csharp");
