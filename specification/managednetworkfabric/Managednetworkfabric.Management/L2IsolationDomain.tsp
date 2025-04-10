import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The L2 Isolation Domain resource definition.
 */
model L2IsolationDomain
  is Azure.ResourceManager.TrackedResource<L2IsolationDomainProperties, false> {
  ...ResourceNameParameter<
    Resource = L2IsolationDomain,
    KeyName = "l2IsolationDomainName",
    SegmentName = "l2IsolationDomains",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    L2IsolationDomain,
    PatchModel = L2IsolationDomainPatch
  >;

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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("L2IsolationDomains_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    L2IsolationDomain,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForDeviceUpdate>
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    ArmResponse<ValidateConfigurationResponse>
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(L2IsolationDomain.name, "Name of the L2 Isolation Domain.");
@@doc(L2IsolationDomain.properties, "Resource properties.");
@@doc(L2IsolationDomains.create::parameters.resource, "Request payload.");
@@doc(L2IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L2 Isolation Domain resource.."
);
@@doc(L2IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
