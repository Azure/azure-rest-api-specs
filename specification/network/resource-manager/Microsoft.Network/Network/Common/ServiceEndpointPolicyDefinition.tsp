import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Common;
/**
 * Service Endpoint policy definitions.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@parentResource(ServiceEndpointPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ServiceEndpointPolicyDefinition extends SubResourceModel {
  properties?: ServiceEndpointPolicyDefinitionPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("serviceEndpointPolicyDefinitionName")
  @segment("serviceEndpointPolicyDefinitions")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(ServiceEndpointPolicyDefinition.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(ServiceEndpointPolicyDefinition.properties,
  "Properties of the service endpoint policy definition."
);
