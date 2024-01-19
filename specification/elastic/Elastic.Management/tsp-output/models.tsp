import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;


namespace Microsoft.Elastic;

interface Operations extends Azure.ResourceManager.Operations {} 

@doc("Provisioning state of Elastic resource.")
    enum ProvisioningState {
        "Accepted", "Creating", "Updating", "Deleting", "Succeeded", "Failed", "Canceled", "Deleted", "NotSpecified"
    }

@doc("Flag specifying if the resource monitoring is enabled or disabled.")
    enum MonitoringStatus {
        "Enabled", "Disabled"
    }


    enum LiftrResourceCategories {
        "Unknown", "MonitorLogs"
    }

@doc("Managed Identity types.")
    enum ManagedIdentityTypes {
        "SystemAssigned"
    }

@doc("Flag indicating the status of the resource for sending logs operation to Elastic.")
    enum SendingLogs {
        "True", "False"
    }

@doc("Flag specifying if the Elastic deployment status is healthy or not.")
    enum ElasticDeploymentStatus {
        "Healthy", "Unhealthy"
    }

@doc("Valid actions for a filtering tag. Exclusion takes priority over inclusion.")
    enum TagAction {
        "Include", "Exclude"
    }

@doc("Operation to be performed on the given vm resource id.")
    enum OperationName {
        "Add", "Delete"
    }




@doc("A Microsoft.Elastic REST API operation.")
model OperationResult {
@doc("Operation name, i.e., {provider}/{resource}/{operation}.")
"name"?: string;
@doc("Indicates whether the operation is a data action")
"isDataAction"?: boolean;
@doc("The object that represents the operation.")
"display"?: OperationDisplay;
@doc("Origin of the operation")
"origin"?: string;
}

@doc("RP default error response.")
@error
model ResourceProviderDefaultErrorResponse {
@doc("Response body of Error")
@visibility("read")
"error"?: ErrorResponseBody;
}

@doc("Error response body.")
model ErrorResponseBody {
@doc("Error code.")
"code"?: string;
@doc("Error message.")
"message"?: string;
@doc("Error target.")
"target"?: string;
@doc("Error details.")
"details"?: ErrorResponseBody[];
}

@doc("Properties specific to the monitor resource.")
model MonitorProperties {
@doc("Provisioning state of the monitor resource.")
"provisioningState"?: ProvisioningState;
@doc("Flag specifying if the resource monitoring is enabled or disabled.")
"monitoringStatus"?: MonitoringStatus;
@doc("Elastic cloud properties.")
"elasticProperties"?: ElasticProperties;
@doc("User information.")
@visibility("create")
"userInfo"?: UserInfo;
@visibility("read")
"liftrResourceCategory"?: LiftrResourceCategories;
@doc("The priority of the resource.")
@visibility("read")
"liftrResourcePreference"?: int32;
}

@doc("Elastic Resource Properties.")
model ElasticProperties {
@doc("Details of the user's elastic account.")
"elasticCloudUser"?: ElasticCloudUser;
@doc("Details of the elastic cloud deployment.")
"elasticCloudDeployment"?: ElasticCloudDeployment;
}

@doc("Details of the user's elastic account.")
model ElasticCloudUser {
@doc("Email of the Elastic User Account.")
@visibility("read")
"emailAddress"?: string;
@doc("User Id of the elastic account of the User.")
@visibility("read")
"id"?: string;
@doc("Elastic cloud default dashboard sso URL of the Elastic user account.")
@visibility("read")
"elasticCloudSsoDefaultUrl"?: string;
}

@doc("Details of the user's elastic deployment associated with the monitor resource.")
model ElasticCloudDeployment {
@doc("Elastic deployment name")
@visibility("read")
"name"?: string;
@doc("Elastic deployment Id")
@visibility("read")
"deploymentId"?: string;
@doc("Associated Azure subscription Id for the elastic deployment.")
@visibility("read")
"azureSubscriptionId"?: string;
@doc("Region where Deployment at Elastic side took place.")
@visibility("read")
"elasticsearchRegion"?: string;
@doc("Elasticsearch ingestion endpoint of the Elastic deployment.")
@visibility("read")
"elasticsearchServiceUrl"?: string;
@doc("Kibana endpoint of the Elastic deployment.")
@visibility("read")
"kibanaServiceUrl"?: string;
@doc("Kibana dashboard sso URL of the Elastic deployment.")
@visibility("read")
"kibanaSsoUrl"?: string;
}

