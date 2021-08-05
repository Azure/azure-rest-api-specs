import { Examples } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
import {
  ExampleLabelObject,
  ExamplesAddOptionalParams,
  ExamplesAddResponse,
  ExamplesBatchOptionalParams,
  ExamplesBatchResponse,
  ExamplesListOptionalParams,
  ExamplesListResponse,
  ExamplesDeleteOptionalParams,
  ExamplesDeleteResponse
} from "../models";

/** Class representing a Examples. */
export class ExamplesImpl implements Examples {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Examples class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

  /**
   * Adds a labeled example utterance in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param exampleLabelObject A labeled example utterance with the expected intent and entities.
   * @param options The options parameters.
   */
  add(
    appId: string,
    versionId: string,
    exampleLabelObject: ExampleLabelObject,
    options?: ExamplesAddOptionalParams
  ): Promise<ExamplesAddResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, exampleLabelObject, options },
      addOperationSpec
    );
  }

  /**
   * Adds a batch of labeled example utterances to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param exampleLabelObjectArray Array of example utterances.
   * @param options The options parameters.
   */
  batch(
    appId: string,
    versionId: string,
    exampleLabelObjectArray: ExampleLabelObject[],
    options?: ExamplesBatchOptionalParams
  ): Promise<ExamplesBatchResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, exampleLabelObjectArray, options },
      batchOperationSpec
    );
  }

  /**
   * Returns example utterances to be reviewed from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    versionId: string,
    options?: ExamplesListOptionalParams
  ): Promise<ExamplesListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listOperationSpec
    );
  }

  /**
   * Deletes the labeled example utterances with the specified ID from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param exampleId The example ID.
   * @param options The options parameters.
   */
  delete(
    appId: string,
    versionId: string,
    exampleId: number,
    options?: ExamplesDeleteOptionalParams
  ): Promise<ExamplesDeleteResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, exampleId, options },
      deleteOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const addOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/example",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: Mappers.LabelExampleResponse
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.exampleLabelObject,
  queryParameters: [Parameters.enableNestedChildren],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const batchOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/examples",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "BatchLabelExample" }
          }
        }
      }
    },
    207: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "BatchLabelExample" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.exampleLabelObjectArray,
  queryParameters: [Parameters.enableNestedChildren],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/examples",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "LabeledUtterance" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [
    Parameters.skip,
    Parameters.take,
    Parameters.enableNestedChildren
  ],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/examples/{exampleId}",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.exampleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
