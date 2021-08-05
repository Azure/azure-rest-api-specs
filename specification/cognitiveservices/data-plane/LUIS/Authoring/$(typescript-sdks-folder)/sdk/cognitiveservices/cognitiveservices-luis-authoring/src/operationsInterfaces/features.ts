import {
  PhraselistCreateObject,
  FeaturesAddPhraseListOptionalParams,
  FeaturesAddPhraseListResponse,
  FeaturesListPhraseListsOptionalParams,
  FeaturesListPhraseListsResponse,
  FeaturesListOptionalParams,
  FeaturesListResponse,
  FeaturesGetPhraseListOptionalParams,
  FeaturesGetPhraseListResponse,
  FeaturesUpdatePhraseListOptionalParams,
  FeaturesUpdatePhraseListResponse,
  FeaturesDeletePhraseListOptionalParams,
  FeaturesDeletePhraseListResponse,
  ModelFeatureInformation,
  FeaturesAddIntentFeatureOptionalParams,
  FeaturesAddIntentFeatureResponse,
  FeaturesAddEntityFeatureOptionalParams,
  FeaturesAddEntityFeatureResponse
} from "../models";

/** Interface representing a Features. */
export interface Features {
  /**
   * Creates a new phraselist feature in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistCreateObject A Phraselist object containing Name, comma-separated Phrases and the
   *                               isExchangeable boolean. Default value for isExchangeable is true.
   * @param options The options parameters.
   */
  addPhraseList(
    appId: string,
    versionId: string,
    phraselistCreateObject: PhraselistCreateObject,
    options?: FeaturesAddPhraseListOptionalParams
  ): Promise<FeaturesAddPhraseListResponse>;
  /**
   * Gets all the phraselist features in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listPhraseLists(
    appId: string,
    versionId: string,
    options?: FeaturesListPhraseListsOptionalParams
  ): Promise<FeaturesListPhraseListsResponse>;
  /**
   * Gets all the extraction phraselist and pattern features in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  list(
    appId: string,
    versionId: string,
    options?: FeaturesListOptionalParams
  ): Promise<FeaturesListResponse>;
  /**
   * Gets phraselist feature info in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistId The ID of the feature to be retrieved.
   * @param options The options parameters.
   */
  getPhraseList(
    appId: string,
    versionId: string,
    phraselistId: number,
    options?: FeaturesGetPhraseListOptionalParams
  ): Promise<FeaturesGetPhraseListResponse>;
  /**
   * Updates the phrases, the state and the name of the phraselist feature in a version of the
   * application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistId The ID of the feature to be updated.
   * @param options The options parameters.
   */
  updatePhraseList(
    appId: string,
    versionId: string,
    phraselistId: number,
    options?: FeaturesUpdatePhraseListOptionalParams
  ): Promise<FeaturesUpdatePhraseListResponse>;
  /**
   * Deletes a phraselist feature from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param phraselistId The ID of the feature to be deleted.
   * @param options The options parameters.
   */
  deletePhraseList(
    appId: string,
    versionId: string,
    phraselistId: number,
    options?: FeaturesDeletePhraseListOptionalParams
  ): Promise<FeaturesDeletePhraseListResponse>;
  /**
   * Adds a new feature relation to be used by the intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param featureRelationCreateObject A Feature relation information object.
   * @param options The options parameters.
   */
  addIntentFeature(
    appId: string,
    versionId: string,
    intentId: string,
    featureRelationCreateObject: ModelFeatureInformation,
    options?: FeaturesAddIntentFeatureOptionalParams
  ): Promise<FeaturesAddIntentFeatureResponse>;
  /**
   * Adds a new feature relation to be used by the entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param featureRelationCreateObject A Feature relation information object.
   * @param options The options parameters.
   */
  addEntityFeature(
    appId: string,
    versionId: string,
    entityId: string,
    featureRelationCreateObject: ModelFeatureInformation,
    options?: FeaturesAddEntityFeatureOptionalParams
  ): Promise<FeaturesAddEntityFeatureResponse>;
}
