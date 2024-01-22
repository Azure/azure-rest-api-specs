import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;


namespace Microsoft.CertificateRegistration;



interface AppServiceCertificateOrdersOperations {
@summary("Validate information for a certificate order.")
/**
* Description for Validate information for a certificate order.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.CertificateRegistration/validateCertificateRegistrationInformation")
@post op `validatePurchaseInformation` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Information for a certificate order.
*/
@body
"appServiceCertificateOrder": AppServiceCertificateOrder}, void>;



}

interface DomainsOperations {
@summary("Check if a domain is available for registration.")
/**
* Description for Check if a domain is available for registration.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/checkDomainAvailability")
@post op `checkAvailability` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Name of the domain.
*/
@body
"identifier": NameIdentifier}, DomainAvailabilityCheckResult>;



@summary("Generate a single sign-on request for the domain management portal.")
/**
* Description for Generate a single sign-on request for the domain management portal.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/generateSsoRequest")
@post op `getControlCenterSsoRequest` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DomainControlCenterSsoRequest>;



@summary("Get domain name recommendations based on keywords.")
/**
* Description for Get domain name recommendations based on keywords.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/listDomainRecommendations")
@post op `listRecommendations` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Search parameters for domain name recommendations.
*/
@body
"parameters": DomainRecommendationSearchParameters}, NameIdentifierCollection>;



}

interface AppServiceEnvironmentsOperations {
@summary("Get all worker pools of an App Service Environment.")
/**
* Description for Get all worker pools of an App Service Environment.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools")
@get op `listWorkerPools` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<WorkerPoolResource>>;



@summary("Get properties of a worker pool.")
/**
* Description for Get properties of a worker pool.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
@get op `getWorkerPool` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, WorkerPoolResource>;



@summary("Create or update a worker pool.")
/**
* Description for Create or update a worker pool.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
@put op `createOrUpdateWorkerPool` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the worker pool.
*/
@body
"workerPoolEnvelope": WorkerPoolResource}, WorkerPoolResource>;



@summary("Create or update a worker pool.")
/**
* Description for Create or update a worker pool.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
@patch op `updateWorkerPool` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the worker pool.
*/
@body
"workerPoolEnvelope": WorkerPoolResource}, WorkerPoolResource>;



@summary("Get metric definitions for a specific instance of a worker pool of an App Service Environment.")
/**
* Description for Get metric definitions for a specific instance of a worker pool of an App Service Environment.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/instances/{instance}/metricdefinitions")
@get op `listWorkerPoolInstanceMetricDefinitions` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Name of the instance in the worker pool.
*/
@path
"instance": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceMetricDefinitionCollection>;



@summary("Get metric definitions for a worker pool of an App Service Environment.")
/**
* Description for Get metric definitions for a worker pool of an App Service Environment.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/metricdefinitions")
@get op `listWebWorkerMetricDefinitions` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceMetricDefinitionCollection>;



@summary("Get available SKUs for scaling a worker pool.")
/**
* Description for Get available SKUs for scaling a worker pool.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/skus")
@get op `listWorkerPoolSkus` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SkuInfoCollection>;



@summary("Get usage metrics for a worker pool of an App Service Environment.")
/**
* Description for Get usage metrics for a worker pool of an App Service Environment.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/usages")
@get op `listWebWorkerUsages` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the App Service Environment.
*/
@path
"name": string
/**
* Name of the worker pool.
*/
@path
"workerPoolName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, UsageCollection>;



}

interface DiagnosticsOperations {
@summary("List Hosting Environment Detector Responses")
/**
* Description for List Hosting Environment Detector Responses
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/detectors")
@get op `listHostingEnvironmentDetectorResponses` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<DetectorResponse>>;



@summary("Get Hosting Environment Detector Response")
/**
* Description for Get Hosting Environment Detector Response
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/detectors/{detectorName}")
@get op `getHostingEnvironmentDetectorResponse` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* App Service Environment Name
*/
@path
"name": string
/**
* Detector Resource Name
*/
@path
"detectorName": string
/**
* Start Time
*/
@query("startTime")
"startTime"?: utcDateTime
/**
* End Time
*/
@query("endTime")
"endTime"?: utcDateTime
/**
* Time Grain
*/
@pattern("PT[1-9][0-9]+[SMH]")
@query("timeGrain")
"timeGrain"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DetectorResponse>;



@summary("List Site Detector Responses")
/**
* Description for List Site Detector Responses
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/detectors")
@get op `listSiteDetectorResponses` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<DetectorResponse>>;



@summary("Get site detector response")
/**
* Description for Get site detector response
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/detectors/{detectorName}")
@get op `getSiteDetectorResponse` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Detector Resource Name
*/
@path
"detectorName": string
/**
* Start Time
*/
@query("startTime")
"startTime"?: utcDateTime
/**
* End Time
*/
@query("endTime")
"endTime"?: utcDateTime
/**
* Time Grain
*/
@pattern("PT[1-9][0-9]+[SMH]")
@query("timeGrain")
"timeGrain"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DetectorResponse>;



@summary("List Site Detector Responses")
/**
* Description for List Site Detector Responses
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/detectors")
@get op `listSiteDetectorResponsesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<DetectorResponse>>;



@summary("Get site detector response")
/**
* Description for Get site detector response
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/detectors/{detectorName}")
@get op `getSiteDetectorResponseSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Detector Resource Name
*/
@path
"detectorName": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Start Time
*/
@query("startTime")
"startTime"?: utcDateTime
/**
* End Time
*/
@query("endTime")
"endTime"?: utcDateTime
/**
* Time Grain
*/
@pattern("PT[1-9][0-9]+[SMH]")
@query("timeGrain")
"timeGrain"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DetectorResponse>;



@summary("Get Diagnostics Categories")
/**
* Description for Get Diagnostics Categories
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics")
@get op `listSiteDiagnosticCategoriesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<DiagnosticCategory>>;



@summary("Get Diagnostics Category")
/**
* Description for Get Diagnostics Category
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}")
@get op `getSiteDiagnosticCategorySlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Diagnostic Category
*/
@path
"diagnosticCategory": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DiagnosticCategory>;



@summary("Get Site Analyses")
/**
* Description for Get Site Analyses
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses")
@get op `listSiteAnalysesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Diagnostic Category
*/
@path
"diagnosticCategory": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<AnalysisDefinition>>;



@summary("Get Site Analysis")
/**
* Description for Get Site Analysis
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}")
@get op `getSiteAnalysisSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Diagnostic Category
*/
@path
"diagnosticCategory": string
/**
* Analysis Name
*/
@path
"analysisName": string
/**
* Slot - optional
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, AnalysisDefinition>;



@summary("Execute Analysis")
/**
* Description for Execute Analysis
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}/execute")
@post op `executeSiteAnalysisSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Category Name
*/
@path
"diagnosticCategory": string
/**
* Analysis Resource Name
*/
@path
"analysisName": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Start Time
*/
@query("startTime")
"startTime"?: utcDateTime
/**
* End Time
*/
@query("endTime")
"endTime"?: utcDateTime
/**
* Time Grain
*/
@pattern("PT[1-9][0-9]+[SMH]")
@query("timeGrain")
"timeGrain"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DiagnosticAnalysis>;



@summary("Get Detectors")
/**
* Description for Get Detectors
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors")
@get op `listSiteDetectorsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Diagnostic Category
*/
@path
"diagnosticCategory": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<DetectorDefinitionResource>>;



@summary("Get Detector")
/**
* Description for Get Detector
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors/{detectorName}")
@get op `getSiteDetectorSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Diagnostic Category
*/
@path
"diagnosticCategory": string
/**
* Detector Name
*/
@path
"detectorName": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DetectorDefinitionResource>;



@summary("Execute Detector")
/**
* Description for Execute Detector
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors/{detectorName}/execute")
@post op `executeSiteDetectorSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site Name
*/
@path
"siteName": string
/**
* Detector Resource Name
*/
@path
"detectorName": string
/**
* Category Name
*/
@path
"diagnosticCategory": string
/**
* Slot Name
*/
@path
"slot": string
/**
* Start Time
*/
@query("startTime")
"startTime"?: utcDateTime
/**
* End Time
*/
@query("endTime")
"endTime"?: utcDateTime
/**
* Time Grain
*/
@pattern("PT[1-9][0-9]+[SMH]")
@query("timeGrain")
"timeGrain"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DiagnosticDetectorResponse>;



}

