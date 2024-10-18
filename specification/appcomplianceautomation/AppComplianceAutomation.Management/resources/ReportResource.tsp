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
using OpenAPI;
using Azure.Core;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation report resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ReportProperties)
model ReportResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Report Name.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  @key("reportName")
  @segment("reports")
  @visibility("read")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_Get")
  get is ArmResourceRead<ReportResource>;

  /**
   * Create a new AppComplianceAutomation report or update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("Report_CreateOrUpdate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ReportResource,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @parameterVisibility
  @operationId("Report_Update")
  update is ArmCustomPatchAsync<
    ReportResource,
    ReportResourcePatch,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Delete an AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReportResource,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Get the AppComplianceAutomation report list for the tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_List")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_SyncCertRecord")
  syncCertRecord is ArmResourceActionAsync<
    ReportResource,
    SyncCertRecordRequest,
    SyncCertRecordResponse,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Checks the report's nested resource name availability, e.g: Webhooks, Evidences, Snapshots.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_NestedResourceCheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    ReportResource,
    Azure.ResourceManager.Foundations.CheckNameAvailabilityRequest,
    Azure.ResourceManager.Foundations.CheckNameAvailabilityResponse
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_Fix")
  fix is ArmResourceActionAsync<
    ReportResource,
    void,
    ReportFixResult,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_GetScopingQuestions")
  getScopingQuestions is ArmResourceActionSync<
    ReportResource,
    void,
    ScopingQuestions,
    Azure.ResourceManager.Foundations.BaseParameters<ReportResource>
  >;

  /**
   * Verify the AppComplianceAutomation report health status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Report_Verify")
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
@@doc(Report.syncCertRecord::parameters.body,
  "Parameters for synchronize certification record operation"
);
@@doc(Report.checkNameAvailability::parameters.body,
  "NameAvailabilityRequest object."
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Report.update::parameters.properties,
  "application/json",
  "parameters"
);

@@encodedName(Report.syncCertRecord::parameters.body,
  "application/json",
  "parameters"
);
