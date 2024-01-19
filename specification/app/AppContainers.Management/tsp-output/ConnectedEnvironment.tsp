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
@doc("An environment for Kubernetes cluster specialized for web workloads by Azure App Service")
model ConnectedEnvironment is TrackedResource<ConnectedEnvironmentProperties> {
  @doc("Name of the connectedEnvironment.")
  @path
  @key("connectedEnvironmentName")
  @segment("connectedEnvironments")
  name: string;

  @doc("The complex type of the extended location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface ConnectedEnvironments {
  @doc("Get the properties of an connectedEnvironment.")
  get is ArmResourceRead<ConnectedEnvironment>;

  @doc("Creates or updates an connectedEnvironment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ConnectedEnvironment,
    BaseParameters<ConnectedEnvironment>,
    ArmAsyncOperationHeader
  >;

  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Patches a Managed Environment. Only patching of tags is supported currently")
  update is ArmCustomPatchSync<ConnectedEnvironment, {}>;

  @doc("Delete an connectedEnvironment.")
  delete is ArmResourceDeleteAsync<
    ConnectedEnvironment,
    BaseParameters<ConnectedEnvironment>,
    ArmLroLocationHeader
  >;

  @doc("Get all connectedEnvironments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ConnectedEnvironment>;

  @doc("Get all connectedEnvironments for a subscription.")
  listBySubscription is ArmListBySubscription<ConnectedEnvironment>;

  @doc("Checks if resource connectedEnvironmentName is available.")
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
