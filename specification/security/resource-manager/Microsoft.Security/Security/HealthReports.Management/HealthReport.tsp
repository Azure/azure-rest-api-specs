import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The health report resource
 */
@extensionResource
model HealthReport
  is Azure.ResourceManager.ExtensionResource<HealthReportProperties> {
  ...ResourceNameParameter<
    Resource = HealthReport,
    KeyName = "healthReportName",
    SegmentName = "healthReports",
    NamePattern = "[{]?[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$"
  >;
}

@armResourceOperations
interface HealthReports {
  /**
   * Get health report of resource
   */
  get is Extension.Read<Extension.ScopeParameter, HealthReport>;

  /**
   * Get a list of all health reports inside a scope. Valid scopes are: subscription (format: 'subscriptions/{subscriptionId}'), or security connector (format: 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName})'
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    HealthReport,
    Parameters = {
      /**
       * The scope at which the operation is performed.
       */
      @minLength(1)
      @path
      scope: string;
    },
    Response = ArmResponse<HealthReportsList>
  >;
}

@@doc(HealthReport.name,
  "The health report Key - Unique key for the health report type"
);
@@doc(HealthReport.properties, "Properties of a health report");
