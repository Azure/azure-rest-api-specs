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

namespace Microsoft.DataReplication;
@doc("Fabric model.")
model FabricModel is TrackedResource<FabricModelProperties> {
  @doc("The fabric name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("fabricName")
  @segment("replicationFabrics")
  name: string;
}

@armResourceOperations
interface FabricModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the fabric.")
  @operationId("Fabric_Get")
  get is ArmResourceRead<FabricModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the fabric.")
  @operationId("Fabric_Create")
  create is ArmResourceCreateOrUpdateAsync<
    FabricModel,
    BaseParameters<FabricModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Performs update on the fabric.")
  @operationId("Fabric_Update")
  update is ArmCustomPatchAsync<
    FabricModel,
    FabricModelUpdate,
    BaseParameters<FabricModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Removes the fabric.")
  @operationId("Fabric_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    FabricModel,
    BaseParameters<FabricModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of fabrics in the given subscription and resource group.")
  @operationId("Fabric_List")
  list is ArmResourceListByParent<
    FabricModel,
    {
      ...BaseParameters<FabricModel>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of fabrics in the given subscription.")
  @operationId("Fabric_ListBySubscription")
  listBySubscription is ArmListBySubscription<FabricModel>;
}

@@projectedName(FabricModels.create::parameters.resource, "json", "body");
@@extension(FabricModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(FabricModels.create::parameters.resource, "Fabric properties.");
@@projectedName(FabricModels.update::parameters.properties, "json", "body");
@@extension(FabricModels.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(FabricModels.update::parameters.properties, "Fabric properties.");
