import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Commvault.ContentStore;

@@clientName(ProtectionGroups.stopBackup::parameters.body, "request");
@@doc(
  ProtectionGroups.stopBackup::parameters.body,
  "The body type of the operation request."
);
