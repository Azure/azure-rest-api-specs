import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;

model PrivateLink is PrivateLinkResource;
alias PrivateLinkOperations = PrivateLinks<PrivateLink>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a private link resource by name which can be used for the Maps Account.
   */
  get is PrivateLinkOperations.Read<MapsAccount, PrivateLink>;
  /**
   * Gets the private link resources that are available to be used for the Maps Account.
   */
  listByAccount is PrivateLinkOperations.ListByParent<
    MapsAccount,
    PrivateLink,
    Response = ArmResponse<PrivateLinkResourceList>
  >;
}

@@doc(PrivateLink.properties, "Resource properties.");
