import {
  IdpsQueryObject,
  FirewallPolicyIdpsSignaturesListOptionalParams,
  FirewallPolicyIdpsSignaturesListResponse
} from "../models";

/** Interface representing a FirewallPolicyIdpsSignatures. */
export interface FirewallPolicyIdpsSignatures {
  /**
   * Retrieves the current status of IDPS signatures for the relevant policy
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Will describe the query to run against the IDPS signatures DB
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: IdpsQueryObject,
    options?: FirewallPolicyIdpsSignaturesListOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesListResponse>;
}
