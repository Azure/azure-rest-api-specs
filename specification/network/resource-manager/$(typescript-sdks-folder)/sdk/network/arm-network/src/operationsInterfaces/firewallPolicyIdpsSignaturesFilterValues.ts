import {
  SignatureOverridesFilterValuesQuery,
  FirewallPolicyIdpsSignaturesFilterValuesListOptionalParams,
  FirewallPolicyIdpsSignaturesFilterValuesListResponse
} from "../models";

/** Interface representing a FirewallPolicyIdpsSignaturesFilterValues. */
export interface FirewallPolicyIdpsSignaturesFilterValues {
  /**
   * Retrieves the current filter values for the signatures overrides
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Describes the filter values possibles for a given column
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: SignatureOverridesFilterValuesQuery,
    options?: FirewallPolicyIdpsSignaturesFilterValuesListOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesFilterValuesListResponse>;
}