interface ProviderOperations {
@summary("Get available application frameworks and their versions")
/**
* Description for Get available application frameworks and their versions
*/
@route("/providers/Microsoft.Web/availableStacks")
@get op `getAvailableStacks` is Azure.Core.Foundations.Operation<{
@query("osTypeSelected")
"osTypeSelected"?: ProviderOsTypeSelected}, ApplicationStackCollection>;



@summary("Get available Function app frameworks and their versions")
/**
* Description for Get available Function app frameworks and their versions
*/
@route("/providers/Microsoft.Web/functionAppStacks")
@get op `getFunctionAppStacks` is Azure.Core.Foundations.Operation<{/**
* Stack OS Type
*/
@query("stackOsType")
"stackOsType"?: ProviderStackOsType}, FunctionAppStackCollection>;



@summary("Get available Function app frameworks and their versions for location")
/**
* Description for Get available Function app frameworks and their versions for location
*/
@route("/providers/Microsoft.Web/locations/{location}/functionAppStacks")
@get op `getFunctionAppStacksForLocation` is Azure.Core.Foundations.Operation<{/**
* Function App stack location.
*/
@path
"location": string
/**
* Stack OS Type
*/
@query("stackOsType")
"stackOsType"?: ProviderStackOsType}, FunctionAppStackCollection>;



@summary("Get available Web app frameworks and their versions for location")
/**
* Description for Get available Web app frameworks and their versions for location
*/
@route("/providers/Microsoft.Web/locations/{location}/webAppStacks")
@get op `getWebAppStacksForLocation` is Azure.Core.Foundations.Operation<{/**
* Web App stack location.
*/
@path
"location": string
/**
* Stack OS Type
*/
@query("stackOsType")
"stackOsType"?: ProviderStackOsType}, WebAppStackCollection>;



@summary("Get available Web app frameworks and their versions")
/**
* Description for Get available Web app frameworks and their versions
*/
@route("/providers/Microsoft.Web/webAppStacks")
@get op `getWebAppStacks` is Azure.Core.Foundations.Operation<{/**
* Stack OS Type
*/
@query("stackOsType")
"stackOsType"?: ProviderStackOsType}, WebAppStackCollection>;



@summary("Get available application frameworks and their versions")
/**
* Description for Get available application frameworks and their versions
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/availableStacks")
@get op `getAvailableStacksOnPrem` is Azure.Core.Foundations.Operation<{
@query("osTypeSelected")
"osTypeSelected"?: ProviderOsTypeSelected
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ApplicationStackCollection>;



}

interface RecommendationsOperations {
@summary("List all recommendations for a subscription.")
/**
* Description for List all recommendations for a subscription.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations")
@get op `list` is Azure.Core.Foundations.Operation<{/**
* Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
*/
@query("featured")
"featured"?: boolean
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
*/
@query("$filter")
"$filter"?: string}, RecommendationCollection>;



@summary("Reset all recommendation opt-out settings for a subscription.")
/**
* Description for Reset all recommendation opt-out settings for a subscription.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/reset")
@post op `resetAllFilters` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Disables the specified rule so it will not apply to a subscription in the future.")
/**
* Description for Disables the specified rule so it will not apply to a subscription in the future.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/{name}/disable")
@post op `disableRecommendationForSubscription` is Azure.Core.Foundations.Operation<{/**
* Rule name
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get a recommendation rule for an app.")
/**
* Description for Get a recommendation rule for an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}")
@get op `getRuleDetailsByWebApp` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"siteName": string
/**
* Name of the recommendation.
*/
@path
"name": string
/**
* Specify <code>true</code> to update the last-seen timestamp of the recommendation object.
*/
@query("updateSeen")
"updateSeen"?: boolean
/**
* The GUID of the recommendation object if you query an expired one. You don't need to specify it to query an active entry.
*/
@query("recommendationId")
"recommendationId"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, RecommendationRule>;



@summary("Disables the specific rule for a web site permanently.")
/**
* Description for Disables the specific rule for a web site permanently.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}/disable")
@post op `disableRecommendationForSite` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name
*/
@path
"siteName": string
/**
* Rule name
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



}

interface ResourceHealthMetadataOperations {
@summary("List all ResourceHealthMetadata for all sites in the subscription.")
/**
* Description for List all ResourceHealthMetadata for all sites in the subscription.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/resourceHealthMetadata")
@get op `list` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ResourceHealthMetadata>>;



@summary("List all ResourceHealthMetadata for all sites in the resource group in the subscription.")
/**
* Description for List all ResourceHealthMetadata for all sites in the resource group in the subscription.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/resourceHealthMetadata")
@get op `listByResourceGroup` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ResourceHealthMetadata>>;



@summary("Gets the category of ResourceHealthMetadata to use for the given site as a collection")
/**
* Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resourceHealthMetadata")
@get op `listBySiteSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ResourceHealthMetadata>>;



@summary("Gets the category of ResourceHealthMetadata to use for the given site")
/**
* Description for Gets the category of ResourceHealthMetadata to use for the given site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resourceHealthMetadata/default")
@get op `getBySiteSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceHealthMetadata>;



}

@summary("Gets a list of meters for a given location.")
/**
* Description for Gets a list of meters for a given location.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/billingMeters")
@get op `listBillingMeters` is Azure.Core.Foundations.Operation<{/**
* Azure Location of billable resource
*/
@query("billingLocation")
"billingLocation"?: string
/**
* App Service OS type meters used for
*/
@query("osType")
"osType"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, BillingMeterCollection>;



@summary("Check if a resource name is available.")
/**
* Description for Check if a resource name is available.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/checknameavailability")
@post op `checkNameAvailability` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Name availability request.
*/
@body
"request": ResourceNameAvailabilityRequest}, ResourceNameAvailability>;



@summary("Gets list of available geo regions plus ministamps")
/**
* Description for Gets list of available geo regions plus ministamps
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/deploymentLocations")
@get op `getSubscriptionDeploymentLocations` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, DeploymentLocations>;



@summary("Get a list of available geographical regions.")
/**
* Description for Get a list of available geographical regions.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/geoRegions")
@get op `listGeoRegions` is Azure.Core.Foundations.Operation<{/**
* Name of SKU used to filter the regions.
*/
@query("sku")
"sku"?: SkuName
/**
* Specify <code>true</code> if you want to filter to only regions that support Linux workers.
*/
@query("linuxWorkersEnabled")
"linuxWorkersEnabled"?: boolean
/**
* Specify <code>true</code> if you want to filter to only regions that support Xenon workers.
*/
@query("xenonWorkersEnabled")
"xenonWorkersEnabled"?: boolean
/**
* Specify <code>true</code> if you want to filter to only regions that support Linux Consumption Workers.
*/
@query("linuxDynamicWorkersEnabled")
"linuxDynamicWorkersEnabled"?: boolean
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, GeoRegionCollection>;



@summary("List all apps that are assigned to a hostname.")
/**
* Description for List all apps that are assigned to a hostname.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/listSitesAssignedToHostName")
@post op `listSiteIdentifiersAssignedToHostName` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Hostname information.
*/
@body
"nameIdentifier": NameIdentifier}, ResourceListResult<Identifier>>;



@summary("List all premier add-on offers.")
/**
* Description for List all premier add-on offers.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/premieraddonoffers")
@get op `listPremierAddOnOffers` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PremierAddOnOfferCollection>;



@summary("List all SKUs.")
/**
* Description for List all SKUs.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/skus")
@get op `listSkus` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SkuInfos>;



@summary("Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.")
/**
* Description for Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/verifyHostingEnvironmentVnet")
@post op `verifyHostingEnvironmentVnet` is Azure.Core.Foundations.Operation<{/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* VNET information
*/
@body
"parameters": VnetParameters}, VnetValidationFailureDetails>;



@summary("Validate if a resource can be created.")
/**
* Description for Validate if a resource can be created.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/validate")
@post op `validate` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Request with the resources to validate.
*/
@body
"validateRequest": ValidateRequest}, ValidateResponse>;




interface StaticSitesOperations {
@summary("Generates a preview workflow file for the static site")
/**
* Description for Generates a preview workflow file for the static site
*/
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/locations/{location}/previewStaticSiteWorkflowFile")
@post op `previewWorkflow` is Azure.Core.Foundations.Operation<{/**
* Location where you plan to create the static site.
*/
@path
"location": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the StaticSitesWorkflowPreviewRequest properties. See example.
*/
@body
"staticSitesWorkflowPreviewRequest": StaticSitesWorkflowPreviewRequest}, StaticSitesWorkflowPreview>;



@summary("Gets the list of private endpoint connections associated with a static site")
/**
* Description for Gets the list of private endpoint connections associated with a static site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections")
@get op `getPrivateEndpointConnectionList` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<RemotePrivateEndpointConnectionARMResource>>;



@summary("Gets a private endpoint connection")
/**
* Description for Gets a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
@get op `getPrivateEndpointConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Name of the private endpoint connection.
*/
@path
"privateEndpointConnectionName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, RemotePrivateEndpointConnectionARMResource>;



@summary("Approves or rejects a private endpoint connection")
/**
* Description for Approves or rejects a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
@put op `approveOrRejectPrivateEndpointConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Name of the private endpoint connection.
*/
@path
"privateEndpointConnectionName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Request body.
*/
@body
"privateEndpointWrapper": PrivateLinkConnectionApprovalRequestResource}, RemotePrivateEndpointConnectionARMResource>;



