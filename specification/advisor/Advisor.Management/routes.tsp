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


namespace Microsoft.Advisor;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ConfigurationsOperationGroup {
@summary("Retrieve Azure Advisor configurations.")
/**
* Retrieve Azure Advisor configurations and also retrieve configurations of contained resource groups.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Configurations_ListBySubscription")
@autoRoute
@get
@action("configurations")
listBySubscription is ArmProviderActionSync<Response = ResourceListResult<ConfigData>,Scope = SubscriptionActionScope,Parameters = {}>
@summary("Create/Overwrite Azure Advisor configuration.")
/**
* Create/Overwrite Azure Advisor configuration and also delete all configurations of contained resource groups.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Configurations_CreateInSubscription")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}")
@put op `createInSubscription`(
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
/**
* Advisor configuration name. Value must be 'default'
*/
@path
"configurationName": ConfigurationName,
/**
* The Azure Advisor configuration data structure.
*/
@bodyRoot
"configContract": ConfigData
        ): ArmResponse<ConfigData> | ErrorResponse;



@summary("Retrieve Azure Advisor configurations.")
/**
* Retrieve Azure Advisor configurations.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Configurations_ListByResourceGroup")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations")
@get op `listByResourceGroup`(
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
/**
* The name of the Azure resource group.
*/
@path
"resourceGroup": string
        ): ArmResponse<ResourceListResult<ConfigData>> | ErrorResponse;



@summary("Create/Overwrite Azure Advisor configuration.")
/**
* Create/Overwrite Azure Advisor configuration.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Configurations_CreateInResourceGroup")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations/{configurationName}")
@put op `createInResourceGroup`(
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
/**
* Advisor configuration name. Value must be 'default'
*/
@path
"configurationName": ConfigurationName,
/**
* The name of the Azure resource group.
*/
@path
"resourceGroup": string,
/**
* The Azure Advisor configuration data structure.
*/
@bodyRoot
"configContract": ConfigData
        ): ArmResponse<ConfigData> | ErrorResponse;



}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface RecommendationsOperationGroup {
/**
* Initiates the recommendation generation or computation process for a subscription. This operation is asynchronous. The generated recommendations are stored in a cache in the Advisor service.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Recommendations_Generate")
@autoRoute
@action("generateRecommendations")
generate is ArmProviderActionSync<Scope = SubscriptionActionScope,Parameters = {}>
/**
* Retrieves the status of the recommendation computation or generation process. Invoke this API after calling the generation recommendation. The URI of this API is returned in the Location field of the response header.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Recommendations_GetGenerateStatus")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/generateRecommendations/{operationId}")
@get op `getGenerateStatus`(
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
/**
* The operation ID, which can be found from the Location field in the generate recommendation response header.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
@path
"operationId": string
        ): | ArmAcceptedResponse | ErrorResponse;



}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SuppressionsOperationGroup {
/**
* Retrieves the list of snoozed or dismissed suppressions for a subscription. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Suppressions_List")
@autoRoute
@get
@action("suppressions")
list is ArmProviderActionSync<Response = ResourceListResult<SuppressionContract>,Scope = SubscriptionActionScope,Parameters = {/**
* The number of suppressions per page if a paged version of this API is being used.
*/
@query("$top")
"$top"?: int32,/**
* The page-continuation token to use with a paged version of this API.
*/
@query("$skipToken")
"$skipToken"?: string}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@summary("Predicts a recommendation.")
/**
* Predicts a recommendation.
*/
@autoRoute
predict is ArmProviderActionSync<Request = PredictionRequest,Response = PredictionResponse,Scope = SubscriptionActionScope,Parameters = {}>

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AssessmentTypesOperationGroup {
@summary("Get assessment types list.")
/**
* Get list of Azure Advisor assessment types.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("AssessmentTypes_List")
@autoRoute
@get
@action("assessmentTypes")
list is ArmProviderActionSync<Response = AssessmentTypeListResult,Scope = SubscriptionActionScope,Parameters = {}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface WorkloadsOperationGroup {
@summary("Get Workloads list.")
/**
* Get list of Workloads.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Workloads_List")
@autoRoute
@get
@action("workloads")
list is ArmProviderActionSync<Response = WorkloadListResult,Scope = SubscriptionActionScope,Parameters = {}>
}