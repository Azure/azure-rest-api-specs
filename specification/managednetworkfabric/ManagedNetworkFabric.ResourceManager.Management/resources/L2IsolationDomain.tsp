import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The L2 Isolation Domain resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model L2IsolationDomain
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the L2 Isolation Domain.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("l2IsolationDomainName")
  @segment("l2IsolationDomains")
  @visibility("read")
  name: string;

  /** The L2IsolationDomain properties */
  properties: L2IsolationDomainProperties;
}

@armResourceOperations
interface L2IsolationDomains {
  /**
   * Implements L2 Isolation Domain GET method.
   */
  get is ArmResourceRead<L2IsolationDomain>;

  /**
   * Creates layer 2 network connectivity between compute nodes within a rack and across racks.The configuration is applied on the devices only after the isolation domain is enabled.
   */
  create is ArmResourceCreateOrReplaceAsync<L2IsolationDomain>;

  /**
   * API to update certain properties of the L2 Isolation Domain resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<L2IsolationDomain, L2IsolationDomainPatch>;

  /**
   * Deletes layer 2 connectivity between compute nodes by managed by named L2 Isolation name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<L2IsolationDomain>;

  /**
   * Displays L2IsolationDomains list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<L2IsolationDomain>;

  /**
   * Displays L2IsolationDomains list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<L2IsolationDomain>;

  /**
   * Enables isolation domain across the fabric or on specified racks.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    L2IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    ValidateConfigurationResponse
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(L2IsolationDomains.create::parameters.resource, "Request payload.");
@@doc(L2IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L2 Isolation Domain resource.."
);
@@doc(L2IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