@summary("Deletes a private endpoint connection")
/**
* Description for Deletes a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
@delete op `deletePrivateEndpointConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Name of the private endpoint connection.
*/
@path
"privateEndpointConnectionName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the details of the user provided function apps registered with a static site")
/**
* Description for Gets the details of the user provided function apps registered with a static site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps")
@get op `getUserProvidedFunctionAppsForStaticSite` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<StaticSiteUserProvidedFunctionAppARMResource>>;



@summary("Gets the details of the user provided function app registered with a static site")
/**
* Description for Gets the details of the user provided function app registered with a static site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
@get op `getUserProvidedFunctionAppForStaticSite` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Name of the function app registered with the static site.
*/
@path
"functionAppName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, StaticSiteUserProvidedFunctionAppARMResource>;



@summary("Register a user provided function app with a static site")
/**
* Description for Register a user provided function app with a static site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
@put op `registerUserProvidedFunctionAppWithStaticSite` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Name of the function app to register with the static site.
*/
@path
"functionAppName": string
/**
* Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.
*/
@query("isForced")
"isForced"?: boolean
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the user provided function app properties. See example.
*/
@body
"staticSiteUserProvidedFunctionEnvelope": StaticSiteUserProvidedFunctionAppARMResource}, StaticSiteUserProvidedFunctionAppARMResource>;



@summary("Detach the user provided function app from the static site")
/**
* Description for Detach the user provided function app from the static site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
@delete op `detachUserProvidedFunctionAppFromStaticSite` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the static site.
*/
@path
"name": string
/**
* Name of the function app registered with the static site.
*/
@path
"functionAppName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



}

interface WebAppsOperations {
@summary("Returns whether Scm basic auth is allowed on the site or not.")
/**
* Description for Returns whether Scm basic auth is allowed on the site or not.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/basicPublishingCredentialsPolicies/scm")
@get op `getScmAllowed` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, CsmPublishingCredentialsPoliciesEntity>;



@summary("Updates whether user publishing credentials are allowed on the site or not.")
/**
* Description for Updates whether user publishing credentials are allowed on the site or not.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/basicPublishingCredentialsPolicies/scm")
@put op `updateScmAllowed` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string

@body
"csmPublishingAccessPoliciesEntity": CsmPublishingCredentialsPoliciesEntity}, CsmPublishingCredentialsPoliciesEntity>;



@summary("Gets the config reference app settings and status of an app")
/**
* Description for Gets the config reference app settings and status of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/configreferences/connectionstrings")
@get op `getSiteConnectionStringKeyVaultReferences` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ApiKVReference>>;



@summary("Gets the config reference and status of an app")
/**
* Description for Gets the config reference and status of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/configreferences/connectionstrings/{connectionStringKey}")
@get op `getSiteConnectionStringKeyVaultReference` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"connectionStringKey": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ApiKVReference>;



@summary("Gets a snapshot of the configuration of an app at a previous point in time.")
/**
* Description for Gets a snapshot of the configuration of an app at a previous point in time.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}")
@get op `getConfigurationSnapshot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* The ID of the snapshot to read.
*/
@path
"snapshotId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteConfig>;



@summary("Reverts the configuration of an app to a previous snapshot.")
/**
* Description for Reverts the configuration of an app to a previous snapshot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}/recover")
@post op `recoverSiteConfigurationSnapshot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* The ID of the snapshot to read.
*/
@path
"snapshotId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
/**
* Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@get op `getHybridConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, HybridConnection>;



@summary("Creates a new Hybrid Connection using a Service Bus relay.")
/**
* Description for Creates a new Hybrid Connection using a Service Bus relay.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@put op `createOrUpdateHybridConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The details of the hybrid connection.
*/
@body
"connectionEnvelope": HybridConnection}, HybridConnection>;



@summary("Removes a Hybrid Connection from this site.")
/**
* Description for Removes a Hybrid Connection from this site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@delete op `deleteHybridConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Creates a new Hybrid Connection using a Service Bus relay.")
/**
* Description for Creates a new Hybrid Connection using a Service Bus relay.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@patch op `updateHybridConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The details of the hybrid connection.
*/
@body
"connectionEnvelope": HybridConnection}, HybridConnection>;



@summary("Get the status of the last MSDeploy operation.")
/**
* Description for Get the status of the last MSDeploy operation.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy")
@get op `getInstanceMsDeployStatus` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* ID of web app instance.
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, MSDeployStatus>;



@summary("Invoke the MSDeploy web app extension.")
/**
* Description for Invoke the MSDeploy web app extension.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy")
@put op `createInstanceMSDeployOperation` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* ID of web app instance.
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Details of MSDeploy operation
*/
@body
"MSDeploy": MSDeploy}, MSDeployStatus>;



@summary("Get the MSDeploy Log for the last MSDeploy operation.")
/**
* Description for Get the MSDeploy Log for the last MSDeploy operation.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy/log")
@get op `getInstanceMSDeployLog` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* ID of web app instance.
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, MSDeployLog>;



@summary("Gets the list of private endpoint connections associated with a site")
/**
* Description for Gets the list of private endpoint connections associated with a site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections")
@get op `getPrivateEndpointConnectionList` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<RemotePrivateEndpointConnectionARMResource>>;



@summary("Gets a private endpoint connection")
/**
* Description for Gets a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
@get op `getPrivateEndpointConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string
/**
* Name of the private endpoint connection.
*/
@path
"privateEndpointConnectionName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, RemotePrivateEndpointConnectionARMResource>;



@summary("Approves or rejects a private endpoint connection")
/**
* Description for Approves or rejects a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
@put op `approveOrRejectPrivateEndpointConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string

@path
"privateEndpointConnectionName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string

@body
"privateEndpointWrapper": PrivateLinkConnectionApprovalRequestResource}, RemotePrivateEndpointConnectionARMResource>;



@summary("Deletes a private endpoint connection")
/**
* Description for Deletes a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
@delete op `deletePrivateEndpointConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string

@path
"privateEndpointConnectionName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
/**
* Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes")
@get op `listProcesses` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ProcessInfo>>;



@summary("Get process information by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get process information by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}")
@get op `getProcess` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessInfo>;



@summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
/**
* Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}")
@delete op `deleteProcess` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/dump")
@get op `getProcessDump` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/modules")
@get op `listProcessModules` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ProcessModuleInfo>>;



@summary("Get process information by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get process information by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/modules/{baseAddress}")
@get op `getProcessModule` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Module base address.
*/
@path
"baseAddress": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessModuleInfo>;



@summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/threads")
@get op `listProcessThreads` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessThreadInfoCollection>;



@summary("Gets an app's deployment slots.")
/**
* Description for Gets an app's deployment slots.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots")
@get op `listSlots` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<Site>>;



@summary("Gets the details of a web, mobile, or API app.")
/**
* Description for Gets the details of a web, mobile, or API app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
@get op `getSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. By default, this API returns the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, Site>;



@summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
/**
* Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
@put op `createOrUpdateSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Unique name of the app to create or update. To create or update a deployment slot, use the {slot} parameter.
*/
@path
"name": string
/**
* Name of the deployment slot to create or update. By default, this API attempts to create or modify the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the app properties. See example.
*/
@body
"siteEnvelope": Site}, Site>;



@summary("Deletes a web, mobile, or API app, or one of the deployment slots.")
/**
* Description for Deletes a web, mobile, or API app, or one of the deployment slots.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
@delete op `deleteSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app to delete.
*/
@path
"name": string
/**
* Name of the deployment slot to delete. By default, the API deletes the production slot.
*/
@path
"slot": string
/**
* If true, web app metrics are also deleted.
*/
@query("deleteMetrics")
"deleteMetrics"?: boolean
/**
* Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.
*/
@query("deleteEmptyServerFarm")
"deleteEmptyServerFarm"?: boolean
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
/**
* Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
@patch op `updateSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Unique name of the app to create or update. To create or update a deployment slot, use the {slot} parameter.
*/
@path
"name": string
/**
* Name of the deployment slot to create or update. By default, this API attempts to create or modify the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the app properties. See example.
*/
@body
"siteEnvelope": SitePatchResource}, Site>;



@summary("Analyze a custom hostname.")
/**
* Description for Analyze a custom hostname.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/analyzeCustomHostname")
@get op `analyzeCustomHostnameSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Custom hostname.
*/
@query("hostName")
"hostName"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, CustomHostnameAnalysisResult>;



