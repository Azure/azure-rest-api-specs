import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";


using TypeSpec.Rest;
using TypeSpec.Http;


namespace NewRelic.Observability;



    enum Origin {
        "user", "system", "user,system"
    }

    enum ActionType {
        "Internal"
    }

    enum CreatedByType {
        "User", "Application", "ManagedIdentity", "Key"
    }

    enum ProvisioningState {
        @doc("Monitor resource creation request accepted")"Accepted", @doc("Monitor resource creation started")"Creating", @doc("Monitor resource is being updated")"Updating", @doc("Monitor resource deletion started")"Deleting", @doc("Monitor resource creation successful")"Succeeded", @doc("Monitor resource creation failed")"Failed", @doc("Monitor resource creation canceled")"Canceled", @doc("Monitor resource is deleted")"Deleted", @doc("Monitor resource state is unknown")"NotSpecified"
    }

    enum MonitoringStatus {
        @doc("monitoring is enabled")"Enabled", @doc("monitoring is disabled")"Disabled"
    }

    enum MarketplaceSubscriptionStatus {
        @doc("monitoring is enabled")"Active", @doc("monitoring is disabled")"Suspended"
    }

    enum SingleSignOnStates {
        "Initial", "Enable", "Disable", "Existing"
    }

    enum UsageType {
        @doc("Usage type is PAYG")"PAYG", @doc("Usage type is COMMITTED")"COMMITTED"
    }

    enum BillingCycle {
        @doc("Billing cycle is YEARLY")"YEARLY", @doc("Billing cycle is MONTHLY")"MONTHLY", @doc("Billing cycle is WEEKLY")"WEEKLY"
    }

    enum LiftrResourceCategories {
        "Unknown", "MonitorLogs"
    }

    enum OrgCreationSource {
        @doc("Org is created from LIFTR")"LIFTR", @doc("Org is created from NEWRELIC")"NEWRELIC"
    }

    enum AccountCreationSource {
        @doc("Account is created from LIFTR")"LIFTR", @doc("Account is created from NEWRELIC")"NEWRELIC"
    }

    enum ManagedServiceIdentityType {
        "None", "SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"
    }

    enum BillingSource {
        @doc("Billing source is Azure")"AZURE", "NEWRELIC"
    }

    enum SendMetricsStatus {
        "Enabled", "Disabled"
    }

    enum TagAction {
        "Include", "Exclude"
    }

    enum SendingMetricsStatus {
        "Enabled", "Disabled"
    }

    enum SendingLogsStatus {
        "Enabled", "Disabled"
    }

    enum SendAadLogsStatus {
        "Enabled", "Disabled"
    }

    enum SendSubscriptionLogsStatus {
        "Enabled", "Disabled"
    }

    enum SendActivityLogsStatus {
        "Enabled", "Disabled"
    }



@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation> {
}

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
@doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
@visibility("read")
"name"?: string;
@doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
@visibility("read")
"isDataAction"?: boolean;
@doc("Localized display information for this particular operation.")
"display"?: OperationDisplay;
@doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
@visibility("read")
"origin"?: Origin;
@doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
@visibility("read")
"actionType"?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
@doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
@visibility("read")
"provider"?: string;
@doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
@visibility("read")
"resource"?: string;
@doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
@visibility("read")
"operation"?: string;
@doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
@visibility("read")
"description"?: string;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
@doc("The error object.")
"error"?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
@doc("The error code.")
@visibility("read")
"code"?: string;
@doc("The error message.")
@visibility("read")
"message"?: string;
@doc("The error target.")
@visibility("read")
"target"?: string;
@doc("The error details.")
@visibility("read")
"details"?: ErrorDetail[];
@doc("The error additional info.")
@visibility("read")
"additionalInfo"?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
@doc("The additional info type.")
@visibility("read")
"type"?: string;
@doc("The additional info.")
@visibility("read")
"info"?: unknown;
}

@doc("Response of get all accounts Operation.")
model AccountsListResponse is Azure.Core.Page<AccountResource> {
}

@doc("The details of a account resource.")
model AccountResource {
...ProxyResource;
@doc("The resource-specific properties for this resource.")
"properties"?: AccountProperties;
}

