import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;

interface AppServiceCertificateOrdersOperations {
  /**
   * Description for Validate information for a certificate order.
   */
  @summary("Validate information for a certificate order.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.CertificateRegistration/validateCertificateRegistrationInformation")
  @post
  validatePurchaseInformation is Azure.Core.Foundations.Operation<
    {
      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Information for a certificate order.
       */
      @body
      appServiceCertificateOrder: AppServiceCertificateOrder;
    },
    void
  >;
}

interface DomainsOperations {
  /**
   * Description for Check if a domain is available for registration.
   */
  @summary("Check if a domain is available for registration.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/checkDomainAvailability")
  @post
  checkAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Name of the domain.
       */
      @body
      identifier: NameIdentifier;
    },
    DomainAvailabilityCheckResult
  >;

  /**
   * Description for Generate a single sign-on request for the domain management portal.
   */
  @summary("Generate a single sign-on request for the domain management portal.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/generateSsoRequest")
  @post
  getControlCenterSsoRequest is Azure.Core.Foundations.Operation<
    {
      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DomainControlCenterSsoRequest
  >;

  /**
   * Description for Get domain name recommendations based on keywords.
   */
  @summary("Get domain name recommendations based on keywords.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/listDomainRecommendations")
  @post
  listRecommendations is Azure.Core.Foundations.Operation<
    {
      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Search parameters for domain name recommendations.
       */
      @body
      parameters: DomainRecommendationSearchParameters;
    },
    NameIdentifierCollection
  >;
}

interface AppServiceEnvironmentsOperations {
  /**
   * Description for Get all worker pools of an App Service Environment.
   */
  @summary("Get all worker pools of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools")
  @get
  listWorkerPools is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<WorkerPoolResource>
  >;

  /**
   * Description for Get properties of a worker pool.
   */
  @summary("Get properties of a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
  @get
  getWorkerPool is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    WorkerPoolResource
  >;

  /**
   * Description for Create or update a worker pool.
   */
  @summary("Create or update a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
  @put
  createOrUpdateWorkerPool is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the worker pool.
       */
      @body
      workerPoolEnvelope: WorkerPoolResource;
    },
    WorkerPoolResource
  >;

  /**
   * Description for Create or update a worker pool.
   */
  @summary("Create or update a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}")
  @patch
  updateWorkerPool is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the worker pool.
       */
      @body
      workerPoolEnvelope: WorkerPoolResource;
    },
    WorkerPoolResource
  >;

  /**
   * Description for Get metric definitions for a specific instance of a worker pool of an App Service Environment.
   */
  @summary("Get metric definitions for a specific instance of a worker pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/instances/{instance}/metricdefinitions")
  @get
  listWorkerPoolInstanceMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Name of the instance in the worker pool.
       */
      @path
      instance: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  /**
   * Description for Get metric definitions for a worker pool of an App Service Environment.
   */
  @summary("Get metric definitions for a worker pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/metricdefinitions")
  @get
  listWebWorkerMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  /**
   * Description for Get available SKUs for scaling a worker pool.
   */
  @summary("Get available SKUs for scaling a worker pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/skus")
  @get
  listWorkerPoolSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SkuInfoCollection
  >;

  /**
   * Description for Get usage metrics for a worker pool of an App Service Environment.
   */
  @summary("Get usage metrics for a worker pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/usages")
  @get
  listWebWorkerUsages is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the worker pool.
       */
      @path
      workerPoolName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    UsageCollection
  >;
}

interface DiagnosticsOperations {
  /**
   * Description for List Hosting Environment Detector Responses
   */
  @summary("List Hosting Environment Detector Responses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/detectors")
  @get
  listHostingEnvironmentDetectorResponses is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DetectorResponse>
  >;

  /**
   * Description for Get Hosting Environment Detector Response
   */
  @summary("Get Hosting Environment Detector Response")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/detectors/{detectorName}")
  @get
  getHostingEnvironmentDetectorResponse is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * App Service Environment Name
       */
      @path
      name: string;

      /**
       * Detector Resource Name
       */
      @path
      detectorName: string;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DetectorResponse
  >;

  /**
   * Description for List Site Detector Responses
   */
  @summary("List Site Detector Responses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/detectors")
  @get
  listSiteDetectorResponses is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DetectorResponse>
  >;

  /**
   * Description for Get site detector response
   */
  @summary("Get site detector response")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/detectors/{detectorName}")
  @get
  getSiteDetectorResponse is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Detector Resource Name
       */
      @path
      detectorName: string;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DetectorResponse
  >;

  /**
   * Description for List Site Detector Responses
   */
  @summary("List Site Detector Responses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/detectors")
  @get
  listSiteDetectorResponsesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DetectorResponse>
  >;

  /**
   * Description for Get site detector response
   */
  @summary("Get site detector response")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/detectors/{detectorName}")
  @get
  getSiteDetectorResponseSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Detector Resource Name
       */
      @path
      detectorName: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DetectorResponse
  >;

  /**
   * Description for Get Diagnostics Categories
   */
  @summary("Get Diagnostics Categories")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics")
  @get
  listSiteDiagnosticCategoriesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DiagnosticCategory>
  >;

  /**
   * Description for Get Diagnostics Category
   */
  @summary("Get Diagnostics Category")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}")
  @get
  getSiteDiagnosticCategorySlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Diagnostic Category
       */
      @path
      diagnosticCategory: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DiagnosticCategory
  >;

  /**
   * Description for Get Site Analyses
   */
  @summary("Get Site Analyses")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses")
  @get
  listSiteAnalysesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Diagnostic Category
       */
      @path
      diagnosticCategory: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<AnalysisDefinition>
  >;

  /**
   * Description for Get Site Analysis
   */
  @summary("Get Site Analysis")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}")
  @get
  getSiteAnalysisSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Diagnostic Category
       */
      @path
      diagnosticCategory: string;

      /**
       * Analysis Name
       */
      @path
      analysisName: string;

      /**
       * Slot - optional
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    AnalysisDefinition
  >;

  /**
   * Description for Execute Analysis
   */
  @summary("Execute Analysis")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}/execute")
  @post
  executeSiteAnalysisSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Category Name
       */
      @path
      diagnosticCategory: string;

      /**
       * Analysis Resource Name
       */
      @path
      analysisName: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DiagnosticAnalysis
  >;

  /**
   * Description for Get Detectors
   */
  @summary("Get Detectors")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors")
  @get
  listSiteDetectorsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Diagnostic Category
       */
      @path
      diagnosticCategory: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DetectorDefinitionResource>
  >;

  /**
   * Description for Get Detector
   */
  @summary("Get Detector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors/{detectorName}")
  @get
  getSiteDetectorSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Diagnostic Category
       */
      @path
      diagnosticCategory: string;

      /**
       * Detector Name
       */
      @path
      detectorName: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DetectorDefinitionResource
  >;

  /**
   * Description for Execute Detector
   */
  @summary("Execute Detector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/detectors/{detectorName}/execute")
  @post
  executeSiteDetectorSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site Name
       */
      @path
      siteName: string;

      /**
       * Detector Resource Name
       */
      @path
      detectorName: string;

      /**
       * Category Name
       */
      @path
      diagnosticCategory: string;

      /**
       * Slot Name
       */
      @path
      slot: string;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    DiagnosticDetectorResponse
  >;
}

interface ProviderOperations {
  /**
   * Description for Get available application frameworks and their versions
   */
  @summary("Get available application frameworks and their versions")
  @route("/providers/Microsoft.Web/availableStacks")
  @get
  getAvailableStacks is Azure.Core.Foundations.Operation<
    {
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;
    },
    ApplicationStackCollection
  >;