@summary("Applies the configuration settings from the target slot onto the current slot.")
/**
* Description for Applies the configuration settings from the target slot onto the current slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/applySlotConfig")
@post op `applySlotConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the source slot. If a slot is not specified, the production slot is used as the source slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON object that contains the target slot name. See example.
*/
@body
"slotSwapEntity": CsmSlotEntity}, void>;



@summary("Creates a backup of an app.")
/**
* Description for Creates a backup of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backup")
@post op `backupSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will create a backup for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Backup configuration. You can use the JSON response from the POST action as input here.
*/
@body
"request": BackupRequest}, BackupItem>;



@summary("Gets existing backups of an app.")
/**
* Description for Gets existing backups of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups")
@get op `listBackupsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get backups of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<BackupItem>>;



@summary("Gets a backup of an app by its ID.")
/**
* Description for Gets a backup of an app by its ID.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}")
@get op `getBackupStatusSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* ID of the backup.
*/
@path
"backupId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get a backup of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, BackupItem>;



@summary("Deletes a backup of an app by its ID.")
/**
* Description for Deletes a backup of an app by its ID.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}")
@delete op `deleteBackupSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* ID of the backup.
*/
@path
"backupId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete a backup of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
/**
* Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/list")
@post op `listBackupStatusSecretsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* ID of backup.
*/
@path
"backupId": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Information on backup request.
*/
@body
"request": BackupRequest}, BackupItem>;



@summary("Restores a specific backup to another app (or deployment slot, if specified).")
/**
* Description for Restores a specific backup to another app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/restore")
@post op `restoreSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* ID of the backup.
*/
@path
"backupId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will restore a backup of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Information on restore request .
*/
@body
"request": RestoreRequest}, void>;



@summary("Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
/**
* Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies")
@get op `listBasicPublishingCredentialsPoliciesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<CsmPublishingCredentialsPoliciesEntity>>;



@summary("Returns whether FTP is allowed on the site or not.")
/**
* Description for Returns whether FTP is allowed on the site or not.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/ftp")
@get op `getFtpAllowedSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, CsmPublishingCredentialsPoliciesEntity>;



@summary("Updates whether FTP is allowed on the site or not.")
/**
* Description for Updates whether FTP is allowed on the site or not.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/ftp")
@put op `updateFtpAllowedSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string

@body
"csmPublishingAccessPoliciesEntity": CsmPublishingCredentialsPoliciesEntity}, CsmPublishingCredentialsPoliciesEntity>;



@summary("Returns whether Scm basic auth is allowed on the site or not.")
/**
* Description for Returns whether Scm basic auth is allowed on the site or not.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/scm")
@get op `getScmAllowedSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, CsmPublishingCredentialsPoliciesEntity>;



@summary("Updates whether user publishing credentials are allowed on the site or not.")
/**
* Description for Updates whether user publishing credentials are allowed on the site or not.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/scm")
@put op `updateScmAllowedSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string

@body
"csmPublishingAccessPoliciesEntity": CsmPublishingCredentialsPoliciesEntity}, CsmPublishingCredentialsPoliciesEntity>;



@summary("List the configurations of an app")
/**
* Description for List the configurations of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config")
@get op `listConfigurationsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<SiteConfig>>;



@summary("Replaces the application settings of an app.")
/**
* Description for Replaces the application settings of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/appsettings")
@put op `updateApplicationSettingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the application settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Application settings of the app.
*/
@body
"appSettings": StringDictionary}, StringDictionary>;



@summary("Gets the application settings of an app.")
/**
* Description for Gets the application settings of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/appsettings/list")
@post op `listApplicationSettingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the application settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, StringDictionary>;



@summary("Updates the Authentication / Authorization settings associated with web app.")
/**
* Description for Updates the Authentication / Authorization settings associated with web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettings")
@put op `updateAuthSettingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Auth settings associated with web app.
*/
@body
"siteAuthSettings": SiteAuthSettings}, SiteAuthSettings>;



@summary("Gets the Authentication/Authorization settings of an app.")
/**
* Description for Gets the Authentication/Authorization settings of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettings/list")
@post op `getAuthSettingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteAuthSettings>;



@summary("Updates site's Authentication / Authorization settings for apps via the V2 format")
/**
* Description for Updates site's Authentication / Authorization settings for apps via the V2 format
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettingsV2")
@put op `updateAuthSettingsV2Slot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Auth settings associated with web app.
*/
@body
"siteAuthSettingsV2": SiteAuthSettingsV2}, SiteAuthSettingsV2>;



@summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
/**
* Description for Gets site's Authentication / Authorization settings for apps via the V2 format
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettingsV2/list")
@get op `getAuthSettingsV2Slot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteAuthSettingsV2>;



@summary("Updates the Azure storage account configurations of an app.")
/**
* Description for Updates the Azure storage account configurations of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/azurestorageaccounts")
@put op `updateAzureStorageAccountsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the Azure storage account configurations for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Azure storage accounts of the app.
*/
@body
"azureStorageAccounts": AzureStoragePropertyDictionaryResource}, AzureStoragePropertyDictionaryResource>;



@summary("Gets the Azure storage account configurations of an app.")
/**
* Description for Gets the Azure storage account configurations of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/azurestorageaccounts/list")
@post op `listAzureStorageAccountsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the Azure storage account configurations for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, AzureStoragePropertyDictionaryResource>;



@summary("Updates the backup configuration of an app.")
/**
* Description for Updates the backup configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup")
@put op `updateBackupConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the backup configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Edited backup configuration.
*/
@body
"request": BackupRequest}, BackupRequest>;



@summary("Deletes the backup configuration of an app.")
/**
* Description for Deletes the backup configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup")
@delete op `deleteBackupConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the backup configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the backup configuration of an app.")
/**
* Description for Gets the backup configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup/list")
@post op `getBackupConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the backup configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, BackupRequest>;



@summary("Gets the config reference app settings and status of an app")
/**
* Description for Gets the config reference app settings and status of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/appsettings")
@get op `getAppSettingsKeyVaultReferencesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ApiKVReference>>;



@summary("Gets the config reference and status of an app")
/**
* Description for Gets the config reference and status of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/appsettings/{appSettingKey}")
@get op `getAppSettingKeyVaultReferenceSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* App Setting key name.
*/
@path
"appSettingKey": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ApiKVReference>;



@summary("Gets the config reference app settings and status of an app")
/**
* Description for Gets the config reference app settings and status of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/connectionstrings")
@get op `getSiteConnectionStringKeyVaultReferencesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ApiKVReference>>;



@summary("Gets the config reference and status of an app")
/**
* Description for Gets the config reference and status of an app
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/connectionstrings/{connectionStringKey}")
@get op `getSiteConnectionStringKeyVaultReferenceSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"connectionStringKey": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ApiKVReference>;



@summary("Replaces the connection strings of an app.")
/**
* Description for Replaces the connection strings of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/connectionstrings")
@put op `updateConnectionStringsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the connection settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Connection strings of the app or deployment slot. See example.
*/
@body
"connectionStrings": ConnectionStringDictionary}, ConnectionStringDictionary>;



@summary("Gets the connection strings of an app.")
/**
* Description for Gets the connection strings of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/connectionstrings/list")
@post op `listConnectionStringsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the connection settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ConnectionStringDictionary>;



@summary("Gets the logging configuration of an app.")
/**
* Description for Gets the logging configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/logs")
@get op `getDiagnosticLogsConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the logging configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteLogsConfig>;



@summary("Updates the logging configuration of an app.")
/**
* Description for Updates the logging configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/logs")
@put op `updateDiagnosticLogsConfigSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the logging configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A SiteLogsConfig JSON object that contains the logging configuration to change in the "properties" property.
*/
@body
"siteLogsConfig": SiteLogsConfig}, SiteLogsConfig>;



@summary("Replaces the metadata of an app.")
/**
* Description for Replaces the metadata of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/metadata")
@put op `updateMetadataSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the metadata for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Edited metadata of the app or deployment slot. See example.
*/
@body
"metadata": StringDictionary}, StringDictionary>;



@summary("Gets the metadata of an app.")
/**
* Description for Gets the metadata of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/metadata/list")
@post op `listMetadataSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the metadata for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, StringDictionary>;



@summary("Gets the Git/FTP publishing credentials of an app.")
/**
* Description for Gets the Git/FTP publishing credentials of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/publishingcredentials/list")
@post op `listPublishingCredentialsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the publishing credentials for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, User>;



@summary("Updates the Push settings associated with web app.")
/**
* Description for Updates the Push settings associated with web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/pushsettings")
@put op `updateSitePushSettingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Push settings associated with web app.
*/
@body
"pushSettings": PushSettings}, PushSettings>;



