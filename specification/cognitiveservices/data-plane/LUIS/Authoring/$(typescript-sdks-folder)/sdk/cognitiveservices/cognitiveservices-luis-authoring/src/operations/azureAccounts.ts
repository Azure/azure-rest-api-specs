import { AzureAccounts } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
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

/** Class representing a AzureAccounts. */
export class AzureAccountsImpl implements AzureAccounts {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class AzureAccounts class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

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
  ): Promise<AzureAccountsAssignToAppResponse> {
    return this.client.sendOperationRequest(
      { appId, authorization, options },
      assignToAppOperationSpec
    );
  }

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
  ): Promise<AzureAccountsGetAssignedResponse> {
    return this.client.sendOperationRequest(
      { appId, authorization, options },
      getAssignedOperationSpec
    );
  }

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
  ): Promise<AzureAccountsRemoveFromAppResponse> {
    return this.client.sendOperationRequest(
      { appId, authorization, options },
      removeFromAppOperationSpec
    );
  }

  /**
   * Gets the LUIS Azure accounts for the user using his ARM token.
   * @param authorization The bearer authorization header to use; containing the user's ARM token used to
   *                      validate Azure accounts information.
   * @param options The options parameters.
   */
  listUserLuisAccounts(
    authorization: string,
    options?: AzureAccountsListUserLuisAccountsOptionalParams
  ): Promise<AzureAccountsListUserLuisAccountsResponse> {
    return this.client.sendOperationRequest(
      { authorization, options },
      listUserLuisAccountsOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const assignToAppOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/azureaccounts",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.azureAccountInfoObject,
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [
    Parameters.contentType,
    Parameters.accept,
    Parameters.authorization,
    Parameters.armToken
  ],
  mediaType: "json",
  serializer
};
const getAssignedOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/azureaccounts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "AzureAccountInfoObject" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [
    Parameters.accept,
    Parameters.authorization,
    Parameters.armToken
  ],
  serializer
};
const removeFromAppOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/azureaccounts",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.azureAccountInfoObject,
  urlParameters: [Parameters.endpoint, Parameters.appId],
  headerParameters: [
    Parameters.contentType,
    Parameters.accept,
    Parameters.authorization,
    Parameters.armToken
  ],
  mediaType: "json",
  serializer
};
const listUserLuisAccountsOperationSpec: coreClient.OperationSpec = {
  path: "/azureaccounts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "AzureAccountInfoObject" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint],
  headerParameters: [
    Parameters.accept,
    Parameters.authorization,
    Parameters.armToken
  ],
  serializer
};
