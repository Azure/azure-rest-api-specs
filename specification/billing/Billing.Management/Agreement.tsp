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
 * An agreement.
 */
@tenantResource
@parentResource(BillingAccount)
model Agreement is Azure.ResourceManager.ProxyResource<AgreementProperties> {
  ...ResourceNameParameter<
    Resource = Agreement,
    KeyName = "agreementName",
    SegmentName = "agreements",
    NamePattern = "^[a-fA-F0-9]{1,12}$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface Agreements {
  /**
   * Gets an agreement by ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Agreement")
  get is ArmResourceRead<
    Agreement,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the agreements for a billing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Agreement")
  listByBillingAccount is ArmResourceListByParent<
    Agreement,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the participants.
       */
      @query("expand")
      expand?: string;
    }
  >;
}

@@doc(Agreement.name, "The ID that uniquely identifies an agreement.");
@@doc(Agreement.properties, "An agreement.");
