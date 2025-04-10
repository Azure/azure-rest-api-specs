import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.DesktopVirtualization;
/**
* Represents a HostPool definition.
*/
model HostPool is Azure.ResourceManager.TrackedResource<HostPoolProperties, false> {
...ResourceNameParameter<Resource = HostPool,KeyName = "hostPoolName",SegmentName = "hostPools",NamePattern = "^[A-Za-z0-9@.\\-_ ]*$">
}



@armResourceOperations
interface HostPools {
/**
* Get a host pool.
*/
get is ArmResourceRead<HostPool>;


/**
* Create or update a host pool.
*/
createOrUpdate is ArmResourceCreateOrReplaceSync<HostPool>;


/**
* Update a host pool.
*/
@patch(#{ implicitOptionality: false })
update is ArmCustomPatchSync<HostPool, PatchModel = HostPoolPatch>;


/**
* Remove a host pool.
*/
delete is ArmResourceDeleteSync<HostPool, Parameters = { /**
* Force flag to delete sessionHost.
*/
@query("force")
"force"?: boolean }>;


/**
* List hostPools.
*/
listByResourceGroup is ArmResourceListByParent<HostPool, Parameters = { /**
* Number of items per page.
*/
@query("pageSize")
"pageSize"?: int32,
/**
* Indicates whether the collection is descending.
*/
@query("isDescending")
"isDescending"?: boolean,
/**
* Initial number of items to skip.
*/
@query("initialSkip")
"initialSkip"?: int32 }, Response = ArmResponse<HostPoolList>>;


/**
* List hostPools in subscription.
*/
list is ArmListBySubscription<HostPool, Parameters = { /**
* Number of items per page.
*/
@query("pageSize")
"pageSize"?: int32,
/**
* Indicates whether the collection is descending.
*/
@query("isDescending")
"isDescending"?: boolean,
/**
* Initial number of items to skip.
*/
@query("initialSkip")
"initialSkip"?: int32 }, Response = ArmResponse<HostPoolList>>;


/**
* List the private link resources available for this hostpool.
*/
@get
@action("privateLinkResources")
@operationId("PrivateLinkResources_ListByHostPool")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listByHostPool is ArmResourceActionSync<HostPool, void, ArmResponse<ResourceListResult<PrivateLinkResource>>, Parameters = { /**
* Number of items per page.
*/
@query("pageSize")
"pageSize"?: int32,
/**
* Indicates whether the collection is descending.
*/
@query("isDescending")
"isDescending"?: boolean,
/**
* Initial number of items to skip.
*/
@query("initialSkip")
"initialSkip"?: int32 }>;


/**
* List scaling plan associated with hostpool.
*/
@get
@action("scalingPlans")
@operationId("ScalingPlans_ListByHostPool")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
scalingPlansListByHostPool is ArmResourceActionSync<HostPool, void, ArmResponse<ScalingPlanList>, Parameters = { /**
* Number of items per page.
*/
@query("pageSize")
"pageSize"?: int32,
/**
* Indicates whether the collection is descending.
*/
@query("isDescending")
"isDescending"?: boolean,
/**
* Initial number of items to skip.
*/
@query("initialSkip")
"initialSkip"?: int32 }>;


/**
* Registration token of the host pool.
*/
retrieveRegistrationToken is ArmResourceActionSync<HostPool, void, ArmResponse<RegistrationInfo>>;


/**
* Operation to list the RegistrationTokens associated with the HostPool.
*/
listRegistrationTokens is ArmResourceActionSync<HostPool, void, ArmResponse<RegistrationTokenList>>;


/**
* List userSessions.
*/
@get
@action("userSessions")
@operationId("UserSessions_ListByHostPool")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
userSessionsListByHostPool is ArmResourceActionSync<HostPool, void, ArmResponse<UserSessionList>, Parameters = { /**
* OData filter expression. Valid properties for filtering are userprincipalname and sessionstate.
*/
@query("$filter")
"$filter"?: string,
/**
* Number of items per page.
*/
@query("pageSize")
"pageSize"?: int32,
/**
* Indicates whether the collection is descending.
*/
@query("isDescending")
"isDescending"?: boolean,
/**
* Initial number of items to skip.
*/
@query("initialSkip")
"initialSkip"?: int32 }>;


/**
* Gets information from a package given the path to the package.
*/
@action("importAppAttachPackageInfo")
@operationId("AppAttachPackageInfo_Import")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
import is ArmResourceActionSync<HostPool, ImportPackageInfoRequest, ArmResponse<AppAttachPackageList>>;


/**
* Expands and Lists MSIX packages in an Image, given the Image Path.
*/
@action("expandMsixImage")
@operationId("MsixImages_Expand")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
expand is ArmResourceActionSync<HostPool, MsixImageURI, ArmResponse<ExpandMsixImageList>>;


}


@@maxLength(HostPool.name, 255)
@@minLength(HostPool.name, 1)
@@doc(HostPool.name, "The name of the host pool within the specified resource group")
@@doc(HostPool.properties, "Detailed properties for HostPool")
@@doc(HostPools.`createOrUpdate`::parameters.resource, "Object containing HostPool definitions.");
@@doc(HostPools.`update`::parameters.properties, "Object containing HostPool definitions.");
@@doc(HostPools.`import`::parameters.body, "Object containing URI to package image and other optional properties");
@@doc(HostPools.`expand`::parameters.body, "Object containing URI to MSIX Image");