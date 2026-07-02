import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.BillingTrust;
using Azure.ClientGenerator.Core;

@@clientName(ProvisioningState, "BillingTrustProvisioningState", "csharp");
