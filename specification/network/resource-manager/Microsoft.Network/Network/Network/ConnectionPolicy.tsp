import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Network;
/**
 * ConnectionPolicy resource defined for VirtualHub.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VirtualHub)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ConnectionPolicy extends ReadOnlySubResourceModel {
  properties?: ConnectionPolicyProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("connectionPolicyName")
  @segment("connectionPolicies")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@armResourceOperations(#{ omitTags: true })
interface ConnectionPolicies {
  /**
   * Retrieves the details of a ConnectionPolicy.
   */
  get is ArmResourceRead<ConnectionPolicy, Error = CloudError>;

  /**
   * Creates a ConnectionPolicy if it doesn't exist else updates the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConnectionPolicy,
    Error = CloudError
  >;

  /**
   * Deletes a ConnectionPolicy.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectionPolicy,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all ConnectionPolicies of the hub.
   */
  list is ArmResourceListByParent<
    ConnectionPolicy,
    Response = ArmResponse<ListConnectionPoliciesResult>,
    Error = CloudError
  >;
}

@@doc(ConnectionPolicy.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(ConnectionPolicy.properties, "Properties of the ConnectionPolicy.");
@@doc(ConnectionPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a ConnectionPolicy."
);
