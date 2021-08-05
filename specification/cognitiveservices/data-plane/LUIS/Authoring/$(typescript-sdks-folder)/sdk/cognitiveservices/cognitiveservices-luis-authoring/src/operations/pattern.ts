import { Pattern } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
import {
  PatternRuleCreateObject,
  PatternAddPatternOptionalParams,
  PatternAddPatternResponse,
  PatternListPatternsOptionalParams,
  PatternListPatternsResponse,
  PatternRuleUpdateObject,
  PatternUpdatePatternsOptionalParams,
  PatternUpdatePatternsResponse,
  PatternBatchAddPatternsOptionalParams,
  PatternBatchAddPatternsResponse,
  PatternDeletePatternsOptionalParams,
  PatternDeletePatternsResponse,
  PatternUpdatePatternOptionalParams,
  PatternUpdatePatternResponse,
  PatternDeletePatternOptionalParams,
  PatternDeletePatternResponse,
  PatternListIntentPatternsOptionalParams,
  PatternListIntentPatternsResponse
} from "../models";

/** Class representing a Pattern. */
export class PatternImpl implements Pattern {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Pattern class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

  /**
   * Adds a pattern to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param pattern The input pattern.
   * @param options The options parameters.
   */
  addPattern(
    appId: string,
    versionId: string,
    pattern: PatternRuleCreateObject,
    options?: PatternAddPatternOptionalParams
  ): Promise<PatternAddPatternResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, pattern, options },
      addPatternOperationSpec
    );
  }

  /**
   * Gets patterns in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listPatterns(
    appId: string,
    versionId: string,
    options?: PatternListPatternsOptionalParams
  ): Promise<PatternListPatternsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listPatternsOperationSpec
    );
  }

  /**
   * Updates patterns in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param patterns An array represents the patterns.
   * @param options The options parameters.
   */
  updatePatterns(
    appId: string,
    versionId: string,
    patterns: PatternRuleUpdateObject[],
    options?: PatternUpdatePatternsOptionalParams
  ): Promise<PatternUpdatePatternsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, patterns, options },
      updatePatternsOperationSpec
    );
  }

  /**
   * Adds a batch of patterns in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param patterns A JSON array containing patterns.
   * @param options The options parameters.
   */
  batchAddPatterns(
    appId: string,
    versionId: string,
    patterns: PatternRuleCreateObject[],
    options?: PatternBatchAddPatternsOptionalParams
  ): Promise<PatternBatchAddPatternsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, patterns, options },
      batchAddPatternsOperationSpec
    );
  }

  /**
   * Deletes a list of patterns in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param patternIds The patterns IDs.
   * @param options The options parameters.
   */
  deletePatterns(
    appId: string,
    versionId: string,
    patternIds: string[],
    options?: PatternDeletePatternsOptionalParams
  ): Promise<PatternDeletePatternsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, patternIds, options },
      deletePatternsOperationSpec
    );
  }

  /**
   * Updates a pattern in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param patternId The pattern ID.
   * @param pattern An object representing a pattern.
   * @param options The options parameters.
   */
  updatePattern(
    appId: string,
    versionId: string,
    patternId: string,
    pattern: PatternRuleUpdateObject,
    options?: PatternUpdatePatternOptionalParams
  ): Promise<PatternUpdatePatternResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, patternId, pattern, options },
      updatePatternOperationSpec
    );
  }

  /**
   * Deletes the pattern with the specified ID from a version of the application..
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param patternId The pattern ID.
   * @param options The options parameters.
   */
  deletePattern(
    appId: string,
    versionId: string,
    patternId: string,
    options?: PatternDeletePatternOptionalParams
  ): Promise<PatternDeletePatternResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, patternId, options },
      deletePatternOperationSpec
    );
  }

  /**
   * Returns patterns for the specific intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param options The options parameters.
   */
  listIntentPatterns(
    appId: string,
    versionId: string,
    intentId: string,
    options?: PatternListIntentPatternsOptionalParams
  ): Promise<PatternListIntentPatternsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, options },
      listIntentPatternsOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const addPatternOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrule",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: Mappers.PatternRuleInfo
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.pattern,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listPatternsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "PatternRuleInfo" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.take],
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePatternsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrules",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "PatternRuleInfo" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.patterns,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const batchAddPatternsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrules",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "PatternRuleInfo" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.patterns1,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deletePatternsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrules",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.patternIds,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const updatePatternOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrules/{patternId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.PatternRuleInfo
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.pattern1,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.patternId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deletePatternOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternrules/{patternId}",
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
    Parameters.patternId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listIntentPatternsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}/patternrules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "PatternRuleInfo" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.skip, Parameters.take],
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
