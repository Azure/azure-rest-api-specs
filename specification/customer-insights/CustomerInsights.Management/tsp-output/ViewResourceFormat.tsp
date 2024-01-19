import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
@doc("The view resource format.")
@parentResource(Hub)
model ViewResourceFormat is ProxyResource<View> {
  @doc("The name of the view.")
  @path
  @key("viewName")
  @segment("views")
  name: string;
}

@armResourceOperations
interface ViewResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a view in the hub.")
  @operationId("Views_Get")
  get is ArmResourceRead<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      @doc("The user ID. Use * to retrieve hub level view.")
      @query("userId")
      userId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a view or updates an existing view in the hub.")
  @operationId("Views_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ViewResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a view in the specified hub.")
  @operationId("Views_Delete")
  delete is ArmResourceDeleteSync<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      @doc("The user ID. Use * to retrieve hub level view.")
      @query("userId")
      userId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all available views for given user in the specified hub.")
  @operationId("Views_ListByHub")
  listByHub is ArmResourceListByParent<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      @doc("The user ID. Use * to retrieve hub level views.")
      @query("userId")
      userId: string;
    }
  >;
}

@@projectedName(ViewResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ViewResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ViewResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
