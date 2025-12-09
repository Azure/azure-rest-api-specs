import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AlertsManagement;
/**
 * A Tenant Activity Log Alert rule resource.
 */
model TenantActivityLogAlertResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<
    AlertRuleProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = TenantActivityLogAlertResource,
    KeyName = "alertRuleName",
    SegmentName = "tenantActivityLogAlerts",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface TenantActivityLogAlertResources {
  /**
   * Get Tenant Activity Log Alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActivityLogAlerts_Get")
  get is Extension.Read<
    Extension.ManagementGroup,
    TenantActivityLogAlertResource
  >;

  /**
   * Create a new Tenant Activity Log Alert rule or update an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActivityLogAlerts_CreateOrUpdate")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ManagementGroup,
    TenantActivityLogAlertResource
  >;

  /**
   * Updates 'tags' and 'enabled' fields in an existing Tenant Alert rule. This method is used to update the Alert rule tags, and to enable or disable the Alert rule. To update other fields use CreateOrUpdate operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActivityLogAlerts_Update")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ManagementGroup,
    TenantActivityLogAlertResource,
    PatchModel = TenantAlertRulePatchObject
  >;

  /**
   * Delete a Tenant Activity Log Alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActivityLogAlerts_Delete")
  delete is Extension.DeleteSync<
    Extension.ManagementGroup,
    TenantActivityLogAlertResource
  >;

  /**
   * Get a list of all Tenant Activity Log Alert rules in a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActivityLogAlerts_ListByManagementGroup")
  listByManagementGroup is Extension.ListByTarget<
    Extension.ManagementGroup,
    TenantActivityLogAlertResource,
    Response = ArmResponse<TenantAlertRuleList>
  >;
}

@@doc(TenantActivityLogAlertResource.name,
  "The name of the Tenant Activity Log Alert rule."
);
@@doc(TenantActivityLogAlertResource.properties,
  "The Activity Log Alert rule properties of the resource."
);
@@doc(TenantActivityLogAlertResources.createOrUpdate::parameters.resource,
  "The Tenant Activity Log Alert rule to create or use for the update."
);
@@doc(TenantActivityLogAlertResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
