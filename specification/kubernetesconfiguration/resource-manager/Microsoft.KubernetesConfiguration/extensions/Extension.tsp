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
* The Extension object.
*/
model Extension is Azure.ResourceManager.ProxyResource<ExtensionProperties> {
...ResourceNameParameter<Resource = Extension,KeyName = "extensionName",SegmentName = "extensions",NamePattern = "">
/**
* Identity of the Extension resource
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"identity"?: Azure.ResourceManager.CommonTypes.Identity;
...Azure.ResourceManager.ResourcePlanProperty
}



alias {clusterResourceName}ExternalResource = Extension.ExternalResource<"{clusterRp}"
      , "{clusterResourceName}", "{clusterName}">;
      
@armResourceOperations
interface Extensions {
/**
* Gets Kubernetes Cluster Extension.
*/
get is ArmResourceRead<Extension, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }
        >;


/**
* Create a new Kubernetes Cluster Extension.
*/
create is ArmResourceCreateOrReplaceAsync<Extension, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }
        >;


/**
* Patch an existing Kubernetes Cluster Extension.
*/
@patch(#{ implicitOptionality: false })
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
update is ArmCustomPatchAsync<Extension, PatchModel = PatchExtension, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }, Response = ArmResponse<Extension> | ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = Extension> & Azure.Core.Foundations.RetryAfterHeader> & { @bodyRoot
"_": Extension; }
        >;


/**
* Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall the extension from the cluster.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
delete is ArmResourceDeleteWithoutOkAsync<Extension, Parameters = { /**
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
* List all Extensions in the cluster.
*/
list is ArmResourceListByParent<Extension, Parameters = { /**
* The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
*/
@pattern("^[a-zA-Z]*$")
@path
"clusterResourceName": string }, Response = ArmResponse<ExtensionsList>
        >;


/**
* Get Async Operation status
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("OperationStatus_Get")
@get
@action("{operationId}")
operationStatusGet is ArmResourceActionSync<Extension, void, ArmResponse<OperationStatusResult>, Parameters = { /**
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


@@doc(Extension.name, "Name of the Extension.")
@@doc(Extension.properties, "Properties of an Extension resource")
@@doc(Extensions.`create`::parameters.resource, "Properties necessary to Create an Extension.");
@@doc(Extensions.`update`::parameters.properties, "Properties to Patch in an existing Extension.");