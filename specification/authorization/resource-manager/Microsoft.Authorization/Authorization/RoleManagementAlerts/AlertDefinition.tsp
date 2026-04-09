import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.RoleManagementAlerts;
/**
 * Alert definition
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model AlertDefinition
  is Azure.ResourceManager.ExtensionResource<AlertDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = AlertDefinition,
    KeyName = "alertDefinitionId",
    SegmentName = "roleManagementAlertDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AlertDefinitions {
  /**
   * Get the specified alert definition.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    AlertDefinition,
    Error = CloudError
  >;

  /**
   * Gets alert definitions for a resource scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    AlertDefinition,
    Error = CloudError
  >;
}

@@doc(AlertDefinition.name, "The name of the alert definition to get.");
@@doc(AlertDefinition.properties, "Alert definition properties.");
