import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using OperationsClient;

@@clientLocation(OperationStatusOperationGroup.list, "OperationStatus");
