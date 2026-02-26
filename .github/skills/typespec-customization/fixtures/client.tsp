import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(MyService.ComputeResourceProvisioningState, "ProvisioningState");
@@access(MyService.internalOp, Access.internal);
