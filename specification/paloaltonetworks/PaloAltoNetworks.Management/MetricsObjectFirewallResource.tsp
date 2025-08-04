import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * Firewall Metrics Object
 */
@singleton("default")
@parentResource(FirewallResource)
model MetricsObjectFirewallResource
  is Azure.ResourceManager.ProxyResource<MetricsObject, false> {
  ...ResourceNameParameter<
    Resource = MetricsObjectFirewallResource,
    KeyName = "metric",
    SegmentName = "metrics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MetricsObjectFirewallResources {
  /**
   * Get a MetricsObjectFirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsObjectFirewall_Get")
  get is ArmResourceRead<MetricsObjectFirewallResource>;

  /**
   * Create a MetricsObjectFirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsObjectFirewall_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MetricsObjectFirewallResource>;

  /**
   * Delete a MetricsObjectFirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("MetricsObjectFirewall_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    MetricsObjectFirewallResource,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List MetricsObjectFirewallResource resources by Firewalls
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricsObjectFirewall_ListByFirewalls")
  listByFirewalls is ArmResourceListByParent<MetricsObjectFirewallResource>;
}

@@doc(MetricsObjectFirewallResource.name, "");
@@doc(MetricsObjectFirewallResource.properties,
  "The resource-specific properties for this resource."
);
