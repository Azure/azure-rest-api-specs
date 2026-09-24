import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;

alias AgreementListByBillingAccountParameters = {
  /**
   * May be used to expand the participants.
   */
  @query("expand")
  expand?: string;
};

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
    NamePattern = AgreementNamePattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface Agreements {
  /**
   * Gets an agreement by ID.
   */
  @tag("Agreement")
  get is ArmResourceRead<
    Agreement,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the agreements for a billing account.
   */
  @tag("Agreement")
  listByBillingAccount is ArmResourceListByParent<
    Agreement,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = AgreementListByBillingAccountParameters,
    Response = ArmResponse<AgreementListResult>
  >;
}

@@doc(Agreement.name, "The ID that uniquely identifies an agreement.");
@@doc(Agreement.properties, "An agreement.");