@doc("User Information to be passed to partners.")
model UserInfo {
@doc("First name of the user")
@maxLength(50)
"firstName"?: string;
@doc("Last name of the user")
@maxLength(50)
"lastName"?: string;
@doc("Company name of the user")
@maxLength(50)
"companyName"?: string;
@doc("Email of the user used by Elastic for contacting them if needed")
@pattern("^([^<>()\\[\\]\\.,;:\\s@"]+(\\.[^<>()\\[\\]\\.,;:\\s@"]+)*)@(([a-zA-Z-_0-9]+\\.)+[a-zA-Z]{2,})$")
"emailAddress"?: string;
@doc("Company information of the user to be passed to partners.")
"companyInfo"?: CompanyInfo;
}

@doc("Company information of the user to be passed to partners.")
model CompanyInfo {
@doc("Domain of the company")
@maxLength(250)
"domain"?: string;
@doc("Business of the company")
@maxLength(50)
"business"?: string;
@doc("Number of employees in the company")
@maxLength(20)
"employeesNumber"?: string;
@doc("State of the company location.")
@maxLength(50)
"state"?: string;
@doc("Country of the company location.")
@maxLength(50)
"country"?: string;
}

@doc("Identity properties.")
model IdentityProperties {
@doc("The identity ID.")
@visibility("read")
"principalId"?: string;
@doc("The tenant ID of resource.")
@visibility("read")
"tenantId"?: string;
@doc("Managed identity type.")
"type"?: ManagedIdentityTypes;
}

@doc("Monitor resource update parameters.")
model ElasticMonitorResourceUpdateParameters {
@doc("elastic monitor resource tags.")
"tags"?: Record<string>;
}

@doc("Response of a list operation.")
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource> {
}

@doc("The properties of a resource currently being monitored by the Elastic monitor resource.")
model MonitoredResource {
@doc("The ARM id of the resource.")
"id"?: string;
@doc("Flag indicating the status of the resource for sending logs operation to Elastic.")
"sendingLogs"?: SendingLogs;
@doc("Reason for why the resource is sending logs (or why it is not sending).")
"reasonForLogsStatus"?: string;
}

@doc("The properties of deployment in Elastic cloud corresponding to the Elastic monitor resource.")
model DeploymentInfoResponse {
@doc("The Elastic deployment status.")
@visibility("read")
"status"?: ElasticDeploymentStatus;
@doc("Version of the elasticsearch in Elastic cloud deployment.")
@visibility("read")
"version"?: string;
@doc("RAM capacity of the elasticsearch in Elastic cloud deployment.")
@visibility("read")
"memoryCapacity"?: string;
@doc("Disk capacity of the elasticsearch in Elastic cloud deployment.")
@visibility("read")
"diskCapacity"?: string;
}

@doc("Definition of the properties for a TagRules resource.")
model MonitoringTagRulesProperties {
@doc("Provisioning state of the monitoring tag rules.")
"provisioningState"?: ProvisioningState;
@doc("Rules for sending logs.")
"logRules"?: LogRules;
}

@doc("Set of rules for sending logs for the Monitor resource.")
model LogRules {
@doc("Flag specifying if AAD logs should be sent for the Monitor resource.")
"sendAadLogs"?: boolean;
@doc("Flag specifying if subscription logs should be sent for the Monitor resource.")
"sendSubscriptionLogs"?: boolean;
@doc("Flag specifying if activity logs from Azure resources should be sent for the Monitor resource.")
"sendActivityLogs"?: boolean;
@doc("List of filtering tags to be used for capturing logs. This only takes effect if SendActivityLogs flag is enabled. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.")
"filteringTags"?: FilteringTag[];
}

@doc("The definition of a filtering tag. Filtering tags are used for capturing resources and include/exclude them from being monitored.")
model FilteringTag {
@doc("The name (also known as the key) of the tag.")
"name"?: string;
@doc("The value of the tag.")
"value"?: string;
@doc("Valid actions for a filtering tag.")
"action"?: TagAction;
}

@doc("Response of a list operation.")
model VMHostListResponse is Azure.Core.Page<VMResources> {
}

@doc("The vm resource properties that is currently being monitored by the Elastic monitor resource.")
model VMResources {
@doc("The ARM id of the VM resource.")
"vmResourceId"?: string;
}

@doc("The vm ingestion details to install an agent.")
model VMIngestionDetailsResponse {
@doc("The cloudId of given Elastic monitor resource.")
"cloudId"?: string;
@doc("Ingestion details to install agent on given VM.")
"ingestionKey"?: string;
}

@doc("Update VM resource collection.")
model VMCollectionUpdate {
@doc("ARM id of the VM resource.")
"vmResourceId"?: string;
@doc("Operation to be performed for given VM.")
"operationName"?: OperationName;
}