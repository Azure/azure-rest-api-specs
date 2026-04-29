import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualHub.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;
/**
 * ConnectionPolicy resource defined for VirtualHub.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP VirtualWAN feature gating, consistent with all other VirtualWAN interface definitions"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for includeInapplicableMetadataInPayload which suppresses systemData in the response payload, consistent with all other VirtualWAN nested resources"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "ConnectionPolicy uses the local Network RP ProxyResource base type consistent with all other VirtualWAN nested resources (e.g. AzureWebCategory, BgpConnection)"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the local Network RP ProxyResource is the established pattern for nested resources in this RP"
@added(Versions.v2025_07_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VirtualHub)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ConnectionPolicy extends ProxyResource {
  /**
   * Properties of the ConnectionPolicy resource.
   */
  properties?: ConnectionPolicyProperties;

  /**
   * The name of the ConnectionPolicy that is unique within a VirtualHub. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("connectionPolicyName")
  @segment("connectionPolicies")
  @pattern("^(?![.-])[a-zA-Z0-9_.-]{1,128}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP VirtualWAN feature gating, consistent with all other VirtualWAN interface definitions"
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
   * Retrieves the details of all ConnectionPolicies.
   */
  list is ArmResourceListByParent<
    ConnectionPolicy,
    Response = ArmResponse<ListConnectionPoliciesResult>,
    Error = CloudError
  >;
}

@@doc(ConnectionPolicy.name,
  "The name of the ConnectionPolicy that is unique within a VirtualHub. This name can be used to access the resource."
);
@@doc(ConnectionPolicy.properties,
  "Properties of the ConnectionPolicy resource."
);
@@doc(ConnectionPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a ConnectionPolicy."
);
