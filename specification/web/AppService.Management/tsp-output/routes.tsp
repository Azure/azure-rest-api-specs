import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;

interface AppServiceCertificateOrdersOperations {
  @summary("Validate information for a certificate order.")
  @doc("Description for Validate information for a certificate order.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CertificateRegistration/validateCertificateRegistrationInformation")
  @post
  ValidatePurchaseInformation is Azure.Core.Foundations.Operation<
    {
      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Information for a certificate order.")
      @body
      appServiceCertificateOrder: AppServiceCertificateOrder;
    },
    void
  >;
}

interface DomainsOperations {
  @summary("Check if a domain is available for registration.")
  @doc("Description for Check if a domain is available for registration.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/checkDomainAvailability")
  @post
  CheckAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Name of the domain.")
      @body
      identifier: NameIdentifier;
    },
    DomainAvailabilityCheckResult
  >;

  @summary("Generate a single sign-on request for the domain management portal.")
  @doc("Description for Generate a single sign-on request for the domain management portal.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/generateSsoRequest")
  @post
  GetControlCenterSsoRequest is Azure.Core.Foundations.Operation<
    {
      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DomainControlCenterSsoRequest
  >;

  @summary("Get domain name recommendations based on keywords.")
  @doc("Description for Get domain name recommendations based on keywords.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/listDomainRecommendations")
  @post
  ListRecommendations is Azure.Core.Foundations.Operation<
    {
      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Search parameters for domain name recommendations.")
      @body
      parameters: DomainRecommendationSearchParameters;
    },
    NameIdentifierCollection
  >;
}

interface AppServiceEnvironmentsOperations {
  @summary("Get all worker pools of an App Service Environment.")
  @doc("Description for Get all worker pools of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools")
  @get
  ListWorkerPools is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WorkerPoolCollection
  >;

  @summary("Get properties of a worker pool.")
  @doc("Description for Get properties of a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
  @get
  GetWorkerPool is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WorkerPoolResource
  >;

  @summary("Create or update a worker pool.")
  @doc("Description for Create or update a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
  @put
  CreateOrUpdateWorkerPool is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the worker pool.")
      @body
      workerPoolEnvelope: WorkerPoolResource;
    },
    WorkerPoolResource
  >;

  @summary("Create or update a worker pool.")
  @doc("Description for Create or update a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
  @patch
  UpdateWorkerPool is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the worker pool.")
      @body
      workerPoolEnvelope: WorkerPoolResource;
    },
    WorkerPoolResource
  >;

  @summary("Get metric definitions for a specific instance of a worker pool of an App Service Environment.")
  @doc("Description for Get metric definitions for a specific instance of a worker pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/instances/{instance}/metricdefinitions")
  @get
  ListWorkerPoolInstanceMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Name of the instance in the worker pool.")
      @path
      instance: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  @summary("Get metric definitions for a worker pool of an App Service Environment.")
  @doc("Description for Get metric definitions for a worker pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/metricdefinitions")
  @get
  ListWebWorkerMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  @summary("Get available SKUs for scaling a worker pool.")
  @doc("Description for Get available SKUs for scaling a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/skus")
  @get
  ListWorkerPoolSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SkuInfoCollection
  >;

  @summary("Get usage metrics for a worker pool of an App Service Environment.")
  @doc("Description for Get usage metrics for a worker pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/usages")
  @get
  ListWebWorkerUsages is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the worker pool.")
      @path
      workerPoolName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    UsageCollection
  >;
}

interface DiagnosticsOperations {
  @summary("List Hosting Environment Detector Responses")
  @doc("Description for List Hosting Environment Detector Responses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/detectors")
  @get
  ListHostingEnvironmentDetectorResponses is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorResponseCollection
  >;

  @summary("Get Hosting Environment Detector Response")
  @doc("Description for Get Hosting Environment Detector Response")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/detectors/{detectorName}")
  @get
  GetHostingEnvironmentDetectorResponse is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("App Service Environment Name")
      @path
      name: string;

      @doc("Detector Resource Name")
      @path
      detectorName: string;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorResponse
  >;

  @summary("List Site Detector Responses")
  @doc("Description for List Site Detector Responses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/detectors")
  @get
  ListSiteDetectorResponses is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorResponseCollection
  >;

  @summary("Get site detector response")
  @doc("Description for Get site detector response")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/detectors/{detectorName}")
  @get
  GetSiteDetectorResponse is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Detector Resource Name")
      @path
      detectorName: string;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorResponse
  >;

  @summary("List Site Detector Responses")
  @doc("Description for List Site Detector Responses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/detectors")
  @get
  ListSiteDetectorResponsesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorResponseCollection
  >;

  @summary("Get site detector response")
  @doc("Description for Get site detector response")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/detectors/{detectorName}")
  @get
  GetSiteDetectorResponseSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Detector Resource Name")
      @path
      detectorName: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorResponse
  >;

  @summary("Get Diagnostics Categories")
  @doc("Description for Get Diagnostics Categories")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics")
  @get
  ListSiteDiagnosticCategoriesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DiagnosticCategoryCollection
  >;

  @summary("Get Diagnostics Category")
  @doc("Description for Get Diagnostics Category")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}")
  @get
  GetSiteDiagnosticCategorySlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Diagnostic Category")
      @path
      diagnosticCategory: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DiagnosticCategory
  >;

  @summary("Get Site Analyses")
  @doc("Description for Get Site Analyses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses")
  @get
  ListSiteAnalysesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Diagnostic Category")
      @path
      diagnosticCategory: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DiagnosticAnalysisCollection
  >;

  @summary("Get Site Analysis")
  @doc("Description for Get Site Analysis")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}")
  @get
  GetSiteAnalysisSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Diagnostic Category")
      @path
      diagnosticCategory: string;

      @doc("Analysis Name")
      @path
      analysisName: string;

      @doc("Slot - optional")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    AnalysisDefinition
  >;

  @summary("Execute Analysis")
  @doc("Description for Execute Analysis")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}/execute")
  @post
  ExecuteSiteAnalysisSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Category Name")
      @path
      diagnosticCategory: string;

      @doc("Analysis Resource Name")
      @path
      analysisName: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DiagnosticAnalysis
  >;

  @summary("Get Detectors")
  @doc("Description for Get Detectors")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors")
  @get
  ListSiteDetectorsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Diagnostic Category")
      @path
      diagnosticCategory: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DiagnosticDetectorCollection
  >;

  @summary("Get Detector")
  @doc("Description for Get Detector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors/{detectorName}")
  @get
  GetSiteDetectorSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Diagnostic Category")
      @path
      diagnosticCategory: string;

      @doc("Detector Name")
      @path
      detectorName: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DetectorDefinitionResource
  >;

  @summary("Execute Detector")
  @doc("Description for Execute Detector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors/{detectorName}/execute")
  @post
  ExecuteSiteDetectorSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site Name")
      @path
      siteName: string;

      @doc("Detector Resource Name")
      @path
      detectorName: string;

      @doc("Category Name")
      @path
      diagnosticCategory: string;

      @doc("Slot Name")
      @path
      slot: string;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DiagnosticDetectorResponse
  >;
}

interface ProviderOperations {
  @summary("Get available application frameworks and their versions")
  @doc("Description for Get available application frameworks and their versions")
  @route("/providers/Microsoft.Web/availableStacks")
  @get
  GetAvailableStacks is Azure.Core.Foundations.Operation<
    {
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;
    },
    ApplicationStackCollection
  >;

