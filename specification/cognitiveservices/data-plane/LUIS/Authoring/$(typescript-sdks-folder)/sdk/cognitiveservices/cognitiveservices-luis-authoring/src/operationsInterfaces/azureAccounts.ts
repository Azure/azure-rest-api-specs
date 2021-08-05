import {
  AzureAccountsAssignToAppOptionalParams,
  AzureAccountsAssignToAppResponse,
  AzureAccountsGetAssignedOptionalParams,
  AzureAccountsGetAssignedResponse,
  AzureAccountsRemoveFromAppOptionalParams,
  AzureAccountsRemoveFromAppResponse,
  AzureAccountsListUserLuisAccountsOptionalParams,
  AzureAccountsListUserLuisAccountsResponse
} from "../models";

/** Interface representing a AzureAccounts. */
export interface AzureAccounts {
  /**
   * Assigns an Azure account to the application.
   * @param appId The application ID.
   * @param authorization The bearer authorization header to use; containing the user's ARM token used to
   *                      validate Azure accounts information.
   * @param options The options parameters.
   */
  assignToApp(
    appId: string,
    authorization: string,
    options?: AzureAccountsAssignToAppOptionalParams
  ): Promise<AzureAccountsAssignToAppResponse>;
  /**
   * Gets the LUIS Azure accounts assigned to the application for the user using his ARM token.
   * @param appId The application ID.
   * @param authorization The bearer authorization header to use; containing the user's ARM token used to
   *                      validate Azure accounts information.
   * @param options The options parameters.
   */
  getAssigned(
    appId: string,
    authorization: string,
    options?: AzureAccountsGetAssignedOptionalParams
  ): Promise<AzureAccountsGetAssignedResponse>;
  /**
   * Removes assigned Azure account from the application.
   * @param appId The application ID.
   * @param authorization The bearer authorization header to use; containing the user's ARM token used to
   *                      validate Azure accounts information.
   * @param options The options parameters.
   */
  removeFromApp(
    appId: string,
    authorization: string,
    options?: AzureAccountsRemoveFromAppOptionalParams
  ): Promise<AzureAccountsRemoveFromAppResponse>;
  /**
   * Gets the LUIS Azure accounts for the user using his ARM token.
   * @param authorization The bearer authorization header to use; containing the user's ARM token used to
   *                      validate Azure accounts information.
   * @param options The options parameters.
   */
  listUserLuisAccounts(
    authorization: string,
    options?: AzureAccountsListUserLuisAccountsOptionalParams
  ): Promise<AzureAccountsListUserLuisAccountsResponse>;
}
