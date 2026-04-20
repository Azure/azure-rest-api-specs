// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Education;

@doc("code redeemed")
model RedeemCodeResponse {
  ...OkResponse;
}

/**
 * Redeem invite code to join a redeemable lab
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("JoinRequest")
@autoRoute
op redeemInvitationCode is ArmProviderActionSync<
  Request = RedeemRequest,
  Response = RedeemCodeResponse,
  Error = DefaultErrorResponse
>;

@@Azure.ClientGenerator.Core.clientName(redeemInvitationCode::parameters.body,
  "parameters"
);