  @summary("Get available Function app frameworks and their versions")
  @doc("Description for Get available Function app frameworks and their versions")
  @route("/providers/Microsoft.Web/functionAppStacks")
  @get
  GetFunctionAppStacks is Azure.Core.Foundations.Operation<
    {
      @doc("Stack OS Type")
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    FunctionAppStackCollection
  >;

  @summary("Get available Function app frameworks and their versions for location")
  @doc("Description for Get available Function app frameworks and their versions for location")
  @route("/providers/Microsoft.Web/locations/{location}/functionAppStacks")
  @get
  GetFunctionAppStacksForLocation is Azure.Core.Foundations.Operation<
    {
      @doc("Function App stack location.")
      @path
      location: string;

      @doc("Stack OS Type")
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    FunctionAppStackCollection
  >;

  @summary("Get available Web app frameworks and their versions for location")
  @doc("Description for Get available Web app frameworks and their versions for location")
  @route("/providers/Microsoft.Web/locations/{location}/webAppStacks")
  @get
  GetWebAppStacksForLocation is Azure.Core.Foundations.Operation<
    {
      @doc("Web App stack location.")
      @path
      location: string;

      @doc("Stack OS Type")
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    WebAppStackCollection
  >;

  @summary("Get available Web app frameworks and their versions")
  @doc("Description for Get available Web app frameworks and their versions")
  @route("/providers/Microsoft.Web/webAppStacks")
  @get
  GetWebAppStacks is Azure.Core.Foundations.Operation<
    {
      @doc("Stack OS Type")
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    WebAppStackCollection
  >;

  @summary("Get available application frameworks and their versions")
  @doc("Description for Get available application frameworks and their versions")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/availableStacks")
  @get
  GetAvailableStacksOnPrem is Azure.Core.Foundations.Operation<
    {
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApplicationStackCollection
  >;
}

interface RecommendationsOperations {
  @summary("List all recommendations for a subscription.")
  @doc("Description for List all recommendations for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.")
      @query("featured")
      featured?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]")
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  @summary("Reset all recommendation opt-out settings for a subscription.")
  @doc("Description for Reset all recommendation opt-out settings for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/reset")
  @post
  ResetAllFilters is Azure.Core.Foundations.Operation<
    {
      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Disables the specified rule so it will not apply to a subscription in the future.")
  @doc("Description for Disables the specified rule so it will not apply to a subscription in the future.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/{name}/disable")
  @post
  DisableRecommendationForSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("Rule name")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get a recommendation rule for an app.")
  @doc("Description for Get a recommendation rule for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}")
  @get
  GetRuleDetailsByWebApp is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      siteName: string;

      @doc("Name of the recommendation.")
      @path
      name: string;

      @doc("Specify <code>true</code> to update the last-seen timestamp of the recommendation object.")
      @query("updateSeen")
      updateSeen?: boolean;

      @doc("The GUID of the recommendation object if you query an expired one. You don't need to specify it to query an active entry.")
      @query("recommendationId")
      recommendationId?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RecommendationRule
  >;

  @summary("Disables the specific rule for a web site permanently.")
  @doc("Description for Disables the specific rule for a web site permanently.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}/disable")
  @post
  DisableRecommendationForSite is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name")
      @path
      siteName: string;

      @doc("Rule name")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ResourceHealthMetadataOperations {
  @summary("List all ResourceHealthMetadata for all sites in the subscription.")
  @doc("Description for List all ResourceHealthMetadata for all sites in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/resourceHealthMetadata")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceHealthMetadataCollection
  >;

  @summary("List all ResourceHealthMetadata for all sites in the resource group in the subscription.")
  @doc("Description for List all ResourceHealthMetadata for all sites in the resource group in the subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/resourceHealthMetadata")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceHealthMetadataCollection
  >;

  @summary("Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  @doc("Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resourceHealthMetadata")
  @get
  ListBySiteSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceHealthMetadataCollection
  >;

  @summary("Gets the category of ResourceHealthMetadata to use for the given site")
  @doc("Description for Gets the category of ResourceHealthMetadata to use for the given site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resourceHealthMetadata/default")
  @get
  GetBySiteSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceHealthMetadata
  >;
}

@summary("Gets a list of meters for a given location.")
@doc("Description for Gets a list of meters for a given location.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/billingMeters")
@get
op ListBillingMeters is Azure.Core.Foundations.Operation<
  {
    @doc("Azure Location of billable resource")
    @query("billingLocation")
    billingLocation?: string;

    @doc("App Service OS type meters used for")
    @query("osType")
    osType?: string;

    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;
  },
  BillingMeterCollection
>;

@summary("Check if a resource name is available.")
@doc("Description for Check if a resource name is available.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/checknameavailability")
@post
op CheckNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;

    @doc("Name availability request.")
    @body
    request: ResourceNameAvailabilityRequest;
  },
  ResourceNameAvailability
>;

@summary("Gets list of available geo regions plus ministamps")
@doc("Description for Gets list of available geo regions plus ministamps")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/deploymentLocations")
@get
op GetSubscriptionDeploymentLocations is Azure.Core.Foundations.Operation<
  {
    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;
  },
  DeploymentLocations
>;

@summary("Get a list of available geographical regions.")
@doc("Description for Get a list of available geographical regions.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/geoRegions")
@get
op ListGeoRegions is Azure.Core.Foundations.Operation<
  {
    @doc("Name of SKU used to filter the regions.")
    @query("sku")
    sku?: SkuName;

    @doc("Specify <code>true</code> if you want to filter to only regions that support Linux workers.")
    @query("linuxWorkersEnabled")
    linuxWorkersEnabled?: boolean;

    @doc("Specify <code>true</code> if you want to filter to only regions that support Xenon workers.")
    @query("xenonWorkersEnabled")
    xenonWorkersEnabled?: boolean;

    @doc("Specify <code>true</code> if you want to filter to only regions that support Linux Consumption Workers.")
    @query("linuxDynamicWorkersEnabled")
    linuxDynamicWorkersEnabled?: boolean;

    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;
  },
  GeoRegionCollection
>;

@summary("List all apps that are assigned to a hostname.")
@doc("Description for List all apps that are assigned to a hostname.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/listSitesAssignedToHostName")
@post
op ListSiteIdentifiersAssignedToHostName is Azure.Core.Foundations.Operation<
  {
    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;

    @doc("Hostname information.")
    @body
    nameIdentifier: NameIdentifier;
  },
  IdentifierCollection
>;

@summary("List all premier add-on offers.")
@doc("Description for List all premier add-on offers.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/premieraddonoffers")
@get
op ListPremierAddOnOffers is Azure.Core.Foundations.Operation<
  {
    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;
  },
  PremierAddOnOfferCollection
>;

@summary("List all SKUs.")
@doc("Description for List all SKUs.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/skus")
@get
op ListSkus is Azure.Core.Foundations.Operation<
  {
    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;
  },
  SkuInfos
>;

@summary("Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.")
@doc("Description for Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/verifyHostingEnvironmentVnet")
@post
op VerifyHostingEnvironmentVnet is Azure.Core.Foundations.Operation<
  {
    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;

    @doc("VNET information")
    @body
    parameters: VnetParameters;
  },
  VnetValidationFailureDetails
>;

@summary("Validate if a resource can be created.")
@doc("Description for Validate if a resource can be created.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/validate")
@post
op Validate is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the resource group to which the resource belongs.")
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
    @path
    resourceGroupName: string;

    @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
    @path
    subscriptionId: string;

    @doc("Request with the resources to validate.")
    @body
    validateRequest: ValidateRequest;
  },
  ValidateResponse
>;

interface StaticSitesOperations {
  @summary("Generates a preview workflow file for the static site")
  @doc("Description for Generates a preview workflow file for the static site")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/locations/{location}/previewStaticSiteWorkflowFile")
  @post
  PreviewWorkflow is Azure.Core.Foundations.Operation<
    {
      @doc("Location where you plan to create the static site.")
      @path
      location: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the StaticSitesWorkflowPreviewRequest properties. See example.")
      @body
      staticSitesWorkflowPreviewRequest: StaticSitesWorkflowPreviewRequest;
    },
    StaticSitesWorkflowPreview
  >;

  @summary("Gets the list of private endpoint connections associated with a static site")
  @doc("Description for Gets the list of private endpoint connections associated with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections")
  @get
  GetPrivateEndpointConnectionList is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionCollection
  >;

  @summary("Gets a private endpoint connection")
  @doc("Description for Gets a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  GetPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Name of the private endpoint connection.")
      @path
      privateEndpointConnectionName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  @summary("Approves or rejects a private endpoint connection")
  @doc("Description for Approves or rejects a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  ApproveOrRejectPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Name of the private endpoint connection.")
      @path
      privateEndpointConnectionName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Request body.")
      @body
      privateEndpointWrapper: PrivateLinkConnectionApprovalRequestResource;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  @summary("Deletes a private endpoint connection")
  @doc("Description for Deletes a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  DeletePrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Name of the private endpoint connection.")
      @path
      privateEndpointConnectionName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the details of the user provided function apps registered with a static site")
  @doc("Description for Gets the details of the user provided function apps registered with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps")
  @get
  GetUserProvidedFunctionAppsForStaticSite is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StaticSiteUserProvidedFunctionAppsCollection
  >;

  @summary("Gets the details of the user provided function app registered with a static site")
  @doc("Description for Gets the details of the user provided function app registered with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
  @get
  GetUserProvidedFunctionAppForStaticSite is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Name of the function app registered with the static site.")
      @path
      functionAppName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StaticSiteUserProvidedFunctionAppARMResource
  >;

  @summary("Register a user provided function app with a static site")
  @doc("Description for Register a user provided function app with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
  @put
  RegisterUserProvidedFunctionAppWithStaticSite is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Name of the function app to register with the static site.")
      @path
      functionAppName: string;

      @doc("Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.")
      @query("isForced")
      isForced?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the user provided function app properties. See example.")
      @body
      staticSiteUserProvidedFunctionEnvelope: StaticSiteUserProvidedFunctionAppARMResource;
    },
    StaticSiteUserProvidedFunctionAppARMResource
  >;

  @summary("Detach the user provided function app from the static site")
  @doc("Description for Detach the user provided function app from the static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
  @delete
  DetachUserProvidedFunctionAppFromStaticSite is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("Name of the function app registered with the static site.")
      @path
      functionAppName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface WebAppsOperations {
  @summary("Returns whether Scm basic auth is allowed on the site or not.")
  @doc("Description for Returns whether Scm basic auth is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/basicPublishingCredentialsPolicies/scm")
  @get
  GetScmAllowed is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  @summary("Updates whether user publishing credentials are allowed on the site or not.")
  @doc("Description for Updates whether user publishing credentials are allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/basicPublishingCredentialsPolicies/scm")
  @put
  UpdateScmAllowed is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @body
      csmPublishingAccessPoliciesEntity: CsmPublishingCredentialsPoliciesEntity;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  @summary("Gets the config reference app settings and status of an app")
  @doc("Description for Gets the config reference app settings and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/configreferences/connectionstrings")
  @get
  GetSiteConnectionStringKeyVaultReferences is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApiKVReferenceCollection
  >;

  @summary("Gets the config reference and status of an app")
  @doc("Description for Gets the config reference and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/configreferences/connectionstrings/{connectionStringKey}")
  @get
  GetSiteConnectionStringKeyVaultReference is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      connectionStringKey: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApiKVReference
  >;

  @summary("Gets a snapshot of the configuration of an app at a previous point in time.")
  @doc("Description for Gets a snapshot of the configuration of an app at a previous point in time.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}")
  @get
  GetConfigurationSnapshot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of the snapshot to read.")
      @path
      snapshotId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfig
  >;

  @summary("Reverts the configuration of an app to a previous snapshot.")
  @doc("Description for Reverts the configuration of an app to a previous snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}/recover")
  @post
  RecoverSiteConfigurationSnapshot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of the snapshot to read.")
      @path
      snapshotId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  @doc("Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @get
  GetHybridConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @doc("Description for Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @put
  CreateOrUpdateHybridConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The details of the hybrid connection.")
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  @summary("Removes a Hybrid Connection from this site.")
  @doc("Description for Removes a Hybrid Connection from this site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @delete
  DeleteHybridConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @doc("Description for Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @patch
  UpdateHybridConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The details of the hybrid connection.")
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  @summary("Get the status of the last MSDeploy operation.")
  @doc("Description for Get the status of the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy")
  @get
  GetInstanceMsDeployStatus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("ID of web app instance.")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployStatus
  >;

  @summary("Invoke the MSDeploy web app extension.")
  @doc("Description for Invoke the MSDeploy web app extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy")
  @put
  CreateInstanceMSDeployOperation is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("ID of web app instance.")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Details of MSDeploy operation")
      @body
      MSDeploy: MSDeploy;
    },
    MSDeployStatus
  >;

  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @doc("Description for Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy/log")
  @get
  GetInstanceMSDeployLog is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("ID of web app instance.")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;

  @summary("Gets the list of private endpoint connections associated with a site")
  @doc("Description for Gets the list of private endpoint connections associated with a site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections")
  @get
  GetPrivateEndpointConnectionList is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionCollection
  >;

  @summary("Gets a private endpoint connection")
  @doc("Description for Gets a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  GetPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @doc("Name of the private endpoint connection.")
      @path
      privateEndpointConnectionName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  @summary("Approves or rejects a private endpoint connection")
  @doc("Description for Approves or rejects a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  ApproveOrRejectPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @body
      privateEndpointWrapper: PrivateLinkConnectionApprovalRequestResource;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  @summary("Deletes a private endpoint connection")
  @doc("Description for Deletes a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  DeletePrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @doc("Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes")
  @get
  ListProcesses is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessInfoCollection
  >;

  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}")
  @get
  GetProcess is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessInfo
  >;

  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @doc("Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}")
  @delete
  DeleteProcess is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/dump")
  @get
  GetProcessDump is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/modules")
  @get
  ListProcessModules is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessModuleInfoCollection
  >;

  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/modules/{baseAddress}")
  @get
  GetProcessModule is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Module base address.")
      @path
      baseAddress: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessModuleInfo
  >;

  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/threads")
  @get
  ListProcessThreads is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;

  @summary("Gets an app's deployment slots.")
  @doc("Description for Gets an app's deployment slots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots")
  @get
  ListSlots is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WebAppCollection
  >;

  @summary("Gets the details of a web, mobile, or API app.")
  @doc("Description for Gets the details of a web, mobile, or API app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @get
  GetSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. By default, this API returns the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    Site
  >;

  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @doc("Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @put
  CreateOrUpdateSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Unique name of the app to create or update. To create or update a deployment slot, use the {slot} parameter.")
      @path
      name: string;

      @doc("Name of the deployment slot to create or update. By default, this API attempts to create or modify the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the app properties. See example.")
      @body
      siteEnvelope: Site;
    },
    Site
  >;

  @summary("Deletes a web, mobile, or API app, or one of the deployment slots.")
  @doc("Description for Deletes a web, mobile, or API app, or one of the deployment slots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @delete
  DeleteSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app to delete.")
      @path
      name: string;

      @doc("Name of the deployment slot to delete. By default, the API deletes the production slot.")
      @path
      slot: string;

      @doc("If true, web app metrics are also deleted.")
      @query("deleteMetrics")
      deleteMetrics?: boolean;

      @doc("Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.")
      @query("deleteEmptyServerFarm")
      deleteEmptyServerFarm?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @doc("Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @patch
  UpdateSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Unique name of the app to create or update. To create or update a deployment slot, use the {slot} parameter.")
      @path
      name: string;

      @doc("Name of the deployment slot to create or update. By default, this API attempts to create or modify the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the app properties. See example.")
      @body
      siteEnvelope: SitePatchResource;
    },
    Site
  >;

  @summary("Analyze a custom hostname.")
  @doc("Description for Analyze a custom hostname.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/analyzeCustomHostname")
  @get
  AnalyzeCustomHostnameSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Custom hostname.")
      @query("hostName")
      hostName?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    CustomHostnameAnalysisResult
  >;

  @summary("Applies the configuration settings from the target slot onto the current slot.")
  @doc("Description for Applies the configuration settings from the target slot onto the current slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/applySlotConfig")
  @post
  ApplySlotConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the source slot. If a slot is not specified, the production slot is used as the source slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON object that contains the target slot name. See example.")
      @body
      slotSwapEntity: CsmSlotEntity;
    },
    void
  >;

  @summary("Creates a backup of an app.")
  @doc("Description for Creates a backup of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backup")
  @post
  BackupSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will create a backup for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Backup configuration. You can use the JSON response from the POST action as input here.")
      @body
      request: BackupRequest;
    },
    BackupItem
  >;

  @summary("Gets existing backups of an app.")
  @doc("Description for Gets existing backups of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups")
  @get
  ListBackupsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get backups of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    BackupItemCollection
  >;

  @summary("Gets a backup of an app by its ID.")
  @doc("Description for Gets a backup of an app by its ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}")
  @get
  GetBackupStatusSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("ID of the backup.")
      @path
      backupId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get a backup of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    BackupItem
  >;

  @summary("Deletes a backup of an app by its ID.")
  @doc("Description for Deletes a backup of an app by its ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}")
  @delete
  DeleteBackupSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("ID of the backup.")
      @path
      backupId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete a backup of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
  @doc("Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/list")
  @post
  ListBackupStatusSecretsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("ID of backup.")
      @path
      backupId: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Information on backup request.")
      @body
      request: BackupRequest;
    },
    BackupItem
  >;

  @summary("Restores a specific backup to another app (or deployment slot, if specified).")
  @doc("Description for Restores a specific backup to another app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/restore")
  @post
  RestoreSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("ID of the backup.")
      @path
      backupId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will restore a backup of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Information on restore request .")
      @body
      request: RestoreRequest;
    },
    void
  >;

  @summary("Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
  @doc("Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies")
  @get
  ListBasicPublishingCredentialsPoliciesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PublishingCredentialsPoliciesCollection
  >;

  @summary("Returns whether FTP is allowed on the site or not.")
  @doc("Description for Returns whether FTP is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/ftp")
  @get
  GetFtpAllowedSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  @summary("Updates whether FTP is allowed on the site or not.")
  @doc("Description for Updates whether FTP is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/ftp")
  @put
  UpdateFtpAllowedSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @body
      csmPublishingAccessPoliciesEntity: CsmPublishingCredentialsPoliciesEntity;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  @summary("Returns whether Scm basic auth is allowed on the site or not.")
  @doc("Description for Returns whether Scm basic auth is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/scm")
  @get
  GetScmAllowedSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  @summary("Updates whether user publishing credentials are allowed on the site or not.")
  @doc("Description for Updates whether user publishing credentials are allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/scm")
  @put
  UpdateScmAllowedSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @body
      csmPublishingAccessPoliciesEntity: CsmPublishingCredentialsPoliciesEntity;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  @summary("List the configurations of an app")
  @doc("Description for List the configurations of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config")
  @get
  ListConfigurationsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfigResourceCollection
  >;

  @summary("Replaces the application settings of an app.")
  @doc("Description for Replaces the application settings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/appsettings")
  @put
  UpdateApplicationSettingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the application settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Application settings of the app.")
      @body
      appSettings: StringDictionary;
    },
    StringDictionary
  >;

  @summary("Gets the application settings of an app.")
  @doc("Description for Gets the application settings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/appsettings/list")
  @post
  ListApplicationSettingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the application settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StringDictionary
  >;

  @summary("Updates the Authentication / Authorization settings associated with web app.")
  @doc("Description for Updates the Authentication / Authorization settings associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettings")
  @put
  UpdateAuthSettingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Auth settings associated with web app.")
      @body
      siteAuthSettings: SiteAuthSettings;
    },
    SiteAuthSettings
  >;

  @summary("Gets the Authentication/Authorization settings of an app.")
  @doc("Description for Gets the Authentication/Authorization settings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettings/list")
  @post
  GetAuthSettingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteAuthSettings
  >;

  @summary("Updates site's Authentication / Authorization settings for apps via the V2 format")
  @doc("Description for Updates site's Authentication / Authorization settings for apps via the V2 format")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettingsV2")
  @put
  UpdateAuthSettingsV2Slot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Auth settings associated with web app.")
      @body
      siteAuthSettingsV2: SiteAuthSettingsV2;
    },
    SiteAuthSettingsV2
  >;

  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  @doc("Description for Gets site's Authentication / Authorization settings for apps via the V2 format")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettingsV2/list")
  @get
  GetAuthSettingsV2Slot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteAuthSettingsV2
  >;

  @summary("Updates the Azure storage account configurations of an app.")
  @doc("Description for Updates the Azure storage account configurations of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/azurestorageaccounts")
  @put
  UpdateAzureStorageAccountsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the Azure storage account configurations for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Azure storage accounts of the app.")
      @body
      azureStorageAccounts: AzureStoragePropertyDictionaryResource;
    },
    AzureStoragePropertyDictionaryResource
  >;

  @summary("Gets the Azure storage account configurations of an app.")
  @doc("Description for Gets the Azure storage account configurations of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/azurestorageaccounts/list")
  @post
  ListAzureStorageAccountsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the Azure storage account configurations for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    AzureStoragePropertyDictionaryResource
  >;

  @summary("Updates the backup configuration of an app.")
  @doc("Description for Updates the backup configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup")
  @put
  UpdateBackupConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the backup configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Edited backup configuration.")
      @body
      request: BackupRequest;
    },
    BackupRequest
  >;

  @summary("Deletes the backup configuration of an app.")
  @doc("Description for Deletes the backup configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup")
  @delete
  DeleteBackupConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the backup configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the backup configuration of an app.")
  @doc("Description for Gets the backup configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup/list")
  @post
  GetBackupConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the backup configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    BackupRequest
  >;

  @summary("Gets the config reference app settings and status of an app")
  @doc("Description for Gets the config reference app settings and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/appsettings")
  @get
  GetAppSettingsKeyVaultReferencesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApiKVReferenceCollection
  >;

  @summary("Gets the config reference and status of an app")
  @doc("Description for Gets the config reference and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/appsettings/{appSettingKey}")
  @get
  GetAppSettingKeyVaultReferenceSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("App Setting key name.")
      @path
      appSettingKey: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApiKVReference
  >;

  @summary("Gets the config reference app settings and status of an app")
  @doc("Description for Gets the config reference app settings and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/connectionstrings")
  @get
  GetSiteConnectionStringKeyVaultReferencesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApiKVReferenceCollection
  >;

  @summary("Gets the config reference and status of an app")
  @doc("Description for Gets the config reference and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/connectionstrings/{connectionStringKey}")
  @get
  GetSiteConnectionStringKeyVaultReferenceSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      connectionStringKey: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ApiKVReference
  >;

  @summary("Replaces the connection strings of an app.")
  @doc("Description for Replaces the connection strings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/connectionstrings")
  @put
  UpdateConnectionStringsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the connection settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Connection strings of the app or deployment slot. See example.")
      @body
      connectionStrings: ConnectionStringDictionary;
    },
    ConnectionStringDictionary
  >;

  @summary("Gets the connection strings of an app.")
  @doc("Description for Gets the connection strings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/connectionstrings/list")
  @post
  ListConnectionStringsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the connection settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ConnectionStringDictionary
  >;

  @summary("Gets the logging configuration of an app.")
  @doc("Description for Gets the logging configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/logs")
  @get
  GetDiagnosticLogsConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the logging configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteLogsConfig
  >;

  @summary("Updates the logging configuration of an app.")
  @doc("Description for Updates the logging configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/logs")
  @put
  UpdateDiagnosticLogsConfigSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the logging configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A SiteLogsConfig JSON object that contains the logging configuration to change in the \"properties\" property.")
      @body
      siteLogsConfig: SiteLogsConfig;
    },
    SiteLogsConfig
  >;

  @summary("Replaces the metadata of an app.")
  @doc("Description for Replaces the metadata of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/metadata")
  @put
  UpdateMetadataSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the metadata for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Edited metadata of the app or deployment slot. See example.")
      @body
      metadata: StringDictionary;
    },
    StringDictionary
  >;

  @summary("Gets the metadata of an app.")
  @doc("Description for Gets the metadata of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/metadata/list")
  @post
  ListMetadataSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the metadata for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StringDictionary
  >;

  @summary("Gets the Git/FTP publishing credentials of an app.")
  @doc("Description for Gets the Git/FTP publishing credentials of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/publishingcredentials/list")
  @post
  ListPublishingCredentialsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the publishing credentials for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    User
  >;

  @summary("Updates the Push settings associated with web app.")
  @doc("Description for Updates the Push settings associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/pushsettings")
  @put
  UpdateSitePushSettingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Push settings associated with web app.")
      @body
      pushSettings: PushSettings;
    },
    PushSettings
  >;

  @summary("Gets the Push settings associated with web app.")
  @doc("Description for Gets the Push settings associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/pushsettings/list")
  @post
  ListSitePushSettingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PushSettings
  >;

  @summary("Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.")
  @doc("Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
  @get
  GetConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfig
  >;

  @summary("Updates the configuration of an app.")
  @doc("Description for Updates the configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
  @put
  CreateOrUpdateConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON representation of a SiteConfig object. See example.")
      @body
      siteConfig: SiteConfig;
    },
    SiteConfig
  >;

  @summary("Updates the configuration of an app.")
  @doc("Description for Updates the configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
  @patch
  UpdateConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON representation of a SiteConfig object. See example.")
      @body
      siteConfig: SiteConfig;
    },
    SiteConfig
  >;

  @summary("Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @doc("Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots")
  @get
  ListConfigurationSnapshotInfoSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfigurationSnapshotInfoCollection
  >;

  @summary("Gets a snapshot of the configuration of an app at a previous point in time.")
  @doc("Description for Gets a snapshot of the configuration of an app at a previous point in time.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots/{snapshotId}")
  @get
  GetConfigurationSnapshotSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of the snapshot to read.")
      @path
      snapshotId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfig
  >;

  @summary("Reverts the configuration of an app to a previous snapshot.")
  @doc("Description for Reverts the configuration of an app to a previous snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots/{snapshotId}/recover")
  @post
  RecoverSiteConfigurationSnapshotSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of the snapshot to read.")
      @path
      snapshotId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the last lines of docker logs for the given site")
  @doc("Description for Gets the last lines of docker logs for the given site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/containerlogs")
  @post
  GetWebSiteContainerLogsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Accept header")
      @header
      accept: "application/octet-stream";
    },
    void
  >;

  @summary("Gets the ZIP archived docker log files for the given site")
  @doc("Description for Gets the ZIP archived docker log files for the given site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/containerlogs/zip/download")
  @post
  GetContainerLogsZipSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Accept header")
      @header
      accept: "application/zip";
    },
    void
  >;

  @summary("List continuous web jobs for an app, or a deployment slot.")
  @doc("Description for List continuous web jobs for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs")
  @get
  ListContinuousWebJobsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ContinuousWebJobCollection
  >;

  @summary("Gets a continuous web job by its ID for an app, or a deployment slot.")
  @doc("Description for Gets a continuous web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}")
  @get
  GetContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ContinuousWebJob
  >;

  @summary("Delete a continuous web job by its ID for an app, or a deployment slot.")
  @doc("Description for Delete a continuous web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}")
  @delete
  DeleteContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Start a continuous web job for an app, or a deployment slot.")
  @doc("Description for Start a continuous web job for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}/start")
  @post
  StartContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Stop a continuous web job for an app, or a deployment slot.")
  @doc("Description for Stop a continuous web job for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}/stop")
  @post
  StopContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List deployments for an app, or a deployment slot.")
  @doc("Description for List deployments for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments")
  @get
  ListDeploymentsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    DeploymentCollection
  >;

  @summary("Get a deployment by its ID for an app, or a deployment slot.")
  @doc("Description for Get a deployment by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
  @get
  GetDeploymentSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Deployment ID.")
      @path
      id: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API gets a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    Deployment
  >;

  @summary("Create a deployment for an app, or a deployment slot.")
  @doc("Description for Create a deployment for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
  @put
  CreateDeploymentSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("ID of an existing deployment.")
      @path
      id: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API creates a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Deployment details.")
      @body
      deployment: Deployment;
    },
    Deployment
  >;

  @summary("Delete a deployment by its ID for an app, or a deployment slot.")
  @doc("Description for Delete a deployment by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
  @delete
  DeleteDeploymentSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Deployment ID.")
      @path
      id: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List deployment log for specific deployment for an app, or a deployment slot.")
  @doc("Description for List deployment log for specific deployment for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}/log")
  @get
  ListDeploymentLogSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of a specific deployment. This is the value of the name property in the JSON response from \"GET /api/sites/{siteName}/deployments\".")
      @path
      id: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    Deployment
  >;

  @summary("Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
  @doc("Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/discoverbackup")
  @post
  DiscoverBackupSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will perform discovery for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup.")
      @body
      request: RestoreRequest;
    },
    RestoreRequest
  >;

  @summary("Lists ownership identifiers for domain associated with web app.")
  @doc("Description for Lists ownership identifiers for domain associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers")
  @get
  ListDomainOwnershipIdentifiersSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    IdentifierCollection
  >;

  @summary("Get domain ownership identifier for web app.")
  @doc("Description for Get domain ownership identifier for web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @get
  GetDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of domain ownership identifier.")
      @path
      domainOwnershipIdentifierName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    Identifier
  >;

  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @put
  CreateOrUpdateDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of domain ownership identifier.")
      @path
      domainOwnershipIdentifierName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the domain ownership properties.")
      @body
      domainOwnershipIdentifier: Identifier;
    },
    Identifier
  >;

  @summary("Deletes a domain ownership identifier for a web app.")
  @doc("Description for Deletes a domain ownership identifier for a web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @delete
  DeleteDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of domain ownership identifier.")
      @path
      domainOwnershipIdentifierName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @patch
  UpdateDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of domain ownership identifier.")
      @path
      domainOwnershipIdentifierName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the domain ownership properties.")
      @body
      domainOwnershipIdentifier: Identifier;
    },
    Identifier
  >;

  @summary("Get the status of the last MSDeploy operation.")
  @doc("Description for Get the status of the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy")
  @get
  GetMSDeployStatusSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployStatus
  >;

  @summary("Invoke the MSDeploy web app extension.")
  @doc("Description for Invoke the MSDeploy web app extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy")
  @put
  CreateMSDeployOperationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Details of MSDeploy operation")
      @body
      MSDeploy: MSDeploy;
    },
    MSDeployStatus
  >;

  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @doc("Description for Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy/log")
  @get
  GetMSDeployLogSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;

  @summary("List the functions for a web site, or a deployment slot.")
  @doc("Description for List the functions for a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions")
  @get
  ListInstanceFunctionsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    FunctionEnvelopeCollection
  >;

  @summary("Fetch a short lived token that can be exchanged for a master key.")
  @doc("Description for Fetch a short lived token that can be exchanged for a master key.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/admin/token")
  @get
  GetFunctionsAdminTokenSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get function information by its ID for web site, or a deployment slot.")
  @doc("Description for Get function information by its ID for web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
  @get
  GetInstanceFunctionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Function name.")
      @path
      functionName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    FunctionEnvelope
  >;

  @summary("Create function for web site, or a deployment slot.")
  @doc("Description for Create function for web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
  @put
  CreateInstanceFunctionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Function name.")
      @path
      functionName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Function details.")
      @body
      function_envelope: FunctionEnvelope;
    },
    FunctionEnvelope
  >;

  @summary("Delete a function for web site, or a deployment slot.")
  @doc("Description for Delete a function for web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
  @delete
  DeleteInstanceFunctionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Function name.")
      @path
      functionName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Add or update a function secret.")
  @doc("Description for Add or update a function secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/keys/{keyName}")
  @put
  CreateOrUpdateFunctionSecretSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("The name of the function.")
      @path
      functionName: string;

      @doc("The name of the key.")
      @path
      keyName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The key to create or update")
      @body
      key: KeyInfo;
    },
    KeyInfo
  >;

  @summary("Delete a function secret.")
  @doc("Description for Delete a function secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/keys/{keyName}")
  @delete
  DeleteFunctionSecretSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("The name of the function.")
      @path
      functionName: string;

      @doc("The name of the key.")
      @path
      keyName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get function keys for a function in a web site, or a deployment slot.")
  @doc("Description for Get function keys for a function in a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/listkeys")
  @post
  ListFunctionKeysSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Function name.")
      @path
      functionName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StringDictionary
  >;

  @summary("Get function secrets for a function in a web site, or a deployment slot.")
  @doc("Description for Get function secrets for a function in a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/listsecrets")
  @post
  ListFunctionSecretsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Function name.")
      @path
      functionName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    FunctionSecrets
  >;

  @summary("Get host secrets for a function app.")
  @doc("Description for Get host secrets for a function app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/listkeys")
  @post
  ListHostKeysSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HostKeys
  >;

  @summary("This is to allow calling via powershell and ARM template.")
  @doc("Description for This is to allow calling via powershell and ARM template.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/listsyncstatus")
  @post
  ListSyncStatusSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Syncs function trigger metadata to the management database")
  @doc("Description for Syncs function trigger metadata to the management database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/sync")
  @post
  SyncFunctionsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Add or update a host level secret.")
  @doc("Description for Add or update a host level secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
  @put
  CreateOrUpdateHostSecretSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("The type of host key.")
      @path
      keyType: string;

      @doc("The name of the key.")
      @path
      keyName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The key to create or update")
      @body
      key: KeyInfo;
    },
    KeyInfo
  >;

  @summary("Delete a host level secret.")
  @doc("Description for Delete a host level secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
  @delete
  DeleteHostSecretSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("The type of host key.")
      @path
      keyType: string;

      @doc("The name of the key.")
      @path
      keyName: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get hostname bindings for an app or a deployment slot.")
  @doc("Description for Get hostname bindings for an app or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings")
  @get
  ListHostNameBindingsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API gets hostname bindings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HostNameBindingCollection
  >;

  @summary("Get the named hostname binding for an app (or deployment slot, if specified).")
  @doc("Description for Get the named hostname binding for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
  @get
  GetHostNameBindingSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot.")
      @path
      slot: string;

      @doc("Hostname in the hostname binding.")
      @path
      hostName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HostNameBinding
  >;

  @summary("Creates a hostname binding for an app.")
  @doc("Description for Creates a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
  @put
  CreateOrUpdateHostNameBindingSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Hostname in the hostname binding.")
      @path
      hostName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Binding details. This is the JSON representation of a HostNameBinding object.")
      @body
      hostNameBinding: HostNameBinding;
    },
    HostNameBinding
  >;

  @summary("Deletes a hostname binding for an app.")
  @doc("Description for Deletes a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
  @delete
  DeleteHostNameBindingSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Hostname in the hostname binding.")
      @path
      hostName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  @doc("Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @get
  GetHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @doc("Description for Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @put
  CreateOrUpdateHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The details of the hybrid connection.")
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  @summary("Removes a Hybrid Connection from this site.")
  @doc("Description for Removes a Hybrid Connection from this site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @delete
  DeleteHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @doc("Description for Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @patch
  UpdateHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The namespace for this hybrid connection.")
      @path
      namespaceName: string;

      @doc("The relay name for this hybrid connection.")
      @path
      relayName: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The details of the hybrid connection.")
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  @summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @doc("Description for Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionRelays")
  @get
  ListHybridConnectionsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  @summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @doc("Description for Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection")
  @get
  ListRelayServiceConnectionsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get hybrid connections for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RelayServiceConnectionEntity
  >;

  @summary("Gets a hybrid connection configuration by its name.")
  @doc("Description for Gets a hybrid connection configuration by its name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @get
  GetRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the hybrid connection.")
      @path
      entityName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get a hybrid connection for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RelayServiceConnectionEntity
  >;

  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @put
  CreateOrUpdateRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the hybrid connection configuration.")
      @path
      entityName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will create or update a hybrid connection for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Details of the hybrid connection configuration.")
      @body
      connectionEnvelope: RelayServiceConnectionEntity;
    },
    RelayServiceConnectionEntity
  >;

  @summary("Deletes a relay service connection by its name.")
  @doc("Description for Deletes a relay service connection by its name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @delete
  DeleteRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the hybrid connection configuration.")
      @path
      entityName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete a hybrid connection for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @patch
  UpdateRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the hybrid connection configuration.")
      @path
      entityName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will create or update a hybrid connection for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Details of the hybrid connection configuration.")
      @body
      connectionEnvelope: RelayServiceConnectionEntity;
    },
    RelayServiceConnectionEntity
  >;

  @summary("Gets all scale-out instances of an app.")
  @doc("Description for Gets all scale-out instances of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances")
  @get
  ListInstanceIdentifiersSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API gets the production slot instances.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WebAppInstanceStatusCollection
  >;

  @summary("Gets all scale-out instances of an app.")
  @doc("Description for Gets all scale-out instances of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}")
  @get
  GetInstanceInfoSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @path
      instanceId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API gets the production slot instances.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WebSiteInstanceStatus
  >;

  @summary("Get the status of the last MSDeploy operation.")
  @doc("Description for Get the status of the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy")
  @get
  GetInstanceMsDeployStatusSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("ID of web app instance.")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployStatus
  >;

  @summary("Invoke the MSDeploy web app extension.")
  @doc("Description for Invoke the MSDeploy web app extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy")
  @put
  CreateInstanceMSDeployOperationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("ID of web app instance.")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Details of MSDeploy operation")
      @body
      MSDeploy: MSDeploy;
    },
    MSDeployStatus
  >;

  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @doc("Description for Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy/log")
  @get
  GetInstanceMSDeployLogSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("ID of web app instance.")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;

  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @doc("Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes")
  @get
  ListInstanceProcessesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessInfoCollection
  >;

  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}")
  @get
  GetInstanceProcessSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessInfo
  >;

  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @doc("Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}")
  @delete
  DeleteInstanceProcessSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/dump")
  @get
  GetInstanceProcessDumpSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/modules")
  @get
  ListInstanceProcessModulesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessModuleInfoCollection
  >;

  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/modules/{baseAddress}")
  @get
  GetInstanceProcessModuleSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Module base address.")
      @path
      baseAddress: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessModuleInfo
  >;

  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/threads")
  @get
  ListInstanceProcessThreadsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;

  @summary("Shows whether an app can be cloned to another resource group or subscription.")
  @doc("Description for Shows whether an app can be cloned to another resource group or subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/iscloneable")
  @post
  IsCloneableSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. By default, this API returns information on the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteCloneability
  >;

  @summary("Gets existing backups of an app.")
  @doc("Description for Gets existing backups of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/listbackups")
  @post
  ListSiteBackupsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get backups of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    BackupItemCollection
  >;

  @summary("This is to allow calling via powershell and ARM template.")
  @doc("Description for This is to allow calling via powershell and ARM template.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/listsyncfunctiontriggerstatus")
  @post
  ListSyncFunctionTriggersSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    FunctionSecrets
  >;

  @summary("Gets a Swift Virtual Network connection.")
  @doc("Description for Gets a Swift Virtual Network connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @get
  GetSwiftVirtualNetworkConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SwiftVirtualNetwork
  >;

  @summary("""
Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  @doc("""
Description for Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @put
  CreateOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the Virtual Network connection. See example.")
      @body
      connectionEnvelope: SwiftVirtualNetwork;
    },
    SwiftVirtualNetwork
  >;

  @summary("Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  @doc("Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @delete
  DeleteSwiftVirtualNetworkSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the connection for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("""
Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  @doc("""
Description for Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @patch
  UpdateSwiftVirtualNetworkConnectionWithCheckSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the Virtual Network connection. See example.")
      @body
      connectionEnvelope: SwiftVirtualNetwork;
    },
    SwiftVirtualNetwork
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/operationresults/{operationId}")
  @get
  GetNetworkTraceOperationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Start capturing network packets for the site (To be deprecated).")
  @doc("Description for Start capturing network packets for the site (To be deprecated).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/start")
  @post
  StartWebSiteNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The duration to keep capturing in seconds.")
      @query("durationInSeconds")
      durationInSeconds?: int32;

      @doc("The name of the slot for this web app.")
      @path
      slot: string;

      @doc("The maximum frame length in bytes (Optional).")
      @query("maxFrameLength")
      maxFrameLength?: int32;

      @doc("The Blob URL to store capture file.")
      @query("sasUrl")
      sasUrl?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Start capturing network packets for the site.")
  @doc("Description for Start capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/startOperation")
  @post
  StartWebSiteNetworkTraceOperationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The duration to keep capturing in seconds.")
      @query("durationInSeconds")
      durationInSeconds?: int32;

      @doc("The name of the slot for this web app.")
      @path
      slot: string;

      @doc("The maximum frame length in bytes (Optional).")
      @query("maxFrameLength")
      maxFrameLength?: int32;

      @doc("The Blob URL to store capture file.")
      @query("sasUrl")
      sasUrl?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Stop ongoing capturing network packets for the site.")
  @doc("Description for Stop ongoing capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/stop")
  @post
  StopWebSiteNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The name of the slot for this web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/{operationId}")
  @get
  GetNetworkTracesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTraces/current/operationresults/{operationId}")
  @get
  GetNetworkTraceOperationSlotV2 is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTraces/{operationId}")
  @get
  GetNetworkTracesSlotV2 is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Generates a new publishing password for an app (or deployment slot, if specified).")
  @doc("Description for Generates a new publishing password for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/newpassword")
  @post
  GenerateNewSitePublishingPasswordSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API generate a new publishing password for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets perfmon counters for web app.")
  @doc("Description for Gets perfmon counters for web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/perfcounters")
  @get
  ListPerfMonCountersSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.")
      @query("$filter")
      $filter?: string;
    },
    PerfMonCounterCollection
  >;

  @summary("Gets web app's event logs.")
  @doc("Description for Gets web app's event logs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/phplogging")
  @get
  GetSitePhpErrorLogFlagSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SitePhpErrorLogFlag
  >;

  @summary("Gets the premier add-ons of an app.")
  @doc("Description for Gets the premier add-ons of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons")
  @get
  ListPremierAddOnsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the premier add-ons for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PremierAddOn
  >;

  @summary("Gets a named add-on of an app.")
  @doc("Description for Gets a named add-on of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @get
  GetPremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Add-on name.")
      @path
      premierAddOnName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the named add-on for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PremierAddOn
  >;

  @summary("Updates a named add-on of an app.")
  @doc("Description for Updates a named add-on of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @put
  AddPremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Add-on name.")
      @path
      premierAddOnName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the named add-on for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the edited premier add-on.")
      @body
      premierAddOn: PremierAddOn;
    },
    PremierAddOn
  >;

  @summary("Delete a premier add-on from an app.")
  @doc("Description for Delete a premier add-on from an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @delete
  DeletePremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Add-on name.")
      @path
      premierAddOnName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the named add-on for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Updates a named add-on of an app.")
  @doc("Description for Updates a named add-on of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @patch
  UpdatePremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Add-on name.")
      @path
      premierAddOnName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will update the named add-on for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("A JSON representation of the edited premier add-on.")
      @body
      premierAddOn: PremierAddOnPatchResource;
    },
    PremierAddOn
  >;

  @summary("Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  @doc("Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateAccess/virtualNetworks")
  @get
  GetPrivateAccessSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateAccess
  >;

  @summary("Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  @doc("Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateAccess/virtualNetworks")
  @put
  PutPrivateAccessVnetSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The name of the slot for the web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The information for the private access")
      @body
      access: PrivateAccess;
    },
    PrivateAccess
  >;

  @summary("Gets the list of private endpoint connections associated with a site")
  @doc("Description for Gets the list of private endpoint connections associated with a site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections")
  @get
  GetPrivateEndpointConnectionListSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @doc("Name of the site deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionCollection
  >;

  @summary("Gets a private endpoint connection")
  @doc("Description for Gets a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  GetPrivateEndpointConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @doc("Name of the private endpoint connection.")
      @path
      privateEndpointConnectionName: string;

      @doc("Name of the site deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  @summary("Approves or rejects a private endpoint connection")
  @doc("Description for Approves or rejects a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  ApproveOrRejectPrivateEndpointConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @body
      privateEndpointWrapper: PrivateLinkConnectionApprovalRequestResource;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  @summary("Deletes a private endpoint connection")
  @doc("Description for Deletes a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  DeletePrivateEndpointConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the private link resources")
  @doc("Description for Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateLinkResources")
  @get
  GetPrivateLinkResourcesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;

  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @doc("Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes")
  @get
  ListProcessesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessInfoCollection
  >;

  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}")
  @get
  GetProcessSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessInfo
  >;

  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @doc("Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}")
  @delete
  DeleteProcessSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/dump")
  @get
  GetProcessDumpSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/modules")
  @get
  ListProcessModulesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessModuleInfoCollection
  >;

  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/modules/{baseAddress}")
  @get
  GetProcessModuleSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Module base address.")
      @path
      baseAddress: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessModuleInfo
  >;

  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/threads")
  @get
  ListProcessThreadsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;

  @summary("Get public certificates for an app or a deployment slot.")
  @doc("Description for Get public certificates for an app or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates")
  @get
  ListPublicCertificatesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API gets hostname bindings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PublicCertificateCollection
  >;

  @summary("Get the named public certificate for an app (or deployment slot, if specified).")
  @doc("Description for Get the named public certificate for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
  @get
  GetPublicCertificateSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot.")
      @path
      slot: string;

      @doc("Public certificate name.")
      @path
      publicCertificateName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PublicCertificate
  >;

  @summary("Creates a hostname binding for an app.")
  @doc("Description for Creates a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
  @put
  CreateOrUpdatePublicCertificateSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Public certificate name.")
      @path
      publicCertificateName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Public certificate details. This is the JSON representation of a PublicCertificate object.")
      @body
      publicCertificate: PublicCertificate;
    },
    PublicCertificate
  >;

  @summary("Deletes a hostname binding for an app.")
  @doc("Description for Deletes a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
  @delete
  DeletePublicCertificateSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.")
      @path
      slot: string;

      @doc("Public certificate name.")
      @path
      publicCertificateName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the publishing profile for an app (or deployment slot, if specified).")
  @doc("Description for Gets the publishing profile for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publishxml")
  @post
  ListPublishingProfileXmlWithSecretsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the publishing profile for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Specifies publishingProfileOptions for publishing profile. For example, use {\"format\": \"FileZilla3\"} to get a FileZilla publishing profile.")
      @body
      publishingProfileOptions: CsmPublishingProfileOptions;

      @doc("Accept header")
      @header
      accept: "application/xml";
    },
    void
  >;

  @summary("Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
  @doc("Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resetSlotConfig")
  @post
  ResetSlotConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API resets configuration settings for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Restarts an app (or deployment slot, if specified).")
  @doc("Description for Restarts an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restart")
  @post
  RestartSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will restart the production slot.")
      @path
      slot: string;

      @doc("Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.")
      @query("softRestart")
      softRestart?: boolean;

      @doc("Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).")
      @query("synchronous")
      synchronous?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Restores an app from a backup blob in Azure Storage.")
  @doc("Description for Restores an app from a backup blob in Azure Storage.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreFromBackupBlob")
  @post
  RestoreFromBackupBlobSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will restore a backup of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Information on restore request .")
      @body
      request: RestoreRequest;
    },
    void
  >;

  @summary("Restores a deleted web app to this web app.")
  @doc("Description for Restores a deleted web app to this web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreFromDeletedApp")
  @post
  RestoreFromDeletedAppSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Deleted web app restore information.")
      @body
      restoreRequest: DeletedAppRestoreRequest;
    },
    void
  >;

  @summary("Restores a web app from a snapshot.")
  @doc("Description for Restores a web app from a snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreSnapshot")
  @post
  RestoreSnapshotSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API.")
      @body
      restoreRequest: SnapshotRestoreRequest;
    },
    void
  >;

  @summary("Get list of siteextensions for a web site, or a deployment slot.")
  @doc("Description for Get list of siteextensions for a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions")
  @get
  ListSiteExtensionsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API uses the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteExtensionInfoCollection
  >;

  @summary("Get site extension information by its ID for a web site, or a deployment slot.")
  @doc("Description for Get site extension information by its ID for a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
  @get
  GetSiteExtensionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Site extension name.")
      @path
      siteExtensionId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API uses the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteExtensionInfo
  >;

  @summary("Install site extension on a web site, or a deployment slot.")
  @doc("Description for Install site extension on a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
  @put
  InstallSiteExtensionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Site extension name.")
      @path
      siteExtensionId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API uses the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteExtensionInfo
  >;

  @summary("Remove a site extension from a web site, or a deployment slot.")
  @doc("Description for Remove a site extension from a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
  @delete
  DeleteSiteExtensionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Site extension name.")
      @path
      siteExtensionId: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Get the difference in configuration settings between two web app slots.")
  @doc("Description for Get the difference in configuration settings between two web app slots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/slotsdiffs")
  @post
  ListSlotDifferencesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the source slot. If a slot is not specified, the production slot is used as the source slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON object that contains the target slot name. See example.")
      @body
      slotSwapEntity: CsmSlotEntity;
    },
    SlotDifferenceCollection
  >;

  @summary("Swaps two deployment slots of an app.")
  @doc("Description for Swaps two deployment slots of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/slotsswap")
  @post
  SwapSlotSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the source slot. If a slot is not specified, the production slot is used as the source slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON object that contains the target slot name. See example.")
      @body
      slotSwapEntity: CsmSlotEntity;
    },
    void
  >;

  @summary("Returns all Snapshots to the user.")
  @doc("Description for Returns all Snapshots to the user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/snapshots")
  @get
  ListSnapshotsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Website Name.")
      @path
      name: string;

      @doc("Website Slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  @summary("Returns all Snapshots to the user from DRSecondary endpoint.")
  @doc("Description for Returns all Snapshots to the user from DRSecondary endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/snapshotsdr")
  @get
  ListSnapshotsFromDRSecondarySlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Website Name.")
      @path
      name: string;

      @doc("Website Slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  @summary("Starts an app (or deployment slot, if specified).")
  @doc("Description for Starts an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/start")
  @post
  StartSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will start the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Start capturing network packets for the site.")
  @doc("Description for Start capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/startNetworkTrace")
  @post
  StartNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The duration to keep capturing in seconds.")
      @query("durationInSeconds")
      durationInSeconds?: int32;

      @doc("The name of the slot for this web app.")
      @path
      slot: string;

      @doc("The maximum frame length in bytes (Optional).")
      @query("maxFrameLength")
      maxFrameLength?: int32;

      @doc("The Blob URL to store capture file.")
      @query("sasUrl")
      sasUrl?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Stops an app (or deployment slot, if specified).")
  @doc("Description for Stops an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/stop")
  @post
  StopSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will stop the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Stop ongoing capturing network packets for the site.")
  @doc("Description for Stop ongoing capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/stopNetworkTrace")
  @post
  StopNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("The name of the slot for this web app.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Sync web app repository.")
  @doc("Description for Sync web app repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/sync")
  @post
  SyncRepositorySlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Name of web app slot. If not specified then will default to production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Syncs function trigger metadata to the management database")
  @doc("Description for Syncs function trigger metadata to the management database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/syncfunctiontriggers")
  @post
  SyncFunctionTriggersSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the quota usage information of an app (or deployment slot, if specified).")
  @doc("Description for Gets the quota usage information of an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/usages")
  @get
  ListUsagesSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get quota information of the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.")
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;

  @summary("Gets the virtual networks the app (or deployment slot) is connected to.")
  @doc("Description for Gets the virtual networks the app (or deployment slot) is connected to.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections")
  @get
  ListVnetConnectionsSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get virtual network connections for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a virtual network the app (or deployment slot) is connected to by name.")
  @doc("Description for Gets a virtual network the app (or deployment slot) is connected to by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @get
  GetVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the virtual network.")
      @path
      vnetName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get the named virtual network for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    VnetInfoResource
  >;

  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @doc("Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @put
  CreateOrUpdateVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of an existing Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the Virtual Network connection. See example.")
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  @summary("Deletes a connection from an app (or deployment slot to a named virtual network.")
  @doc("Description for Deletes a connection from an app (or deployment slot to a named virtual network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @delete
  DeleteVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the virtual network.")
      @path
      vnetName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will delete the connection for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @doc("Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @patch
  UpdateVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of an existing Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the Virtual Network connection. See example.")
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  @summary("Gets an app's Virtual Network gateway.")
  @doc("Description for Gets an app's Virtual Network gateway.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @get
  GetVnetConnectionGatewaySlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the gateway. Currently, the only supported string is \"primary\".")
      @path
      gatewayName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    VnetGateway
  >;

  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @doc("Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @put
  CreateOrUpdateVnetConnectionGatewaySlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the gateway. Currently, the only supported string is \"primary\".")
      @path
      gatewayName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will add or update a gateway for the production slot's Virtual Network.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The properties to update this gateway with.")
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @doc("Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @patch
  UpdateVnetConnectionGatewaySlot is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the gateway. Currently, the only supported string is \"primary\".")
      @path
      gatewayName: string;

      @doc("Name of the deployment slot. If a slot is not specified, the API will add or update a gateway for the production slot's Virtual Network.")
      @path
      slot: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The properties to update this gateway with.")
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  @summary("Gets the source control configuration of an app.")
  @doc("Description for Gets the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @get
  GetSourceControl is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteSourceControl
  >;

  @summary("Updates the source control configuration of an app.")
  @doc("Description for Updates the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @put
  CreateOrUpdateSourceControl is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON representation of a SiteSourceControl object. See example.")
      @body
      siteSourceControl: SiteSourceControl;
    },
    SiteSourceControl
  >;

  @summary("Deletes the source control configuration of an app.")
  @doc("Description for Deletes the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @delete
  DeleteSourceControl is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @query("additionalFlags")
      additionalFlags?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Updates the source control configuration of an app.")
  @doc("Description for Updates the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @patch
  UpdateSourceControl is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("JSON representation of a SiteSourceControl object. See example.")
      @body
      siteSourceControl: SiteSourceControl;
    },
    SiteSourceControl
  >;

  @summary("List triggered web jobs for an app, or a deployment slot.")
  @doc("Description for List triggered web jobs for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs")
  @get
  ListTriggeredWebJobs is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    TriggeredWebJobCollection
  >;

  @summary("Gets a triggered web job by its ID for an app, or a deployment slot.")
  @doc("Description for Gets a triggered web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}")
  @get
  GetTriggeredWebJob is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    TriggeredWebJob
  >;

  @summary("Delete a triggered web job by its ID for an app, or a deployment slot.")
  @doc("Description for Delete a triggered web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}")
  @delete
  DeleteTriggeredWebJob is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List a triggered web job's history for an app, or a deployment slot.")
  @doc("Description for List a triggered web job's history for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/history")
  @get
  ListTriggeredWebJobHistory is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    TriggeredJobHistoryCollection
  >;

  @summary("Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  @doc("Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/history/{id}")
  @get
  GetTriggeredWebJobHistory is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("History ID.")
      @path
      id: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    TriggeredJobHistory
  >;

  @summary("Run a triggered web job for an app, or a deployment slot.")
  @doc("Description for Run a triggered web job for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/run")
  @post
  RunTriggeredWebJob is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of Web Job.")
      @path
      webJobName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets the virtual networks the app (or deployment slot) is connected to.")
  @doc("Description for Gets the virtual networks the app (or deployment slot) is connected to.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections")
  @get
  ListVnetConnections is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a virtual network the app (or deployment slot) is connected to by name.")
  @doc("Description for Gets a virtual network the app (or deployment slot) is connected to by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @get
  GetVnetConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the virtual network.")
      @path
      vnetName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    VnetInfoResource
  >;

  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @doc("Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @put
  CreateOrUpdateVnetConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of an existing Virtual Network.")
      @path
      vnetName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the Virtual Network connection. See example.")
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  @summary("Deletes a connection from an app (or deployment slot to a named virtual network.")
  @doc("Description for Deletes a connection from an app (or deployment slot to a named virtual network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @delete
  DeleteVnetConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the virtual network.")
      @path
      vnetName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @doc("Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @patch
  UpdateVnetConnection is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of an existing Virtual Network.")
      @path
      vnetName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Properties of the Virtual Network connection. See example.")
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  @summary("Gets an app's Virtual Network gateway.")
  @doc("Description for Gets an app's Virtual Network gateway.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @get
  GetVnetConnectionGateway is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the gateway. Currently, the only supported string is \"primary\".")
      @path
      gatewayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    VnetGateway
  >;

  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @doc("Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @put
  CreateOrUpdateVnetConnectionGateway is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the gateway. Currently, the only supported string is \"primary\".")
      @path
      gatewayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The properties to update this gateway with.")
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @doc("Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @patch
  UpdateVnetConnectionGateway is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Name of the gateway. Currently, the only supported string is \"primary\".")
      @path
      gatewayName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("The properties to update this gateway with.")
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  @summary("List webjobs for an app, or a deployment slot.")
  @doc("Description for List webjobs for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/webjobs")
  @get
  ListWebJobs is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WebJobCollection
  >;

  @summary("Get webjob information for an app, or a deployment slot.")
  @doc("Description for Get webjob information for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/webjobs/{webJobName}")
  @get
  GetWebJob is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("Name of the web job.")
      @path
      webJobName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    WebJob
  >;
}
