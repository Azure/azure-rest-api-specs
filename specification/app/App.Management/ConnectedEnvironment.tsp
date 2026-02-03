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
  get is ArmResourceRead<ConnectedEnvironment, Error = DefaultErrorResponse>;

  /**
   * Creates or updates an connectedEnvironment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConnectedEnvironment,
    Error = DefaultErrorResponse
  >;

  /**
   * Patches a Managed Environment. Only patching of tags is supported currently
   */
  @summary("Update connected Environment's properties.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    ConnectedEnvironment,
    PatchModel = ConnectedEnvironmentPatchResource,
    OptionalRequestBody = true,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete an connectedEnvironment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Delete an connectedEnvironment.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectedEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Get all connectedEnvironments in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ConnectedEnvironment,
    Response = ArmResponse<ConnectedEnvironmentCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Get all connectedEnvironments for a subscription.
   */
  @summary("Get all connectedEnvironments for a subscription.")
  listBySubscription is ArmListBySubscription<
    ConnectedEnvironment,
    Response = ArmResponse<ConnectedEnvironmentCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Checks if resource connectedEnvironmentName is available.
   */
  @summary("Checks the resource connectedEnvironmentName availability.")
  checkNameAvailability is ArmResourceActionSync<
    ConnectedEnvironment,
    Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    ArmResponse<Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse>,
    Error = DefaultErrorResponse
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
