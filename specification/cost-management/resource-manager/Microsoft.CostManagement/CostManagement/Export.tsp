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
 * An export resource.
 */
model Export is Azure.ResourceManager.ExtensionResource<ExportProperties> {
  ...ResourceNameParameter<
    Resource = Export,
    KeyName = "exportName",
    SegmentName = "exports",
    NamePattern = ""
  >;

  /**
   * The managed identity associated with Export
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity;

  /**
   * The location of the Export's managed identity. Only required when utilizing managed identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: Azure.Core.eTag;
}

@armResourceOperations
interface ExportsOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** The scope associated with alerts operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId} for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners. */
        @path(#{ allowReserved: true })
        scope: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {},
      {}
    > {}

@armResourceOperations
interface Exports {
  /**
   * The operation to get the export for the defined scope by export name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  get is Extension.Read<
    Extension.ScopeParameter,
    Export,
    Parameters = {
      /**
       * May be used to expand the properties within an export. Currently only 'runHistory' is supported and will return information for the last 10 runs of the export.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = ErrorResponse
  >;

  /**
   * The operation to create or update a export. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    Export,
    Error = ErrorResponse
  >;

  /**
   * The operation to delete a export.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    Export,
    Response = ArmDeletedResponse,
    Error = ErrorResponse
  >;

  /**
   * The operation to list all exports at the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  list is ExportsOps.ListSinglePage<
    Export,
    Parameters = {
      /**
       * May be used to expand the properties within an export. Currently only 'runHistory' is supported and will return information for the last run of each export.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<ExportListResult>,
    ErrorType = ErrorResponse
  >;

  /**
   * The operation to run an export.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("run")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  execute is Extension.ActionSync<
    Extension.ScopeParameter,
    Export,
    ExportRunRequest,
    OkResponse,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * The operation to get the run history of an export for the defined scope and export name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("runHistory")
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  getExecutionHistory is Extension.ActionSync<
    Extension.ScopeParameter,
    Export,
    void,
    ArmResponse<ExportExecutionListResult>,
    Error = ErrorResponse
  >;
}

@@doc(Export.name, "Export Name.");
@@doc(Export.properties, "The properties of the export.");
@@doc(Exports.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Export operation."
);
@@doc(Exports.execute::parameters.body,
  "Parameters supplied to the Execute Export operation."
);
