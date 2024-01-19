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

namespace Microsoft.CustomerInsights;
@doc("Hub resource.")
model Hub is TrackedResource<HubPropertiesFormat> {
  @doc("The name of the hub.")
  @path
  @key("hubName")
  @segment("hubs")
  name: string;
}

@armResourceOperations
interface Hubs {
  @doc("Gets information about the specified hub.")
  get is ArmResourceRead<Hub>;

  @doc("Creates a hub, or updates an existing hub.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Hub>;

  @doc("Updates a Hub.")
  update is ArmCustomPatchSync<Hub, Hub>;

  @doc("Deletes the specified hub.")
  delete is ArmResourceDeleteAsync<Hub>;

  @doc("Gets all the hubs in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Hub>;

  @doc("Gets all hubs in the specified subscription.")
  list is ArmListBySubscription<Hub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets entity type (profile or interaction) image upload URL.")
  @operationId("Images_GetUploadUrlForEntityType")
  getUploadUrlForEntityType is ArmResourceActionSync<
    Hub,
    GetImageUploadUrlInput,
    ImageDefinition
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets data image upload URL.")
  @operationId("Images_GetUploadUrlForData")
  getUploadUrlForData is ArmResourceActionSync<
    Hub,
    GetImageUploadUrlInput,
    ImageDefinition
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Roles_ListByHub")
  @doc("Gets all the roles for the hub.")
  // FIXME: Roles_ListByHub could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roles")
  @get
  listByHub is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the hub.")
      @path
      hubName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    RoleListResult
  >;
}

@@projectedName(Hubs.createOrUpdate::parameters.resource, "json", "parameters");
@@extension(Hubs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Hubs.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Hub operation."
);
@@projectedName(Hubs.update::parameters.properties, "json", "parameters");
@@extension(Hubs.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Hubs.update::parameters.properties,
  "Parameters supplied to the Update Hub operation."
);
@@projectedName(Hubs.getUploadUrlForEntityType::parameters.body,
  "json",
  "parameters"
);
@@extension(Hubs.getUploadUrlForEntityType::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Hubs.getUploadUrlForEntityType::parameters.body,
  "Parameters supplied to the GetUploadUrlForEntityType operation."
);
@@projectedName(Hubs.getUploadUrlForData::parameters.body,
  "json",
  "parameters"
);
@@extension(Hubs.getUploadUrlForData::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Hubs.getUploadUrlForData::parameters.body,
  "Parameters supplied to the GetUploadUrlForData operation."
);
