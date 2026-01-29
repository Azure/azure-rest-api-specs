import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceEndpointPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
interface ServiceEndpointPolicyDefinitions {
  /**
   * Get the specified service endpoint policy definitions from service endpoint policy.
   */
  get is ArmResourceRead<ServiceEndpointPolicyDefinition, Error = CloudError>;

  /**
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceEndpointPolicyDefinition,
    Error = CloudError
  >;

  /**
   * Deletes the specified ServiceEndpoint policy definitions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceEndpointPolicyDefinition,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all service endpoint policy definitions in a service end point policy.
   */
  listByResourceGroup is ArmResourceListByParent<
    ServiceEndpointPolicyDefinition,
    Error = CloudError
  >;
}

@@doc(ServiceEndpointPolicyDefinition.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(ServiceEndpointPolicyDefinition.properties,
  "Properties of the service endpoint policy definition."
);
@@doc(ServiceEndpointPolicyDefinitions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service endpoint policy operation."
);
