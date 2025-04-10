import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the Internal Network resource.
 */
@parentResource(L3IsolationDomain)
model InternalNetwork
  is Azure.ResourceManager.ProxyResource<InternalNetworkProperties, false> {
  ...ResourceNameParameter<
    Resource = InternalNetwork,
    KeyName = "internalNetworkName",
    SegmentName = "internalNetworks",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    InternalNetwork,
    PatchModel = InternalNetworkPatch
  >;

  /**
   * Implements InternalNetworks DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<InternalNetwork>;

  /**
   * Displays InternalNetworks list by resource group GET method.
   */
  listByL3IsolationDomain is ArmResourceListByParent<
    InternalNetwork,
    Response = ArmResponse<InternalNetworksList>
  >;

  /**
   * Update Administrative state of  InternalNetworks on resources referred by their resource ids.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Update BGP state for internalNetwork. Allowed only on edge devices.
   */
  updateBgpAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Update Static Route BFD administrative state for internalNetwork.
   */
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(InternalNetwork.name, "Name of the Internal Network.");
@@doc(InternalNetwork.properties, "Resource properties.");
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
