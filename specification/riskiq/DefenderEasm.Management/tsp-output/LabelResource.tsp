import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkspaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Easm;
@doc("Label details")
@parentResource(WorkspaceResource)
model LabelResource is ProxyResource<LabelResourceProperties> {
  @doc("The name of the Label.")
  @path
  @key("labelName")
  @segment("labels")
  name: string;
}

@armResourceOperations
interface LabelResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a label in the given workspace.")
  @operationId("Labels_GetByWorkspace")
  getByWorkspace is ArmResourceRead<LabelResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Label.")
  @operationId("Labels_CreateAndUpdate")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<
    LabelResource,
    BaseParameters<LabelResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a Label.")
  @operationId("Labels_Update")
  update is ArmCustomPatchSync<LabelResource, LabelPatchResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Label.")
  @operationId("Labels_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    LabelResource,
    BaseParameters<LabelResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a list of labels in the given workspace.")
  @operationId("Labels_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<LabelResource>;
}

@@projectedName(LabelResources.createAndUpdate::parameters.resource,
  "json",
  "LabelResource"
);
@@extension(LabelResources.createAndUpdate::parameters.resource,
  "x-ms-client-name",
  "LabelResource"
);
@@doc(LabelResources.createAndUpdate::parameters.resource, "Label details.");
@@projectedName(LabelResources.update::parameters.properties,
  "json",
  "LabelPatchResource"
);
@@extension(LabelResources.update::parameters.properties,
  "x-ms-client-name",
  "LabelPatchResource"
);
@@doc(LabelResources.update::parameters.properties, "Label patch details.");
