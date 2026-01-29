import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * An environment for Kubernetes cluster specialized for web workloads by Azure App Service
 */
model ConnectedEnvironment
  is Azure.ResourceManager.TrackedResource<ConnectedEnvironmentProperties> {
  ...ResourceNameParameter<
    Resource = ConnectedEnvironment,
    KeyName = "connectedEnvironmentName",
    SegmentName = "connectedEnvironments",
    NamePattern = ""
  >;

  /**
   * The complex type of the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectedEnvironment>;

  /**
   * Patches a Managed Environment. Only patching of tags is supported currently
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    ConnectedEnvironment,
    PatchModel = ConnectedEnvironmentPatchResource,
    OptionalRequestBody = true
  >;

  /**
   * Delete an connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectedEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all connectedEnvironments in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ConnectedEnvironment,
    Response = ArmResponse<ConnectedEnvironmentCollection>
  >;

  /**
   * Get all connectedEnvironments for a subscription.
   */
  listBySubscription is ArmListBySubscription<
    ConnectedEnvironment,
    Response = ArmResponse<ConnectedEnvironmentCollection>
  >;

  /**
   * Checks if resource connectedEnvironmentName is available.
   */
  checkNameAvailability is ArmResourceActionSync<
    ConnectedEnvironment,
    CheckNameAvailabilityRequest,
    ArmResponse<Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse>
  >;
}

@@doc(ConnectedEnvironment.name, "Name of the connectedEnvironment.");
@@doc(ConnectedEnvironment.properties,
  "ConnectedEnvironment resource specific properties"
);
@@doc(ConnectedEnvironments.createOrUpdate::parameters.resource,
  "Configuration details of the connectedEnvironment."
);
@@doc(ConnectedEnvironments.update::parameters.properties,
  "Configuration details of the connectedEnvironment."
);
@@doc(ConnectedEnvironments.checkNameAvailability::parameters.body,
  "The check connectedEnvironmentName availability request."
);
