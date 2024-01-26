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

/**
* Provisioning state of Elastic resource.
*/
    enum ProvisioningState {
        "Accepted", "Creating", "Updating", "Deleting", "Succeeded", "Failed", "Canceled", "Deleted", "NotSpecified"
    }

/**
* Flag specifying if the resource monitoring is enabled or disabled.
*/
    enum MonitoringStatus {
        "Enabled", "Disabled"
    }


    enum LiftrResourceCategories {
        "Unknown", "MonitorLogs"
    }

/**
* Managed Identity types.
*/
    enum ManagedIdentityTypes {
        "SystemAssigned"
    }

/**
* Flag indicating the status of the resource for sending logs operation to Elastic.
*/
    enum SendingLogs {
        "True", "False"
    }

/**
* Flag specifying if the Elastic deployment status is healthy or not.
*/
    enum ElasticDeploymentStatus {
        "Healthy", "Unhealthy"
    }

/**
* Valid actions for a filtering tag. Exclusion takes priority over inclusion.
*/
    enum TagAction {
        "Include", "Exclude"
    }

/**
* Operation to be performed on the given vm resource id.
*/
    enum OperationName {
        "Add", "Delete"
    }




/**
* A Microsoft.Elastic REST API operation.
*/
model OperationResult {
/**
* Operation name, i.e., {provider}/{resource}/{operation}.
*/
"name"?: string;
/**
* Indicates whether the operation is a data action
*/
"isDataAction"?: boolean;
/**
* The object that represents the operation.
*/
"display"?: OperationDisplay;
/**
* Origin of the operation
*/
"origin"?: string;
}

/**
* RP default error response.
*/
@error
model ResourceProviderDefaultErrorResponse {
/**
* Response body of Error
*/
@visibility("read")
"error"?: ErrorResponseBody;
}

/**
* Error response body.
*/
model ErrorResponseBody {
/**
* Error code.
*/
"code"?: string;
/**
* Error message.
*/
"message"?: string;
/**
* Error target.
*/
"target"?: string;
/**
* Error details.
*/
"details"?: ErrorResponseBody[];
}

/**
* Properties specific to the monitor resource.
*/
model MonitorProperties {
/**
* Provisioning state of the monitor resource.
*/
"provisioningState"?: ProvisioningState;
/**
* Flag specifying if the resource monitoring is enabled or disabled.
*/
"monitoringStatus"?: MonitoringStatus;
/**
* Elastic cloud properties.
*/
"elasticProperties"?: ElasticProperties;
/**
* User information.
*/
@visibility("create")
"userInfo"?: UserInfo;
@visibility("read")
"liftrResourceCategory"?: LiftrResourceCategories;
/**
* The priority of the resource.
*/
@visibility("read")
"liftrResourcePreference"?: int32;
}

/**
* Elastic Resource Properties.
*/
model ElasticProperties {
/**
* Details of the user's elastic account.
*/
"elasticCloudUser"?: ElasticCloudUser;
/**
* Details of the elastic cloud deployment.
*/
"elasticCloudDeployment"?: ElasticCloudDeployment;
}

/**
* Details of the user's elastic account.
*/
model ElasticCloudUser {
/**
* Email of the Elastic User Account.
*/
@visibility("read")
"emailAddress"?: string;
/**
* User Id of the elastic account of the User.
*/
@visibility("read")
"id"?: string;
/**
* Elastic cloud default dashboard sso URL of the Elastic user account.
*/
@visibility("read")
"elasticCloudSsoDefaultUrl"?: string;
}

/**
* Details of the user's elastic deployment associated with the monitor resource.
*/
model ElasticCloudDeployment {
/**
* Elastic deployment name
*/
@visibility("read")
"name"?: string;
/**
* Elastic deployment Id
*/
@visibility("read")
"deploymentId"?: string;
/**
* Associated Azure subscription Id for the elastic deployment.
*/
@visibility("read")
"azureSubscriptionId"?: string;
/**
* Region where Deployment at Elastic side took place.
*/
@visibility("read")
"elasticsearchRegion"?: string;
/**
* Elasticsearch ingestion endpoint of the Elastic deployment.
*/
@visibility("read")
"elasticsearchServiceUrl"?: string;
/**
* Kibana endpoint of the Elastic deployment.
*/
@visibility("read")
"kibanaServiceUrl"?: string;
/**
* Kibana dashboard sso URL of the Elastic deployment.
*/
@visibility("read")
"kibanaSsoUrl"?: string;
}

