import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthDataAIServices;

@@clientName(PrivateLinkResource,
    "HealthDataAIServicePrivateLinkResourceData",
    "csharp"
);
