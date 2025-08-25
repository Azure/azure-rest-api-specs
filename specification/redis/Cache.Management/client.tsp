import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Cache;

@@clientName(Microsoft.Cache, "RedisManagementClient", "python");
@@clientName(Microsoft.Cache, "RedisManagementClient", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "One0", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "One1", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "One2", "javascript");

// Go SDK specific customizations to resolve breaking changes
// Fix TLS version naming (Pattern: Naming Changes with Numbers)
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "One0", "go");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "One1", "go");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "One2", "go");
@@clientName(Microsoft.Cache.RedisResource, "ResourceInfo", "go");

// Python SDK specific customizations to resolve breaking changes
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "ONE0", "python");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "ONE1", "python");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "ONE2", "python");

// Java SDK specific customizations to resolve breaking changes
@@clientName(RedisCommonPropertiesRedisConfiguration,
  "RedisConfiguration",
  "java"
);
@@clientName(RedisCreateProperties.staticIP, "staticIp", "java");
@@clientName(RedisProperties.hostName, "hostname", "java");
@@clientName(ImportRDBParameters, "ImportRdbParameters", "java");
@@clientName(ExportRDBParameters, "ExportRdbParameters", "java");
@@clientName(RedisFirewallRuleProperties.startIP, "startIp", "java");
@@clientName(RedisFirewallRuleProperties.endIP, "endIp", "java");
@@clientName(RedisLinkedServerCreateProperties.primaryHostName,
  "primaryHostname",
  "java"
);
@@clientName(RedisLinkedServerCreateProperties.geoReplicatedPrimaryHostName,
  "geoReplicatedPrimaryHostname",
  "java"
);
@@flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "java"
);
// Fix Java SDK handwritten code
@@usage(RedisResource, Usage.input | Usage.output, "java");
@@usage(RedisFirewallRuleCreateParameters, Usage.input, "java");
