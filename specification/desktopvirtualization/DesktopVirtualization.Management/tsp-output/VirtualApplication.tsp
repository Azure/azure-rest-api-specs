import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualApplicationGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
@doc("Schema for Application properties.")
@parentResource(VirtualApplicationGroup)
model VirtualApplication is ProxyResource<ApplicationProperties> {
  @doc("The name of the application within the specified application group")
  @maxLength(24)
  @minLength(3)
  @path
  @key("applicationName")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface VirtualApplications {
  @doc("Get an application.")
  get is ArmResourceRead<VirtualApplication>;
  @doc("Create or update an application.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<VirtualApplication>;
  @doc("Update an application.")
  update is ArmResourcePatchSync<VirtualApplication, ApplicationProperties>;
  @doc("Remove an application.")
  delete is ArmResourceDeleteSync<VirtualApplication>;
  @doc("List applications.")
  list is ArmResourceListByParent<
    VirtualApplication,
    {
      ...BaseParameters<VirtualApplication>;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}
