// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;


namespace Microsoft.MachineLearningServices;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DataReferencesOperationGroup {

#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DataReferences_GetBlobReferenceSAS")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/registries/{registryName}/datarefs/{name}/versions/{version}")
@post op `getBlobReferenceSAS`(
        ...ApiVersionParameter,
        
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
@path
"name": string,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@path
"version": string,
...SubscriptionIdParameter,
...ResourceGroupParameter,
/**
* Name of Azure Machine Learning registry.
*/
@path
"registryName": string,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@bodyRoot
"body": BlobReferenceSASRequestDto
        ): ArmResponse<BlobReferenceSASResponseDto> | ErrorResponse;



}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceManagementAssetReferenceOperationGroup {
@summary("""
Import the source asset provided in the request into registry.
The import performs a deep copy of the source asset given in the request into the registry.
The destination name/version value in ImportSourceAssetReference allows the client to update the name/version value after being imported.
If the destination resource exists, it will be overwritten.
""")
/**
* Import the source asset provided in the request into registry.
* The import performs a deep copy of the source asset given in the request into the registry.
* The destination name/version value in ImportSourceAssetReference allows the client to update the name/version value after being imported.
* If the destination resource exists, it will be overwritten.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("ResourceManagementAssetReference_Import")
@autoRoute
`import` is ArmProviderActionAsync<Request = ResourceManagementAssetReferenceData,Response = unknown,Scope = Extension.ResourceGroup,Parameters = {/**
* Name of Azure Machine Learning registry.
*/
@path
@segment("registries")
"registryName": string}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface TemporaryDataReferencesOperationGroup {

#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("TemporaryDataReferences_CreateOrGetTemporaryDataReference")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/registries/{registryName}/tempdatarefs/{name}/versions/{version}")
@put op `createOrGetTemporaryDataReference`(
        ...ApiVersionParameter,
        
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@pattern("^(?![\\-_.])[a-zA-Z0-9\\-_.]{1,255}(?<!\\.)$")
@path
"name": string,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@path
"version": string,
...SubscriptionIdParameter,
...ResourceGroupParameter,
/**
* Name of Azure Machine Learning registry.
*/
@path
"registryName": string,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@bodyRoot
"body": TemporaryDataReferenceRequestDto
        ): ArmResponse<TemporaryDataReferenceResponseDto> | ErrorResponse;



}