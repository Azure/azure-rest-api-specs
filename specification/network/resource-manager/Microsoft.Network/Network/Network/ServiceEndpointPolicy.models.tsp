import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Service End point policy resource.
 */
@featureFile(Features.expressRoute)
model ServiceEndpointPolicy
  is ResourceInstance<ServiceEndpointPolicyPropertiesFormat> {
  @visibility(Lifecycle.Read)
  @path
  @key("serviceEndpointPolicyName")
  @segment("serviceEndpointPolicies")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Kind of service endpoint policy. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@@doc(ServiceEndpointPolicy.name, "The name of the service endpoint policy.");
@@doc(
  ServiceEndpointPolicy.properties,
  "Properties of the service end point policy."
);
