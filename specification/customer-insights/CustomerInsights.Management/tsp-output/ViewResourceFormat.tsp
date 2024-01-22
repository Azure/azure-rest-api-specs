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
/**
 * The view resource format.
 */
@parentResource(Hub)
model ViewResourceFormat is ProxyResource<View> {
  /**
   * The name of the view.
   */
  @path
  @key("viewName")
  @segment("views")
  name: string;
}

@armResourceOperations
interface ViewResourceFormats {
  /**
   * Gets a view in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Views_Get")
  get is ArmResourceRead<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      /**
       * The user ID. Use * to retrieve hub level view.
       */
      @query("userId")
      userId: string;
    }
  >;

  /**
   * Creates a view or updates an existing view in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Views_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ViewResourceFormat>;

  /**
   * Deletes a view in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Views_Delete")
  delete is ArmResourceDeleteSync<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      /**
       * The user ID. Use * to retrieve hub level view.
       */
      @query("userId")
      userId: string;
    }
  >;

  /**
   * Gets all available views for given user in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Views_ListByHub")
  listByHub is ArmResourceListByParent<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      /**
       * The user ID. Use * to retrieve hub level views.
       */
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
