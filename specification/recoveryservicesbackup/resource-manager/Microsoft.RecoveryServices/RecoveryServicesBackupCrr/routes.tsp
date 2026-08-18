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


namespace Microsoft.RecoveryServices;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("BackupUsageSummaries_CRR")
interface BackupUsageSummariesCRROperationGroup {
/**
* Fetches the backup management usage summaries of the vault.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("BackupUsageSummariesCRR_List")
@autoRoute
@get
@action("backupUsageSummaries")
list is ArmProviderActionSync<Response = BackupManagementUsageList,Scope = Extension.ResourceGroup,Parameters = {/**
* The name of the recovery services vault.
*/
@path
@segment("vaults")
"vaultName": string,/**
* OData filter options.
*/
@query("$filter")
"$filter"?: string,/**
* skipToken Filter.
*/
@query("$skipToken")
"$skipToken"?: string}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("AadProperties")
interface AadPropertiesOperationGroup {
@summary("Fetches the AAD properties from target region BCM stamp.")
/**
* Fetches the AAD properties from target region BCM stamp.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("AadProperties_Get")
@autoRoute
@get
@action("backupAadProperties")
get is ArmProviderActionSync<Response = AADPropertiesResource,Scope = SubscriptionActionScope,Parameters = {/**
* Azure region to hit Api
*/
@path
@segment("locations")
"azureRegion": string,/**
* OData filter options.
*/
@query("$filter")
"$filter"?: string}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrossRegionRestore")
interface CrossRegionRestoreOperationGroup {
@summary("Restores the specified backed up data in a different region as compared to where the data is backed up.")
/**
* Restores the specified backed up data in a different region as compared to where the data is backed up.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("CrossRegionRestore_Trigger")
@autoRoute
@action("backupCrossRegionRestore")
trigger is ArmProviderActionAsync<Request = CrossRegionRestoreRequest,Response = void,Scope = SubscriptionActionScope,Parameters = {/**
* Azure region to hit Api
*/
@path
@segment("locations")
"azureRegion": string},LroHeaders = ArmAsyncOperationHeader<FinalResult = void> & Azure.Core.Foundations.RetryAfterHeader>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrrJobDetails")
interface BackupCrrJobDetailsOperationGroup {
@summary("Get CRR job details from target region.")
/**
* Get CRR job details from target region.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("BackupCrrJobDetails_Get")
@autoRoute
@action("backupCrrJob")
get is ArmProviderActionSync<Request = CrrJobRequest,Response = JobResource,Scope = SubscriptionActionScope,Parameters = {/**
* Azure region to hit Api
*/
@path
@segment("locations")
"azureRegion": string}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("BackupCrrJobs")
interface BackupCrrJobsOperationGroup {
@summary("Gets the list of CRR jobs from the target region.")
/**
* Gets the list of CRR jobs from the target region.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("BackupCrrJobs_List")
@autoRoute
@action("backupCrrJobs")
list is ArmProviderActionSync<Request = CrrJobRequest,Response = JobResourceList,Scope = SubscriptionActionScope,Parameters = {/**
* Azure region to hit Api
*/
@path
@segment("locations")
"azureRegion": string,/**
* OData filter options.
*/
@query("$filter")
"$filter"?: string,/**
* skipToken Filter.
*/
@query("$skipToken")
"$skipToken"?: string}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrrOperationResults")
interface CrrOperationResultsOperationGroup {

#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("CrrOperationResults_Get")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrOperationResults/{operationId}")
@get op `get`(
        ...ApiVersionParameter,
        /**
* Azure region to hit Api
*/
@path
"azureRegion": string,
...SubscriptionIdParameter,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@path
"operationId": string
        ): | OkResponse|ArmAcceptedResponse | ErrorResponse;



}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrrOperationStatus")
interface CrrOperationStatusOperationGroup {

#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("CrrOperationStatus_Get")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrOperationsStatus/{operationId}")
@get op `get`(
        ...ApiVersionParameter,
        /**
* Azure region to hit Api
*/
@path
"azureRegion": string,
...SubscriptionIdParameter,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@path
"operationId": string
        ): ArmResponse<OperationStatus> | ErrorResponse;



}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("BackupProtectedItems_Crr")
interface BackupProtectedItemsCrrOperationGroup {
/**
* Provides a pageable list of all items that are backed up within a vault.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("BackupProtectedItemsCrr_List")
@autoRoute
@get
@action("backupProtectedItems/")
list is ArmProviderActionSync<Response = ProtectedItemResourceList,Scope = Extension.ResourceGroup,Parameters = {/**
* The name of the recovery services vault.
*/
@path
@segment("vaults")
"vaultName": string,/**
* OData filter options.
*/
@query("$filter")
"$filter"?: string,/**
* skipToken Filter.
*/
@query("$skipToken")
"$skipToken"?: string}>
}