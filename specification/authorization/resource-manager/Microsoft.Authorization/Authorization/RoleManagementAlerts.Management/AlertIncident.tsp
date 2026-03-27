import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Alert.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.RoleManagementAlerts;
/**
 * Alert incident
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
@parentResource(Alert)
model AlertIncident
  is Azure.ResourceManager.ExtensionResource<AlertIncidentProperties> {
  ...ResourceNameParameter<
    Resource = AlertIncident,
    KeyName = "alertIncidentId",
    SegmentName = "alertIncidents",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AlertIncidents {
  /**
   * Get the specified alert incident.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    AlertIncident,
    Error = CloudError
  >;

  /**
   * Gets alert incidents for a resource scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    AlertIncident,
    Error = CloudError
  >;

  /**
   * Remediate an alert incident.
   */
  remediate is Extension.ActionSync<
    Extension.ScopeParameter,
    AlertIncident,
    void,
    NoContentResponse,
    Error = CloudError
  >;
}

@@doc(AlertIncident.name, "The name of the alert incident to get.");
@@doc(AlertIncident.properties, "Alert incident properties.");