  /**
   * Description for Get available Function app frameworks and their versions
   */
  @summary("Get available Function app frameworks and their versions")
  @route("/providers/Microsoft.Web/functionAppStacks")
  @get
  getFunctionAppStacks is Azure.Core.Foundations.Operation<
    {
      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    FunctionAppStackCollection
  >;

  /**
   * Description for Get available Function app frameworks and their versions for location
   */
  @summary("Get available Function app frameworks and their versions for location")
  @route("/providers/Microsoft.Web/locations/{location}/functionAppStacks")
  @get
  getFunctionAppStacksForLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * Function App stack location.
       */
      @path
      location: string;

      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    FunctionAppStackCollection
  >;

  /**
   * Description for Get available Web app frameworks and their versions for location
   */
  @summary("Get available Web app frameworks and their versions for location")
  @route("/providers/Microsoft.Web/locations/{location}/webAppStacks")
  @get
  getWebAppStacksForLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * Web App stack location.
       */
      @path
      location: string;

      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    WebAppStackCollection
  >;

  /**
   * Description for Get available Web app frameworks and their versions
   */
  @summary("Get available Web app frameworks and their versions")
  @route("/providers/Microsoft.Web/webAppStacks")
  @get
  getWebAppStacks is Azure.Core.Foundations.Operation<
    {
      /**
       * Stack OS Type
       */
      @query("stackOsType")
      stackOsType?: ProviderStackOsType;
    },
    WebAppStackCollection
  >;

  /**
   * Description for Get available application frameworks and their versions
   */
  @summary("Get available application frameworks and their versions")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/availableStacks")
  @get
  getAvailableStacksOnPrem is Azure.Core.Foundations.Operation<
    {
      @query("osTypeSelected")
      osTypeSelected?: ProviderOsTypeSelected;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ApplicationStackCollection
  >;
}

interface RecommendationsOperations {
  /**
   * Description for List all recommendations for a subscription.
   */
  @summary("List all recommendations for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
       */
      @query("featured")
      featured?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
       */
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  /**
   * Description for Reset all recommendation opt-out settings for a subscription.
   */
  @summary("Reset all recommendation opt-out settings for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/reset")
  @post
  resetAllFilters is Azure.Core.Foundations.Operation<
    {
      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Disables the specified rule so it will not apply to a subscription in the future.
   */
  @summary("Disables the specified rule so it will not apply to a subscription in the future.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/{name}/disable")
  @post
  disableRecommendationForSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * Rule name
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get a recommendation rule for an app.
   */
  @summary("Get a recommendation rule for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}")
  @get
  getRuleDetailsByWebApp is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      siteName: string;

      /**
       * Name of the recommendation.
       */
      @path
      name: string;

      /**
       * Specify <code>true</code> to update the last-seen timestamp of the recommendation object.
       */
      @query("updateSeen")
      updateSeen?: boolean;

      /**
       * The GUID of the recommendation object if you query an expired one. You don't need to specify it to query an active entry.
       */
      @query("recommendationId")
      recommendationId?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RecommendationRule
  >;

  /**
   * Description for Disables the specific rule for a web site permanently.
   */
  @summary("Disables the specific rule for a web site permanently.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}/disable")
  @post
  disableRecommendationForSite is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name
       */
      @path
      siteName: string;

      /**
       * Rule name
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ResourceHealthMetadataOperations {
  /**
   * Description for List all ResourceHealthMetadata for all sites in the subscription.
   */
  @summary("List all ResourceHealthMetadata for all sites in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/resourceHealthMetadata")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ResourceHealthMetadata>
  >;

  /**
   * Description for List all ResourceHealthMetadata for all sites in the resource group in the subscription.
   */
  @summary("List all ResourceHealthMetadata for all sites in the resource group in the subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/resourceHealthMetadata")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ResourceHealthMetadata>
  >;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  @summary("Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resourceHealthMetadata")
  @get
  listBySiteSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ResourceHealthMetadata>
  >;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  @summary("Gets the category of ResourceHealthMetadata to use for the given site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resourceHealthMetadata/default")
  @get
  getBySiteSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceHealthMetadata
  >;
}

/**
 * Description for Gets a list of meters for a given location.
 */
@summary("Gets a list of meters for a given location.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/billingMeters")
@get
op listBillingMeters is Azure.Core.Foundations.Operation<
  {
    /**
     * Azure Location of billable resource
     */
    @query("billingLocation")
    billingLocation?: string;

    /**
     * App Service OS type meters used for
     */
    @query("osType")
    osType?: string;

    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;
  },
  BillingMeterCollection
>;

/**
 * Description for Check if a resource name is available.
 */
@summary("Check if a resource name is available.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/checknameavailability")
@post
op checkNameAvailability is Azure.Core.Foundations.Operation<
  {
    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;

    /**
     * Name availability request.
     */
    @body
    @extension("x-ms-client-flatten", true)
    request: ResourceNameAvailabilityRequest;
  },
  ResourceNameAvailability
>;

/**
 * Description for Gets list of available geo regions plus ministamps
 */
@summary("Gets list of available geo regions plus ministamps")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/deploymentLocations")
@get
op getSubscriptionDeploymentLocations is Azure.Core.Foundations.Operation<
  {
    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;
  },
  DeploymentLocations
>;

/**
 * Description for Get a list of available geographical regions.
 */
@summary("Get a list of available geographical regions.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/geoRegions")
@get
op listGeoRegions is Azure.Core.Foundations.Operation<
  {
    /**
     * Name of SKU used to filter the regions.
     */
    @query("sku")
    sku?: SkuName;

    /**
     * Specify <code>true</code> if you want to filter to only regions that support Linux workers.
     */
    @query("linuxWorkersEnabled")
    linuxWorkersEnabled?: boolean;

    /**
     * Specify <code>true</code> if you want to filter to only regions that support Xenon workers.
     */
    @query("xenonWorkersEnabled")
    xenonWorkersEnabled?: boolean;

    /**
     * Specify <code>true</code> if you want to filter to only regions that support Linux Consumption Workers.
     */
    @query("linuxDynamicWorkersEnabled")
    linuxDynamicWorkersEnabled?: boolean;

    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;
  },
  GeoRegionCollection
>;

/**
 * Description for List all apps that are assigned to a hostname.
 */
@summary("List all apps that are assigned to a hostname.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/listSitesAssignedToHostName")
@post
op listSiteIdentifiersAssignedToHostName is Azure.Core.Foundations.Operation<
  {
    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;

    /**
     * Hostname information.
     */
    @body
    nameIdentifier: NameIdentifier;
  },
  ResourceListResult<Identifier>
>;

/**
 * Description for List all premier add-on offers.
 */
@summary("List all premier add-on offers.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/premieraddonoffers")
@get
op listPremierAddOnOffers is Azure.Core.Foundations.Operation<
  {
    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;
  },
  PremierAddOnOfferCollection
>;

/**
 * Description for List all SKUs.
 */
@summary("List all SKUs.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/skus")
@get
op listSkus is Azure.Core.Foundations.Operation<
  {
    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;
  },
  SkuInfos
>;

/**
 * Description for Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.
 */
@summary("Verifies if this VNET is compatible with an App Service Environment by analyzing the Network Security Group rules.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/verifyHostingEnvironmentVnet")
@post
op verifyHostingEnvironmentVnet is Azure.Core.Foundations.Operation<
  {
    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;

    /**
     * VNET information
     */
    @body
    parameters: VnetParameters;
  },
  VnetValidationFailureDetails
>;

/**
 * Description for Validate if a resource can be created.
 */
@summary("Validate if a resource can be created.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/validate")
@post
op validate is Azure.Core.Foundations.Operation<
  {
    /**
     * Name of the resource group to which the resource belongs.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
    @path
    resourceGroupName: string;

    /**
     * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
     */
    @path
    subscriptionId: string;

    /**
     * Request with the resources to validate.
     */
    @body
    validateRequest: ValidateRequest;
  },
  ValidateResponse
>;

interface StaticSitesOperations {
  /**
   * Description for Generates a preview workflow file for the static site
   */
  @summary("Generates a preview workflow file for the static site")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Web/locations/{location}/previewStaticSiteWorkflowFile")
  @post
  previewWorkflow is Azure.Core.Foundations.Operation<
    {
      /**
       * Location where you plan to create the static site.
       */
      @path
      location: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the StaticSitesWorkflowPreviewRequest properties. See example.
       */
      @body
      staticSitesWorkflowPreviewRequest: StaticSitesWorkflowPreviewRequest;
    },
    StaticSitesWorkflowPreview
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a static site
   */
  @summary("Gets the list of private endpoint connections associated with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections")
  @get
  getPrivateEndpointConnectionList is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<RemotePrivateEndpointConnectionARMResource>
  >;

  /**
   * Description for Gets a private endpoint connection
   */
  @summary("Gets a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  getPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Name of the private endpoint connection.
       */
      @path
      privateEndpointConnectionName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  @summary("Approves or rejects a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  approveOrRejectPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Name of the private endpoint connection.
       */
      @path
      privateEndpointConnectionName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Request body.
       */
      @body
      privateEndpointWrapper: PrivateLinkConnectionApprovalRequestResource;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  @summary("Deletes a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  deletePrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Name of the private endpoint connection.
       */
      @path
      privateEndpointConnectionName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the details of the user provided function apps registered with a static site
   */
  @summary("Gets the details of the user provided function apps registered with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps")
  @get
  getUserProvidedFunctionAppsForStaticSite is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<StaticSiteUserProvidedFunctionAppARMResource>
  >;

  /**
   * Description for Gets the details of the user provided function app registered with a static site
   */
  @summary("Gets the details of the user provided function app registered with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
  @get
  getUserProvidedFunctionAppForStaticSite is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Name of the function app registered with the static site.
       */
      @path
      functionAppName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    StaticSiteUserProvidedFunctionAppARMResource
  >;

  /**
   * Description for Register a user provided function app with a static site
   */
  @summary("Register a user provided function app with a static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
  @put
  registerUserProvidedFunctionAppWithStaticSite is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Name of the function app to register with the static site.
       */
      @path
      functionAppName: string;

      /**
       * Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.
       */
      @query("isForced")
      isForced?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the user provided function app properties. See example.
       */
      @body
      staticSiteUserProvidedFunctionEnvelope: StaticSiteUserProvidedFunctionAppARMResource;
    },
    StaticSiteUserProvidedFunctionAppARMResource
  >;

  /**
   * Description for Detach the user provided function app from the static site
   */
  @summary("Detach the user provided function app from the static site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/userProvidedFunctionApps/{functionAppName}")
  @delete
  detachUserProvidedFunctionAppFromStaticSite is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the static site.
       */
      @path
      name: string;

      /**
       * Name of the function app registered with the static site.
       */
      @path
      functionAppName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface WebAppsOperations {
  /**
   * Description for Returns whether Scm basic auth is allowed on the site or not.
   */
  @summary("Returns whether Scm basic auth is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/basicPublishingCredentialsPolicies/scm")
  @get
  getScmAllowed is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  /**
   * Description for Updates whether user publishing credentials are allowed on the site or not.
   */
  @summary("Updates whether user publishing credentials are allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/basicPublishingCredentialsPolicies/scm")
  @put
  updateScmAllowed is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      @body
      csmPublishingAccessPoliciesEntity: CsmPublishingCredentialsPoliciesEntity;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/configreferences/connectionstrings")
  @get
  getSiteConnectionStringKeyVaultReferences is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ApiKVReference>
  >;

  /**
   * Description for Gets the config reference and status of an app
   */
  @summary("Gets the config reference and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/configreferences/connectionstrings/{connectionStringKey}")
  @get
  getSiteConnectionStringKeyVaultReference is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      connectionStringKey: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ApiKVReference
  >;

  /**
   * Description for Gets a snapshot of the configuration of an app at a previous point in time.
   */
  @summary("Gets a snapshot of the configuration of an app at a previous point in time.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}")
  @get
  getConfigurationSnapshot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * The ID of the snapshot to read.
       */
      @path
      snapshotId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteConfig
  >;

  /**
   * Description for Reverts the configuration of an app to a previous snapshot.
   */
  @summary("Reverts the configuration of an app to a previous snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}/recover")
  @post
  recoverSiteConfigurationSnapshot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * The ID of the snapshot to read.
       */
      @path
      snapshotId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.
   */
  @summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @get
  getHybridConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @put
  createOrUpdateHybridConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The details of the hybrid connection.
       */
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  /**
   * Description for Removes a Hybrid Connection from this site.
   */
  @summary("Removes a Hybrid Connection from this site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @delete
  deleteHybridConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @patch
  updateHybridConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The details of the hybrid connection.
       */
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  @summary("Get the status of the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy")
  @get
  getInstanceMsDeployStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * ID of web app instance.
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployStatus
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  @summary("Invoke the MSDeploy web app extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy")
  @put
  createInstanceMSDeployOperation is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * ID of web app instance.
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Details of MSDeploy operation
       */
      @body
      MSDeploy: MSDeploy;
    },
    MSDeployStatus
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy/log")
  @get
  getInstanceMSDeployLog is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * ID of web app instance.
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a site
   */
  @summary("Gets the list of private endpoint connections associated with a site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections")
  @get
  getPrivateEndpointConnectionList is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<RemotePrivateEndpointConnectionARMResource>
  >;

  /**
   * Description for Gets a private endpoint connection
   */
  @summary("Gets a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  getPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      /**
       * Name of the private endpoint connection.
       */
      @path
      privateEndpointConnectionName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  @summary("Approves or rejects a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  approveOrRejectPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      @body
      privateEndpointWrapper: PrivateLinkConnectionApprovalRequestResource;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  @summary("Deletes a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  deletePrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes")
  @get
  listProcesses is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ProcessInfo>
  >;

  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}")
  @get
  getProcess is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessInfo
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}")
  @delete
  deleteProcess is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/dump")
  @get
  getProcessDump is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/modules")
  @get
  listProcessModules is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ProcessModuleInfo>
  >;

  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/modules/{baseAddress}")
  @get
  getProcessModule is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Module base address.
       */
      @path
      baseAddress: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessModuleInfo
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/processes/{processId}/threads")
  @get
  listProcessThreads is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;

  /**
   * Description for Gets an app's deployment slots.
   */
  @summary("Gets an app's deployment slots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots")
  @get
  listSlots is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Site>
  >;

  /**
   * Description for Gets the details of a web, mobile, or API app.
   */
  @summary("Gets the details of a web, mobile, or API app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @get
  getSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. By default, this API returns the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    Site
  >;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @put
  createOrUpdateSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Unique name of the app to create or update. To create or update a deployment slot, use the {slot} parameter.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot to create or update. By default, this API attempts to create or modify the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the app properties. See example.
       */
      @body
      siteEnvelope: Site;
    },
    Site
  >;

  /**
   * Description for Deletes a web, mobile, or API app, or one of the deployment slots.
   */
  @summary("Deletes a web, mobile, or API app, or one of the deployment slots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @delete
  deleteSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app to delete.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot to delete. By default, the API deletes the production slot.
       */
      @path
      slot: string;

      /**
       * If true, web app metrics are also deleted.
       */
      @query("deleteMetrics")
      deleteMetrics?: boolean;

      /**
       * Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.
       */
      @query("deleteEmptyServerFarm")
      deleteEmptyServerFarm?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}")
  @patch
  updateSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Unique name of the app to create or update. To create or update a deployment slot, use the {slot} parameter.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot to create or update. By default, this API attempts to create or modify the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the app properties. See example.
       */
      @body
      siteEnvelope: SitePatchResource;
    },
    Site
  >;

  /**
   * Description for Analyze a custom hostname.
   */
  @summary("Analyze a custom hostname.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/analyzeCustomHostname")
  @get
  analyzeCustomHostnameSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Custom hostname.
       */
      @query("hostName")
      hostName?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    CustomHostnameAnalysisResult
  >;

  /**
   * Description for Applies the configuration settings from the target slot onto the current slot.
   */
  @summary("Applies the configuration settings from the target slot onto the current slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/applySlotConfig")
  @post
  applySlotConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the source slot. If a slot is not specified, the production slot is used as the source slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON object that contains the target slot name. See example.
       */
      @body
      slotSwapEntity: CsmSlotEntity;
    },
    void
  >;

  /**
   * Description for Creates a backup of an app.
   */
  @summary("Creates a backup of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backup")
  @post
  backupSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will create a backup for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Backup configuration. You can use the JSON response from the POST action as input here.
       */
      @body
      request: BackupRequest;
    },
    BackupItem
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  @summary("Gets existing backups of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups")
  @get
  listBackupsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get backups of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<BackupItem>
  >;

  /**
   * Description for Gets a backup of an app by its ID.
   */
  @summary("Gets a backup of an app by its ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}")
  @get
  getBackupStatusSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * ID of the backup.
       */
      @path
      backupId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get a backup of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    BackupItem
  >;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  @summary("Deletes a backup of an app by its ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}")
  @delete
  deleteBackupSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * ID of the backup.
       */
      @path
      backupId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete a backup of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  @summary("Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/list")
  @post
  listBackupStatusSecretsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * ID of backup.
       */
      @path
      backupId: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Information on backup request.
       */
      @body
      request: BackupRequest;
    },
    BackupItem
  >;

  /**
   * Description for Restores a specific backup to another app (or deployment slot, if specified).
   */
  @summary("Restores a specific backup to another app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/restore")
  @post
  restoreSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * ID of the backup.
       */
      @path
      backupId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will restore a backup of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Information on restore request .
       */
      @body
      request: RestoreRequest;
    },
    void
  >;

  /**
   * Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
   */
  @summary("Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies")
  @get
  listBasicPublishingCredentialsPoliciesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<CsmPublishingCredentialsPoliciesEntity>
  >;

  /**
   * Description for Returns whether FTP is allowed on the site or not.
   */
  @summary("Returns whether FTP is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/ftp")
  @get
  getFtpAllowedSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  /**
   * Description for Updates whether FTP is allowed on the site or not.
   */
  @summary("Updates whether FTP is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/ftp")
  @put
  updateFtpAllowedSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      @body
      csmPublishingAccessPoliciesEntity: CsmPublishingCredentialsPoliciesEntity;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  /**
   * Description for Returns whether Scm basic auth is allowed on the site or not.
   */
  @summary("Returns whether Scm basic auth is allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/scm")
  @get
  getScmAllowedSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  /**
   * Description for Updates whether user publishing credentials are allowed on the site or not.
   */
  @summary("Updates whether user publishing credentials are allowed on the site or not.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/basicPublishingCredentialsPolicies/scm")
  @put
  updateScmAllowedSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      @body
      csmPublishingAccessPoliciesEntity: CsmPublishingCredentialsPoliciesEntity;
    },
    CsmPublishingCredentialsPoliciesEntity
  >;

  /**
   * Description for List the configurations of an app
   */
  @summary("List the configurations of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config")
  @get
  listConfigurationsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SiteConfig>
  >;

  /**
   * Description for Replaces the application settings of an app.
   */
  @summary("Replaces the application settings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/appsettings")
  @put
  updateApplicationSettingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the application settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Application settings of the app.
       */
      @body
      appSettings: StringDictionary;
    },
    StringDictionary
  >;

  /**
   * Description for Gets the application settings of an app.
   */
  @summary("Gets the application settings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/appsettings/list")
  @post
  listApplicationSettingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the application settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    StringDictionary
  >;

  /**
   * Description for Updates the Authentication / Authorization settings associated with web app.
   */
  @summary("Updates the Authentication / Authorization settings associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettings")
  @put
  updateAuthSettingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Auth settings associated with web app.
       */
      @body
      siteAuthSettings: SiteAuthSettings;
    },
    SiteAuthSettings
  >;

  /**
   * Description for Gets the Authentication/Authorization settings of an app.
   */
  @summary("Gets the Authentication/Authorization settings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettings/list")
  @post
  getAuthSettingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteAuthSettings
  >;

  /**
   * Description for Updates site's Authentication / Authorization settings for apps via the V2 format
   */
  @summary("Updates site's Authentication / Authorization settings for apps via the V2 format")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettingsV2")
  @put
  updateAuthSettingsV2Slot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Auth settings associated with web app.
       */
      @body
      siteAuthSettingsV2: SiteAuthSettingsV2;
    },
    SiteAuthSettingsV2
  >;

