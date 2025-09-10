import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Bing;

@@clientName(CustomSearchConfigurations.createOrUpdate::parameters.resource,
  "customSearchConfiguration"
);

// Additional @@clientName decorators for operations with @operationId
@@clientName(BingAccounts.get, "Get");
@@clientName(BingAccounts.create, "Create");
@@clientName(BingAccounts.update, "Update");
@@clientName(BingAccounts.delete, "Delete");
@@clientName(BingAccounts.listByResourceGroup, "ListByResourceGroup");
@@clientName(BingAccounts.list, "List");
@@clientName(BingAccounts.listKeys, "ListKeys");
@@clientName(BingAccounts.regenerateKey, "RegenerateKey");
@@clientName(BingAccounts.listSkus, "ListSkus");
@@clientName(BingAccounts.listUsages, "ListUsages");

@@clientName(CustomSearchConfigurations.get, "Get");
@@clientName(CustomSearchConfigurations.delete, "Delete");

@@clientName(SkusOperationGroup.list, "List");

@@clientName(BingAccounts.create::parameters.resource, "account");
@@clientName(BingAccounts.update::parameters.properties, "account");
@@clientName(BingAccounts.regenerateKey::parameters.body, "parameters");

@@clientName(checkSkuAvailability::parameters.body, "parameters");

@@clientName(CheckSkuAvailabilityParameter,
  "CheckSkuAvailabilityContent",
  "csharp"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// BingAccounts interface operations
@@clientLocation(BingAccounts.get, "Accounts");
@@clientLocation(BingAccounts.create, "Accounts");
@@clientLocation(BingAccounts.update, "Accounts");
@@clientLocation(BingAccounts.delete, "Accounts");
@@clientLocation(BingAccounts.listByResourceGroup, "Accounts");
@@clientLocation(BingAccounts.list, "Accounts");
@@clientLocation(BingAccounts.listKeys, "Accounts");
@@clientLocation(BingAccounts.regenerateKey, "Accounts");
@@clientLocation(BingAccounts.listSkus, "Accounts");
@@clientLocation(BingAccounts.listUsages, "Accounts");

// CustomSearchConfigurations interface operations
@@clientLocation(CustomSearchConfigurations.get, "CustomSearchConfiguration");
@@clientLocation(CustomSearchConfigurations.delete,
  "CustomSearchConfiguration"
);

// SkusOperationGroup interface operations
@@clientLocation(SkusOperationGroup.list, "Skus");
