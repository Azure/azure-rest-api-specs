import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

@@clientLocation(OperationResultsOperationGroup.get, "OperationResults");

@@clientLocation(OperationStatusesOperationGroup.get, "OperationStatuses");
