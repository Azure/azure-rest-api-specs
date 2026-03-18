import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Alert.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * Alert incident
 */
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
  get is Extension.Read<Extension.ScopeParameter, AlertIncident>;

  /**
   * Gets alert incidents for a resource scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    AlertIncident
  >;

  /**
   * Remediate an alert incident.
   */
  remediate is Extension.ActionSync<
    Extension.ScopeParameter,
    AlertIncident,
    void,
    NoContentResponse
  >;
}

@@doc(AlertIncident.name, "The name of the alert incident to get.");
@@doc(AlertIncident.properties, "Alert incident properties.");
