import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.DocumentDB;

@@clientName(Microsoft.DocumentDB, "MongoClusterMgmtClient", "python");
@@access(Operations.list, Access.internal, "csharp");
@@clientName(CheckNameAvailabilityResponse,
    "CheckNameAvailabilityResult",
    "csharp"
);
@@clientName(MongoClusterRestoreParameters,
    "MongoClusterRestoreContent",
    "csharp"
);
@@clientName(PrivateLinkResource,
    "MongoClusterPrviateLinkResourceData",
    "csharp"
);