@summary("Gets the Push settings associated with web app.")
/**
* Description for Gets the Push settings associated with web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/pushsettings/list")
@post op `listSitePushSettingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PushSettings>;



@summary("Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.")
/**
* Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
@get op `getConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteConfig>;



@summary("Updates the configuration of an app.")
/**
* Description for Updates the configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
@put op `createOrUpdateConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON representation of a SiteConfig object. See example.
*/
@body
"siteConfig": SiteConfig}, SiteConfig>;



@summary("Updates the configuration of an app.")
/**
* Description for Updates the configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
@patch op `updateConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON representation of a SiteConfig object. See example.
*/
@body
"siteConfig": SiteConfig}, SiteConfig>;



@summary("Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
/**
* Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots")
@get op `listConfigurationSnapshotInfoSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteConfigurationSnapshotInfoCollection>;



@summary("Gets a snapshot of the configuration of an app at a previous point in time.")
/**
* Description for Gets a snapshot of the configuration of an app at a previous point in time.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots/{snapshotId}")
@get op `getConfigurationSnapshotSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* The ID of the snapshot to read.
*/
@path
"snapshotId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteConfig>;



@summary("Reverts the configuration of an app to a previous snapshot.")
/**
* Description for Reverts the configuration of an app to a previous snapshot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots/{snapshotId}/recover")
@post op `recoverSiteConfigurationSnapshotSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* The ID of the snapshot to read.
*/
@path
"snapshotId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the last lines of docker logs for the given site")
/**
* Description for Gets the last lines of docker logs for the given site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/containerlogs")
@post op `getWebSiteContainerLogsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Accept header
*/
@header
"accept": "application/octet-stream"}, void>;



@summary("Gets the ZIP archived docker log files for the given site")
/**
* Description for Gets the ZIP archived docker log files for the given site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/containerlogs/zip/download")
@post op `getContainerLogsZipSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Accept header
*/
@header
"accept": "application/zip"}, void>;



@summary("List continuous web jobs for an app, or a deployment slot.")
/**
* Description for List continuous web jobs for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs")
@get op `listContinuousWebJobsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ContinuousWebJob>>;



@summary("Gets a continuous web job by its ID for an app, or a deployment slot.")
/**
* Description for Gets a continuous web job by its ID for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}")
@get op `getContinuousWebJobSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ContinuousWebJob>;



@summary("Delete a continuous web job by its ID for an app, or a deployment slot.")
/**
* Description for Delete a continuous web job by its ID for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}")
@delete op `deleteContinuousWebJobSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Start a continuous web job for an app, or a deployment slot.")
/**
* Description for Start a continuous web job for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}/start")
@post op `startContinuousWebJobSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Stop a continuous web job for an app, or a deployment slot.")
/**
* Description for Stop a continuous web job for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}/stop")
@post op `stopContinuousWebJobSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("List deployments for an app, or a deployment slot.")
/**
* Description for List deployments for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments")
@get op `listDeploymentsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<Deployment>>;



@summary("Get a deployment by its ID for an app, or a deployment slot.")
/**
* Description for Get a deployment by its ID for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
@get op `getDeploymentSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Deployment ID.
*/
@path
"id": string
/**
* Name of the deployment slot. If a slot is not specified, the API gets a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, Deployment>;



@summary("Create a deployment for an app, or a deployment slot.")
/**
* Description for Create a deployment for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
@put op `createDeploymentSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* ID of an existing deployment.
*/
@path
"id": string
/**
* Name of the deployment slot. If a slot is not specified, the API creates a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Deployment details.
*/
@body
"deployment": Deployment}, Deployment>;



@summary("Delete a deployment by its ID for an app, or a deployment slot.")
/**
* Description for Delete a deployment by its ID for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
@delete op `deleteDeploymentSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Deployment ID.
*/
@path
"id": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("List deployment log for specific deployment for an app, or a deployment slot.")
/**
* Description for List deployment log for specific deployment for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}/log")
@get op `listDeploymentLogSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* The ID of a specific deployment. This is the value of the name property in the JSON response from "GET /api/sites/{siteName}/deployments".
*/
@path
"id": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, Deployment>;



@summary("Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
/**
* Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/discoverbackup")
@post op `discoverBackupSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will perform discovery for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup.
*/
@body
"request": RestoreRequest}, RestoreRequest>;



@summary("Lists ownership identifiers for domain associated with web app.")
/**
* Description for Lists ownership identifiers for domain associated with web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers")
@get op `listDomainOwnershipIdentifiersSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<Identifier>>;



@summary("Get domain ownership identifier for web app.")
/**
* Description for Get domain ownership identifier for web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
@get op `getDomainOwnershipIdentifierSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of domain ownership identifier.
*/
@path
"domainOwnershipIdentifierName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, Identifier>;



@summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
/**
* Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
@put op `createOrUpdateDomainOwnershipIdentifierSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of domain ownership identifier.
*/
@path
"domainOwnershipIdentifierName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the domain ownership properties.
*/
@body
"domainOwnershipIdentifier": Identifier}, Identifier>;



@summary("Deletes a domain ownership identifier for a web app.")
/**
* Description for Deletes a domain ownership identifier for a web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
@delete op `deleteDomainOwnershipIdentifierSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of domain ownership identifier.
*/
@path
"domainOwnershipIdentifierName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
/**
* Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
@patch op `updateDomainOwnershipIdentifierSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of domain ownership identifier.
*/
@path
"domainOwnershipIdentifierName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the domain ownership properties.
*/
@body
"domainOwnershipIdentifier": Identifier}, Identifier>;



@summary("Get the status of the last MSDeploy operation.")
/**
* Description for Get the status of the last MSDeploy operation.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy")
@get op `getMSDeployStatusSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, MSDeployStatus>;



@summary("Invoke the MSDeploy web app extension.")
/**
* Description for Invoke the MSDeploy web app extension.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy")
@put op `createMSDeployOperationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Details of MSDeploy operation
*/
@body
"MSDeploy": MSDeploy}, MSDeployStatus>;



@summary("Get the MSDeploy Log for the last MSDeploy operation.")
/**
* Description for Get the MSDeploy Log for the last MSDeploy operation.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy/log")
@get op `getMSDeployLogSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, MSDeployLog>;



@summary("List the functions for a web site, or a deployment slot.")
/**
* Description for List the functions for a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions")
@get op `listInstanceFunctionsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<FunctionEnvelope>>;



@summary("Fetch a short lived token that can be exchanged for a master key.")
/**
* Description for Fetch a short lived token that can be exchanged for a master key.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/admin/token")
@get op `getFunctionsAdminTokenSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get function information by its ID for web site, or a deployment slot.")
/**
* Description for Get function information by its ID for web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
@get op `getInstanceFunctionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Function name.
*/
@path
"functionName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, FunctionEnvelope>;



@summary("Create function for web site, or a deployment slot.")
/**
* Description for Create function for web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
@put op `createInstanceFunctionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Function name.
*/
@path
"functionName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Function details.
*/
@body
"function_envelope": FunctionEnvelope}, FunctionEnvelope>;



@summary("Delete a function for web site, or a deployment slot.")
/**
* Description for Delete a function for web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
@delete op `deleteInstanceFunctionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Function name.
*/
@path
"functionName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Add or update a function secret.")
/**
* Description for Add or update a function secret.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/keys/{keyName}")
@put op `createOrUpdateFunctionSecretSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* The name of the function.
*/
@path
"functionName": string
/**
* The name of the key.
*/
@path
"keyName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The key to create or update
*/
@body
"key": KeyInfo}, KeyInfo>;



@summary("Delete a function secret.")
/**
* Description for Delete a function secret.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/keys/{keyName}")
@delete op `deleteFunctionSecretSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* The name of the function.
*/
@path
"functionName": string
/**
* The name of the key.
*/
@path
"keyName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get function keys for a function in a web site, or a deployment slot.")
/**
* Description for Get function keys for a function in a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/listkeys")
@post op `listFunctionKeysSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Function name.
*/
@path
"functionName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, StringDictionary>;



@summary("Get function secrets for a function in a web site, or a deployment slot.")
/**
* Description for Get function secrets for a function in a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/listsecrets")
@post op `listFunctionSecretsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Function name.
*/
@path
"functionName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, FunctionSecrets>;



@summary("Get host secrets for a function app.")
/**
* Description for Get host secrets for a function app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/listkeys")
@post op `listHostKeysSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, HostKeys>;



@summary("This is to allow calling via powershell and ARM template.")
/**
* Description for This is to allow calling via powershell and ARM template.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/listsyncstatus")
@post op `listSyncStatusSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Syncs function trigger metadata to the management database")
/**
* Description for Syncs function trigger metadata to the management database
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/sync")
@post op `syncFunctionsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Add or update a host level secret.")
/**
* Description for Add or update a host level secret.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
@put op `createOrUpdateHostSecretSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* The type of host key.
*/
@path
"keyType": string
/**
* The name of the key.
*/
@path
"keyName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The key to create or update
*/
@body
"key": KeyInfo}, KeyInfo>;



