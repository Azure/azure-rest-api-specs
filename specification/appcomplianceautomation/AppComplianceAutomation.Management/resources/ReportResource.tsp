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
using TypeSpec.Versioning;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation report resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Referencing elements inside Private namespace"
@tenantResource
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ReportProperties)
model ReportResource extends Foundations.ProxyResource {
  /**
   * Report Name.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  @path
  @key("reportName")
  @segment("reports")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Report property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  @extension("x-ms-client-name", "properties")
  properties: ReportProperties;

  @added(Versions.v2024_12_15_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface ReportResources {
  /**
   * Get the AppComplianceAutomation report and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Reports_Get")
  get is ArmResourceRead<ReportResource>;

  /**
   * Create a new AppComplianceAutomation report or update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Reports_CreateOrUpdate")
  createOrUpdate is AcatOperations.AcatResourceCreateOrReplaceAsync<
    ReportResource,
    BaseParameters<ReportResource>
  >;

  /**
   * Update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Reports_Update")
  update is ArmCustomPatchAsync<
    ReportResource,
    ReportResourcePatch,
    BaseParameters<ReportResource>
  >;

  /**
   * Delete an AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Reports_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReportResource,
    BaseParameters<ReportResource>
  >;

  /**
   * Get the AppComplianceAutomation report list for the tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Reports_NestedResourceCheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    ReportResource,
    CheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse
  >;

  /**
   * Fix the AppComplianceAutomation report error. e.g: App Compliance Automation Tool service unregistered, automation removed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Deprecated: Using encodedName for the body property is meaningless."
@@encodedName(ReportResources.update::parameters.properties,
  "application/json",
  "parameters"
);
