import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./L3IsolationDomain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("Defines the Internal Network resource.")
@parentResource(L3IsolationDomain)
model InternalNetwork is ProxyResource<InternalNetworkProperties> {
  @doc("Name of the Internal Network.")
  @path
  @key("internalNetworkName")
  @segment("internalNetworks")
  name: string;
}

@armResourceOperations
interface InternalNetworks {
  @doc("Gets a InternalNetworks.")
  get is ArmResourceRead<InternalNetwork>;

  @doc("Creates InternalNetwork PUT method.")
  create is ArmResourceCreateOrUpdateAsync<
    InternalNetwork,
    BaseParameters<InternalNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a InternalNetworks.")
  update is ArmCustomPatchAsync<
    InternalNetwork,
    InternalNetworkPatch,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Implements InternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    InternalNetwork,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Displays InternalNetworks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<InternalNetwork>;

  @doc("Update Administrative state of  InternalNetworks on resources referred by their resource ids.")
  updateAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Update BGP state for internalNetwork. Allowed only on edge devices.")
  updateBgpAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Update Static Route BFD administrative state for internalNetwork.")
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;
}

@@projectedName(InternalNetworks.create::parameters.resource, "json", "body");
@@extension(InternalNetworks.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(InternalNetworks.create::parameters.resource, "Request payload.");
@@projectedName(InternalNetworks.update::parameters.properties, "json", "body");
@@extension(InternalNetworks.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
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