@doc("List of all the New relic accounts for the given user")
model AccountProperties {
@doc("organization id")
"organizationId"?: string;
@doc("account id")
"accountId"?: string;
@doc("account name")
"accountName"?: string;
@doc("region")
"region"?: string;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
...Resource;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
@doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
@visibility("read")
"id"?: string;
@doc("The name of the resource")
@visibility("read")
"name"?: string;
@doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
@visibility("read")
"type"?: string;
@doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
@visibility("read")
"systemData"?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
@doc("The identity that created the resource.")
"createdBy"?: string;
@doc("The type of identity that created the resource.")
"createdByType"?: CreatedByType;
@doc("The timestamp of resource creation (UTC).")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdAt"?: utcDateTime;
@doc("The identity that last modified the resource.")
"lastModifiedBy"?: string;
@doc("The type of identity that last modified the resource.")
"lastModifiedByType"?: CreatedByType;
@doc("The timestamp of resource last modification (UTC)")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastModifiedAt"?: utcDateTime;
}

@doc("The response of a NewRelicMonitorResource list operation.")
model NewRelicMonitorResourceListResult is Azure.Core.Page<NewRelicMonitorResource> {
}

@doc("A Monitor Resource by NewRelic")
model NewRelicMonitorResource {
...TrackedResource;
@doc("The resource-specific properties for this resource.")
"properties": MonitorProperties;
@doc("The managed service identities assigned to this resource.")
"identity"?: ManagedServiceIdentity;
}

@doc("Properties specific to the NewRelic Monitor resource")
model MonitorProperties {
@doc("Provisioning State of the resource")
@visibility("read")
"provisioningState"?: ProvisioningState;
@doc("MonitoringStatus of the resource")
@visibility("read")
"monitoringStatus"?: MonitoringStatus;
@doc("NewRelic Organization properties of the resource")
@visibility("read")
"marketplaceSubscriptionStatus"?: MarketplaceSubscriptionStatus;
@doc("Marketplace Subscription Id")
@visibility("read")
"marketplaceSubscriptionId"?: string;
@doc("MarketplaceSubscriptionStatus of the resource")
"newRelicAccountProperties"?: NewRelicAccountProperties;
@doc("User Info")
"userInfo"?: UserInfo;
@doc("Plan details")
"planData"?: PlanData;
@doc("Liftr resource category")
@visibility("read")
"liftrResourceCategory"?: LiftrResourceCategories;
@doc("Liftr resource preference. The priority of the resource.")
@visibility("read")
"liftrResourcePreference"?: int32;
@doc("Source of org creation")
"orgCreationSource"?: OrgCreationSource;
@doc("Source of account creation")
"accountCreationSource"?: AccountCreationSource;
}

@doc("Properties of the NewRelic account")
model NewRelicAccountProperties {
@doc("User id")
"userId"?: string;
@doc("NewRelic Account Information")
"accountInfo"?: AccountInfo;
@doc("NewRelic Organization Information")
"organizationInfo"?: OrganizationInfo;
@doc("date when plan was applied")
"singleSignOnProperties"?: NewRelicSingleSignOnProperties;
}

@doc("Account Info of the NewRelic account")
model AccountInfo {
@doc("Account id")
"accountId"?: string;
@doc("ingestion key of account")
"ingestionKey"?: @secret string;
@doc("NewRelic account region")
"region"?: string;
}

@doc("Organization Info of the NewRelic account")
model OrganizationInfo {
@doc("Organization id")
"organizationId"?: string;
}

@doc("Single sign on Info of the NewRelic account")
model NewRelicSingleSignOnProperties {
@doc("Single sign-on state")
"singleSignOnState"?: SingleSignOnStates;
@doc("The Id of the Enterprise App used for Single sign-on.")
"enterpriseAppId"?: string;
@doc("The login URL specific to this NewRelic Organization")
"singleSignOnUrl"?: string;
@doc("Provisioning state")
"provisioningState"?: ProvisioningState;
}

@doc("User Info of NewRelic Monitor resource")
model UserInfo {
@doc("First name")
"firstName"?: string;
@doc("Last name")
"lastName"?: string;
@doc("User Email")
"emailAddress"?: string;
@doc("Contact phone number")
"phoneNumber"?: string;
@doc("country if user")
"country"?: string;
}

@doc("Plan data of NewRelic Monitor resource")
model PlanData {
@doc("Different usage type like PAYG/COMMITTED. this could be enum")
"usageType"?: UsageType;
@doc("Different billing cycles like MONTHLY/WEEKLY. this could be enum")
"billingCycle"?: BillingCycle;
@doc("plan id as published by NewRelic")
"planDetails"?: string;
@doc("date when plan was applied")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"effectiveDate"?: utcDateTime;
}

