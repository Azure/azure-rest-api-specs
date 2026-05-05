import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.ComputeBulkActions;

@@clientName(ExecuteTypeRequest.correlationid, "correlationId", "java");
@@clientName(ExecuteCreateRequest.correlationid, "correlationId", "java");
@@clientName(GetOperationStatusRequest.correlationid, "correlationId", "java");
@@clientName(CancelOperationsRequest.correlationid, "correlationId", "java");
@@clientName(Microsoft.ComputeBulkActions,
  "ComputeBulkActionsMgmtClient",
  "python"
);
