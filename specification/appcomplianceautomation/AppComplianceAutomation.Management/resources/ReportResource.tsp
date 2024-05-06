import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "../operations.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using OpenAPI;
using Azure.Core;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation report resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ReportProperties)
model ReportResource extends ProxyResourceBase {
  /**
   * Report Name.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  @path
  @key("reportName")
  @segment("reports")
  @visibility("read")
  name: string;

  /**
   * Report property.
   */
  @extension("x-ms-client-flatten", true)
  @extension("x-ms-client-name", "properties")
  properties: ReportProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface ReportResources {
  /**
   * Get the AppComplianceAutomation report and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_Get")
  get is ArmResourceRead<ReportResource>;

  /**
   * Create a new AppComplianceAutomation report or update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_CreateOrUpdate")
  createOrUpdate is AcatOperations.AcatResourceCreateOrReplaceAsync<
    ReportResource,
    BaseParameters<ReportResource>
  >;

  /**
   * Update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Reports_Update")
  update is ArmCustomPatchAsync<
    ReportResource,
    ReportResourcePatch,
    BaseParameters<ReportResource>
  >;

  /**
   * Delete an AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReportResource,
    BaseParameters<ReportResource>
  >;

  /**
   * Get the AppComplianceAutomation report list for the tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_List")
  list is ArmResourceListByParent<
    ReportResource,
    {
      ...BaseParameters<ReportResource>;
      ...QueryParameters;
    }
  >;

  /**
   * Synchronize attestation record from app compliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_SyncCertRecord")
  syncCertRecord is ArmResourceActionAsync<
    ReportResource,
    SyncCertRecordRequest,
    SyncCertRecordResponse,
    BaseParameters<ReportResource>
  >;

  /**
   * Checks the report's nested resource name availability, e.g: Webhooks, Evidences, Snapshots.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_NestedResourceCheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    ReportResource,
    CheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_Fix")
  fix is ArmResourceActionAsync<
    ReportResource,
    void,
    ReportFixResult,
    BaseParameters<ReportResource>
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GetScopingQuestions")
  getScopingQuestions is ArmResourceActionSync<
    ReportResource,
    void,
    ScopingQuestions,
    BaseParameters<ReportResource>
  >;

  /**
   * Verify the AppComplianceAutomation report health status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Report_Verify")
  verify is ArmResourceActionAsync<
    ReportResource,
    void,
    ReportVerificationResult,
    BaseParameters<ReportResource>
  >;
}

@@doc(ReportResources.createOrUpdate::parameters.parameters,
  "Parameters for the create or update operation"
);
@@doc(ReportResources.update::parameters.properties,
  "Parameters for the create or update operation"
);
@@doc(ReportResources.syncCertRecord::parameters.body,
  "Parameters for synchronize certification record operation"
);
@@doc(ReportResources.checkNameAvailability::parameters.body,
  "NameAvailabilityRequest object."
);
@@encodedName(ReportResources.update::parameters.properties,
  "application/json",
  "parameters"
);
