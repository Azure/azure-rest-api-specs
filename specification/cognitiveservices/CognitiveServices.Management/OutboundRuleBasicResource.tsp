import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedNetworkSettingsPropertiesBasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;

@parentResource(ManagedNetworkSettingsPropertiesBasicResource)
model OutboundRuleBasicResource
  is Azure.ResourceManager.ProxyResource<OutboundRule, false> {
  ...ResourceNameParameter<
    Resource = OutboundRuleBasicResource,
    KeyName = "ruleName",
    SegmentName = "outboundRules",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@armResourceOperations
interface OutboundRuleBasicResources {
  /**
   * The GET API for retrieving a single outbound rule of the managed network associated with the cognitive services account.
   */
  get is ArmResourceRead<OutboundRuleBasicResource>;

  /**
   * The PUT API for creating or updating a single outbound rule of the managed network associated with the cognitive services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OutboundRuleBasicResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = OutboundRuleBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The DELETE API for deleting a single outbound rule of the managed network associated with the cognitive services account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<OutboundRuleBasicResource>;

  /**
   * The GET API for retrieving the list of outbound rules of the managed network associated with the cognitive services account.
   */
  list is ArmResourceListByParent<
    OutboundRuleBasicResource,
    Response = OutboundRuleListResult
  >;
}

@@doc(OutboundRuleBasicResource.name,
  "Name of the cognitive services account managed network outbound rule"
);
@@doc(OutboundRuleBasicResource.properties,
  "Outbound Rule for the managed network of a cognitive services account."
);
@@doc(OutboundRuleBasicResources.createOrUpdate::parameters.resource, "");
@@summary(OutboundRuleBasicResources.list,
  "The GET API for retrieving the list of outbound rules of the managed network associated with the cognitive services account."
);
@@summary(OutboundRuleBasicResources.get,
  "The GET API for retrieving a single outbound rule of the managed network associated with the cognitive services account."
);
@@summary(OutboundRuleBasicResources.createOrUpdate,
  "The PUT API for creating or updating a single outbound rule of the managed network associated with the cognitive services account."
);
@@summary(OutboundRuleBasicResources.delete,
  "The DELETE API for deleting a single outbound rule of the managed network associated with the cognitive services account."
);