@summary("Delete a host level secret.")
/**
* Description for Delete a host level secret.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
@delete op `deleteHostSecretSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* The type of host key.
*/
@path
"keyType": string
/**
* The name of the key.
*/
@path
"keyName": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get hostname bindings for an app or a deployment slot.")
/**
* Description for Get hostname bindings for an app or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings")
@get op `listHostNameBindingsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API gets hostname bindings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<HostNameBinding>>;



@summary("Get the named hostname binding for an app (or deployment slot, if specified).")
/**
* Description for Get the named hostname binding for an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
@get op `getHostNameBindingSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot.
*/
@path
"slot": string
/**
* Hostname in the hostname binding.
*/
@path
"hostName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, HostNameBinding>;



@summary("Creates a hostname binding for an app.")
/**
* Description for Creates a hostname binding for an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
@put op `createOrUpdateHostNameBindingSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Hostname in the hostname binding.
*/
@path
"hostName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Binding details. This is the JSON representation of a HostNameBinding object.
*/
@body
"hostNameBinding": HostNameBinding}, HostNameBinding>;



@summary("Deletes a hostname binding for an app.")
/**
* Description for Deletes a hostname binding for an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
@delete op `deleteHostNameBindingSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Hostname in the hostname binding.
*/
@path
"hostName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
/**
* Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@get op `getHybridConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, HybridConnection>;



@summary("Creates a new Hybrid Connection using a Service Bus relay.")
/**
* Description for Creates a new Hybrid Connection using a Service Bus relay.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@put op `createOrUpdateHybridConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The details of the hybrid connection.
*/
@body
"connectionEnvelope": HybridConnection}, HybridConnection>;



@summary("Removes a Hybrid Connection from this site.")
/**
* Description for Removes a Hybrid Connection from this site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@delete op `deleteHybridConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Creates a new Hybrid Connection using a Service Bus relay.")
/**
* Description for Creates a new Hybrid Connection using a Service Bus relay.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
@patch op `updateHybridConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The namespace for this hybrid connection.
*/
@path
"namespaceName": string
/**
* The relay name for this hybrid connection.
*/
@path
"relayName": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The details of the hybrid connection.
*/
@body
"connectionEnvelope": HybridConnection}, HybridConnection>;



@summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
/**
* Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionRelays")
@get op `listHybridConnectionsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, HybridConnection>;



@summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
/**
* Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection")
@get op `listRelayServiceConnectionsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get hybrid connections for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, RelayServiceConnectionEntity>;



@summary("Gets a hybrid connection configuration by its name.")
/**
* Description for Gets a hybrid connection configuration by its name.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
@get op `getRelayServiceConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the hybrid connection.
*/
@path
"entityName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get a hybrid connection for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, RelayServiceConnectionEntity>;



@summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
/**
* Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
@put op `createOrUpdateRelayServiceConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the hybrid connection configuration.
*/
@path
"entityName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will create or update a hybrid connection for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Details of the hybrid connection configuration.
*/
@body
"connectionEnvelope": RelayServiceConnectionEntity}, RelayServiceConnectionEntity>;



@summary("Deletes a relay service connection by its name.")
/**
* Description for Deletes a relay service connection by its name.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
@delete op `deleteRelayServiceConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the hybrid connection configuration.
*/
@path
"entityName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete a hybrid connection for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
/**
* Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
@patch op `updateRelayServiceConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the hybrid connection configuration.
*/
@path
"entityName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will create or update a hybrid connection for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Details of the hybrid connection configuration.
*/
@body
"connectionEnvelope": RelayServiceConnectionEntity}, RelayServiceConnectionEntity>;



@summary("Gets all scale-out instances of an app.")
/**
* Description for Gets all scale-out instances of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances")
@get op `listInstanceIdentifiersSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API gets the production slot instances.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<WebSiteInstanceStatus>>;



@summary("Gets all scale-out instances of an app.")
/**
* Description for Gets all scale-out instances of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}")
@get op `getInstanceInfoSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@path
"instanceId": string
/**
* Name of the deployment slot. If a slot is not specified, the API gets the production slot instances.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, WebSiteInstanceStatus>;



@summary("Get the status of the last MSDeploy operation.")
/**
* Description for Get the status of the last MSDeploy operation.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy")
@get op `getInstanceMsDeployStatusSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* ID of web app instance.
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, MSDeployStatus>;



@summary("Invoke the MSDeploy web app extension.")
/**
* Description for Invoke the MSDeploy web app extension.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy")
@put op `createInstanceMSDeployOperationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* ID of web app instance.
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Details of MSDeploy operation
*/
@body
"MSDeploy": MSDeploy}, MSDeployStatus>;



@summary("Get the MSDeploy Log for the last MSDeploy operation.")
/**
* Description for Get the MSDeploy Log for the last MSDeploy operation.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy/log")
@get op `getInstanceMSDeployLogSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* ID of web app instance.
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, MSDeployLog>;



@summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
/**
* Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes")
@get op `listInstanceProcessesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ProcessInfo>>;



@summary("Get process information by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get process information by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}")
@get op `getInstanceProcessSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessInfo>;



@summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
/**
* Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}")
@delete op `deleteInstanceProcessSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/dump")
@get op `getInstanceProcessDumpSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/modules")
@get op `listInstanceProcessModulesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ProcessModuleInfo>>;



@summary("Get process information by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get process information by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/modules/{baseAddress}")
@get op `getInstanceProcessModuleSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Module base address.
*/
@path
"baseAddress": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessModuleInfo>;



@summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/threads")
@get op `listInstanceProcessThreadsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
*/
@path
"instanceId": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessThreadInfoCollection>;



@summary("Shows whether an app can be cloned to another resource group or subscription.")
/**
* Description for Shows whether an app can be cloned to another resource group or subscription.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/iscloneable")
@post op `isCloneableSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. By default, this API returns information on the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteCloneability>;



@summary("Gets existing backups of an app.")
/**
* Description for Gets existing backups of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/listbackups")
@post op `listSiteBackupsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get backups of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<BackupItem>>;



@summary("This is to allow calling via powershell and ARM template.")
/**
* Description for This is to allow calling via powershell and ARM template.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/listsyncfunctiontriggerstatus")
@post op `listSyncFunctionTriggersSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, FunctionSecrets>;



@summary("Gets a Swift Virtual Network connection.")
/**
* Description for Gets a Swift Virtual Network connection.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
@get op `getSwiftVirtualNetworkConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SwiftVirtualNetwork>;



@summary("Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.")
/**
* Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
@put op `createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the Virtual Network connection. See example.
*/
@body
"connectionEnvelope": SwiftVirtualNetwork}, SwiftVirtualNetwork>;



@summary("Deletes a Swift Virtual Network connection from an app (or deployment slot).")
/**
* Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
@delete op `deleteSwiftVirtualNetworkSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the connection for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.")
/**
* Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
@patch op `updateSwiftVirtualNetworkConnectionWithCheckSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the Virtual Network connection. See example.
*/
@body
"connectionEnvelope": SwiftVirtualNetwork}, SwiftVirtualNetwork>;



@summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/operationresults/{operationId}")
@get op `getNetworkTraceOperationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* GUID of the operation.
*/
@path
"operationId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Start capturing network packets for the site (To be deprecated).")
/**
* Description for Start capturing network packets for the site (To be deprecated).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/start")
@post op `startWebSiteNetworkTraceSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32
/**
* The name of the slot for this web app.
*/
@path
"slot": string
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Start capturing network packets for the site.")
/**
* Description for Start capturing network packets for the site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/startOperation")
@post op `startWebSiteNetworkTraceOperationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32
/**
* The name of the slot for this web app.
*/
@path
"slot": string
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Stop ongoing capturing network packets for the site.")
/**
* Description for Stop ongoing capturing network packets for the site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/stop")
@post op `stopWebSiteNetworkTraceSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The name of the slot for this web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/{operationId}")
@get op `getNetworkTracesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* GUID of the operation.
*/
@path
"operationId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTraces/current/operationresults/{operationId}")
@get op `getNetworkTraceOperationSlotV2` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* GUID of the operation.
*/
@path
"operationId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTraces/{operationId}")
@get op `getNetworkTracesSlotV2` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* GUID of the operation.
*/
@path
"operationId": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Generates a new publishing password for an app (or deployment slot, if specified).")
/**
* Description for Generates a new publishing password for an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/newpassword")
@post op `generateNewSitePublishingPasswordSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API generate a new publishing password for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets perfmon counters for web app.")
/**
* Description for Gets perfmon counters for web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/perfcounters")
@get op `listPerfMonCountersSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
*/
@query("$filter")
"$filter"?: string}, PerfMonCounterCollection>;