/**
* User Information to be passed to partners.
*/
model UserInfo {
/**
* First name of the user
*/
@maxLength(50)
"firstName"?: string;
/**
* Last name of the user
*/
@maxLength(50)
"lastName"?: string;
/**
* Company name of the user
*/
@maxLength(50)
"companyName"?: string;
/**
* Email of the user used by Elastic for contacting them if needed
*/
@pattern("^([^<>()\\[\\]\\.,;:\\s@"]+(\\.[^<>()\\[\\]\\.,;:\\s@"]+)*)@(([a-zA-Z-_0-9]+\\.)+[a-zA-Z]{2,})$")
"emailAddress"?: string;
/**
* Company information of the user to be passed to partners.
*/
"companyInfo"?: CompanyInfo;
}

/**
* Company information of the user to be passed to partners.
*/
model CompanyInfo {
/**
* Domain of the company
*/
@maxLength(250)
"domain"?: string;
/**
* Business of the company
*/
@maxLength(50)
"business"?: string;
/**
* Number of employees in the company
*/
@maxLength(20)
"employeesNumber"?: string;
/**
* State of the company location.
*/
@maxLength(50)
"state"?: string;
/**
* Country of the company location.
*/
@maxLength(50)
"country"?: string;
}

/**
* Identity properties.
*/
model IdentityProperties {
/**
* The identity ID.
*/
@visibility("read")
"principalId"?: string;
/**
* The tenant ID of resource.
*/
@visibility("read")
"tenantId"?: string;
/**
* Managed identity type.
*/
"type"?: ManagedIdentityTypes;
}

/**
* Monitor resource update parameters.
*/
model ElasticMonitorResourceUpdateParameters {
/**
* elastic monitor resource tags.
*/
"tags"?: Record<string>;
}

/**
* Response of a list operation.
*/
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource> {
}

/**
* The properties of a resource currently being monitored by the Elastic monitor resource.
*/
model MonitoredResource {
/**
* The ARM id of the resource.
*/
"id"?: string;
/**
* Flag indicating the status of the resource for sending logs operation to Elastic.
*/
"sendingLogs"?: SendingLogs;
/**
* Reason for why the resource is sending logs (or why it is not sending).
*/
"reasonForLogsStatus"?: string;
}

/**
* The properties of deployment in Elastic cloud corresponding to the Elastic monitor resource.
*/
model DeploymentInfoResponse {
/**
* The Elastic deployment status.
*/
@visibility("read")
"status"?: ElasticDeploymentStatus;
/**
* Version of the elasticsearch in Elastic cloud deployment.
*/
@visibility("read")
"version"?: string;
/**
* RAM capacity of the elasticsearch in Elastic cloud deployment.
*/
@visibility("read")
"memoryCapacity"?: string;
/**
* Disk capacity of the elasticsearch in Elastic cloud deployment.
*/
@visibility("read")
"diskCapacity"?: string;
}

/**
* Definition of the properties for a TagRules resource.
*/
model MonitoringTagRulesProperties {
/**
* Provisioning state of the monitoring tag rules.
*/
"provisioningState"?: ProvisioningState;
/**
* Rules for sending logs.
*/
"logRules"?: LogRules;
}

/**
* Set of rules for sending logs for the Monitor resource.
*/
model LogRules {
/**
* Flag specifying if AAD logs should be sent for the Monitor resource.
*/
"sendAadLogs"?: boolean;
/**
* Flag specifying if subscription logs should be sent for the Monitor resource.
*/
"sendSubscriptionLogs"?: boolean;
/**
* Flag specifying if activity logs from Azure resources should be sent for the Monitor resource.
*/
"sendActivityLogs"?: boolean;
/**
* List of filtering tags to be used for capturing logs. This only takes effect if SendActivityLogs flag is enabled. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
*/
"filteringTags"?: FilteringTag[];
}

/**
* The definition of a filtering tag. Filtering tags are used for capturing resources and include/exclude them from being monitored.
*/
model FilteringTag {
/**
* The name (also known as the key) of the tag.
*/
"name"?: string;
/**
* The value of the tag.
*/
"value"?: string;
/**
* Valid actions for a filtering tag.
*/
"action"?: TagAction;
}

/**
* Response of a list operation.
*/
model VMHostListResponse is Azure.Core.Page<VMResources> {
}

/**
* The vm resource properties that is currently being monitored by the Elastic monitor resource.
*/
model VMResources {
/**
* The ARM id of the VM resource.
*/
"vmResourceId"?: string;
}

/**
* The vm ingestion details to install an agent.
*/
model VMIngestionDetailsResponse {
/**
* The cloudId of given Elastic monitor resource.
*/
"cloudId"?: string;
/**
* Ingestion details to install agent on given VM.
*/
"ingestionKey"?: string;
}

/**
* Update VM resource collection.
*/
model VMCollectionUpdate {
/**
* ARM id of the VM resource.
*/
"vmResourceId"?: string;
/**
* Operation to be performed for given VM.
*/
"operationName"?: OperationName;
}