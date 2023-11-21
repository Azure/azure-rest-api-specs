import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;


namespace AzureAnalysisServices;



    enum State {
        "Deleting", "Succeeded", "Failed", "Paused", "Suspended", "Provisioning", "Updating", "Suspending", "Pausing", "Resuming", "Preparing", "Scaling"
    }

    enum ProvisioningState {
        "Deleting", "Succeeded", "Failed", "Paused", "Suspended", "Provisioning", "Updating", "Suspending", "Pausing", "Resuming", "Preparing", "Scaling"
    }

    enum SkuTier {
        "Development", "Basic", "Standard"
    }
@Azure.Core.fixed
    enum ConnectionMode {
        "All", "ReadOnly"
    }
@Azure.Core.fixed
    enum ManagedMode {
        0: 0, 1: 1
    }
@Azure.Core.fixed
    enum ServerMonitorMode {
        0: 0, 1: 1
    }



@doc("Represents an instance of an Analysis Services resource.")
model AnalysisServicesServer {
...Resource;
@doc("Properties of the provision operation request.")
"properties"?: AnalysisServicesServerProperties;
}

@doc("Properties of Analysis Services resource.")
model AnalysisServicesServerProperties {
...AnalysisServicesServerMutableProperties;
@doc("""
The current state of Analysis Services resource. The state is to indicate more
states outside of resource provisioning.
""")
@visibility("read")
"state"?: State;
@doc("""
The current deployment state of Analysis Services resource. The
provisioningState is to indicate states for resource provisioning.
""")
@visibility("read")
"provisioningState"?: ProvisioningState;
@doc("The full name of the Analysis Services resource.")
@visibility("read")
"serverFullName"?: string;
@doc("The SKU of the Analysis Services resource.")
"sku"?: ResourceSku;
}

@doc("Represents the SKU name and Azure pricing tier for Analysis Services resource.")
model ResourceSku {
@doc("Name of the SKU level.")
"name": string;
@doc("The name of the Azure pricing tier to which the SKU applies.")
"tier"?: SkuTier;
@doc("The number of instances in the read only query pool.")
"capacity"?: int32;
}

@doc("""
An object that represents a set of mutable Analysis Services resource
properties.
""")
model AnalysisServicesServerMutableProperties {
@doc("A collection of AS server administrators")
"asAdministrators"?: ServerAdministrators;
@doc("The SAS container URI to the backup container.")
"backupBlobContainerUri"?: string;
@doc("The gateway details configured for the AS server.")
"gatewayDetails"?: GatewayDetails;
@doc("The firewall settings for the AS server.")
"ipV4FirewallSettings"?: IPv4FirewallSettings;
@doc("""
How the read-write server's participation in the query pool is
controlled.<br/>It can have the following values: <ul><li>readOnly - indicates
that the read-write server is intended not to participate in query
operations</li><li>all - indicates that the read-write server can participate
in query operations</li></ul>Specifying readOnly when capacity is 1 results in
error.
""")
"querypoolConnectionMode"?: ConnectionMode;
@doc("The managed mode of the server (0 = not managed, 1 = managed).")
"managedMode"?: ManagedMode;
@doc("The server monitor mode for AS server")
"serverMonitorMode"?: ServerMonitorMode;
}

@doc("An array of administrator user identities.")
model ServerAdministrators {
@doc("An array of administrator user identities.")
"members"?: string[];
}

@doc("The gateway details.")
model GatewayDetails {
@doc("Gateway resource to be associated with the server.")
"gatewayResourceId"?: string;
@doc("Gateway object id from in the DMTS cluster for the gateway resource.")
@visibility("read")
"gatewayObjectId"?: string;
@doc("Uri of the DMTS cluster.")
@visibility("read")
"dmtsClusterUri"?: string;
}

@doc("An array of firewall rules.")
model IPv4FirewallSettings {
@doc("An array of firewall rules.")
"firewallRules"?: IPv4FirewallRule[];
@doc("The indicator of enabling PBI service.")
"enablePowerBIService"?: boolean;
}

@doc("The detail of firewall rule.")
model IPv4FirewallRule {
@doc("The rule name.")
"firewallRuleName"?: string;
@doc("The start range of IPv4.")
"rangeStart"?: string;
@doc("The end range of IPv4.")
"rangeEnd"?: string;
}

@doc("Represents an instance of an Analysis Services resource.")
model Resource {
@doc("An identifier that represents the Analysis Services resource.")
@visibility("read")
"id"?: string;
@doc("The name of the Analysis Services resource.")
@visibility("read")
"name"?: string;
@doc("The type of the Analysis Services resource.")
@visibility("read")
"type"?: string;
@doc("Location of the Analysis Services resource.")
"location": string;
@doc("The SKU of the Analysis Services resource.")
"sku": ResourceSku;
@doc("Key-value pairs of additional resource provisioning properties.")
"tags"?: Record<string>;
}

