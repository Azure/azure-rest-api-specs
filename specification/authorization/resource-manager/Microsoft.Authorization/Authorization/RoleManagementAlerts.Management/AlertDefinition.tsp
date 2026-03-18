import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * Alert definition
 */
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
  get is Extension.Read<Extension.ScopeParameter, AlertDefinition>;

  /**
   * Gets alert definitions for a resource scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    AlertDefinition
  >;
}

@@doc(AlertDefinition.name, "The name of the alert definition to get.");
@@doc(AlertDefinition.properties, "Alert definition properties.");
