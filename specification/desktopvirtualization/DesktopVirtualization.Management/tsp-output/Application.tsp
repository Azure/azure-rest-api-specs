import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
@doc("Schema for Application properties.")
@parentResource(ApplicationGroup)
model Application is ProxyResource<ApplicationProperties> {
  @doc("The name of the application within the specified application group")
  @maxLength(24)
  @minLength(3)
  @key("applicationName")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface Applications {
  @doc("Get an application.")
  get is ArmResourceRead<Application>;

  @doc("Create or update an application.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Application>;

  @doc("Update an application.")
  update is ArmCustomPatchSync<Application, ApplicationPatch>;

  @doc("Remove an application.")
  delete is ArmResourceDeleteSync<Application>;

  @doc("List applications.")
  list is ArmResourceListByParent<
    Application,
    {
      ...BaseParameters<Application>;

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
