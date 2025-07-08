import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Qumulo.Storage, "QumuloMgmt", "python");
@@clientName(LiftrBase.Storage.FileSystemResource,
  "QumuloFileSystemResource",
  "csharp"
);
@@clientName(LiftrBase.UserDetails, "QumuloUserDetails", "csharp");
@@flattenProperty(LiftrBase.Storage.FileSystemResource.properties, "csharp");

@@clientName(LiftrBase.MarketplaceSubscriptionStatus, 
  "QumuloMarketplaceSubscriptionStatus",
  "csharp"
);

@@clientName(LiftrBase.MarketplaceDetails, "QumuloMarketplaceDetails", "csharp");