@doc("Managed service identity (system assigned and/or user assigned identities)")
model ManagedServiceIdentity {
@doc("""
The service principal ID of the system assigned identity. This property will
only be provided for a system assigned identity.
""")
@visibility("read")
"principalId"?: string;
@doc("""
The tenant ID of the system assigned identity. This property will only be
provided for a system assigned identity.
""")
@visibility("read")
"tenantId"?: string;
@doc("""
Type of managed service identity (where both SystemAssigned and UserAssigned
types are allowed).
""")
"type": ManagedServiceIdentityType;
@doc("""
The set of user assigned identities associated with the resource. The
userAssignedIdentities dictionary keys will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}.
The dictionary values can be empty objects ({}) in requests.
""")
"userAssignedIdentities"?: Record<UserAssignedIdentity>;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
@doc("The principal ID of the assigned identity.")
@visibility("read")
"principalId"?: string;
@doc("The client ID of the assigned identity.")
@visibility("read")
"clientId"?: string;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
...Resource;
@doc("Resource tags.")
"tags"?: Record<string>;
@doc("The geo-location where the resource lives")
"location": string;
}

@doc("Response of get all organizations Operation.")
model OrganizationsListResponse is Azure.Core.Page<OrganizationResource> {
}

@doc("The details of a Organization resource.")
model OrganizationResource {
...ProxyResource;
@doc("The resource-specific properties for this resource.")
"properties"?: OrganizationProperties;
}

@doc("Details of Organizations")
model OrganizationProperties {
@doc("organization id")
"organizationId"?: string;
@doc("organization name")
"organizationName"?: string;
@doc("Billing source")
"billingSource"?: BillingSource;
}

@doc("Response of get all plan data Operation.")
model PlanDataListResponse is Azure.Core.Page<PlanDataResource> {
}

@doc("The details of a PlanData resource.")
model PlanDataResource {
...ProxyResource;
@doc("The resource-specific properties for this resource.")
"properties"?: PlanDataProperties;
}

@doc("Plan details")
model PlanDataProperties {
@doc("Plan details")
"planData"?: PlanData;
@doc("Source of org creation")
"orgCreationSource"?: OrgCreationSource;
@doc("Source of account creation")
"accountCreationSource"?: AccountCreationSource;
}

@doc("The type used for update operations of the NewRelicMonitorResource.")
model NewRelicMonitorResourceUpdate {
@doc("The managed service identities assigned to this resource.")
"identity"?: ManagedServiceIdentity;
@doc("Resource tags.")
"tags"?: Record<string>;
@doc("The updatable properties of the NewRelicMonitorResource.")
"properties"?: NewRelicMonitorResourceUpdateProperties;
}

@doc("The updatable properties of the NewRelicMonitorResource.")
model NewRelicMonitorResourceUpdateProperties {
@doc("MarketplaceSubscriptionStatus of the resource")
"newRelicAccountProperties"?: NewRelicAccountProperties;
@doc("User Info")
"userInfo"?: UserInfo;
@doc("Plan details")
"planData"?: PlanData;
@doc("Source of org creation")
"orgCreationSource"?: OrgCreationSource;
@doc("Source of account creation")
"accountCreationSource"?: AccountCreationSource;
}

@doc("Request of get metrics Operation.")
model MetricsRequest {
@doc("User Email")
"userEmail": string;
}

@doc("Set of rules for sending metrics for the Monitor resource.")
model MetricRules {
@doc("Flag specifying if metrics should be sent for the Monitor resource.")
"sendMetrics"?: SendMetricsStatus;
@doc("List of filtering tags to be used for capturing metrics.")
"filteringTags"?: FilteringTag[];
@doc("User Email")
"userEmail"?: string;
}

@doc("""
The definition of a filtering tag. Filtering tags are used for capturing
resources and include/exclude them from being monitored.
""")
model FilteringTag {
@doc("The name (also known as the key) of the tag.")
"name"?: string;
@doc("The value of the tag.")
"value"?: string;
@doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
"action"?: TagAction;
}

@doc("Request of get metrics status Operation.")
model MetricsStatusRequest {
@doc("Azure resource IDs")
"azureResourceIds"?: string[];
@doc("User Email")
"userEmail": string;
}

@doc("Response of get metrics status Operation.")
model MetricsStatusResponse {
@doc("Azure resource IDs")
"azureResourceIds"?: string[];
}

@doc("Request of a app services get Operation.")
model AppServicesGetRequest {
@doc("Azure resource IDs")
"azureResourceIds"?: string[];
@doc("User Email")
"userEmail": string;
}

@doc("Response of a list app services Operation.")
model AppServicesListResponse is Azure.Core.Page<AppServiceInfo> {
}

@doc("Details of VM Resource having NewRelic OneAgent installed")
model AppServiceInfo {
@doc("Azure App service resource ID")
"azureResourceId"?: string;
@doc("Version of the NewRelic agent installed on the App service.")
"agentVersion"?: string;
@doc("Status of the NewRelic agent installed on the App service.")
"agentStatus"?: string;
}

