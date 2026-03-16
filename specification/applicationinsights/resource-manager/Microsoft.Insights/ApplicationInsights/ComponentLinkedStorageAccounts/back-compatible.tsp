import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComponentLinkedStorageAccountApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ComponentLinkedStorageAccountsPatch.properties);

@@clientLocation(ComponentLinkedStorageAccountsOperationGroup.get,
  "ComponentLinkedStorageAccounts"
);
@@clientLocation(ComponentLinkedStorageAccountsOperationGroup.createAndUpdate,
  "ComponentLinkedStorageAccounts"
);
@@clientName(ComponentLinkedStorageAccountsOperationGroup.createAndUpdate::parameters.resource,
  "LinkedStorageAccountsProperties"
);
@@clientLocation(ComponentLinkedStorageAccountsOperationGroup.update,
  "ComponentLinkedStorageAccounts"
);
@@clientName(ComponentLinkedStorageAccountsOperationGroup.update::parameters.properties,
  "LinkedStorageAccountsProperties"
);
@@clientLocation(ComponentLinkedStorageAccountsOperationGroup.delete,
  "ComponentLinkedStorageAccounts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ComponentLinkedStorageAccounts.properties);
