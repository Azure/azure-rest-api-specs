import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The L3 Isolation Domain resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@Azure.ResourceManager.Private.armResourceInternal(L3IsolationDomainProperties)
@includeInapplicableMetadataInPayload(false)
model L3IsolationDomain
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the L3 Isolation Domain.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("l3IsolationDomainName")
  @segment("l3IsolationDomains")
  @visibility("read")
  name: string;

  /** The L3 Isolation Domain Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: L3IsolationDomainProperties;
}

@armResourceOperations
interface L3IsolationDomains {
  /**
   * Retrieves details of this L3 Isolation Domain.
   */
  get is ArmResourceRead<L3IsolationDomain>;

  /**
   * Create isolation domain resources for layer 3 connectivity between compute nodes and for communication with external services .This configuration is applied on the devices only after the creation of networks is completed and isolation domain is enabled.
   */
  create is ArmResourceCreateOrReplaceAsync<L3IsolationDomain>;

  /**
   * API to update certain properties of the L3 Isolation Domain resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<L3IsolationDomain, L3IsolationDomainPatch>;

  /**
   * Deletes layer 3 connectivity between compute nodes by managed by named L3 Isolation name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<L3IsolationDomain>;

  /**
   * Displays L3IsolationDomains list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<L3IsolationDomain>;

  /**
   * Displays L3IsolationDomains list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<L3IsolationDomain>;

  /**
   * Enables racks for this Isolation Domain.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    L3IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    ValidateConfigurationResponse
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(L3IsolationDomains.create::parameters.resource, "Request payload.");
@@doc(L3IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L3 Isolation Domain resource."
);
@@doc(L3IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
