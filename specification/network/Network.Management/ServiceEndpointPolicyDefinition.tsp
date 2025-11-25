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
@parentResource(ServiceEndpointPolicy)
model ServiceEndpointPolicyDefinition
  is Azure.ResourceManager.ProxyResource<ServiceEndpointPolicyDefinitionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ServiceEndpointPolicyDefinition,
    KeyName = "serviceEndpointPolicyDefinitionName",
    SegmentName = "serviceEndpointPolicyDefinitions",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ServiceEndpointPolicyDefinitions {
  /**
   * Get the specified service endpoint policy definitions from service endpoint policy.
   */
  get is ArmResourceRead<ServiceEndpointPolicyDefinition, Error = CloudError>;

  /**
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceEndpointPolicyDefinition, Error = CloudError>;

  /**
   * Deletes the specified ServiceEndpoint policy definitions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<ServiceEndpointPolicyDefinition,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Gets all service endpoint policy definitions in a service end point policy.
   */
  listByResourceGroup is ArmResourceListByParent<ServiceEndpointPolicyDefinition, Error = CloudError>;
}

@@doc(ServiceEndpointPolicyDefinition.name,
  "The name of the service endpoint policy definition name."
);
@@doc(ServiceEndpointPolicyDefinition.properties,
  "Properties of the service endpoint policy definition."
);
@@doc(ServiceEndpointPolicyDefinitions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service endpoint policy operation."
);
