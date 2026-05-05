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

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: Azure.Core.eTag;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  get is ViewOps.Read<View, ErrorType = ErrorResponse>;

  /**
   * The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  createOrUpdate is ViewOps.CreateOrUpdateSync<View, ErrorType = ErrorResponse>;

  /**
   * The operation to delete a view.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  delete is ViewOps.DeleteSync<View, ErrorType = ErrorResponse>;

  /**
   * Lists all views by tenant and object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  list is ViewOps.List<
    View,
    Response = ViewListResult,
    ErrorType = ErrorResponse
  >;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  getByScope is ViewOperationGroupOps.Read<View, ErrorType = ErrorResponse>;

  /**
   * The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  createOrUpdateByScope is ViewOperationGroupOps.CreateOrUpdateSync<
    View,
    ErrorType = ErrorResponse
  >;

  /**
   * The operation to delete a view.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  deleteByScope is ViewOperationGroupOps.DeleteSync<
    View,
    ErrorType = ErrorResponse
  >;

  /**
   * Lists all views at the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  listByScope is ViewOperationGroupOps.List<
    View,
    Response = ViewListResult,
    ErrorType = ErrorResponse
  >;
}

@@doc(View.name, "View name");
@@doc(View.properties, "The properties of the view.");
@@doc(Views.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
@@doc(ViewOperationGroup.createOrUpdateByScope::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
