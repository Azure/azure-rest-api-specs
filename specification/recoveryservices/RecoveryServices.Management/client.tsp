import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.RecoveryServices;

@@clientLocation(getOperationStatus, Operations, "go");
@@clientLocation(getOperationResult, Operations, "go");
@@clientName(getOperationStatus, "OperationStatusGet", "go");
