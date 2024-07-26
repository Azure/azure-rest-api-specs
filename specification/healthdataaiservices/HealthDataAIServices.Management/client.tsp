import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;

@@clientName(PrivateLinkResource,
    "HealthDataAIServicePrivateLinkResourceData",
    "csharp"
);
