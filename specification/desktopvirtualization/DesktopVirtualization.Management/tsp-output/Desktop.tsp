import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
@doc("Schema for Desktop properties.")
@parentResource(ApplicationGroup)
model Desktop is ProxyResource<DesktopProperties> {
  @doc("The name of the desktop within the specified desktop group")
  @maxLength(24)
  @minLength(3)
  @path
  @key("desktopName")
  @segment("desktops")
  name: string;
}

@armResourceOperations
interface Desktops {
  @doc("Get a desktop.")
  get is ArmResourceRead<Desktop>;

  @doc("Update a desktop.")
  update is ArmCustomPatchSync<Desktop, DesktopPatch>;

  @doc("List desktops.")
  list is ArmResourceListByParent<
    Desktop,
    {
      ...BaseParameters<Desktop>;

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

@@projectedName(Desktops.update::parameters.properties, "json", "desktop");
@@extension(Desktops.update::parameters.properties,
  "x-ms-client-name",
  "desktop"
);
@@doc(Desktops.update::parameters.properties,
  "Object containing Desktop definitions."
);
