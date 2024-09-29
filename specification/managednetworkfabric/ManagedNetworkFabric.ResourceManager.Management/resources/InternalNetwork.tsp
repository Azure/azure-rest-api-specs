import "../models/common.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the Internal Network resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@parentResource(L3IsolationDomain)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(InternalNetworkProperties)
model InternalNetwork extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Name of the Internal Network.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internalNetworkName")
  @segment("internalNetworks")
  @visibility("read")
  name: string;

  /** The Internal Network Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: InternalNetworkProperties;
}

@armResourceOperations
interface InternalNetworks {
  /**
   * Gets a InternalNetworks.
   */
  get is ArmResourceRead<InternalNetwork>;

  /**
   * Creates InternalNetwork PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<InternalNetwork>;

  /**
   * Updates a InternalNetworks.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<InternalNetwork, InternalNetworkPatch>;

  /**
   * Implements InternalNetworks DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<InternalNetwork>;

  /**
   * Displays InternalNetworks list by resource group GET method.
   */
  listByL3IsolationDomain is ArmResourceListByParent<InternalNetwork>;

  /**
   * Update Administrative state of  InternalNetworks on resources referred by their resource ids.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Update BGP state for internalNetwork. Allowed only on edge devices.
   */
  updateBgpAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Update Static Route BFD administrative state for internalNetwork.
   */
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(InternalNetworks.create::parameters.resource, "Request payload.");
@@doc(InternalNetworks.update::parameters.properties,
  "InternalNetwork properties to update. Only annotations are supported."
);
@@doc(InternalNetworks.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateBgpAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateStaticRouteBfdAdministrativeState::parameters.body,
  "Request payload."
);
