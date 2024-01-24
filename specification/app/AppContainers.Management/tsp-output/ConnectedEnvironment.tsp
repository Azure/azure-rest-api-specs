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

namespace Microsoft.App;
/**
 * An environment for Kubernetes cluster specialized for web workloads by Azure App Service
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  ConnectedEnvironmentProperties
)
@includeInapplicableMetadataInPayload(false)
model ConnectedEnvironment extends TrackedResourceBase {
  /**
   * Name of the connectedEnvironment.
   */
  @path
  @key("connectedEnvironmentName")
  @segment("connectedEnvironments")
  name: string;

  /**
   * The complex type of the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * ConnectedEnvironment resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConnectedEnvironmentProperties;
}

@armResourceOperations
interface ConnectedEnvironments {
  /**
   * Get the properties of an connectedEnvironment.
   */
  get is ArmResourceRead<ConnectedEnvironment>;

  /**
   * Creates or updates an connectedEnvironment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConnectedEnvironment,
    BaseParameters<ConnectedEnvironment>,
    ArmAsyncOperationHeader
  >;

  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  /**
   * Patches a Managed Environment. Only patching of tags is supported currently
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ConnectedEnvironment, {}>;

  /**
   * Delete an connectedEnvironment.
   */
  delete is ArmResourceDeleteAsync<
    ConnectedEnvironment,
    BaseParameters<ConnectedEnvironment>,
    ArmLroLocationHeader
  >;

  /**
   * Get all connectedEnvironments in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ConnectedEnvironment>;

  /**
   * Get all connectedEnvironments for a subscription.
   */
  listBySubscription is ArmListBySubscription<ConnectedEnvironment>;

  /**
   * Checks if resource connectedEnvironmentName is available.
   */
  checkNameAvailability is ArmResourceActionSync<
    ConnectedEnvironment,
    CheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse
  >;
}

@@projectedName(ConnectedEnvironments.createOrUpdate::parameters.resource,
  "json",
  "environmentEnvelope"
);
@@extension(ConnectedEnvironments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "environmentEnvelope"
);
@@doc(ConnectedEnvironments.createOrUpdate::parameters.resource,
  "Configuration details of the connectedEnvironment."
);
@@projectedName(ConnectedEnvironments.checkNameAvailability::parameters.body,
  "json",
  "checkNameAvailabilityRequest"
);
@@extension(ConnectedEnvironments.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "checkNameAvailabilityRequest"
);
@@doc(ConnectedEnvironments.checkNameAvailability::parameters.body,
  "The check connectedEnvironmentName availability request."
);
