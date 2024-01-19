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

namespace Microsoft.ManagedNetworkFabric;
@doc("The Internet Gateway Rule resource definition.")
model InternetGatewayRule is TrackedResource<InternetGatewayRuleProperties> {
  @doc("Name of the Internet Gateway rule.")
  @path
  @key("internetGatewayRuleName")
  @segment("internetGatewayRules")
  name: string;
}

@armResourceOperations
interface InternetGatewayRules {
  @doc("Gets an Internet Gateway Rule resource.")
  get is ArmResourceRead<InternetGatewayRule>;

  @doc("Creates an Internet Gateway rule resource.")
  create is ArmResourceCreateOrUpdateAsync<
    InternetGatewayRule,
    BaseParameters<InternetGatewayRule>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the Internet Gateway Rule resource.")
  update is ArmCustomPatchAsync<
    InternetGatewayRule,
    InternetGatewayRulePatch,
    BaseParameters<InternetGatewayRule>,
    ArmLroLocationHeader
  >;

  @doc("Implements Internet Gateway Rules DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    InternetGatewayRule,
    BaseParameters<InternetGatewayRule>,
    ArmLroLocationHeader
  >;

  @doc("Implements Internet Gateway Rules list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<InternetGatewayRule>;

  @doc("List all Internet Gateway rules in the given subscription.")
  listBySubscription is ArmListBySubscription<InternetGatewayRule>;
}

@@projectedName(InternetGatewayRules.create::parameters.resource,
  "json",
  "body"
);
@@extension(InternetGatewayRules.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(InternetGatewayRules.create::parameters.resource, "Request payload.");
@@projectedName(InternetGatewayRules.update::parameters.properties,
  "json",
  "body"
);
@@extension(InternetGatewayRules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(InternetGatewayRules.update::parameters.properties,
  "Internet Gateway Rule properties to update."
);
