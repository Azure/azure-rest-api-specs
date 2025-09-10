import "../models/common.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the Internal Network resource.")
@parentResource(L3IsolationDomain)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(InternalNetworkProperties)
model InternalNetwork extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the Internal Network.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internalNetworkName")
  @segment("internalNetworks")
  @visibility(Lifecycle.Read)
  name: string;

  /** The Internal Network Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: InternalNetworkProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("The Internal Network Properties")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: InternalNetworkProperties;
}

@armResourceOperations
interface InternalNetworks {
  @doc("Gets a InternalNetworks.")
  get is ArmResourceRead<InternalNetwork>;

  @doc("Creates InternalNetwork PUT method.")
  create is ArmResourceCreateOrReplaceAsync<InternalNetwork>;

  @doc("Updates a InternalNetworks.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<InternalNetwork, InternalNetworkPatch>;

  @doc("Implements InternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<InternalNetwork>;

  @doc("Displays InternalNetworks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<InternalNetwork>;

  @doc("Update Administrative state of  InternalNetworks on resources referred by their resource ids.")
  @action("updateAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Executes update operation to enable or disable administrative State for InternalNetwork.")
  @action("updateAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Update BGP state for internalNetwork. Allowed only on edge devices.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  @action("updateBgpAdministrativeState")
  updateBgpAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    InternalNetworkUpdateBgpAdministrativeStateRequest,
    InternalNetworkUpdateBgpAdministrativeStateResponse
  >;

  @doc("Update BGP state for internalNetwork. Allowed only on edge devices.")
  @added(Versions.v2024_06_15_preview)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateBgpAdministrativeState")
  @sharedRoute
  @action("updateBgpAdministrativeState")
  updateBgpAdministrativeStateDeprecatedV2 is ArmResourceActionAsync<
    InternalNetwork,
    InternalNetworkBgpAdministrativeStateRequest,
    InternalNetworkBgpAdministrativeStateResponse
  >;

  @doc("Update BGP state for internalNetwork. Allowed only on edge devices.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "updateBgpAdministrativeState")
  @sharedRoute
  @action("updateBgpAdministrativeState")
  updateBgpAdministrativeStateDeprecated is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Update Static Route BFD administrative state for internalNetwork.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2025_07_15, "updateStaticRouteBfdAdministrativeState")
  @action("updateStaticRouteBfdAdministrativeState")
  @sharedRoute
  updateStaticRouteBfdAdministrativeStateDeprecated is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Update Static Route BFD administrative state for internalNetwork.")
  @action("updateStaticRouteBfdAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("BFD administrative state for either static or bgp for internalNetwork.")
  @added(Versions.v2024_06_15_preview)
  @action("updateBfdAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateBfdAdministrativeState")
  @sharedRoute
  updateBfdAdministrativeStateDeprecated is ArmResourceActionAsync<
    InternalNetwork,
    InternalNetworkBfdAdministrativeStateRequest,
    InternalNetworkBfdAdministrativeStateResponse
  >;

  @doc("BFD administrative state for either static or bgp for internalNetwork.")
  @action("updateBfdAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateBfdAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    InternalNetworkUpdateBfdAdministrativeStateRequest,
    InternalNetworkUpdateBfdAdministrativeStateResponse
  >;
}

@@doc(InternalNetworks.create::parameters.resource, "Request payload.");
@@doc(InternalNetworks.update::parameters.properties,
  "InternalNetwork properties to update. Only annotations are supported."
);
@@doc(InternalNetworks.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateBgpAdministrativeStateDeprecatedV2::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateBgpAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateBgpAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateStaticRouteBfdAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateStaticRouteBfdAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateBfdAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(InternalNetworks.updateBfdAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
