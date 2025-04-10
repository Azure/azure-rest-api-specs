import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataLakeStore;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataLakeStoreAccountBasic.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateDataLakeStoreAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateFirewallRuleWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateVirtualNetworkRuleWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateTrustedIdProviderWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateDataLakeStoreAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateFirewallRuleWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateVirtualNetworkRuleWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateTrustedIdProviderWithAccountParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateOrUpdateFirewallRuleParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateFirewallRuleParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateOrUpdateVirtualNetworkRuleParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateVirtualNetworkRuleParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreateOrUpdateTrustedIdProviderParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateTrustedIdProviderParameters.properties);

@@clientName(DataLakeStoreAccounts.create::parameters.resource, "parameters");
@@clientName(DataLakeStoreAccounts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataLakeStoreAccount.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
@@clientName(FirewallRules.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallRule.properties);

@@clientName(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkRules.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetworkRule.properties);

@@clientName(TrustedIdProviders.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(TrustedIdProviders.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TrustedIdProvider.properties);
