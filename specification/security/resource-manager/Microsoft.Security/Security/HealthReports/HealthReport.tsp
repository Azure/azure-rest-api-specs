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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

alias HealthReportOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The health report key. */
    @path
    @segment("healthReports")
    @key
    @pattern("[{]?[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$")
    healthReportName: string;
  }
>;

@armResourceOperations
interface HealthReports {
  /**
   * Get health report of resource
   */
  get is HealthReportOps.Read<HealthReport>;

  /**
   * Get a list of all health reports inside a scope. Valid scopes are: subscription (format: 'subscriptions/{subscriptionId}'), or security connector (format: 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/securityConnectors/{securityConnectorName})'
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    HealthReport,
    Response = ArmResponse<HealthReportsList>
  >;
}

@@minLength(Azure.ResourceManager.Extension.ScopeParameter.scope, 1);
@@doc(HealthReport.name,
  "The health report Key - Unique key for the health report type"
);
@@doc(HealthReport.properties, "Properties of a health report");
