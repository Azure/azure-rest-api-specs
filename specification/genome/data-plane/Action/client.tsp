import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Genome;

// Operation names
@@clientName(getActions, "getActions");
@@clientName(getActionById, "getActionById");
@@clientName(createActionExecution, "createActionExecution");
@@clientName(getActionExecutions, "getActionExecutions");
@@clientName(getActionExecutionById, "getActionExecutionById");
@@clientName(getAllActionExecutions, "getAllActionExecutions");

// Model renames for .NET SDK naming conventions (AZC0030, AZC0012, AZC0034)
@@clientName(ActionListResponse, "GenomeActionList", "csharp");
@@clientName(ActionResponse, "GenomeAction", "csharp");
@@clientName(ActionExecutionRequest, "ActionExecutionContent", "csharp");
@@clientName(ActionExecutionResponse, "ActionExecution", "csharp");
@@clientName(ActionExecutionListResponse, "ActionExecutionList", "csharp");
@@clientName(ActionExecutionSummaryResponse,
  "ActionExecutionSummary",
  "csharp"
);
@@clientName(PaginationResponse, "GenomePagination", "csharp");
@@clientName(ActionExecutionDetailResponse, "ActionExecutionDetail", "csharp");
@@clientName(ExecutionErrorResponse, "ExecutionError", "csharp");
@@clientName(ExecutionProgressResponse, "ExecutionProgress", "csharp");
@@clientName(ErrorResponse, "GenomeError", "csharp");
