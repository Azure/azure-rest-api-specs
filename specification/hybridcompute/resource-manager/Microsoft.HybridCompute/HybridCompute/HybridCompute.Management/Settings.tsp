import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.HybridCompute;

model Settings is Azure.ResourceManager.ProxyResource<SettingsProperties> {
...ResourceNameParameter<Resource = Settings,KeyName = "settingsResourceName",SegmentName = "settings",NamePattern = "default">
}



alias {baseResourceType}ExternalResource = Extension.ExternalResource<"{baseProvider}"
      , "{baseResourceType}", "{baseResourceName}">;
      
@armResourceOperations
interface SettingsOperationGroup {
/**
* Returns the base Settings for the target resource.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Settings_Get")
get is ArmResourceRead<Settings, Parameters = { /**
* The name of the base Resource Type.
*/
@pattern("[a-zA-Z0-9-_\\.]+")
@path
"baseResourceType": string }
        >;


/**
* Updates the base Settings of the target resource.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Settings_Update")
update is ArmResourceCreateOrReplaceSync<Settings, Parameters = { /**
* The name of the base Resource Type.
*/
@pattern("[a-zA-Z0-9-_\\.]+")
@path
"baseResourceType": string }
        >;


/**
* Update the base Settings of the target resource.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Settings_Patch")
@patch(#{ implicitOptionality: false })
patch is ArmCustomPatchSync<Settings, PatchModel = Settings, Parameters = { /**
* The name of the base Resource Type.
*/
@pattern("[a-zA-Z0-9-_\\.]+")
@path
"baseResourceType": string }
        >;


}


@@doc(Settings.name, "The name of the settings resource.")
@@doc(Settings.properties, "Settings properties")
@@doc(SettingsOperationGroup.`update`::parameters.resource, "Settings details");
@@doc(SettingsOperationGroup.`patch`::parameters.properties, "Settings details");