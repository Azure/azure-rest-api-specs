import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Qumulo.Storage, "QumuloMgmt", "python");
@@clientName(LiftrBase.Storage.FileSystemResource,
  "QumuloFileSystemResource",
  "csharp"
);
@@clientName(LiftrBase.Storage.FileSystemResourceProperties,
  "QumuloFileSystemResourceProperties",
  "csharp"
);
@@clientName(LiftrBase.UserDetails, "QumuloUserDetails", "csharp");
@@clientName(LiftrBase.ProvisioningState, "QumuloProvisioningState", "csharp");