@doc("Describes the format of Error response.")
@error
model ErrorResponse {
@doc("The error object")
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
@doc("The error sub code")
@visibility("read")
"subCode"?: int32;
@doc("The http status code")
@visibility("read")
"httpStatusCode"?: int32;
@doc("the timestamp for the error.")
@visibility("read")
"timeStamp"?: string;
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

@doc("Provision request specification")
model AnalysisServicesServerUpdateParameters {
@doc("The SKU of the Analysis Services resource.")
"sku"?: ResourceSku;
@doc("Key-value pairs of additional provisioning properties.")
"tags"?: Record<string>;
@doc("Properties of the provision operation request.")
"properties"?: AnalysisServicesServerMutableProperties;
}

@doc("An array of Analysis Services resources.")
@pagedResult
model AnalysisServicesServers {
@doc("An array of Analysis Services resources.")
@items
"value": AnalysisServicesServer[];
}

@doc("An object that represents enumerating SKUs for new resources.")
model SkuEnumerationForNewResourceResult {
@doc("The collection of available SKUs for new resources.")
"value"?: ResourceSku[];
}

@doc("An object that represents enumerating SKUs for existing resources.")
model SkuEnumerationForExistingResourceResult {
@doc("The collection of available SKUs for existing resources.")
"value"?: SkuDetailsForExistingResource[];
}

@doc("An object that represents SKU details for existing resources.")
model SkuDetailsForExistingResource {
@doc("The SKU in SKU details for existing resources.")
"sku"?: ResourceSku;
@doc("The resource type.")
"resourceType"?: string;
}

@doc("Status of gateway is live.")
model GatewayListStatusLive {
@doc("Live message of list gateway. Status: 0 - Live")
"status"?: 0;
}

@doc("Status of gateway is error.")
@error
model GatewayListStatusError {
@doc("Error of the list gateway status.")
"error"?: ErrorDetail;
}

@doc("Details of server name request body.")
model CheckServerNameAvailabilityParameters {
@doc("Name for checking availability.")
"name"?: string;
@doc("The resource type of azure analysis services.")
"type"?: string;
}

@doc("The checking result of server name availability.")
model CheckServerNameAvailabilityResult {
@doc("Indicator of available of the server name.")
"nameAvailable"?: boolean;
@doc("The reason of unavailability.")
"reason"?: string;
@doc("The detailed message of the request unavailability.")
"message"?: string;
}

@doc("The status of operation.")
model OperationStatus {
@doc("The operation Id.")
"id"?: string;
@doc("The operation name.")
"name"?: string;
@doc("The start time of the operation.")
"startTime"?: string;
@doc("The end time of the operation.")
"endTime"?: string;
@doc("The status of the operation.")
"status"?: string;
@doc("The error detail of the operation if any.")
"error"?: ErrorDetail;
}

@doc("""
Result of listing consumption operations. It contains a list of operations and
a URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation> {
}

@doc("A Consumption REST API operation.")
model Operation {
@doc("Operation name: {provider}/{resource}/{operation}.")
@visibility("read")
"name"?: string;
@doc("The object that represents the operation.")
"display"?: OperationDisplay;
@doc("The origin")
@visibility("read")
"origin"?: string;
@doc("Additional properties to expose performance metrics to shoebox.")
"properties"?: OperationProperties;
}

@doc("The object that represents the operation.")
model OperationDisplay {
@doc("Service provider: Microsoft.Consumption.")
@visibility("read")
"provider"?: string;
@doc("Resource on which the operation is performed: UsageDetail, etc.")
@visibility("read")
"resource"?: string;
@doc("Operation type: Read, write, delete, etc.")
@visibility("read")
"operation"?: string;
@doc("Description of the operation object.")
@visibility("read")
"description"?: string;
}

@doc("Additional properties to expose performance metrics to shoebox.")
model OperationProperties {
@doc("Performance metrics to shoebox.")
"serviceSpecification"?: OperationPropertiesServiceSpecification;
}

@doc("Performance metrics to shoebox.")
model OperationPropertiesServiceSpecification {
@doc("The metric specifications.")
@visibility("read")
"metricSpecifications"?: MetricSpecifications[];
@doc("The log specifications.")
@visibility("read")
"logSpecifications"?: LogSpecifications[];
}

@doc("""
Available operation metric specification for exposing performance metrics to
shoebox.
""")
model MetricSpecifications {
@doc("The name of metric.")
@visibility("read")
"name"?: string;
@doc("The displayed name of metric.")
@visibility("read")
"displayName"?: string;
@doc("The displayed description of metric.")
@visibility("read")
"displayDescription"?: string;
@doc("The unit of the metric.")
@visibility("read")
"unit"?: string;
@doc("The aggregation type of metric.")
@visibility("read")
"aggregationType"?: string;
@doc("The dimensions of metric.")
@visibility("read")
"dimensions"?: MetricDimensions[];
}

@doc("Metric dimension.")
model MetricDimensions {
@doc("Dimension name.")
@visibility("read")
"name"?: string;
@doc("Dimension display name.")
@visibility("read")
"displayName"?: string;
}

@doc("The log metric specification for exposing performance metrics to shoebox.")
model LogSpecifications {
@doc("The name of metric.")
@visibility("read")
"name"?: string;
@doc("The displayed name of log.")
@visibility("read")
"displayName"?: string;
@doc("The blob duration for the log.")
@visibility("read")
"blobDuration"?: string;
}