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

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("The virtual hard disk resource definition.")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VirtualHardDiskProperties)
model VirtualHardDisks extends TrackedResourceBase {
  @doc("Name of the virtual hard disk")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("virtualHardDiskName")
  @segment("virtualHardDisks")
  @visibility("read")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;

  @doc("Properties under the virtual hard disk resource")
  @extension("x-ms-client-flatten", true)
  properties?: VirtualHardDiskProperties;
}

@armResourceOperations
@projectedName("client", "VirtualHardDisks")
interface VirtualHardDisksOperationGroup {
  @doc("Gets a virtual hard disk")
  get is ArmResourceRead<VirtualHardDisks>;

  @doc("The operation to create or update a virtual hard disk. Please note some properties can be set only during virtual hard disk creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualHardDisks,
    BaseParameters<VirtualHardDisks>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update a virtual hard disk.")
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualHardDisks,
    VirtualHardDisksUpdateRequest,
    BaseParameters<VirtualHardDisks>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a virtual hard disk.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualHardDisks,
    BaseParameters<VirtualHardDisks>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the virtual hard disks in the specified resource group. Use the nextLink property in the response to get the next page of virtual hard disks.")
  @operationId("VirtualHardDisks_List")
  list is ArmResourceListByParent<VirtualHardDisks>;

  @doc("Lists all of the virtual hard disks in the specified subscription. Use the nextLink property in the response to get the next page of virtual hard disks.")
  listAll is ArmListBySubscription<VirtualHardDisks>;
}

@@projectedName(VirtualHardDisksOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "virtualHardDisks"
);
@@extension(VirtualHardDisksOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "virtualHardDisks"
);
@@doc(VirtualHardDisksOperationGroup.createOrUpdate::parameters.resource, "");
@@projectedName(VirtualHardDisksOperationGroup.update::parameters.properties,
  "json",
  "virtualHardDisks"
);
@@extension(VirtualHardDisksOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "virtualHardDisks"
);
@@doc(VirtualHardDisksOperationGroup.update::parameters.properties, "");