  /**
   * Description for Gets site's Authentication / Authorization settings for apps via the V2 format
   */
  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/authsettingsV2/list")
  @get
  getAuthSettingsV2Slot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteAuthSettingsV2
  >;

  /**
   * Description for Updates the Azure storage account configurations of an app.
   */
  @summary("Updates the Azure storage account configurations of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/azurestorageaccounts")
  @put
  updateAzureStorageAccountsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the Azure storage account configurations for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Azure storage accounts of the app.
       */
      @body
      azureStorageAccounts: AzureStoragePropertyDictionaryResource;
    },
    AzureStoragePropertyDictionaryResource
  >;

  /**
   * Description for Gets the Azure storage account configurations of an app.
   */
  @summary("Gets the Azure storage account configurations of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/azurestorageaccounts/list")
  @post
  listAzureStorageAccountsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the Azure storage account configurations for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    AzureStoragePropertyDictionaryResource
  >;

  /**
   * Description for Updates the backup configuration of an app.
   */
  @summary("Updates the backup configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup")
  @put
  updateBackupConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the backup configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Edited backup configuration.
       */
      @body
      request: BackupRequest;
    },
    BackupRequest
  >;

  /**
   * Description for Deletes the backup configuration of an app.
   */
  @summary("Deletes the backup configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup")
  @delete
  deleteBackupConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the backup configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the backup configuration of an app.
   */
  @summary("Gets the backup configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/backup/list")
  @post
  getBackupConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the backup configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    BackupRequest
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/appsettings")
  @get
  getAppSettingsKeyVaultReferencesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ApiKVReference>
  >;

  /**
   * Description for Gets the config reference and status of an app
   */
  @summary("Gets the config reference and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/appsettings/{appSettingKey}")
  @get
  getAppSettingKeyVaultReferenceSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * App Setting key name.
       */
      @path
      appSettingKey: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ApiKVReference
  >;

  /**
   * Description for Gets the config reference app settings and status of an app
   */
  @summary("Gets the config reference app settings and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/connectionstrings")
  @get
  getSiteConnectionStringKeyVaultReferencesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ApiKVReference>
  >;

  /**
   * Description for Gets the config reference and status of an app
   */
  @summary("Gets the config reference and status of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/configreferences/connectionstrings/{connectionStringKey}")
  @get
  getSiteConnectionStringKeyVaultReferenceSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      connectionStringKey: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ApiKVReference
  >;

  /**
   * Description for Replaces the connection strings of an app.
   */
  @summary("Replaces the connection strings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/connectionstrings")
  @put
  updateConnectionStringsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the connection settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Connection strings of the app or deployment slot. See example.
       */
      @body
      connectionStrings: ConnectionStringDictionary;
    },
    ConnectionStringDictionary
  >;

  /**
   * Description for Gets the connection strings of an app.
   */
  @summary("Gets the connection strings of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/connectionstrings/list")
  @post
  listConnectionStringsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the connection settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ConnectionStringDictionary
  >;

  /**
   * Description for Gets the logging configuration of an app.
   */
  @summary("Gets the logging configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/logs")
  @get
  getDiagnosticLogsConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the logging configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteLogsConfig
  >;

  /**
   * Description for Updates the logging configuration of an app.
   */
  @summary("Updates the logging configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/logs")
  @put
  updateDiagnosticLogsConfigSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the logging configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A SiteLogsConfig JSON object that contains the logging configuration to change in the "properties" property.
       */
      @body
      siteLogsConfig: SiteLogsConfig;
    },
    SiteLogsConfig
  >;

  /**
   * Description for Replaces the metadata of an app.
   */
  @summary("Replaces the metadata of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/metadata")
  @put
  updateMetadataSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the metadata for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Edited metadata of the app or deployment slot. See example.
       */
      @body
      metadata: StringDictionary;
    },
    StringDictionary
  >;

  /**
   * Description for Gets the metadata of an app.
   */
  @summary("Gets the metadata of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/metadata/list")
  @post
  listMetadataSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the metadata for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    StringDictionary
  >;

  /**
   * Description for Gets the Git/FTP publishing credentials of an app.
   */
  @summary("Gets the Git/FTP publishing credentials of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/publishingcredentials/list")
  @post
  listPublishingCredentialsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the publishing credentials for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    User
  >;

  /**
   * Description for Updates the Push settings associated with web app.
   */
  @summary("Updates the Push settings associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/pushsettings")
  @put
  updateSitePushSettingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Push settings associated with web app.
       */
      @body
      pushSettings: PushSettings;
    },
    PushSettings
  >;

  /**
   * Description for Gets the Push settings associated with web app.
   */
  @summary("Gets the Push settings associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/pushsettings/list")
  @post
  listSitePushSettingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PushSettings
  >;

  /**
   * Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.
   */
  @summary("Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
  @get
  getConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteConfig
  >;

  /**
   * Description for Updates the configuration of an app.
   */
  @summary("Updates the configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
  @put
  createOrUpdateConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON representation of a SiteConfig object. See example.
       */
      @body
      siteConfig: SiteConfig;
    },
    SiteConfig
  >;

  /**
   * Description for Updates the configuration of an app.
   */
  @summary("Updates the configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web")
  @patch
  updateConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON representation of a SiteConfig object. See example.
       */
      @body
      siteConfig: SiteConfig;
    },
    SiteConfig
  >;

  /**
   * Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
   */
  @summary("Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots")
  @get
  listConfigurationSnapshotInfoSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteConfigurationSnapshotInfoCollection
  >;

  /**
   * Description for Gets a snapshot of the configuration of an app at a previous point in time.
   */
  @summary("Gets a snapshot of the configuration of an app at a previous point in time.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots/{snapshotId}")
  @get
  getConfigurationSnapshotSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * The ID of the snapshot to read.
       */
      @path
      snapshotId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteConfig
  >;

  /**
   * Description for Reverts the configuration of an app to a previous snapshot.
   */
  @summary("Reverts the configuration of an app to a previous snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/config/web/snapshots/{snapshotId}/recover")
  @post
  recoverSiteConfigurationSnapshotSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * The ID of the snapshot to read.
       */
      @path
      snapshotId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the last lines of docker logs for the given site
   */
  @summary("Gets the last lines of docker logs for the given site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/containerlogs")
  @post
  getWebSiteContainerLogsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Accept header
       */
      @header
      accept: "application/octet-stream";
    },
    void
  >;

  /**
   * Description for Gets the ZIP archived docker log files for the given site
   */
  @summary("Gets the ZIP archived docker log files for the given site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/containerlogs/zip/download")
  @post
  getContainerLogsZipSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Accept header
       */
      @header
      accept: "application/zip";
    },
    void
  >;

  /**
   * Description for List continuous web jobs for an app, or a deployment slot.
   */
  @summary("List continuous web jobs for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs")
  @get
  listContinuousWebJobsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ContinuousWebJob>
  >;

  /**
   * Description for Gets a continuous web job by its ID for an app, or a deployment slot.
   */
  @summary("Gets a continuous web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}")
  @get
  getContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ContinuousWebJob
  >;

  /**
   * Description for Delete a continuous web job by its ID for an app, or a deployment slot.
   */
  @summary("Delete a continuous web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}")
  @delete
  deleteContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Start a continuous web job for an app, or a deployment slot.
   */
  @summary("Start a continuous web job for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}/start")
  @post
  startContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  @summary("Stop a continuous web job for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/continuouswebjobs/{webJobName}/stop")
  @post
  stopContinuousWebJobSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for List deployments for an app, or a deployment slot.
   */
  @summary("List deployments for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments")
  @get
  listDeploymentsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Deployment>
  >;

  /**
   * Description for Get a deployment by its ID for an app, or a deployment slot.
   */
  @summary("Get a deployment by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
  @get
  getDeploymentSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Deployment ID.
       */
      @path
      id: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API gets a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    Deployment
  >;

  /**
   * Description for Create a deployment for an app, or a deployment slot.
   */
  @summary("Create a deployment for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
  @put
  createDeploymentSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * ID of an existing deployment.
       */
      @path
      id: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API creates a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Deployment details.
       */
      @body
      deployment: Deployment;
    },
    Deployment
  >;

  /**
   * Description for Delete a deployment by its ID for an app, or a deployment slot.
   */
  @summary("Delete a deployment by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}")
  @delete
  deleteDeploymentSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Deployment ID.
       */
      @path
      id: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for List deployment log for specific deployment for an app, or a deployment slot.
   */
  @summary("List deployment log for specific deployment for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/deployments/{id}/log")
  @get
  listDeploymentLogSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * The ID of a specific deployment. This is the value of the name property in the JSON response from "GET /api/sites/{siteName}/deployments".
       */
      @path
      id: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    Deployment
  >;

  /**
   * Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
   */
  @summary("Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/discoverbackup")
  @post
  discoverBackupSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will perform discovery for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup.
       */
      @body
      request: RestoreRequest;
    },
    RestoreRequest
  >;

  /**
   * Description for Lists ownership identifiers for domain associated with web app.
   */
  @summary("Lists ownership identifiers for domain associated with web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers")
  @get
  listDomainOwnershipIdentifiersSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Identifier>
  >;

  /**
   * Description for Get domain ownership identifier for web app.
   */
  @summary("Get domain ownership identifier for web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @get
  getDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of domain ownership identifier.
       */
      @path
      domainOwnershipIdentifierName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    Identifier
  >;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @put
  createOrUpdateDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of domain ownership identifier.
       */
      @path
      domainOwnershipIdentifierName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the domain ownership properties.
       */
      @body
      domainOwnershipIdentifier: Identifier;
    },
    Identifier
  >;

  /**
   * Description for Deletes a domain ownership identifier for a web app.
   */
  @summary("Deletes a domain ownership identifier for a web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @delete
  deleteDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of domain ownership identifier.
       */
      @path
      domainOwnershipIdentifierName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}")
  @patch
  updateDomainOwnershipIdentifierSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of domain ownership identifier.
       */
      @path
      domainOwnershipIdentifierName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the domain ownership properties.
       */
      @body
      domainOwnershipIdentifier: Identifier;
    },
    Identifier
  >;

  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  @summary("Get the status of the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy")
  @get
  getMSDeployStatusSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployStatus
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  @summary("Invoke the MSDeploy web app extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy")
  @put
  createMSDeployOperationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Details of MSDeploy operation
       */
      @body
      MSDeploy: MSDeploy;
    },
    MSDeployStatus
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/extensions/MSDeploy/log")
  @get
  getMSDeployLogSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;

  /**
   * Description for List the functions for a web site, or a deployment slot.
   */
  @summary("List the functions for a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions")
  @get
  listInstanceFunctionsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<FunctionEnvelope>
  >;

  /**
   * Description for Fetch a short lived token that can be exchanged for a master key.
   */
  @summary("Fetch a short lived token that can be exchanged for a master key.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/admin/token")
  @get
  getFunctionsAdminTokenSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get function information by its ID for web site, or a deployment slot.
   */
  @summary("Get function information by its ID for web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
  @get
  getInstanceFunctionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Function name.
       */
      @path
      functionName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    FunctionEnvelope
  >;

  /**
   * Description for Create function for web site, or a deployment slot.
   */
  @summary("Create function for web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
  @put
  createInstanceFunctionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Function name.
       */
      @path
      functionName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Function details.
       */
      @body
      function_envelope: FunctionEnvelope;
    },
    FunctionEnvelope
  >;

  /**
   * Description for Delete a function for web site, or a deployment slot.
   */
  @summary("Delete a function for web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}")
  @delete
  deleteInstanceFunctionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Function name.
       */
      @path
      functionName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Add or update a function secret.
   */
  @summary("Add or update a function secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/keys/{keyName}")
  @put
  createOrUpdateFunctionSecretSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * The name of the function.
       */
      @path
      functionName: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The key to create or update
       */
      @body
      key: KeyInfo;
    },
    KeyInfo
  >;

  /**
   * Description for Delete a function secret.
   */
  @summary("Delete a function secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/keys/{keyName}")
  @delete
  deleteFunctionSecretSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * The name of the function.
       */
      @path
      functionName: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get function keys for a function in a web site, or a deployment slot.
   */
  @summary("Get function keys for a function in a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/listkeys")
  @post
  listFunctionKeysSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Function name.
       */
      @path
      functionName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    StringDictionary
  >;

  /**
   * Description for Get function secrets for a function in a web site, or a deployment slot.
   */
  @summary("Get function secrets for a function in a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/functions/{functionName}/listsecrets")
  @post
  listFunctionSecretsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Function name.
       */
      @path
      functionName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    FunctionSecrets
  >;

  /**
   * Description for Get host secrets for a function app.
   */
  @summary("Get host secrets for a function app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/listkeys")
  @post
  listHostKeysSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HostKeys
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  @summary("This is to allow calling via powershell and ARM template.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/listsyncstatus")
  @post
  listSyncStatusSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  @summary("Syncs function trigger metadata to the management database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/sync")
  @post
  syncFunctionsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Add or update a host level secret.
   */
  @summary("Add or update a host level secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
  @put
  createOrUpdateHostSecretSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * The type of host key.
       */
      @path
      keyType: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The key to create or update
       */
      @body
      key: KeyInfo;
    },
    KeyInfo
  >;

  /**
   * Description for Delete a host level secret.
   */
  @summary("Delete a host level secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
  @delete
  deleteHostSecretSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * The type of host key.
       */
      @path
      keyType: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get hostname bindings for an app or a deployment slot.
   */
  @summary("Get hostname bindings for an app or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings")
  @get
  listHostNameBindingsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API gets hostname bindings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<HostNameBinding>
  >;

  /**
   * Description for Get the named hostname binding for an app (or deployment slot, if specified).
   */
  @summary("Get the named hostname binding for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
  @get
  getHostNameBindingSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Hostname in the hostname binding.
       */
      @path
      hostName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HostNameBinding
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  @summary("Creates a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
  @put
  createOrUpdateHostNameBindingSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Hostname in the hostname binding.
       */
      @path
      hostName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Binding details. This is the JSON representation of a HostNameBinding object.
       */
      @body
      hostNameBinding: HostNameBinding;
    },
    HostNameBinding
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  @summary("Deletes a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}")
  @delete
  deleteHostNameBindingSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Hostname in the hostname binding.
       */
      @path
      hostName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.
   */
  @summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @get
  getHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @put
  createOrUpdateHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The details of the hybrid connection.
       */
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  /**
   * Description for Removes a Hybrid Connection from this site.
   */
  @summary("Removes a Hybrid Connection from this site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @delete
  deleteHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}")
  @patch
  updateHybridConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The namespace for this hybrid connection.
       */
      @path
      namespaceName: string;

      /**
       * The relay name for this hybrid connection.
       */
      @path
      relayName: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The details of the hybrid connection.
       */
      @body
      connectionEnvelope: HybridConnection;
    },
    HybridConnection
  >;

  /**
   * Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
   */
  @summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionRelays")
  @get
  listHybridConnectionsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  /**
   * Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
   */
  @summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection")
  @get
  listRelayServiceConnectionsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get hybrid connections for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RelayServiceConnectionEntity
  >;

  /**
   * Description for Gets a hybrid connection configuration by its name.
   */
  @summary("Gets a hybrid connection configuration by its name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @get
  getRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the hybrid connection.
       */
      @path
      entityName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get a hybrid connection for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RelayServiceConnectionEntity
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @put
  createOrUpdateRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the hybrid connection configuration.
       */
      @path
      entityName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will create or update a hybrid connection for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Details of the hybrid connection configuration.
       */
      @body
      connectionEnvelope: RelayServiceConnectionEntity;
    },
    RelayServiceConnectionEntity
  >;

  /**
   * Description for Deletes a relay service connection by its name.
   */
  @summary("Deletes a relay service connection by its name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @delete
  deleteRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the hybrid connection configuration.
       */
      @path
      entityName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete a hybrid connection for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridconnection/{entityName}")
  @patch
  updateRelayServiceConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the hybrid connection configuration.
       */
      @path
      entityName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will create or update a hybrid connection for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Details of the hybrid connection configuration.
       */
      @body
      connectionEnvelope: RelayServiceConnectionEntity;
    },
    RelayServiceConnectionEntity
  >;

  /**
   * Description for Gets all scale-out instances of an app.
   */
  @summary("Gets all scale-out instances of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances")
  @get
  listInstanceIdentifiersSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API gets the production slot instances.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<WebSiteInstanceStatus>
  >;

  /**
   * Description for Gets all scale-out instances of an app.
   */
  @summary("Gets all scale-out instances of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}")
  @get
  getInstanceInfoSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @path
      instanceId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API gets the production slot instances.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    WebSiteInstanceStatus
  >;

  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  @summary("Get the status of the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy")
  @get
  getInstanceMsDeployStatusSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * ID of web app instance.
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployStatus
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  @summary("Invoke the MSDeploy web app extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy")
  @put
  createInstanceMSDeployOperationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * ID of web app instance.
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Details of MSDeploy operation
       */
      @body
      MSDeploy: MSDeploy;
    },
    MSDeployStatus
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/extensions/MSDeploy/log")
  @get
  getInstanceMSDeployLogSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * ID of web app instance.
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes")
  @get
  listInstanceProcessesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ProcessInfo>
  >;

  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}")
  @get
  getInstanceProcessSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessInfo
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}")
  @delete
  deleteInstanceProcessSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/dump")
  @get
  getInstanceProcessDumpSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/modules")
  @get
  listInstanceProcessModulesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ProcessModuleInfo>
  >;

  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/modules/{baseAddress}")
  @get
  getInstanceProcessModuleSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Module base address.
       */
      @path
      baseAddress: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessModuleInfo
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/instances/{instanceId}/processes/{processId}/threads")
  @get
  listInstanceProcessThreadsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances".
       */
      @path
      instanceId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;

  /**
   * Description for Shows whether an app can be cloned to another resource group or subscription.
   */
  @summary("Shows whether an app can be cloned to another resource group or subscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/iscloneable")
  @post
  isCloneableSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. By default, this API returns information on the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteCloneability
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  @summary("Gets existing backups of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/listbackups")
  @post
  listSiteBackupsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get backups of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<BackupItem>
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  @summary("This is to allow calling via powershell and ARM template.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/listsyncfunctiontriggerstatus")
  @post
  listSyncFunctionTriggersSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    FunctionSecrets
  >;

  /**
   * Description for Gets a Swift Virtual Network connection.
   */
  @summary("Gets a Swift Virtual Network connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @get
  getSwiftVirtualNetworkConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SwiftVirtualNetwork
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  @summary("""
Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @put
  createOrUpdateSwiftVirtualNetworkConnectionWithCheckSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the Virtual Network connection. See example.
       */
      @body
      connectionEnvelope: SwiftVirtualNetwork;
    },
    SwiftVirtualNetwork
  >;

  /**
   * Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).
   */
  @summary("Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @delete
  deleteSwiftVirtualNetworkSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the connection for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
   * in use by another App Service Plan other than the one this App is in.
   */
  @summary("""
Integrates this Web App with a Virtual Network. This requires that 1) "swiftSupported" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkConfig/virtualNetwork")
  @patch
  updateSwiftVirtualNetworkConnectionWithCheckSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the Virtual Network connection. See example.
       */
      @body
      connectionEnvelope: SwiftVirtualNetwork;
    },
    SwiftVirtualNetwork
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/operationresults/{operationId}")
  @get
  getNetworkTraceOperationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Start capturing network packets for the site (To be deprecated).
   */
  @summary("Start capturing network packets for the site (To be deprecated).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/start")
  @post
  startWebSiteNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The duration to keep capturing in seconds.
       */
      @query("durationInSeconds")
      durationInSeconds?: int32;

      /**
       * The name of the slot for this web app.
       */
      @path
      slot: string;

      /**
       * The maximum frame length in bytes (Optional).
       */
      @query("maxFrameLength")
      maxFrameLength?: int32;

      /**
       * The Blob URL to store capture file.
       */
      @query("sasUrl")
      sasUrl?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  @summary("Start capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/startOperation")
  @post
  startWebSiteNetworkTraceOperationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The duration to keep capturing in seconds.
       */
      @query("durationInSeconds")
      durationInSeconds?: int32;

      /**
       * The name of the slot for this web app.
       */
      @path
      slot: string;

      /**
       * The maximum frame length in bytes (Optional).
       */
      @query("maxFrameLength")
      maxFrameLength?: int32;

      /**
       * The Blob URL to store capture file.
       */
      @query("sasUrl")
      sasUrl?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  @summary("Stop ongoing capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/stop")
  @post
  stopWebSiteNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The name of the slot for this web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/{operationId}")
  @get
  getNetworkTracesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTraces/current/operationresults/{operationId}")
  @get
  getNetworkTraceOperationSlotV2 is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTraces/{operationId}")
  @get
  getNetworkTracesSlotV2 is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get an operation for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Generates a new publishing password for an app (or deployment slot, if specified).
   */
  @summary("Generates a new publishing password for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/newpassword")
  @post
  generateNewSitePublishingPasswordSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API generate a new publishing password for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets perfmon counters for web app.
   */
  @summary("Gets perfmon counters for web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/perfcounters")
  @get
  listPerfMonCountersSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    PerfMonCounterCollection
  >;

  /**
   * Description for Gets web app's event logs.
   */
  @summary("Gets web app's event logs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/phplogging")
  @get
  getSitePhpErrorLogFlagSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SitePhpErrorLogFlag
  >;

  /**
   * Description for Gets the premier add-ons of an app.
   */
  @summary("Gets the premier add-ons of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons")
  @get
  listPremierAddOnsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the premier add-ons for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PremierAddOn
  >;

  /**
   * Description for Gets a named add-on of an app.
   */
  @summary("Gets a named add-on of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @get
  getPremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Add-on name.
       */
      @path
      premierAddOnName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the named add-on for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PremierAddOn
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  @summary("Updates a named add-on of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @put
  addPremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Add-on name.
       */
      @path
      premierAddOnName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the named add-on for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the edited premier add-on.
       */
      @body
      premierAddOn: PremierAddOn;
    },
    PremierAddOn
  >;

  /**
   * Description for Delete a premier add-on from an app.
   */
  @summary("Delete a premier add-on from an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @delete
  deletePremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Add-on name.
       */
      @path
      premierAddOnName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the named add-on for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  @summary("Updates a named add-on of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}")
  @patch
  updatePremierAddOnSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Add-on name.
       */
      @path
      premierAddOnName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will update the named add-on for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * A JSON representation of the edited premier add-on.
       */
      @body
      premierAddOn: PremierAddOnPatchResource;
    },
    PremierAddOn
  >;

  /**
   * Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  @summary("Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateAccess/virtualNetworks")
  @get
  getPrivateAccessSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PrivateAccess
  >;

  /**
   * Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  @summary("Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateAccess/virtualNetworks")
  @put
  putPrivateAccessVnetSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The name of the slot for the web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The information for the private access
       */
      @body
      access: PrivateAccess;
    },
    PrivateAccess
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a site
   */
  @summary("Gets the list of private endpoint connections associated with a site")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections")
  @get
  getPrivateEndpointConnectionListSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      /**
       * Name of the site deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<RemotePrivateEndpointConnectionARMResource>
  >;

  /**
   * Description for Gets a private endpoint connection
   */
  @summary("Gets a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  getPrivateEndpointConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      /**
       * Name of the private endpoint connection.
       */
      @path
      privateEndpointConnectionName: string;

      /**
       * Name of the site deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  @summary("Approves or rejects a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  approveOrRejectPrivateEndpointConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      @body
      privateEndpointWrapper: PrivateLinkConnectionApprovalRequestResource;
    },
    RemotePrivateEndpointConnectionARMResource
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  @summary("Deletes a private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  deletePrivateEndpointConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      @path
      privateEndpointConnectionName: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the private link resources
   */
  @summary("Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/privateLinkResources")
  @get
  getPrivateLinkResourcesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes")
  @get
  listProcessesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ProcessInfo>
  >;

  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}")
  @get
  getProcessSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessInfo
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}")
  @delete
  deleteProcessSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/dump")
  @get
  getProcessDumpSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/modules")
  @get
  listProcessModulesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ProcessModuleInfo>
  >;

  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/modules/{baseAddress}")
  @get
  getProcessModuleSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Module base address.
       */
      @path
      baseAddress: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessModuleInfo
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}/threads")
  @get
  listProcessThreadsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * PID.
       */
      @path
      processId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;

  /**
   * Description for Get public certificates for an app or a deployment slot.
   */
  @summary("Get public certificates for an app or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates")
  @get
  listPublicCertificatesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API gets hostname bindings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<PublicCertificate>
  >;

  /**
   * Description for Get the named public certificate for an app (or deployment slot, if specified).
   */
  @summary("Get the named public certificate for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
  @get
  getPublicCertificateSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Public certificate name.
       */
      @path
      publicCertificateName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PublicCertificate
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  @summary("Creates a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
  @put
  createOrUpdatePublicCertificateSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Public certificate name.
       */
      @path
      publicCertificateName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will create a binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Public certificate details. This is the JSON representation of a PublicCertificate object.
       */
      @body
      publicCertificate: PublicCertificate;
    },
    PublicCertificate
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  @summary("Deletes a hostname binding for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}")
  @delete
  deletePublicCertificateSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot.
       */
      @path
      slot: string;

      /**
       * Public certificate name.
       */
      @path
      publicCertificateName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the publishing profile for an app (or deployment slot, if specified).
   */
  @summary("Gets the publishing profile for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publishxml")
  @post
  listPublishingProfileXmlWithSecretsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the publishing profile for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Specifies publishingProfileOptions for publishing profile. For example, use {"format": "FileZilla3"} to get a FileZilla publishing profile.
       */
      @body
      publishingProfileOptions: CsmPublishingProfileOptions;

      /**
       * Accept header
       */
      @header
      accept: "application/xml";
    },
    void
  >;

  /**
   * Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
   */
  @summary("Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/resetSlotConfig")
  @post
  resetSlotConfigurationSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API resets configuration settings for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Restarts an app (or deployment slot, if specified).
   */
  @summary("Restarts an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restart")
  @post
  restartSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will restart the production slot.
       */
      @path
      slot: string;

      /**
       * Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.
       */
      @query("softRestart")
      softRestart?: boolean;

      /**
       * Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).
       */
      @query("synchronous")
      synchronous?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Restores an app from a backup blob in Azure Storage.
   */
  @summary("Restores an app from a backup blob in Azure Storage.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreFromBackupBlob")
  @post
  restoreFromBackupBlobSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will restore a backup of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Information on restore request .
       */
      @body
      request: RestoreRequest;
    },
    void
  >;

  /**
   * Description for Restores a deleted web app to this web app.
   */
  @summary("Restores a deleted web app to this web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreFromDeletedApp")
  @post
  restoreFromDeletedAppSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Deleted web app restore information.
       */
      @body
      restoreRequest: DeletedAppRestoreRequest;
    },
    void
  >;

  /**
   * Description for Restores a web app from a snapshot.
   */
  @summary("Restores a web app from a snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/restoreSnapshot")
  @post
  restoreSnapshotSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API.
       */
      @body
      restoreRequest: SnapshotRestoreRequest;
    },
    void
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  @summary("Get list of siteextensions for a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions")
  @get
  listSiteExtensionsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API uses the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SiteExtensionInfo>
  >;

  /**
   * Description for Get site extension information by its ID for a web site, or a deployment slot.
   */
  @summary("Get site extension information by its ID for a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
  @get
  getSiteExtensionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Site extension name.
       */
      @path
      siteExtensionId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API uses the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteExtensionInfo
  >;

  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  @summary("Install site extension on a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
  @put
  installSiteExtensionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Site extension name.
       */
      @path
      siteExtensionId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API uses the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteExtensionInfo
  >;

  /**
   * Description for Remove a site extension from a web site, or a deployment slot.
   */
  @summary("Remove a site extension from a web site, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}")
  @delete
  deleteSiteExtensionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Site extension name.
       */
      @path
      siteExtensionId: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API deletes a deployment for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Get the difference in configuration settings between two web app slots.
   */
  @summary("Get the difference in configuration settings between two web app slots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/slotsdiffs")
  @post
  listSlotDifferencesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the source slot. If a slot is not specified, the production slot is used as the source slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON object that contains the target slot name. See example.
       */
      @body
      slotSwapEntity: CsmSlotEntity;
    },
    SlotDifferenceCollection
  >;

  /**
   * Description for Swaps two deployment slots of an app.
   */
  @summary("Swaps two deployment slots of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/slotsswap")
  @post
  swapSlotSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the source slot. If a slot is not specified, the production slot is used as the source slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON object that contains the target slot name. See example.
       */
      @body
      slotSwapEntity: CsmSlotEntity;
    },
    void
  >;

  /**
   * Description for Returns all Snapshots to the user.
   */
  @summary("Returns all Snapshots to the user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/snapshots")
  @get
  listSnapshotsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Website Name.
       */
      @path
      name: string;

      /**
       * Website Slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  /**
   * Description for Returns all Snapshots to the user from DRSecondary endpoint.
   */
  @summary("Returns all Snapshots to the user from DRSecondary endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/snapshotsdr")
  @get
  listSnapshotsFromDRSecondarySlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Website Name.
       */
      @path
      name: string;

      /**
       * Website Slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  /**
   * Description for Starts an app (or deployment slot, if specified).
   */
  @summary("Starts an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/start")
  @post
  startSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will start the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  @summary("Start capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/startNetworkTrace")
  @post
  startNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The duration to keep capturing in seconds.
       */
      @query("durationInSeconds")
      durationInSeconds?: int32;

      /**
       * The name of the slot for this web app.
       */
      @path
      slot: string;

      /**
       * The maximum frame length in bytes (Optional).
       */
      @query("maxFrameLength")
      maxFrameLength?: int32;

      /**
       * The Blob URL to store capture file.
       */
      @query("sasUrl")
      sasUrl?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Stops an app (or deployment slot, if specified).
   */
  @summary("Stops an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/stop")
  @post
  stopSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will stop the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  @summary("Stop ongoing capturing network packets for the site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/stopNetworkTrace")
  @post
  stopNetworkTraceSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * The name of the slot for this web app.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Sync web app repository.
   */
  @summary("Sync web app repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/sync")
  @post
  syncRepositorySlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Name of web app slot. If not specified then will default to production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  @summary("Syncs function trigger metadata to the management database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/syncfunctiontriggers")
  @post
  syncFunctionTriggersSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the quota usage information of an app (or deployment slot, if specified).
   */
  @summary("Gets the quota usage information of an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/usages")
  @get
  listUsagesSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get quota information of the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;

  /**
   * Description for Gets the virtual networks the app (or deployment slot) is connected to.
   */
  @summary("Gets the virtual networks the app (or deployment slot) is connected to.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections")
  @get
  listVnetConnectionsSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get virtual network connections for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a virtual network the app (or deployment slot) is connected to by name.
   */
  @summary("Gets a virtual network the app (or deployment slot) is connected to by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @get
  getVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the virtual network.
       */
      @path
      vnetName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get the named virtual network for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    VnetInfoResource
  >;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @put
  createOrUpdateVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of an existing Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the Virtual Network connection. See example.
       */
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  /**
   * Description for Deletes a connection from an app (or deployment slot to a named virtual network.
   */
  @summary("Deletes a connection from an app (or deployment slot to a named virtual network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @delete
  deleteVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the virtual network.
       */
      @path
      vnetName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will delete the connection for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}")
  @patch
  updateVnetConnectionSlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of an existing Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will add or update connections for the production slot.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the Virtual Network connection. See example.
       */
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  /**
   * Description for Gets an app's Virtual Network gateway.
   */
  @summary("Gets an app's Virtual Network gateway.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @get
  getVnetConnectionGatewaySlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the gateway. Currently, the only supported string is "primary".
       */
      @path
      gatewayName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will get a gateway for the production slot's Virtual Network.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    VnetGateway
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @put
  createOrUpdateVnetConnectionGatewaySlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the gateway. Currently, the only supported string is "primary".
       */
      @path
      gatewayName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will add or update a gateway for the production slot's Virtual Network.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The properties to update this gateway with.
       */
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @patch
  updateVnetConnectionGatewaySlot is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the gateway. Currently, the only supported string is "primary".
       */
      @path
      gatewayName: string;

      /**
       * Name of the deployment slot. If a slot is not specified, the API will add or update a gateway for the production slot's Virtual Network.
       */
      @path
      slot: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The properties to update this gateway with.
       */
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  /**
   * Description for Gets the source control configuration of an app.
   */
  @summary("Gets the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @get
  getSourceControl is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteSourceControl
  >;

  /**
   * Description for Updates the source control configuration of an app.
   */
  @summary("Updates the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @put
  createOrUpdateSourceControl is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON representation of a SiteSourceControl object. See example.
       */
      @body
      siteSourceControl: SiteSourceControl;
    },
    SiteSourceControl
  >;

  /**
   * Description for Deletes the source control configuration of an app.
   */
  @summary("Deletes the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @delete
  deleteSourceControl is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      @query("additionalFlags")
      additionalFlags?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Updates the source control configuration of an app.
   */
  @summary("Updates the source control configuration of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/sourcecontrols/web")
  @patch
  updateSourceControl is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * JSON representation of a SiteSourceControl object. See example.
       */
      @body
      siteSourceControl: SiteSourceControl;
    },
    SiteSourceControl
  >;

  /**
   * Description for List triggered web jobs for an app, or a deployment slot.
   */
  @summary("List triggered web jobs for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs")
  @get
  listTriggeredWebJobs is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<TriggeredWebJob>
  >;

  /**
   * Description for Gets a triggered web job by its ID for an app, or a deployment slot.
   */
  @summary("Gets a triggered web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}")
  @get
  getTriggeredWebJob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    TriggeredWebJob
  >;

  /**
   * Description for Delete a triggered web job by its ID for an app, or a deployment slot.
   */
  @summary("Delete a triggered web job by its ID for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}")
  @delete
  deleteTriggeredWebJob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for List a triggered web job's history for an app, or a deployment slot.
   */
  @summary("List a triggered web job's history for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/history")
  @get
  listTriggeredWebJobHistory is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<TriggeredJobHistory>
  >;

  /**
   * Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
   */
  @summary("Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/history/{id}")
  @get
  getTriggeredWebJobHistory is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * History ID.
       */
      @path
      id: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    TriggeredJobHistory
  >;

  /**
   * Description for Run a triggered web job for an app, or a deployment slot.
   */
  @summary("Run a triggered web job for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/triggeredwebjobs/{webJobName}/run")
  @post
  runTriggeredWebJob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of Web Job.
       */
      @path
      webJobName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets the virtual networks the app (or deployment slot) is connected to.
   */
  @summary("Gets the virtual networks the app (or deployment slot) is connected to.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections")
  @get
  listVnetConnections is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a virtual network the app (or deployment slot) is connected to by name.
   */
  @summary("Gets a virtual network the app (or deployment slot) is connected to by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @get
  getVnetConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the virtual network.
       */
      @path
      vnetName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    VnetInfoResource
  >;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @put
  createOrUpdateVnetConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of an existing Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the Virtual Network connection. See example.
       */
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  /**
   * Description for Deletes a connection from an app (or deployment slot to a named virtual network.
   */
  @summary("Deletes a connection from an app (or deployment slot to a named virtual network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @delete
  deleteVnetConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the virtual network.
       */
      @path
      vnetName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).
   */
  @summary("Adds a Virtual Network connection to an app or slot (PUT) or updates the connection properties (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}")
  @patch
  updateVnetConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of an existing Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Properties of the Virtual Network connection. See example.
       */
      @body
      connectionEnvelope: VnetInfoResource;
    },
    VnetInfoResource
  >;

  /**
   * Description for Gets an app's Virtual Network gateway.
   */
  @summary("Gets an app's Virtual Network gateway.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @get
  getVnetConnectionGateway is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the gateway. Currently, the only supported string is "primary".
       */
      @path
      gatewayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    VnetGateway
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @put
  createOrUpdateVnetConnectionGateway is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the gateway. Currently, the only supported string is "primary".
       */
      @path
      gatewayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The properties to update this gateway with.
       */
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  /**
   * Description for Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
   */
  @summary("Adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}")
  @patch
  updateVnetConnectionGateway is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Name of the gateway. Currently, the only supported string is "primary".
       */
      @path
      gatewayName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * The properties to update this gateway with.
       */
      @body
      connectionEnvelope: VnetGateway;
    },
    VnetGateway
  >;

  /**
   * Description for List webjobs for an app, or a deployment slot.
   */
  @summary("List webjobs for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/webjobs")
  @get
  listWebJobs is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<WebJob>
  >;

  /**
   * Description for Get webjob information for an app, or a deployment slot.
   */
  @summary("Get webjob information for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/webjobs/{webJobName}")
  @get
  getWebJob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Site name.
       */
      @path
      name: string;

      /**
       * Name of the web job.
       */
      @path
      webJobName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    WebJob
  >;
}
