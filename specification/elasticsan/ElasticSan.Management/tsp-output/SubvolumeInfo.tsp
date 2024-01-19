import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
@doc("Subvolume Information properties")
@parentResource(Volume)
model SubvolumeInfo is ProxyResource<SubvolumeProperties> {
  @doc("The name of the subvolume.")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("subvolumeName")
  @segment("subvolumes")
  name: string;
}

@armResourceOperations
interface SubvolumeInfos {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the path associated with the subvolumeName provided")
  @operationId("Subvolumes_Get")
  get is ArmResourceRead<SubvolumeInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a subvolume in the path or clones the subvolume mentioned in the parentPath")
  @operationId("Subvolumes_Create")
  create is ArmResourceCreateOrUpdateAsync<
    SubvolumeInfo,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch a subvolume")
  @operationId("Subvolumes_Update")
  update is ArmCustomPatchAsync<
    SubvolumeInfo,
    SubvolumePatchRequest,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete subvolume")
  @operationId("Subvolumes_Delete")
  delete is ArmResourceDeleteAsync<
    SubvolumeInfo,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a list of the subvolumes in the volume")
  @operationId("Subvolumes_ListByVolume")
  listByVolume is ArmResourceListByParent<SubvolumeInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get details of the specified subvolume")
  @operationId("Subvolumes_GetMetadata")
  getMetadata is ArmResourceActionAsync<
    SubvolumeInfo,
    void,
    SubvolumeModel,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SubvolumeInfos.create::parameters.resource, "json", "body");
@@extension(SubvolumeInfos.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SubvolumeInfos.create::parameters.resource,
  "Subvolume object supplied in the body of the operation."
);
@@projectedName(SubvolumeInfos.update::parameters.properties, "json", "body");
@@extension(SubvolumeInfos.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SubvolumeInfos.update::parameters.properties,
  "Subvolume object supplied in the body of the operation."
);
