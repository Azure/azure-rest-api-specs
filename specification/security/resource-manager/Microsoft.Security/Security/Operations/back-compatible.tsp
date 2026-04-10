import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using OperationsAPI;

@@clientLocation(OperationResultsOperationGroup.get, "OperationResults");

@@clientLocation(OperationStatusesOperationGroup.get, "OperationStatuses");

