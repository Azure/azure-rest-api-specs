import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Class representing detector definition
 */
model DiagnosticCategory
  is Azure.ResourceManager.ProxyResource<DiagnosticCategoryProperties> {
  ...ResourceNameParameter<
    Resource = DiagnosticCategory,
    KeyName = "diagnosticCategory",
    SegmentName = "diagnostics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DiagnosticCategoryOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site Name */
        @path
        @segment("sites")
        @key
        siteName: string,
      },
      {
        /** Diagnostic Category */
        @path
        @segment("diagnostics")
        @key
        diagnosticCategory: string,
      }
    > {}

@armResourceOperations
interface DiagnosticCategories {
  /**
   * Description for Get Diagnostics Category
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteDiagnosticCategory")
  getSiteDiagnosticCategory is DiagnosticCategoryOps.Read<DiagnosticCategory>;

  /**
   * Description for Get Diagnostics Categories
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteDiagnosticCategories")
  listSiteDiagnosticCategories is DiagnosticCategoryOps.List<
    DiagnosticCategory,
    Response = ArmResponse<DiagnosticCategoryCollection>
  >;
}
@armResourceOperations
interface DiagnosticCategoryOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site Name */
        @path
        @segment("sites")
        @key
        siteName: string,

        /** Slot Name */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Diagnostic Category */
        @path
        @segment("diagnostics")
        @key
        diagnosticCategory: string,
      }
    > {}

@armResourceOperations
interface DiagnosticCategoryOperationGroup {
  /**
   * Description for Get Diagnostics Category
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteDiagnosticCategorySlot")
  getSiteDiagnosticCategorySlot is DiagnosticCategoryOperationGroupOps.Read<
    DiagnosticCategory,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Diagnostics Categories
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteDiagnosticCategoriesSlot")
  listSiteDiagnosticCategoriesSlot is DiagnosticCategoryOperationGroupOps.List<
    DiagnosticCategory,
    Response = ArmResponse<DiagnosticCategoryCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(DiagnosticCategory.name, "Diagnostic Category");
@@doc(DiagnosticCategory.properties,
  "DiagnosticCategory resource specific properties"
);