@doc("Request of a switch billing Operation.")
model SwitchBillingRequest {
@doc("Azure resource Id")
"azureResourceId"?: string;
@doc("Organization id")
"organizationId"?: string;
@doc("Plan details")
"planData"?: PlanData;
@doc("User Email")
"userEmail": string;
}

@doc("Request of a Hosts get Operation.")
model HostsGetRequest {
@doc("VM resource IDs")
"vmIds"?: string[];
@doc("User Email")
"userEmail": string;
}

@doc("Response of a list VM Host Operation.")
model VMHostsListResponse is Azure.Core.Page<VMInfo> {
}

@doc("Details of VM Resource having NewRelic OneAgent installed")
model VMInfo {
@doc("Azure VM resource ID")
"vmId"?: string;
@doc("Version of the NewRelic agent installed on the VM.")
"agentVersion"?: string;
@doc("Status of the NewRelic agent installed on the VM.")
"agentStatus"?: string;
}

@doc("List of all the resources being monitored by NewRelic monitor resource")
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource> {
}

@doc("Details of resource being monitored by NewRelic monitor resource")
model MonitoredResource {
@doc("The ARM id of the resource.")
"id"?: string;
@doc("Flag indicating if resource is sending metrics to NewRelic.")
"sendingMetrics"?: SendingMetricsStatus;
@doc("Reason for why the resource is sending metrics (or why it is not sending).")
"reasonForMetricsStatus"?: string;
@doc("Flag indicating if resource is sending logs to NewRelic.")
"sendingLogs"?: SendingLogsStatus;
@doc("Reason for why the resource is sending logs (or why it is not sending).")
"reasonForLogsStatus"?: string;
}

@doc("The response of a TagRule list operation.")
model TagRuleListResult is Azure.Core.Page<TagRule> {
}

@doc("A tag rule belonging to NewRelic account")
model TagRule {
...ProxyResource;
@doc("The resource-specific properties for this resource.")
"properties": MonitoringTagRulesProperties;
}

@doc("The resource-specific properties for this resource.")
model MonitoringTagRulesProperties {
@doc("Provisioning State of the resource")
@visibility("read")
"provisioningState"?: ProvisioningState;
@doc("Set of rules for sending logs for the Monitor resource.")
"logRules"?: LogRules;
@doc("Set of rules for sending metrics for the Monitor resource.")
"metricRules"?: MetricRules;
}

@doc("Set of rules for sending logs for the Monitor resource.")
model LogRules {
@doc("Flag specifying if AAD logs should be sent for the Monitor resource.")
"sendAadLogs"?: SendAadLogsStatus;
@doc("Flag specifying if subscription logs should be sent for the Monitor resource.")
"sendSubscriptionLogs"?: SendSubscriptionLogsStatus;
@doc("""
Flag specifying if activity logs from Azure resources should be sent for the
Monitor resource.
""")
"sendActivityLogs"?: SendActivityLogsStatus;
@doc("""
List of filtering tags to be used for capturing logs. This only takes effect if
SendActivityLogs flag is enabled. If empty, all resources will be captured.
If
only Exclude action is specified, the rules will apply to the list of all
available resources. If Include actions are specified, the rules will only
include resources with the associated tags.
""")
"filteringTags"?: FilteringTag[];
}

@doc("The type used for update operations of the TagRule.")
model TagRuleUpdate {
@doc("The updatable properties of the TagRule.")
"properties"?: TagRuleUpdateProperties;
}

@doc("The updatable properties of the TagRule.")
model TagRuleUpdateProperties {
@doc("Set of rules for sending logs for the Monitor resource.")
"logRules"?: LogRules;
@doc("Set of rules for sending metrics for the Monitor resource.")
"metricRules"?: MetricRules;
}

@doc("Response of payload to be passed while installing VM agent.")
model VMExtensionPayload {
@doc("Ingestion key of the account")
"ingestionKey"?: string;
}

@doc("App services Get Parameter specification.")
model AppServicesGetParameter {
@doc("The details of the app services get request.")
"request": AppServicesGetRequest;
}

@doc("Switch Billing Parameter specification.")
model SwitchBillingParameter {
@doc("The details of the switch billing request.")
"request": SwitchBillingRequest;
}

@doc("Host Get Parameter specification.")
model HostsGetParameter {
@doc("The details of the Hosts get request.")
"request": HostsGetRequest;
}

@doc("Get Metrics Status Parameter specification.")
model MetricsRequestParameter {
@doc("The details of the get metrics status request.")
"request": MetricsRequest;
}

@doc("Get Metrics Status Parameter specification.")
model MetricsStatusRequestParameter {
@doc("The details of the get metrics status request.")
"request": MetricsStatusRequest;
}