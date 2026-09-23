import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * Savings plan order
 */
@tenantResource
@parentResource(BillingAccount)
model SavingsPlanOrderModel
  is Azure.ResourceManager.ProxyResource<SavingsPlanOrderModelProperties> {
  ...ResourceNameParameter<
    Resource = SavingsPlanOrderModel,
    KeyName = "savingsPlanOrderId",
    SegmentName = "savingsPlanOrders",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Savings plan SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;
}

@armResourceOperations(#{ omitTags: true })
interface SavingsPlanOrderModels {
  /**
   * Get a savings plan order by billing account.
   */
  @tag("Savings plan order")
  getByBillingAccount is ArmResourceRead<
    SavingsPlanOrderModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the planInformation.
       */
      @query("expand")
      expand?: string;
    }
  >;

  /**
   * List all Savings plan orders by billing account.
   */
  @tag("Savings plan order")
  listByBillingAccount is ArmResourceListByParent<
    SavingsPlanOrderModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * The number of savings plans to skip from the list before returning results
       */
      @query("skiptoken")
      skiptoken?: float32;
    },
    Response = ArmResponse<SavingsPlanOrderModelList>
  >;
}

@@doc(SavingsPlanOrderModel.name, "Order ID of the savings plan");
@@doc(SavingsPlanOrderModel.properties, "Savings plan order properties");
