import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/ServiceEndpointPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
interface ServiceEndpointPolicies {
  /**
   * Gets the specified service Endpoint Policies in a specified resource group.
   */
  get is ArmResourceRead<
    ServiceEndpointPolicy,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a service Endpoint Policies.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceEndpointPolicy,
    Error = CloudError
  >;

  /**
   * Updates tags of a service endpoint policy.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ServiceEndpointPolicy,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified service endpoint policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceEndpointPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all service endpoint Policies in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ServiceEndpointPolicy,
    Error = CloudError
  >;

  /**
   * Gets all the service endpoint policies in a subscription.
   */
  list is ArmListBySubscription<ServiceEndpointPolicy, Error = CloudError>;
}

@@doc(ServiceEndpointPolicy.name, "The name of the service endpoint policy.");
@@doc(ServiceEndpointPolicy.properties,
  "Properties of the service end point policy."
);
@@doc(ServiceEndpointPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service endpoint policy operation."
);
@@doc(ServiceEndpointPolicies.updateTags::parameters.properties,
  "Parameters supplied to update service endpoint policy tags."
);
