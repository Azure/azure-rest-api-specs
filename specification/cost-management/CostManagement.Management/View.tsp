import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * States and configurations of Cost Analysis.
 */
@tenantResource
model View is Azure.ResourceManager.ProxyResource<ViewProperties> {
  ...ResourceNameParameter<
    Resource = View,
    KeyName = "viewName",
    SegmentName = "views",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ViewOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CostManagement",
      },
      {},
      {
        /** View name */
        @path
        @segment("views")
        @key
        viewName: string,
      }
    > {}

@armResourceOperations
interface Views {
  /**
   * Gets the view by view name.
   */
  get is ViewOps.Read<View>;

  /**
   * The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  createOrUpdate is ViewOps.CreateOrUpdateSync<View>;

  /**
   * The operation to delete a view.
   */
  delete is ViewOps.DeleteSync<View>;
}
@armResourceOperations
interface ViewOperationGroupOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** undefined */
        @path
        @segment("")
        @key
        scope: string,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CostManagement",
      },
      {},
      {
        /** View name */
        @path
        @segment("views")
        @key
        viewName: string,
      }
    > {}

@armResourceOperations
interface ViewOperationGroup {
  /**
   * Gets the view for the defined scope by view name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Views_GetByScope")
  getByScope is ViewOperationGroupOps.Read<Extension.ScopeParameter, View>;

  /**
   * The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Views_CreateOrUpdateByScope")
  createOrUpdateByScope is ViewOperationGroupOps.CreateOrUpdateSync<
    Extension.ScopeParameter,
    View
  >;

  /**
   * The operation to delete a view.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Views_DeleteByScope")
  deleteByScope is ViewOperationGroupOps.DeleteSync<
    Extension.ScopeParameter,
    View
  >;

  /**
   * Lists all views by tenant and object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Views_List")
  list is ViewOperationGroupOps.List<Extension.ScopeParameter, View>;
}

@@doc(View.name, "View name");
@@doc(View.properties, "The properties of the view.");
@@doc(Views.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
@@doc(ViewOperationGroup.createOrUpdateByScope::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
