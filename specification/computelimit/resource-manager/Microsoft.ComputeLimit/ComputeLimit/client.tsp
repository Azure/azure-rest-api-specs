import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ComputeLimit;

@@clientName(Microsoft.ComputeLimit, "ComputeLimitMgmtClient", "python");

@@clientName(GuestSubscription, "ComputeLimitGuestSubscription", "csharp");
@@clientName(SharedLimit, "ComputeLimitSharedLimit", "csharp");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "ComputeLimitResourceProvisioningState",
  "csharp"
);
@@clientName(LimitName, "ComputeLimitLimitName", "csharp");
@@clientName(SharedLimitProperties,
  "ComputeLimitSharedLimitProperties",
  "csharp"
);
