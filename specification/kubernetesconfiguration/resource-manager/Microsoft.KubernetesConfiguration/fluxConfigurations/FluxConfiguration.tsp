import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.KubernetesConfiguration;
/**
* The Flux Configuration object returned in Get & Put response.
*/
model FluxConfiguration is Azure.ResourceManager.ProxyResource<FluxConfigurationProperties> {
...ResourceNameParameter<Resource = FluxConfiguration,KeyName = "fluxConfigurationName",SegmentName = "fluxConfigurations",NamePattern = "">
}



alias {clusterResourceName}ExternalResource = Extension.ExternalResource<"{clusterRp}"
      , "{clusterResourceName}", "{clusterName}">;
      
@armResourceOperations
interface FluxConfigurations {
/**
* Gets details of the Flux Configuration.
*/
get is ArmResourceRead<FluxConfiguration, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }
        >;


/**
* Create a new Kubernetes Flux Configuration.
*/
createOrUpdate is ArmResourceCreateOrReplaceAsync<FluxConfiguration, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }
        >;


/**
* Update an existing Kubernetes Flux Configuration.
*/
@patch(#{ implicitOptionality: false })
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
update is ArmCustomPatchAsync<FluxConfiguration, PatchModel = FluxConfigurationPatch, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }, Response = ArmResponse<FluxConfiguration> | ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = FluxConfiguration> & Azure.Core.Foundations.RetryAfterHeader> & { @bodyRoot
"_": FluxConfiguration; }
        >;


/**
* This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
delete is ArmResourceDeleteWithoutOkAsync<FluxConfiguration, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string,
/**
* Delete the extension resource in Azure - not the normal asynchronous delete.
*/
@query("forceDelete")
"forceDelete"?: boolean }, Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
        >;


/**
* List all Flux Configurations.
*/
list is ArmResourceListByParent<FluxConfiguration, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }, Response = ArmResponse<FluxConfigurationsList>
        >;


/**
* Get Async Operation status
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("FluxConfigOperationStatus_Get")
@get
@action("{operationId}")
fluxConfigOperationStatusGet is ArmResourceActionSync<FluxConfiguration, void, ArmResponse<OperationStatusResult>, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string,
/**
* operation Id
*/
@path
"operationId": string }>;


}


@@doc(FluxConfiguration.name, "Name of the Flux Configuration.")
@@doc(FluxConfiguration.properties, "Properties to create a Flux Configuration resource")
@@doc(FluxConfigurations.`createOrUpdate`::parameters.resource, "Properties necessary to Create a FluxConfiguration.");
@@doc(FluxConfigurations.`update`::parameters.properties, "Properties to Patch in an existing Flux Configuration.");