@summary("Gets web app's event logs.")
/**
* Description for Gets web app's event logs.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/phplogging")
@get op `getSitePhpErrorLogFlagSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SitePhpErrorLogFlag>;



@summary("Gets the premier add-ons of an app.")
/**
* Description for Gets the premier add-ons of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons")
@get op `listPremierAddOnsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the premier add-ons for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PremierAddOn>;



@summary("Gets a named add-on of an app.")
/**
* Description for Gets a named add-on of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
@get op `getPremierAddOnSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Add-on name.
*/
@path
"premierAddOnName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the named add-on for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PremierAddOn>;



@summary("Updates a named add-on of an app.")
/**
* Description for Updates a named add-on of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
@put op `addPremierAddOnSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Add-on name.
*/
@path
"premierAddOnName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the named add-on for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the edited premier add-on.
*/
@body
"premierAddOn": PremierAddOn}, PremierAddOn>;



@summary("Delete a premier add-on from an app.")
/**
* Description for Delete a premier add-on from an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
@delete op `deletePremierAddOnSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Add-on name.
*/
@path
"premierAddOnName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the named add-on for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Updates a named add-on of an app.")
/**
* Description for Updates a named add-on of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
@patch op `updatePremierAddOnSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Add-on name.
*/
@path
"premierAddOnName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will update the named add-on for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* A JSON representation of the edited premier add-on.
*/
@body
"premierAddOn": PremierAddOnPatchResource}, PremierAddOn>;



@summary("Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
/**
* Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateAccess/virtualNetworks")
@get op `getPrivateAccessSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PrivateAccess>;



@summary("Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
/**
* Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateAccess/virtualNetworks")
@put op `putPrivateAccessVnetSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The name of the slot for the web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The information for the private access
*/
@body
"access": PrivateAccess}, PrivateAccess>;



@summary("Gets the list of private endpoint connections associated with a site")
/**
* Description for Gets the list of private endpoint connections associated with a site
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections")
@get op `getPrivateEndpointConnectionListSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string
/**
* Name of the site deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<RemotePrivateEndpointConnectionARMResource>>;



@summary("Gets a private endpoint connection")
/**
* Description for Gets a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
@get op `getPrivateEndpointConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string
/**
* Name of the private endpoint connection.
*/
@path
"privateEndpointConnectionName": string
/**
* Name of the site deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, RemotePrivateEndpointConnectionARMResource>;



@summary("Approves or rejects a private endpoint connection")
/**
* Description for Approves or rejects a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
@put op `approveOrRejectPrivateEndpointConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string

@path
"privateEndpointConnectionName": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string

@body
"privateEndpointWrapper": PrivateLinkConnectionApprovalRequestResource}, RemotePrivateEndpointConnectionARMResource>;



@summary("Deletes a private endpoint connection")
/**
* Description for Deletes a private endpoint connection
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
@delete op `deletePrivateEndpointConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string

@path
"privateEndpointConnectionName": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the private link resources")
/**
* Description for Gets the private link resources
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateLinkResources")
@get op `getPrivateLinkResourcesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the site.
*/
@path
"name": string

@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PrivateLinkResourcesWrapper>;



@summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
/**
* Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes")
@get op `listProcessesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ProcessInfo>>;



@summary("Get process information by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get process information by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}")
@get op `getProcessSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessInfo>;



@summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
/**
* Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}")
@delete op `deleteProcessSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/dump")
@get op `getProcessDumpSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/modules")
@get op `listProcessModulesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<ProcessModuleInfo>>;



@summary("Get process information by its ID for a specific scaled-out instance in a web site.")
/**
* Description for Get process information by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/modules/{baseAddress}")
@get op `getProcessModuleSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Module base address.
*/
@path
"baseAddress": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessModuleInfo>;



@summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
/**
* Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/threads")
@get op `listProcessThreadsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* PID.
*/
@path
"processId": string
/**
* Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ProcessThreadInfoCollection>;



@summary("Get public certificates for an app or a deployment slot.")
/**
* Description for Get public certificates for an app or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates")
@get op `listPublicCertificatesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API gets hostname bindings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<PublicCertificate>>;



@summary("Get the named public certificate for an app (or deployment slot, if specified).")
/**
* Description for Get the named public certificate for an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
@get op `getPublicCertificateSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot.
*/
@path
"slot": string
/**
* Public certificate name.
*/
@path
"publicCertificateName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, PublicCertificate>;



@summary("Creates a hostname binding for an app.")
/**
* Description for Creates a hostname binding for an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
@put op `createOrUpdatePublicCertificateSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Public certificate name.
*/
@path
"publicCertificateName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Public certificate details. This is the JSON representation of a PublicCertificate object.
*/
@body
"publicCertificate": PublicCertificate}, PublicCertificate>;



@summary("Deletes a hostname binding for an app.")
/**
* Description for Deletes a hostname binding for an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
@delete op `deletePublicCertificateSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
*/
@path
"slot": string
/**
* Public certificate name.
*/
@path
"publicCertificateName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the publishing profile for an app (or deployment slot, if specified).")
/**
* Description for Gets the publishing profile for an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publishxml")
@post op `listPublishingProfileXmlWithSecretsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the publishing profile for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Specifies publishingProfileOptions for publishing profile. For example, use {"format": "FileZilla3"} to get a FileZilla publishing profile.
*/
@body
"publishingProfileOptions": CsmPublishingProfileOptions
/**
* Accept header
*/
@header
"accept": "application/xml"}, void>;



@summary("Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
/**
* Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resetSlotConfig")
@post op `resetSlotConfigurationSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API resets configuration settings for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Restarts an app (or deployment slot, if specified).")
/**
* Description for Restarts an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restart")
@post op `restartSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will restart the production slot.
*/
@path
"slot": string
/**
* Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.
*/
@query("softRestart")
"softRestart"?: boolean
/**
* Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).
*/
@query("synchronous")
"synchronous"?: boolean
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Restores an app from a backup blob in Azure Storage.")
/**
* Description for Restores an app from a backup blob in Azure Storage.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreFromBackupBlob")
@post op `restoreFromBackupBlobSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will restore a backup of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Information on restore request .
*/
@body
"request": RestoreRequest}, void>;



@summary("Restores a deleted web app to this web app.")
/**
* Description for Restores a deleted web app to this web app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreFromDeletedApp")
@post op `restoreFromDeletedAppSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Deleted web app restore information.
*/
@body
"restoreRequest": DeletedAppRestoreRequest}, void>;



@summary("Restores a web app from a snapshot.")
/**
* Description for Restores a web app from a snapshot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreSnapshot")
@post op `restoreSnapshotSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API.
*/
@body
"restoreRequest": SnapshotRestoreRequest}, void>;



@summary("Get list of siteextensions for a web site, or a deployment slot.")
/**
* Description for Get list of siteextensions for a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions")
@get op `listSiteExtensionsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API uses the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<SiteExtensionInfo>>;



@summary("Get site extension information by its ID for a web site, or a deployment slot.")
/**
* Description for Get site extension information by its ID for a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
@get op `getSiteExtensionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Site extension name.
*/
@path
"siteExtensionId": string
/**
* Name of the deployment slot. If a slot is not specified, the API uses the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteExtensionInfo>;



@summary("Install site extension on a web site, or a deployment slot.")
/**
* Description for Install site extension on a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
@put op `installSiteExtensionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Site extension name.
*/
@path
"siteExtensionId": string
/**
* Name of the deployment slot. If a slot is not specified, the API uses the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteExtensionInfo>;



@summary("Remove a site extension from a web site, or a deployment slot.")
/**
* Description for Remove a site extension from a web site, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
@delete op `deleteSiteExtensionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Site extension name.
*/
@path
"siteExtensionId": string
/**
* Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Get the difference in configuration settings between two web app slots.")
/**
* Description for Get the difference in configuration settings between two web app slots.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/slotsdiffs")
@post op `listSlotDifferencesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the source slot. If a slot is not specified, the production slot is used as the source slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON object that contains the target slot name. See example.
*/
@body
"slotSwapEntity": CsmSlotEntity}, SlotDifferenceCollection>;



@summary("Swaps two deployment slots of an app.")
/**
* Description for Swaps two deployment slots of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/slotsswap")
@post op `swapSlotSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the source slot. If a slot is not specified, the production slot is used as the source slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON object that contains the target slot name. See example.
*/
@body
"slotSwapEntity": CsmSlotEntity}, void>;



