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

/** Interface representing a Pattern. */
export interface Pattern {
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
  ): Promise<PatternAddPatternResponse>;
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
  ): Promise<PatternListPatternsResponse>;
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
  ): Promise<PatternUpdatePatternsResponse>;
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
  ): Promise<PatternBatchAddPatternsResponse>;
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
  ): Promise<PatternDeletePatternsResponse>;
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
  ): Promise<PatternUpdatePatternResponse>;
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
  ): Promise<PatternDeletePatternResponse>;
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
  ): Promise<PatternListIntentPatternsResponse>;
}
