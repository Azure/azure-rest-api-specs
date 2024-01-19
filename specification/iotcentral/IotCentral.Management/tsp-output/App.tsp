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

namespace Microsoft.IoTCentral;
@doc("The IoT Central application.")
model App is TrackedResource<AppProperties> {
  @doc("The ARM resource name of the IoT Central application.")
  @path
  @key("resourceName")
  @segment("iotApps")
  name: string;

  ...Azure.ResourceManager.ManagedSystemAssignedIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Apps {
  @doc("Get the metadata of an IoT Central application.")
  get is ArmResourceRead<App>;

  @doc("Create or update the metadata of an IoT Central application. The usual pattern to modify a property is to retrieve the IoT Central application metadata and security metadata, and then combine them with the modified values in a new body to update the IoT Central application.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<App>;

  @doc("Update the metadata of an IoT Central application.")
  update is ArmCustomPatchAsync<App, AppPatch>;

  @doc("Delete an IoT Central application.")
  delete is ArmResourceDeleteWithoutOkAsync<App>;

  @doc("Get all the IoT Central Applications in a resource group.")
  listByResourceGroup is ArmResourceListByParent<App>;

  @doc("Get all IoT Central Applications in a subscription.")
  listBySubscription is ArmListBySubscription<App>;

  @doc("Get all available application templates.")
  listTemplates is ArmListBySubscription<App>;

  @doc("Check if an IoT Central application name is available.")
  checkNameAvailability is checkGlobalNameAvailability<
    OperationInputs,
    AppAvailabilityInfo
  >;
}

@@projectedName(Apps.createOrUpdate::parameters.resource, "json", "App");
@@extension(Apps.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "App"
);
@@doc(Apps.createOrUpdate::parameters.resource,
  "The IoT Central application metadata and security metadata."
);
@@projectedName(Apps.update::parameters.properties, "json", "AppPatch");
@@extension(Apps.update::parameters.properties, "x-ms-client-name", "AppPatch");
@@doc(Apps.update::parameters.properties,
  "The IoT Central application metadata and security metadata."
);
