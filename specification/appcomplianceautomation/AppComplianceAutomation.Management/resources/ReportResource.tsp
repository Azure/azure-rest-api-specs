import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation report resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
@tenantResource
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ReportProperties)
model ReportResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Report Name.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  @key("reportName")
  @segment("reports")
  @visibility(Lifecycle.Read)
  @path
  name: string;

  /**
   * Report property.
   */
  #suppress "deprecated" "Legacy flatten"
  @Azure.ClientGenerator.Core.flattenProperty
  properties: ReportProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface Report {
  /**
   * Get the AppComplianceAutomation report and its properties.
   */
  get is ArmResourceRead<ReportResource>;

  /**
   * Create a new AppComplianceAutomation report or update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ReportResource,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an exiting AppComplianceAutomation report.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ReportResource,
    ReportResourcePatch,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Delete an AppComplianceAutomation report.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ReportResource,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Get the AppComplianceAutomation report list for the tenant.
   */
  list is ArmResourceListByParent<
    ReportResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<ReportResource>;
      ...QueryParameters;
    }
  >;

  /**
   * Synchronize attestation record from app compliance.
   */
  syncCertRecord is ArmResourceActionAsync<
    ReportResource,
    SyncCertRecordRequest,
    SyncCertRecordResponse,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>,
    BodyParameter = {
      #suppress "deprecated" "Avoid ModelValidation issues"
      @encodedName("application/json", "parameters")
      @doc("Parameters for synchronize certification record operation")
      @bodyRoot
      body: SyncCertRecordRequest;
    }
  >;

  /**
   * Checks the report's nested resource name availability, e.g: Webhooks, Evidences, Snapshots.
   */
  @action("checkNameAvailability")
  nestedResourceCheckNameAvailability is ArmResourceActionSync<
    ReportResource,
    Azure.ResourceManager.Foundations.CheckNameAvailabilityRequest,
    Azure.ResourceManager.Foundations.CheckNameAvailabilityResponse,
    BodyParameter = {
      #suppress "deprecated" "Avoid ModelValidation issues"
      @encodedName("application/json", "parameters")
      @doc("NameAvailabilityRequest object.")
      @bodyRoot
      body: Azure.ResourceManager.Foundations.CheckNameAvailabilityRequest;
    }
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  fix is ArmResourceActionAsync<
    ReportResource,
    void,
    ReportFixResult,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  getScopingQuestions is ArmResourceActionSync<
    ReportResource,
    void,
    ScopingQuestions,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Verify the AppComplianceAutomation report health status.
   */
  verify is ArmResourceActionAsync<
    ReportResource,
    void,
    ReportVerificationResult,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;
}

@@doc(Report.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Report.createOrUpdate::parameters.resource,
  "application/json",
  "parameters"
);

@@clientName(Report.createOrUpdate::parameters.resource, "properties");

@@doc(Report.update::parameters.properties,
  "Parameters for the create or update operation"
);

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Report.update::parameters.properties,
  "application/json",
  "parameters"
);
