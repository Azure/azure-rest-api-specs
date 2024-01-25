import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The L3 Isolation Domain resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(L3IsolationDomainProperties)
model L3IsolationDomain extends TrackedResourceBase {
  /**
   * Name of the L3 Isolation Domain.
   */
  @path
  @key("l3IsolationDomainName")
  @segment("l3IsolationDomains")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
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
  create is ArmResourceCreateOrReplaceAsync<
    L3IsolationDomain,
    BaseParameters<L3IsolationDomain>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the L3 Isolation Domain resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    L3IsolationDomain,
    L3IsolationDomainPatch,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes layer 3 connectivity between compute nodes by managed by named L3 Isolation name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    L3IsolationDomain,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  /**
   * Displays L3IsolationDomains list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("L3IsolationDomains_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<L3IsolationDomain>;

  /**
   * Displays L3IsolationDomains list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<L3IsolationDomain>;

  /**
   * Enables racks for this Isolation Domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("L3IsolationDomains_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    L3IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    ValidateConfigurationResponse,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<L3IsolationDomain>,
    ArmLroLocationHeader
  >;
}

@@projectedName(L3IsolationDomains.create::parameters.resource, "json", "body");
@@extension(L3IsolationDomains.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(L3IsolationDomains.create::parameters.resource, "Request payload.");
@@projectedName(L3IsolationDomains.update::parameters.properties,
  "json",
  "body"
);
@@extension(L3IsolationDomains.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(L3IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L3 Isolation Domain resource."
);
@@doc(L3IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