@summary("Returns all Snapshots to the user.")
/**
* Description for Returns all Snapshots to the user.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/snapshots")
@get op `listSnapshotsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Website Name.
*/
@path
"name": string
/**
* Website Slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SnapshotCollection>;



@summary("Returns all Snapshots to the user from DRSecondary endpoint.")
/**
* Description for Returns all Snapshots to the user from DRSecondary endpoint.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/snapshotsdr")
@get op `listSnapshotsFromDRSecondarySlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Website Name.
*/
@path
"name": string
/**
* Website Slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SnapshotCollection>;



@summary("Starts an app (or deployment slot, if specified).")
/**
* Description for Starts an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/start")
@post op `startSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will start the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Start capturing network packets for the site.")
/**
* Description for Start capturing network packets for the site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/startNetworkTrace")
@post op `startNetworkTraceSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32
/**
* The name of the slot for this web app.
*/
@path
"slot": string
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Stops an app (or deployment slot, if specified).")
/**
* Description for Stops an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/stop")
@post op `stopSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will stop the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Stop ongoing capturing network packets for the site.")
/**
* Description for Stop ongoing capturing network packets for the site.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/stopNetworkTrace")
@post op `stopNetworkTraceSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* The name of the web app.
*/
@path
"name": string
/**
* The name of the slot for this web app.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Sync web app repository.")
/**
* Description for Sync web app repository.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/sync")
@post op `syncRepositorySlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of web app.
*/
@path
"name": string
/**
* Name of web app slot. If not specified then will default to production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Syncs function trigger metadata to the management database")
/**
* Description for Syncs function trigger metadata to the management database
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/syncfunctiontriggers")
@post op `syncFunctionTriggersSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the quota usage information of an app (or deployment slot, if specified).")
/**
* Description for Gets the quota usage information of an app (or deployment slot, if specified).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/usages")
@get op `listUsagesSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get quota information of the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
*/
@query("$filter")
"$filter"?: string}, CsmUsageQuotaCollection>;



@summary("Gets the virtual networks the app (or deployment slot) is connected to.")
/**
* Description for Gets the virtual networks the app (or deployment slot) is connected to.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections")
@get op `listVnetConnectionsSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get virtual network connections for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets a virtual network the app (or deployment slot) is connected to by name.")
/**
* Description for Gets a virtual network the app (or deployment slot) is connected to by name.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
@get op `getVnetConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the virtual network.
*/
@path
"vnetName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get the named virtual network for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, VnetInfoResource>;



@summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
/**
* Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
@put op `createOrUpdateVnetConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of an existing Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the Virtual Network connection. See example.
*/
@body
"connectionEnvelope": VnetInfoResource}, VnetInfoResource>;



@summary("Deletes a connection from an app (or deployment slot to a named virtual network.")
/**
* Description for Deletes a connection from an app (or deployment slot to a named virtual network.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
@delete op `deleteVnetConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the virtual network.
*/
@path
"vnetName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will delete the connection for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
/**
* Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
@patch op `updateVnetConnectionSlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of an existing Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the Virtual Network connection. See example.
*/
@body
"connectionEnvelope": VnetInfoResource}, VnetInfoResource>;



@summary("Gets an app's Virtual Network gateway.")
/**
* Description for Gets an app's Virtual Network gateway.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
@get op `getVnetConnectionGatewaySlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the gateway. Currently, the only supported string is "primary".
*/
@path
"gatewayName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, VnetGateway>;



@summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
/**
* Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
@put op `createOrUpdateVnetConnectionGatewaySlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the gateway. Currently, the only supported string is "primary".
*/
@path
"gatewayName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will add or update a gateway for the production slot's Virtual Network.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The properties to update this gateway with.
*/
@body
"connectionEnvelope": VnetGateway}, VnetGateway>;



@summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
/**
* Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
@patch op `updateVnetConnectionGatewaySlot` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the gateway. Currently, the only supported string is "primary".
*/
@path
"gatewayName": string
/**
* Name of the deployment slot. If a slot is not specified, the API will add or update a gateway for the production slot's Virtual Network.
*/
@path
"slot": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The properties to update this gateway with.
*/
@body
"connectionEnvelope": VnetGateway}, VnetGateway>;



@summary("Gets the source control configuration of an app.")
/**
* Description for Gets the source control configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
@get op `getSourceControl` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, SiteSourceControl>;



@summary("Updates the source control configuration of an app.")
/**
* Description for Updates the source control configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
@put op `createOrUpdateSourceControl` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON representation of a SiteSourceControl object. See example.
*/
@body
"siteSourceControl": SiteSourceControl}, SiteSourceControl>;



@summary("Deletes the source control configuration of an app.")
/**
* Description for Deletes the source control configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
@delete op `deleteSourceControl` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string

@query("additionalFlags")
"additionalFlags"?: string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Updates the source control configuration of an app.")
/**
* Description for Updates the source control configuration of an app.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
@patch op `updateSourceControl` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* JSON representation of a SiteSourceControl object. See example.
*/
@body
"siteSourceControl": SiteSourceControl}, SiteSourceControl>;



@summary("List triggered web jobs for an app, or a deployment slot.")
/**
* Description for List triggered web jobs for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs")
@get op `listTriggeredWebJobs` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<TriggeredWebJob>>;



@summary("Gets a triggered web job by its ID for an app, or a deployment slot.")
/**
* Description for Gets a triggered web job by its ID for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}")
@get op `getTriggeredWebJob` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, TriggeredWebJob>;



@summary("Delete a triggered web job by its ID for an app, or a deployment slot.")
/**
* Description for Delete a triggered web job by its ID for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}")
@delete op `deleteTriggeredWebJob` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("List a triggered web job's history for an app, or a deployment slot.")
/**
* Description for List a triggered web job's history for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/history")
@get op `listTriggeredWebJobHistory` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<TriggeredJobHistory>>;



@summary("Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
/**
* Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/history/{id}")
@get op `getTriggeredWebJobHistory` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* History ID.
*/
@path
"id": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, TriggeredJobHistory>;



@summary("Run a triggered web job for an app, or a deployment slot.")
/**
* Description for Run a triggered web job for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/run")
@post op `runTriggeredWebJob` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of Web Job.
*/
@path
"webJobName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets the virtual networks the app (or deployment slot) is connected to.")
/**
* Description for Gets the virtual networks the app (or deployment slot) is connected to.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections")
@get op `listVnetConnections` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Gets a virtual network the app (or deployment slot) is connected to by name.")
/**
* Description for Gets a virtual network the app (or deployment slot) is connected to by name.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
@get op `getVnetConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the virtual network.
*/
@path
"vnetName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, VnetInfoResource>;



@summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
/**
* Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
@put op `createOrUpdateVnetConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of an existing Virtual Network.
*/
@path
"vnetName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the Virtual Network connection. See example.
*/
@body
"connectionEnvelope": VnetInfoResource}, VnetInfoResource>;



@summary("Deletes a connection from an app (or deployment slot to a named virtual network.")
/**
* Description for Deletes a connection from an app (or deployment slot to a named virtual network.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
@delete op `deleteVnetConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the virtual network.
*/
@path
"vnetName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, void>;



@summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
/**
* Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
@patch op `updateVnetConnection` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of an existing Virtual Network.
*/
@path
"vnetName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* Properties of the Virtual Network connection. See example.
*/
@body
"connectionEnvelope": VnetInfoResource}, VnetInfoResource>;



@summary("Gets an app's Virtual Network gateway.")
/**
* Description for Gets an app's Virtual Network gateway.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
@get op `getVnetConnectionGateway` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the gateway. Currently, the only supported string is "primary".
*/
@path
"gatewayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, VnetGateway>;



@summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
/**
* Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
@put op `createOrUpdateVnetConnectionGateway` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the gateway. Currently, the only supported string is "primary".
*/
@path
"gatewayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The properties to update this gateway with.
*/
@body
"connectionEnvelope": VnetGateway}, VnetGateway>;



@summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
/**
* Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
@patch op `updateVnetConnectionGateway` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Name of the app.
*/
@path
"name": string
/**
* Name of the Virtual Network.
*/
@path
"vnetName": string
/**
* Name of the gateway. Currently, the only supported string is "primary".
*/
@path
"gatewayName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string
/**
* The properties to update this gateway with.
*/
@body
"connectionEnvelope": VnetGateway}, VnetGateway>;



@summary("List webjobs for an app, or a deployment slot.")
/**
* Description for List webjobs for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/webjobs")
@get op `listWebJobs` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, ResourceListResult<WebJob>>;



@summary("Get webjob information for an app, or a deployment slot.")
/**
* Description for Get webjob information for an app, or a deployment slot.
*/
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/webjobs/{webJobName}")
@get op `getWebJob` is Azure.Core.Foundations.Operation<{/**
* Name of the resource group to which the resource belongs.
*/
@maxLength(90)
@minLength(1)
@pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
@path
"resourceGroupName": string
/**
* Site name.
*/
@path
"name": string
/**
* Name of the web job.
*/
@path
"webJobName": string
/**
* Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
*/
@path
"subscriptionId": string}, WebJob>;



}