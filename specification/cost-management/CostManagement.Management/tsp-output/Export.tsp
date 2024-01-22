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

namespace Microsoft.CostManagement;
/**
 * An export resource.
 */
model Export is ExtensionResource<ExportProperties> {
  /**
   * Export Name.
   */
  @path
  @key("exportName")
  @segment("exports")
  name: string;
}

@armResourceOperations
interface Exports {
  /**
   * The operation to get the export for the defined scope by export name.
   */
  get is ArmResourceRead<
    Export,
    {
      ...BaseParameters<Export>;

      /**
       * May be used to expand the properties within an export. Currently only 'runHistory' is supported and will return information for the last 10 runs of the export.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update a export. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Export>;

  /**
   * The operation to delete a export.
   */
  delete is ArmResourceDeleteSync<Export>;

  /**
   * The operation to list all exports at the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Exports_List")
  list is ArmResourceListByParent<
    Export,
    {
      ...BaseParameters<Export>;

      /**
       * May be used to expand the properties within an export. Currently only 'runHistory' is supported and will return information for the last run of each export.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to run an export.
   */
  execute is ArmResourceActionSync<Export, void, void>;

  /**
   * The operation to get the run history of an export for the defined scope and export name.
   */
  // FIXME: Exports_GetExecutionHistory could not be converted to a resource operation
  @route("/{scope}/providers/Microsoft.CostManagement/exports/{exportName}/runHistory")
  @get
  getExecutionHistory is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope associated with export operations. This includes '/subscriptions/{subscriptionId}/' for subscription scope, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, '/providers/Microsoft.Management/managementGroups/{managementGroupId} for Management Group scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for billingProfile scope, '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}/invoiceSections/{invoiceSectionId}' for invoiceSection scope, and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/customers/{customerId}' specific for partners.
       */
      @path
      scope: string;

      /**
       * Export Name.
       */
      @path
      exportName: string;
    },
    ExportExecutionListResult
  >;
}

@@projectedName(Exports.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Exports.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Exports.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Export operation."
);
