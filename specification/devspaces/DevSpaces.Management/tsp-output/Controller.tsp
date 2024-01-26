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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model Controller extends TrackedResource {
  /**
   * Name of the resource.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]([_-]*[a-zA-Z0-9])*$")
  @path
  @key("name")
  @segment("controllers")
  @visibility("read")
  name: string;

  /**
   * Model representing SKU for Azure Dev Spaces Controller.
   */
  sku: Sku;

  @extension("x-ms-client-flatten", true)
  properties: ControllerProperties;
}

@armResourceOperations
interface Controllers {
  /**
   * Gets the properties for an Azure Dev Spaces Controller.
   */
  get is ArmResourceRead<Controller>;

  /**
   * Creates an Azure Dev Spaces Controller with the specified create parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<Controller>;

  /**
   * Updates the properties of an existing Azure Dev Spaces Controller with the specified update parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Controller, ControllerUpdateParameters>;

  /**
   * Deletes an existing Azure Dev Spaces Controller.
   */
  delete is ArmResourceDeleteAsync<Controller>;

  /**
   * Lists all the Azure Dev Spaces Controllers with their properties in the specified resource group and subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Controllers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Controller>;

  /**
   * Lists all the Azure Dev Spaces Controllers with their properties in the subscription.
   */
  list is ArmListBySubscription<Controller>;

  /**
   * Lists connection details for the underlying container resources of an Azure Dev Spaces Controller.
   */
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
