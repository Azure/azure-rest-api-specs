import "../models/common.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the External Network resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@parentResource(L3IsolationDomain)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ExternalNetworkProperties)
model ExternalNetwork extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Name of the External Network.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("externalNetworkName")
  @segment("externalNetworks")
  @visibility("read")
  name: string;

  /** External Network Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: ExternalNetworkProperties;
}

@armResourceOperations
interface ExternalNetworks {
  /**
   * Implements ExternalNetworks GET method.
   */
  get is ArmResourceRead<ExternalNetwork>;

  /**
   * Creates ExternalNetwork PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<ExternalNetwork>;

  /**
   * API to update certain properties of the ExternalNetworks resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<ExternalNetwork, ExternalNetworkPatch>;

  /**
   * Implements ExternalNetworks DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExternalNetwork>;

  /**
   * Implements External Networks list by resource group GET method.
   */
  listByL3IsolationDomain is ArmResourceListByParent<ExternalNetwork>;

  /**
   * Executes update operation to enable or disable administrative State for externalNetwork.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Update Static Route BFD for external Network.
   */
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(ExternalNetworks.create::parameters.resource, "Request payload.");
@@doc(ExternalNetworks.update::parameters.properties,
  "ExternalNetwork properties to update. Only annotations are supported."
);
@@doc(ExternalNetworks.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateStaticRouteBfdAdministrativeState::parameters.body,
  "Request payload."
);
