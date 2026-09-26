import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.KubernetesConfiguration;

model OperationStatusList is Azure.Core.Page<OperationStatusResult>;

// Using OperationStatusResult from Azure.ResourceManager.CommonTypes v6
// which includes: id, name, status, percentComplete, startTime, endTime, operations, resourceId, error
// Aliases for convenience when referencing common types
alias Operation = Azure.ResourceManager.CommonTypes.Operation;
alias OperationListResult = Azure.ResourceManager.CommonTypes.OperationListResult;
alias OperationStatusResult = Azure.ResourceManager.CommonTypes.OperationStatusResult;
