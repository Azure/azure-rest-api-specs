import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Datadog;

// Client decorators for operations (migrated from @operationId)

// DatadogMonitorResources operations
@@clientLocation(DatadogMonitorResources.get, "Monitors", "!csharp");
@@clientName(DatadogMonitorResources.get, "Get");

@@clientLocation(DatadogMonitorResources.create, "Monitors");
@@clientName(DatadogMonitorResources.create, "Create");

@@clientLocation(DatadogMonitorResources.update, "Monitors");
@@clientName(DatadogMonitorResources.update, "Update");

@@clientLocation(DatadogMonitorResources.delete, "Monitors");
@@clientName(DatadogMonitorResources.delete, "Delete");

@@clientLocation(DatadogMonitorResources.listByResourceGroup, "Monitors");
@@clientName(DatadogMonitorResources.listByResourceGroup,
  "ListByResourceGroup"
);

@@clientLocation(DatadogMonitorResources.list, "Monitors", "!csharp");
@@clientName(DatadogMonitorResources.list, "List", "!csharp");
@@clientLocation(DatadogMonitorResources.manageSreAgentConnectors, "Monitors");
@@clientName(DatadogMonitorResources.manageSreAgentConnectors::parameters.body,
  "request"
);
@@clientLocation(DatadogMonitorResources.getDefaultApplicationKey, "Monitors");
@@clientName(DatadogMonitorResources.getDefaultApplicationKey,
  "GetDefaultApplicationKey"
);

@@clientLocation(DatadogMonitorResources.listApiKeys, "Monitors");
@@clientName(DatadogMonitorResources.listApiKeys, "ListApiKeys");

@@clientLocation(DatadogMonitorResources.getDefaultKey, "Monitors");
@@clientName(DatadogMonitorResources.getDefaultKey, "GetDefaultKey");

@@clientLocation(DatadogMonitorResources.setDefaultKey, "Monitors");
@@clientName(DatadogMonitorResources.setDefaultKey, "SetDefaultKey");

@@clientLocation(DatadogMonitorResources.listHosts, "Monitors");
@@clientName(DatadogMonitorResources.listHosts, "ListHosts");

@@clientLocation(DatadogMonitorResources.listLinkedResources, "Monitors");
@@clientName(DatadogMonitorResources.listLinkedResources,
  "ListLinkedResources"
);

@@clientLocation(DatadogMonitorResources.listMonitoredResources, "Monitors");
@@clientName(DatadogMonitorResources.listMonitoredResources,
  "ListMonitoredResources"
);

@@clientLocation(DatadogMonitorResources.refreshSetPasswordLink, "Monitors");
@@clientName(DatadogMonitorResources.refreshSetPasswordLink,
  "RefreshSetPasswordLink"
);

@@clientLocation(DatadogMonitorResources.billingInfoGet, "BillingInfo");
@@clientName(DatadogMonitorResources.billingInfoGet, "Get");
@@clientLocation(DatadogMonitorResources.resubscribe, "Organizations");

// DatadogSingleSignOnResources operations
@@clientLocation(DatadogSingleSignOnResources.get,
  "SingleSignOnConfigurations"
);
@@clientName(DatadogSingleSignOnResources.get, "Get");

@@clientLocation(DatadogSingleSignOnResources.create,
  "SingleSignOnConfigurations"
);
@@clientName(DatadogSingleSignOnResources.create, "CreateOrUpdate");

@@clientLocation(DatadogSingleSignOnResources.list,
  "SingleSignOnConfigurations"
);
@@clientName(DatadogSingleSignOnResources.list, "List");

// MarketplaceAgreementsOperationGroup operations
@@clientLocation(MarketplaceAgreementsOperationGroup.list,
  "MarketplaceAgreements"
);
@@clientName(MarketplaceAgreementsOperationGroup.list, "List");

@@clientLocation(MarketplaceAgreementsOperationGroup.createOrUpdate,
  "MarketplaceAgreements"
);
@@clientName(MarketplaceAgreementsOperationGroup.createOrUpdate,
  "CreateOrUpdate"
);

// CreationSupportedOperationGroup operations
@@clientLocation(CreationSupportedOperationGroup.list, "CreationSupported");
@@clientName(CreationSupportedOperationGroup.list, "List");

@@clientLocation(CreationSupportedOperationGroup.get, "CreationSupported");
@@clientName(CreationSupportedOperationGroup.get, "Get");

// Existing client decorators for parameters and models
@@clientName(DatadogMonitorResources.create::parameters.resource, "body");
@@clientName(DatadogMonitorResources.update::parameters.resource, "body");

@@clientName(TagRules.createOrUpdate::parameters.resource, "body");

@@clientName(DatadogSingleSignOnResources.create::parameters.resource, "body");

@@clientName(MonitoredSubscriptions.createorUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.resource, "body");
@@summary(Operations.list,
  "List all operations provided by Microsoft.Datadog for the 2025-06-11 api version."
);
@@doc(Operations.list,
  "List all operations provided by Microsoft.Datadog for the 2025-06-11 api version."
);
