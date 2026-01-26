import "../models/common.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the External Network resource.")
@parentResource(L3IsolationDomain)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ExternalNetworkProperties)
model ExternalNetwork extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the External Network.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("externalNetworkName")
  @segment("externalNetworks")
  @visibility(Lifecycle.Read)
  name: string;

  /** External Network Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: ExternalNetworkProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("External Network Properties")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: ExternalNetworkProperties;
}

@armResourceOperations
interface ExternalNetworks {
  @doc("Implements ExternalNetworks GET method.")
  get is ArmResourceRead<ExternalNetwork>;

  @doc("Creates ExternalNetwork PUT method.")
  create is ArmResourceCreateOrReplaceAsync<ExternalNetwork>;

  @doc("API to update certain properties of the ExternalNetworks resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<ExternalNetwork, ExternalNetworkPatch>;

  @doc("Implements ExternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<ExternalNetwork>;

  @doc("Implements External Networks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<ExternalNetwork>;

  @doc("Executes update operation to enable or disable administrative State for externalNetwork.")
  @action("updateAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Executes update operation to enable or disable administrative State for externalNetwork.")
  @action("updateAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Update Static Route BFD for external Network.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2025_07_15, "updateStaticRouteBfdAdministrativeState")
  @action("updateStaticRouteBfdAdministrativeState")
  @sharedRoute
  updateStaticRouteBfdAdministrativeStateDeprecated is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Update Static Route BFD for external Network.")
  @action("updateStaticRouteBfdAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
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
    ExternalNetwork,
    ExternalNetworkBfdAdministrativeStateRequest,
    ExternalNetworkBfdAdministrativeStateResponse
  >;

  @doc("BFD administrative state for either static or bgp for internalNetwork.")
  @action("updateBfdAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateBfdAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    ExternalNetworkUpdateBfdAdministrativeStateRequest,
    ExternalNetworkUpdateBfdAdministrativeStateResponse
  >;
}

@@doc(ExternalNetworks.create::parameters.resource, "Request payload.");
@@doc(ExternalNetworks.update::parameters.properties,
  "ExternalNetwork properties to update. Only annotations are supported."
);
@@doc(ExternalNetworks.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateStaticRouteBfdAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateStaticRouteBfdAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateBfdAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateBfdAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
