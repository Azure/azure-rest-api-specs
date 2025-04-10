import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataLakeAnalytics;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataLakeAnalyticsAccountBasic.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateDataLakeAnalyticsAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AddDataLakeStoreWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AddStorageAccountWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateComputePolicyWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateFirewallRuleWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HiveMetastore.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetworkRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateDataLakeAnalyticsAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateDataLakeStoreWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateStorageAccountWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateComputePolicyWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateFirewallRuleWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AddDataLakeStoreParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AddStorageAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateStorageAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateOrUpdateComputePolicyParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateComputePolicyParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateOrUpdateFirewallRuleParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateFirewallRuleParameters.properties);

@@clientName(DataLakeAnalyticsAccounts.create::parameters.resource,
  "parameters"
);
@@clientName(DataLakeAnalyticsAccounts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataLakeAnalyticsAccount.properties);

@@clientName(DataLakeStoreAccountInformations.add::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataLakeStoreAccountInformation.properties);

@@clientName(StorageAccountInformations.add::parameters.resource, "parameters");
@@clientName(StorageAccountInformations.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountInformation.properties);

@@clientName(ComputePolicies.createOrUpdate::parameters.resource, "parameters");
@@clientName(ComputePolicies.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ComputePolicy.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
@@clientName(FirewallRules.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageContainer.properties);
