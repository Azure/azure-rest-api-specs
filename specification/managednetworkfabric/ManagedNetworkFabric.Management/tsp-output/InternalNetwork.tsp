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
/**
 * Defines the Internal Network resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(L3IsolationDomain)
@Azure.ResourceManager.Private.armResourceInternal(InternalNetworkProperties)
@includeInapplicableMetadataInPayload(false)
model InternalNetwork extends ProxyResourceBase {
  /**
   * Name of the Internal Network.
   */
  @path
  @key("internalNetworkName")
  @segment("internalNetworks")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
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
  create is ArmResourceCreateOrReplaceAsync<
    InternalNetwork,
    BaseParameters<InternalNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a InternalNetworks.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    InternalNetwork,
    InternalNetworkPatch,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Implements InternalNetworks DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    InternalNetwork,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Displays InternalNetworks list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InternalNetworks_ListByL3IsolationDomain")
  listByL3IsolationDomain is ArmResourceListByParent<InternalNetwork>;

  /**
   * Update Administrative state of  InternalNetworks on resources referred by their resource ids.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Update BGP state for internalNetwork. Allowed only on edge devices.
   */
  updateBgpAdministrativeState is ArmResourceActionAsync<
    InternalNetwork,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<InternalNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Update Static Route BFD administrative state for internalNetwork.
   */
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
