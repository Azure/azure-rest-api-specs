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
 * Defines the External Network resource.
 */
@parentResource(L3IsolationDomain)
model ExternalNetwork
  is Azure.ResourceManager.ProxyResource<ExternalNetworkProperties, false> {
  ...ResourceNameParameter<
    Resource = ExternalNetwork,
    KeyName = "externalNetworkName",
    SegmentName = "externalNetworks",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ExternalNetwork,
    PatchModel = ExternalNetworkPatch
  >;

  /**
   * Implements ExternalNetworks DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExternalNetwork>;

  /**
   * Implements External Networks list by resource group GET method.
   */
  listByL3IsolationDomain is ArmResourceListByParent<
    ExternalNetwork,
    Response = ArmResponse<ExternalNetworksList>
  >;

  /**
   * Executes update operation to enable or disable administrative State for externalNetwork.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Update Static Route BFD for external Network.
   */
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(ExternalNetwork.name, "Name of the External Network.");
@@doc(ExternalNetwork.properties, "Resource properties.");
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
