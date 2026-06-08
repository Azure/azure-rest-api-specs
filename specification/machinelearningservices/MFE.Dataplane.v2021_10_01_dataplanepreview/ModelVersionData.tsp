import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ModelContainerData.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.MachineLearningServices;
/**
* Azure Resource Manager resource envelope.
*/
@parentResource(ModelContainerData)
model ModelVersionData is Azure.ResourceManager.ProxyResource<ModelVersionDetails, false> {
...ResourceNameParameter<Resource = ModelVersionData,KeyName = "version",SegmentName = "versions",NamePattern = "">
}



@armResourceOperations
interface ModelVersions {
/**
* Get version.
*/
get is ArmResourceRead<ModelVersionData
        >;


/**
* Create or update version.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
createOrUpdate is ArmResourceCreateOrReplaceAsync<ModelVersionData, Response = ArmAcceptedLroResponse, LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >;


/**
* Delete version.
*/
delete is ArmResourceDeleteSync<ModelVersionData
        >;


/**
* List versions.
*/
list is ArmResourceListByParent<ModelVersionData, Parameters = { /**
* Continuation token for pagination.
*/
@query("$skiptoken")
"$skiptoken"?: string,
/**
* Ordering of list.
*/
@query("$orderBy")
"$orderBy"?: string,
/**
* Maximum number of records to return.
*/
@query("$top")
"$top"?: int32,
/**
* Model description.
*/
@query("description")
"description"?: string,
/**
* Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
*/
@query("tags")
"tags"?: string,
/**
* Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
*/
@query("properties")
"properties"?: string,
/**
* View type for including/excluding (for example) archived entities.
*/
@query("listViewType")
"listViewType"?: ListViewType }, Response = ArmResponse<ModelVersionResourceArmPaginatedResult>
        >;


/**
* Model Version Package operation.
*/
`package` is ArmResourceActionAsync<ModelVersionData, PackageRequest, ArmResponse<PackageResponse>>;


}


@@doc(ModelVersionData.name, "Version identifier. This is case-sensitive.");
@@doc(ModelVersionData.properties, "Additional attributes of the entity.");
@@doc(ModelVersions.`createOrUpdate`::parameters.resource, "Version entity to create or update.");
@@doc(ModelVersions.`package`::parameters.body, "Package operation request body.");