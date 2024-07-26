import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
namespace Microsoft.HealthDataAIServices;

@@clientName(CommonTypes.PrivateLinkResource,
    "HealthDataAIServicePrivateLinkResourceData",
    "csharp"
);
