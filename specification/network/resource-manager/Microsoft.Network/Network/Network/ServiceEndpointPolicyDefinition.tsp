import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceEndpointPolicy.tsp";
import "../Common/ServiceEndpointPolicyDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ omitTags: true })
interface ServiceEndpointPolicyDefinitions {
  @tag("serviceEndpointPolicyDefinitions")
  get is ArmResourceRead<ServiceEndpointPolicyDefinition, Error = CloudError>;

  /**
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   */
  @tag("serviceEndpointPolicyDefinitions")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceEndpointPolicyDefinition,
    Error = CloudError
  >;

  /**
   * Deletes the specified ServiceEndpoint policy definitions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ServiceEndpointPolicyDefinitions")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceEndpointPolicyDefinition,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all service endpoint policy definitions in a service end point policy.
   */
  @tag("ServiceEndpointPolicyDefinitions")
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
