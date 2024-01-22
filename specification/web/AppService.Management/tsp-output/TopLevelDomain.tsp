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

namespace Microsoft.CertificateRegistration;
/**
 * A top level domain object.
 */
@subscriptionResource
model TopLevelDomain is ProxyResource<TopLevelDomainProperties> {
  /**
   * Name of the top-level domain.
   */
  @path
  @key("name")
  @segment("topLevelDomains")
  name: string;
}

@armResourceOperations
interface TopLevelDomains {
  /**
   * Description for Get details of a top-level domain.
   */
  get is ArmResourceRead<TopLevelDomain>;

  /**
   * Description for Get all top-level domains supported for registration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TopLevelDomains_List")
  list is ArmResourceListByParent<TopLevelDomain>;

  /**
   * Description for Gets all legal agreements that user needs to accept before purchasing a domain.
   */
  listAgreements is ArmResourceActionSync<
    TopLevelDomain,
    TopLevelDomainAgreementOption,
    TldLegalAgreementCollection
  >;
}

@@projectedName(TopLevelDomains.listAgreements::parameters.body,
  "json",
  "agreementOption"
);
@@extension(TopLevelDomains.listAgreements::parameters.body,
  "x-ms-client-name",
  "agreementOption"
);
@@doc(TopLevelDomains.listAgreements::parameters.body,
  "Domain agreement options."
);
