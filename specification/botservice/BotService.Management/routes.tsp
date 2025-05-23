// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BotsOperationGroup {
  /**
   * Check whether a bot name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_GetCheckNameAvailability")
  @autoRoute
  @action("checkNameAvailability")
  getCheckNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequestBody,
    Response = CheckNameAvailabilityResponseBody,
    Error = Error
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BotConnectionOperationGroup {
  /**
   * Lists the available Service Providers for creating Connection Settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BotConnection_ListServiceProviders")
  @autoRoute
  @action("listAuthServiceProviders")
  listServiceProviders is ArmProviderActionSync<
    Response = ServiceProviderResponseList,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = Error
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface QnAMakerEndpointKeysOperationGroup {
  /**
   * Lists the QnA Maker endpoint keys
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QnAMakerEndpointKeys_Get")
  @autoRoute
  @action("listQnAMakerEndpointKeys")
  get is ArmProviderActionSync<
    Request = QnAMakerEndpointKeysRequestBody,
    Response = QnAMakerEndpointKeysResponse,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = Error
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface HostSettingsOperationGroup {
  /**
   * Get per subscription settings needed to host bot in compute resource such as Azure App Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HostSettings_Get")
  @autoRoute
  @get
  @action("hostSettings")
  get is ArmProviderActionSync<
    Response = HostSettingsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = Error
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationResultsOperationGroup {
  /**
   * Get the operation result for a long running operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/operationresults/{operationResultId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The ID of the operation result to get.
     */
    @path
    operationResultId: string,
  ): ArmResponse<OperationResultsDescription> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationResultsDescription> &
  Azure.Core.Foundations.RetryAfterHeader> | Error;
}
