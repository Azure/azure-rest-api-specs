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
 * The L3 Isolation Domain resource definition.
 */
model L3IsolationDomain
  is Azure.ResourceManager.TrackedResource<L3IsolationDomainProperties, false> {
  ...ResourceNameParameter<
    Resource = L3IsolationDomain,
    KeyName = "l3IsolationDomainName",
    SegmentName = "l3IsolationDomains",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    L3IsolationDomain,
    PatchModel = L3IsolationDomainPatch
  >;

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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("L3IsolationDomains_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    L3IsolationDomain,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForDeviceUpdate>
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    ArmResponse<ValidateConfigurationResponse>
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(L3IsolationDomain.name, "Name of the L3 Isolation Domain.");
@@doc(L3IsolationDomain.properties, "Resource properties.");
@@doc(L3IsolationDomains.create::parameters.resource, "Request payload.");
@@doc(L3IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L3 Isolation Domain resource."
);
@@doc(L3IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
