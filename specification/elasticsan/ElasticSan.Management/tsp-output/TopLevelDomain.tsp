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
@doc("A top level domain object.")
@subscriptionResource
model TopLevelDomain is ProxyResource<TopLevelDomainProperties> {
  @doc("Name of the top-level domain.")
  @path
  @key("name")
  @segment("topLevelDomains")
  name: string;
}

@armResourceOperations
interface TopLevelDomains {
  @doc("Description for Get details of a top-level domain.")
  get is ArmResourceRead<TopLevelDomain>;

  @doc("Description for Get all top-level domains supported for registration.")
  list is ArmResourceListByParent<TopLevelDomain>;

  @doc("Description for Gets all legal agreements that user needs to accept before purchasing a domain.")
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
