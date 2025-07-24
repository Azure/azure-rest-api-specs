import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Cache, "RedisManagementClient", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "One0", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "One1", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "One2", "javascript");

// Go SDK specific customizations to resolve breaking changes
// Fix TLS version naming (Pattern: Naming Changes with Numbers)
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "One0", "go");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "One1", "go");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "One2", "go");
