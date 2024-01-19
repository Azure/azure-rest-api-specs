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
@doc("Defines the External Network resource.")
@parentResource(L3IsolationDomain)
model ExternalNetwork is ProxyResource<ExternalNetworkProperties> {
  @doc("Name of the External Network.")
  @path
  @key("externalNetworkName")
  @segment("externalNetworks")
  name: string;
}

@armResourceOperations
interface ExternalNetworks {
  @doc("Implements ExternalNetworks GET method.")
  get is ArmResourceRead<ExternalNetwork>;

  @doc("Creates ExternalNetwork PUT method.")
  create is ArmResourceCreateOrUpdateAsync<
    ExternalNetwork,
    BaseParameters<ExternalNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the ExternalNetworks resource.")
  update is ArmCustomPatchAsync<
    ExternalNetwork,
    ExternalNetworkPatch,
    BaseParameters<ExternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Implements ExternalNetworks DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExternalNetwork,
    BaseParameters<ExternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Implements External Networks list by resource group GET method.")
  listByL3IsolationDomain is ArmResourceListByParent<ExternalNetwork>;

  @doc("Executes update operation to enable or disable administrative State for externalNetwork.")
  updateAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<ExternalNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Update Static Route BFD for external Network.")
  updateStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    ExternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<ExternalNetwork>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ExternalNetworks.create::parameters.resource, "json", "body");
@@extension(ExternalNetworks.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ExternalNetworks.create::parameters.resource, "Request payload.");
@@projectedName(ExternalNetworks.update::parameters.properties, "json", "body");
@@extension(ExternalNetworks.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(ExternalNetworks.update::parameters.properties,
  "ExternalNetwork properties to update. Only annotations are supported."
);
@@doc(ExternalNetworks.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(ExternalNetworks.updateStaticRouteBfdAdministrativeState::parameters.body,
  "Request payload."
);
