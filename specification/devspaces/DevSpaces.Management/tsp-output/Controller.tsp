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

namespace Microsoft.DevSpaces;

model Controller is TrackedResource<ControllerProperties> {
  @doc("Name of the resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]([_-]*[a-zA-Z0-9])*$")
  @path
  @key("name")
  @segment("controllers")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Controllers {
  @doc("Gets the properties for an Azure Dev Spaces Controller.")
  get is ArmResourceRead<Controller>;

  @doc("Creates an Azure Dev Spaces Controller with the specified create parameters.")
  create is ArmResourceCreateOrUpdateAsync<Controller>;

  @doc("Updates the properties of an existing Azure Dev Spaces Controller with the specified update parameters.")
  update is ArmCustomPatchSync<Controller, ControllerUpdateParameters>;

  @doc("Deletes an existing Azure Dev Spaces Controller.")
  delete is ArmResourceDeleteAsync<Controller>;

  @doc("Lists all the Azure Dev Spaces Controllers with their properties in the specified resource group and subscription.")
  listByResourceGroup is ArmResourceListByParent<Controller>;

  @doc("Lists all the Azure Dev Spaces Controllers with their properties in the subscription.")
  list is ArmListBySubscription<Controller>;

  @doc("Lists connection details for the underlying container resources of an Azure Dev Spaces Controller.")
  listConnectionDetails is ArmResourceActionSync<
    Controller,
    ListConnectionDetailsParameters,
    ControllerConnectionDetailsList
  >;
}

@@projectedName(Controllers.create::parameters.resource, "json", "controller");
@@extension(Controllers.create::parameters.resource,
  "x-ms-client-name",
  "controller"
);
@@doc(Controllers.create::parameters.resource, "Controller create parameters.");
@@projectedName(Controllers.update::parameters.properties,
  "json",
  "controllerUpdateParameters"
);
@@extension(Controllers.update::parameters.properties,
  "x-ms-client-name",
  "controllerUpdateParameters"
);
@@doc(Controllers.update::parameters.properties,
  "Parameters for updating the Azure Dev Spaces Controller."
);
@@projectedName(Controllers.listConnectionDetails::parameters.body,
  "json",
  "listConnectionDetailsParameters"
);
@@extension(Controllers.listConnectionDetails::parameters.body,
  "x-ms-client-name",
  "listConnectionDetailsParameters"
);
@@doc(Controllers.listConnectionDetails::parameters.body,
  "Parameters for listing connection details of Azure Dev Spaces Controller."
);
