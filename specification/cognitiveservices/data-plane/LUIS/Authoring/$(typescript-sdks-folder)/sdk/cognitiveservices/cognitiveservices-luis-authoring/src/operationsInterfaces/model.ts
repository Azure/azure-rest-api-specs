import {
  ModelCreateObject,
  ModelAddIntentOptionalParams,
  ModelAddIntentResponse,
  ModelListIntentsOptionalParams,
  ModelListIntentsResponse,
  EntityModelCreateObject,
  ModelAddEntityOptionalParams,
  ModelAddEntityResponse,
  ModelListEntitiesOptionalParams,
  ModelListEntitiesResponse,
  ModelListHierarchicalEntitiesOptionalParams,
  ModelListHierarchicalEntitiesResponse,
  ModelListCompositeEntitiesOptionalParams,
  ModelListCompositeEntitiesResponse,
  ModelListClosedListsOptionalParams,
  ModelListClosedListsResponse,
  ClosedListModelCreateObject,
  ModelAddClosedListOptionalParams,
  ModelAddClosedListResponse,
  ModelAddPrebuiltOptionalParams,
  ModelAddPrebuiltResponse,
  ModelListPrebuiltsOptionalParams,
  ModelListPrebuiltsResponse,
  ModelListPrebuiltEntitiesOptionalParams,
  ModelListPrebuiltEntitiesResponse,
  ModelListModelsOptionalParams,
  ModelListModelsResponse,
  ModelExamplesOptionalParams,
  ModelExamplesResponse,
  ModelGetIntentOptionalParams,
  ModelGetIntentResponse,
  ModelUpdateObject,
  ModelUpdateIntentOptionalParams,
  ModelUpdateIntentResponse,
  ModelDeleteIntentOptionalParams,
  ModelDeleteIntentResponse,
  ModelGetEntityOptionalParams,
  ModelGetEntityResponse,
  ModelDeleteEntityOptionalParams,
  ModelDeleteEntityResponse,
  EntityModelUpdateObject,
  ModelUpdateEntityChildOptionalParams,
  ModelUpdateEntityChildResponse,
  ModelGetIntentFeaturesOptionalParams,
  ModelGetIntentFeaturesResponse,
  ModelFeatureInformation,
  ModelReplaceIntentFeaturesOptionalParams,
  ModelReplaceIntentFeaturesResponse,
  ModelDeleteIntentFeatureOptionalParams,
  ModelDeleteIntentFeatureResponse,
  ModelGetEntityFeaturesOptionalParams,
  ModelGetEntityFeaturesResponse,
  ModelReplaceEntityFeaturesOptionalParams,
  ModelReplaceEntityFeaturesResponse,
  ModelDeleteEntityFeatureOptionalParams,
  ModelDeleteEntityFeatureResponse,
  ModelGetHierarchicalEntityOptionalParams,
  ModelGetHierarchicalEntityResponse,
  ModelUpdateHierarchicalEntityOptionalParams,
  ModelUpdateHierarchicalEntityResponse,
  ModelDeleteHierarchicalEntityOptionalParams,
  ModelDeleteHierarchicalEntityResponse,
  ModelGetCompositeEntityOptionalParams,
  ModelGetCompositeEntityResponse,
  CompositeEntityModel,
  ModelUpdateCompositeEntityOptionalParams,
  ModelUpdateCompositeEntityResponse,
  ModelDeleteCompositeEntityOptionalParams,
  ModelDeleteCompositeEntityResponse,
  ModelGetClosedListOptionalParams,
  ModelGetClosedListResponse,
  ClosedListModelUpdateObject,
  ModelUpdateClosedListOptionalParams,
  ModelUpdateClosedListResponse,
  ClosedListModelPatchObject,
  ModelPatchClosedListOptionalParams,
  ModelPatchClosedListResponse,
  ModelDeleteClosedListOptionalParams,
  ModelDeleteClosedListResponse,
  ModelGetPrebuiltOptionalParams,
  ModelGetPrebuiltResponse,
  ModelDeletePrebuiltOptionalParams,
  ModelDeletePrebuiltResponse,
  ModelDeleteSubListOptionalParams,
  ModelDeleteSubListResponse,
  WordListBaseUpdateObject,
  ModelUpdateSubListOptionalParams,
  ModelUpdateSubListResponse,
  ModelListIntentSuggestionsOptionalParams,
  ModelListIntentSuggestionsResponse,
  ModelListEntitySuggestionsOptionalParams,
  ModelListEntitySuggestionsResponse,
  WordListObject,
  ModelAddSubListOptionalParams,
  ModelAddSubListResponse,
  PrebuiltDomainCreateBaseObject,
  ModelAddCustomPrebuiltDomainOptionalParams,
  ModelAddCustomPrebuiltDomainResponse,
  PrebuiltDomainModelCreateObject,
  ModelAddCustomPrebuiltIntentOptionalParams,
  ModelAddCustomPrebuiltIntentResponse,
  ModelListCustomPrebuiltIntentsOptionalParams,
  ModelListCustomPrebuiltIntentsResponse,
  ModelAddCustomPrebuiltEntityOptionalParams,
  ModelAddCustomPrebuiltEntityResponse,
  ModelListCustomPrebuiltEntitiesOptionalParams,
  ModelListCustomPrebuiltEntitiesResponse,
  ModelListCustomPrebuiltModelsOptionalParams,
  ModelListCustomPrebuiltModelsResponse,
  ModelDeleteCustomPrebuiltDomainOptionalParams,
  ModelDeleteCustomPrebuiltDomainResponse,
  ChildEntityModelCreateObject,
  ModelAddEntityChildOptionalParams,
  ModelAddEntityChildResponse,
  ModelGetHierarchicalEntityChildOptionalParams,
  ModelGetHierarchicalEntityChildResponse,
  Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchema,
  ModelUpdateHierarchicalEntityChildOptionalParams,
  ModelUpdateHierarchicalEntityChildResponse,
  ModelDeleteHierarchicalEntityChildOptionalParams,
  ModelDeleteHierarchicalEntityChildResponse,
  PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchema,
  ModelAddCompositeEntityChildOptionalParams,
  ModelAddCompositeEntityChildResponse,
  ModelDeleteCompositeEntityChildOptionalParams,
  ModelDeleteCompositeEntityChildResponse,
  ModelListRegexEntityInfosOptionalParams,
  ModelListRegexEntityInfosResponse,
  RegexModelCreateObject,
  ModelCreateRegexEntityModelOptionalParams,
  ModelCreateRegexEntityModelResponse,
  ModelListPatternAnyEntityInfosOptionalParams,
  ModelListPatternAnyEntityInfosResponse,
  PatternAnyModelCreateObject,
  ModelCreatePatternAnyEntityModelOptionalParams,
  ModelCreatePatternAnyEntityModelResponse,
  ModelListEntityRolesOptionalParams,
  ModelListEntityRolesResponse,
  EntityRoleCreateObject,
  ModelCreateEntityRoleOptionalParams,
  ModelCreateEntityRoleResponse,
  ModelListPrebuiltEntityRolesOptionalParams,
  ModelListPrebuiltEntityRolesResponse,
  ModelCreatePrebuiltEntityRoleOptionalParams,
  ModelCreatePrebuiltEntityRoleResponse,
  ModelListClosedListEntityRolesOptionalParams,
  ModelListClosedListEntityRolesResponse,
  ModelCreateClosedListEntityRoleOptionalParams,
  ModelCreateClosedListEntityRoleResponse,
  ModelListRegexEntityRolesOptionalParams,
  ModelListRegexEntityRolesResponse,
  ModelCreateRegexEntityRoleOptionalParams,
  ModelCreateRegexEntityRoleResponse,
  ModelListCompositeEntityRolesOptionalParams,
  ModelListCompositeEntityRolesResponse,
  ModelCreateCompositeEntityRoleOptionalParams,
  ModelCreateCompositeEntityRoleResponse,
  ModelListPatternAnyEntityRolesOptionalParams,
  ModelListPatternAnyEntityRolesResponse,
  ModelCreatePatternAnyEntityRoleOptionalParams,
  ModelCreatePatternAnyEntityRoleResponse,
  ModelListHierarchicalEntityRolesOptionalParams,
  ModelListHierarchicalEntityRolesResponse,
  ModelCreateHierarchicalEntityRoleOptionalParams,
  ModelCreateHierarchicalEntityRoleResponse,
  ModelListCustomPrebuiltEntityRolesOptionalParams,
  ModelListCustomPrebuiltEntityRolesResponse,
  ModelCreateCustomPrebuiltEntityRoleOptionalParams,
  ModelCreateCustomPrebuiltEntityRoleResponse,
  ModelGetExplicitListOptionalParams,
  ModelGetExplicitListResponse,
  ExplicitListItemCreateObject,
  ModelAddExplicitListItemOptionalParams,
  ModelAddExplicitListItemResponse,
  ModelGetRegexEntityInfoOptionalParams,
  ModelGetRegexEntityInfoResponse,
  RegexModelUpdateObject,
  ModelUpdateRegexEntityModelOptionalParams,
  ModelUpdateRegexEntityModelResponse,
  ModelDeleteRegexEntityModelOptionalParams,
  ModelDeleteRegexEntityModelResponse,
  ModelGetPatternAnyEntityInfoOptionalParams,
  ModelGetPatternAnyEntityInfoResponse,
  PatternAnyModelUpdateObject,
  ModelUpdatePatternAnyEntityModelOptionalParams,
  ModelUpdatePatternAnyEntityModelResponse,
  ModelDeletePatternAnyEntityModelOptionalParams,
  ModelDeletePatternAnyEntityModelResponse,
  ModelGetEntityRoleOptionalParams,
  ModelGetEntityRoleResponse,
  EntityRoleUpdateObject,
  ModelUpdateEntityRoleOptionalParams,
  ModelUpdateEntityRoleResponse,
  ModelDeleteEntityRoleOptionalParams,
  ModelDeleteEntityRoleResponse,
  ModelGetPrebuiltEntityRoleOptionalParams,
  ModelGetPrebuiltEntityRoleResponse,
  ModelUpdatePrebuiltEntityRoleOptionalParams,
  ModelUpdatePrebuiltEntityRoleResponse,
  ModelDeletePrebuiltEntityRoleOptionalParams,
  ModelDeletePrebuiltEntityRoleResponse,
  ModelGetClosedListEntityRoleOptionalParams,
  ModelGetClosedListEntityRoleResponse,
  ModelUpdateClosedListEntityRoleOptionalParams,
  ModelUpdateClosedListEntityRoleResponse,
  ModelDeleteClosedListEntityRoleOptionalParams,
  ModelDeleteClosedListEntityRoleResponse,
  ModelGetRegexEntityRoleOptionalParams,
  ModelGetRegexEntityRoleResponse,
  ModelUpdateRegexEntityRoleOptionalParams,
  ModelUpdateRegexEntityRoleResponse,
  ModelDeleteRegexEntityRoleOptionalParams,
  ModelDeleteRegexEntityRoleResponse,
  ModelGetCompositeEntityRoleOptionalParams,
  ModelGetCompositeEntityRoleResponse,
  ModelUpdateCompositeEntityRoleOptionalParams,
  ModelUpdateCompositeEntityRoleResponse,
  ModelDeleteCompositeEntityRoleOptionalParams,
  ModelDeleteCompositeEntityRoleResponse,
  ModelGetPatternAnyEntityRoleOptionalParams,
  ModelGetPatternAnyEntityRoleResponse,
  ModelUpdatePatternAnyEntityRoleOptionalParams,
  ModelUpdatePatternAnyEntityRoleResponse,
  ModelDeletePatternAnyEntityRoleOptionalParams,
  ModelDeletePatternAnyEntityRoleResponse,
  ModelGetHierarchicalEntityRoleOptionalParams,
  ModelGetHierarchicalEntityRoleResponse,
  ModelUpdateHierarchicalEntityRoleOptionalParams,
  ModelUpdateHierarchicalEntityRoleResponse,
  ModelDeleteHierarchicalEntityRoleOptionalParams,
  ModelDeleteHierarchicalEntityRoleResponse,
  ModelGetCustomEntityRoleOptionalParams,
  ModelGetCustomEntityRoleResponse,
  ModelUpdateCustomPrebuiltEntityRoleOptionalParams,
  ModelUpdateCustomPrebuiltEntityRoleResponse,
  ModelDeleteCustomEntityRoleOptionalParams,
  ModelDeleteCustomEntityRoleResponse,
  ModelGetExplicitListItemOptionalParams,
  ModelGetExplicitListItemResponse,
  ExplicitListItemUpdateObject,
  ModelUpdateExplicitListItemOptionalParams,
  ModelUpdateExplicitListItemResponse,
  ModelDeleteExplicitListItemOptionalParams,
  ModelDeleteExplicitListItemResponse
} from "../models";

/** Interface representing a Model. */
export interface Model {
  /**
   * Adds an intent to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentCreateObject A model object containing the name of the new intent.
   * @param options The options parameters.
   */
  addIntent(
    appId: string,
    versionId: string,
    intentCreateObject: ModelCreateObject,
    options?: ModelAddIntentOptionalParams
  ): Promise<ModelAddIntentResponse>;
  /**
   * Gets information about the intent models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listIntents(
    appId: string,
    versionId: string,
    options?: ModelListIntentsOptionalParams
  ): Promise<ModelListIntentsResponse>;
  /**
   * Adds an entity extractor to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityModelCreateObject A model object containing the name of the new entity extractor and
   *                                its children.
   * @param options The options parameters.
   */
  addEntity(
    appId: string,
    versionId: string,
    entityModelCreateObject: EntityModelCreateObject,
    options?: ModelAddEntityOptionalParams
  ): Promise<ModelAddEntityResponse>;
  /**
   * Gets information about all the simple entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listEntities(
    appId: string,
    versionId: string,
    options?: ModelListEntitiesOptionalParams
  ): Promise<ModelListEntitiesResponse>;
  /**
   * Gets information about all the hierarchical entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listHierarchicalEntities(
    appId: string,
    versionId: string,
    options?: ModelListHierarchicalEntitiesOptionalParams
  ): Promise<ModelListHierarchicalEntitiesResponse>;
  /**
   * Gets information about all the composite entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listCompositeEntities(
    appId: string,
    versionId: string,
    options?: ModelListCompositeEntitiesOptionalParams
  ): Promise<ModelListCompositeEntitiesResponse>;
  /**
   * Gets information about all the list entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listClosedLists(
    appId: string,
    versionId: string,
    options?: ModelListClosedListsOptionalParams
  ): Promise<ModelListClosedListsResponse>;
  /**
   * Adds a list entity model to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param closedListModelCreateObject A model containing the name and words for the new list entity
   *                                    extractor.
   * @param options The options parameters.
   */
  addClosedList(
    appId: string,
    versionId: string,
    closedListModelCreateObject: ClosedListModelCreateObject,
    options?: ModelAddClosedListOptionalParams
  ): Promise<ModelAddClosedListResponse>;
  /**
   * Adds a list of prebuilt entities to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param prebuiltExtractorNames An array of prebuilt entity extractor names.
   * @param options The options parameters.
   */
  addPrebuilt(
    appId: string,
    versionId: string,
    prebuiltExtractorNames: string[],
    options?: ModelAddPrebuiltOptionalParams
  ): Promise<ModelAddPrebuiltResponse>;
  /**
   * Gets information about all the prebuilt entities in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listPrebuilts(
    appId: string,
    versionId: string,
    options?: ModelListPrebuiltsOptionalParams
  ): Promise<ModelListPrebuiltsResponse>;
  /**
   * Gets all the available prebuilt entities in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listPrebuiltEntities(
    appId: string,
    versionId: string,
    options?: ModelListPrebuiltEntitiesOptionalParams
  ): Promise<ModelListPrebuiltEntitiesResponse>;
  /**
   * Gets information about all the intent and entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listModels(
    appId: string,
    versionId: string,
    options?: ModelListModelsOptionalParams
  ): Promise<ModelListModelsResponse>;
  /**
   * Gets the example utterances for the given intent or entity model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param modelId The ID (GUID) of the model.
   * @param options The options parameters.
   */
  examples(
    appId: string,
    versionId: string,
    modelId: string,
    options?: ModelExamplesOptionalParams
  ): Promise<ModelExamplesResponse>;
  /**
   * Gets information about the intent model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param options The options parameters.
   */
  getIntent(
    appId: string,
    versionId: string,
    intentId: string,
    options?: ModelGetIntentOptionalParams
  ): Promise<ModelGetIntentResponse>;
  /**
   * Updates the name of an intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param modelUpdateObject A model object containing the new intent name.
   * @param options The options parameters.
   */
  updateIntent(
    appId: string,
    versionId: string,
    intentId: string,
    modelUpdateObject: ModelUpdateObject,
    options?: ModelUpdateIntentOptionalParams
  ): Promise<ModelUpdateIntentResponse>;
  /**
   * Deletes an intent from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param options The options parameters.
   */
  deleteIntent(
    appId: string,
    versionId: string,
    intentId: string,
    options?: ModelDeleteIntentOptionalParams
  ): Promise<ModelDeleteIntentResponse>;
  /**
   * Gets information about an entity model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param options The options parameters.
   */
  getEntity(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelGetEntityOptionalParams
  ): Promise<ModelGetEntityResponse>;
  /**
   * Deletes an entity or a child from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor or the child entity extractor ID.
   * @param options The options parameters.
   */
  deleteEntity(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelDeleteEntityOptionalParams
  ): Promise<ModelDeleteEntityResponse>;
  /**
   * Updates the name of an entity extractor or the name and instanceOf model of a child entity
   * extractor.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor or the child entity extractor ID.
   * @param entityModelUpdateObject A model object containing the name new entity extractor or the name
   *                                and instance of model of a child entity extractor
   * @param options The options parameters.
   */
  updateEntityChild(
    appId: string,
    versionId: string,
    entityId: string,
    entityModelUpdateObject: EntityModelUpdateObject,
    options?: ModelUpdateEntityChildOptionalParams
  ): Promise<ModelUpdateEntityChildResponse>;
  /**
   * Gets the information of the features used by the intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param options The options parameters.
   */
  getIntentFeatures(
    appId: string,
    versionId: string,
    intentId: string,
    options?: ModelGetIntentFeaturesOptionalParams
  ): Promise<ModelGetIntentFeaturesResponse>;
  /**
   * Updates the information of the features used by the intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param featureRelationsUpdateObject A list of feature information objects containing the new feature
   *                                     relations.
   * @param options The options parameters.
   */
  replaceIntentFeatures(
    appId: string,
    versionId: string,
    intentId: string,
    featureRelationsUpdateObject: ModelFeatureInformation[],
    options?: ModelReplaceIntentFeaturesOptionalParams
  ): Promise<ModelReplaceIntentFeaturesResponse>;
  /**
   * Deletes a relation from the feature relations used by the intent in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param featureRelationDeleteObject A feature information object containing the feature relation to
   *                                    delete.
   * @param options The options parameters.
   */
  deleteIntentFeature(
    appId: string,
    versionId: string,
    intentId: string,
    featureRelationDeleteObject: ModelFeatureInformation,
    options?: ModelDeleteIntentFeatureOptionalParams
  ): Promise<ModelDeleteIntentFeatureResponse>;
  /**
   * Gets the information of the features used by the entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param options The options parameters.
   */
  getEntityFeatures(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelGetEntityFeaturesOptionalParams
  ): Promise<ModelGetEntityFeaturesResponse>;
  /**
   * Updates the information of the features used by the entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param featureRelationsUpdateObject A list of feature information objects containing the new feature
   *                                     relations.
   * @param options The options parameters.
   */
  replaceEntityFeatures(
    appId: string,
    versionId: string,
    entityId: string,
    featureRelationsUpdateObject: ModelFeatureInformation[],
    options?: ModelReplaceEntityFeaturesOptionalParams
  ): Promise<ModelReplaceEntityFeaturesResponse>;
  /**
   * Deletes a relation from the feature relations used by the entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param featureRelationDeleteObject A feature information object containing the feature relation to
   *                                    delete.
   * @param options The options parameters.
   */
  deleteEntityFeature(
    appId: string,
    versionId: string,
    entityId: string,
    featureRelationDeleteObject: ModelFeatureInformation,
    options?: ModelDeleteEntityFeatureOptionalParams
  ): Promise<ModelDeleteEntityFeatureResponse>;
  /**
   * Gets information about a hierarchical entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param options The options parameters.
   */
  getHierarchicalEntity(
    appId: string,
    versionId: string,
    hEntityId: string,
    options?: ModelGetHierarchicalEntityOptionalParams
  ): Promise<ModelGetHierarchicalEntityResponse>;
  /**
   * Updates the name of a hierarchical entity model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param modelUpdateObject Model containing names of the hierarchical entity.
   * @param options The options parameters.
   */
  updateHierarchicalEntity(
    appId: string,
    versionId: string,
    hEntityId: string,
    modelUpdateObject: ModelUpdateObject,
    options?: ModelUpdateHierarchicalEntityOptionalParams
  ): Promise<ModelUpdateHierarchicalEntityResponse>;
  /**
   * Deletes a hierarchical entity from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param options The options parameters.
   */
  deleteHierarchicalEntity(
    appId: string,
    versionId: string,
    hEntityId: string,
    options?: ModelDeleteHierarchicalEntityOptionalParams
  ): Promise<ModelDeleteHierarchicalEntityResponse>;
  /**
   * Gets information about a composite entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param options The options parameters.
   */
  getCompositeEntity(
    appId: string,
    versionId: string,
    cEntityId: string,
    options?: ModelGetCompositeEntityOptionalParams
  ): Promise<ModelGetCompositeEntityResponse>;
  /**
   * Updates a composite entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param compositeModelUpdateObject A model object containing the new entity extractor name and
   *                                   children.
   * @param options The options parameters.
   */
  updateCompositeEntity(
    appId: string,
    versionId: string,
    cEntityId: string,
    compositeModelUpdateObject: CompositeEntityModel,
    options?: ModelUpdateCompositeEntityOptionalParams
  ): Promise<ModelUpdateCompositeEntityResponse>;
  /**
   * Deletes a composite entity from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param options The options parameters.
   */
  deleteCompositeEntity(
    appId: string,
    versionId: string,
    cEntityId: string,
    options?: ModelDeleteCompositeEntityOptionalParams
  ): Promise<ModelDeleteCompositeEntityResponse>;
  /**
   * Gets information about a list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list model ID.
   * @param options The options parameters.
   */
  getClosedList(
    appId: string,
    versionId: string,
    clEntityId: string,
    options?: ModelGetClosedListOptionalParams
  ): Promise<ModelGetClosedListResponse>;
  /**
   * Updates the list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list model ID.
   * @param closedListModelUpdateObject The new list entity name and words list.
   * @param options The options parameters.
   */
  updateClosedList(
    appId: string,
    versionId: string,
    clEntityId: string,
    closedListModelUpdateObject: ClosedListModelUpdateObject,
    options?: ModelUpdateClosedListOptionalParams
  ): Promise<ModelUpdateClosedListResponse>;
  /**
   * Adds a batch of sublists to an existing list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list entity model ID.
   * @param closedListModelPatchObject A words list batch.
   * @param options The options parameters.
   */
  patchClosedList(
    appId: string,
    versionId: string,
    clEntityId: string,
    closedListModelPatchObject: ClosedListModelPatchObject,
    options?: ModelPatchClosedListOptionalParams
  ): Promise<ModelPatchClosedListResponse>;
  /**
   * Deletes a list entity model from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list entity model ID.
   * @param options The options parameters.
   */
  deleteClosedList(
    appId: string,
    versionId: string,
    clEntityId: string,
    options?: ModelDeleteClosedListOptionalParams
  ): Promise<ModelDeleteClosedListResponse>;
  /**
   * Gets information about a prebuilt entity model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param prebuiltId The prebuilt entity extractor ID.
   * @param options The options parameters.
   */
  getPrebuilt(
    appId: string,
    versionId: string,
    prebuiltId: string,
    options?: ModelGetPrebuiltOptionalParams
  ): Promise<ModelGetPrebuiltResponse>;
  /**
   * Deletes a prebuilt entity extractor from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param prebuiltId The prebuilt entity extractor ID.
   * @param options The options parameters.
   */
  deletePrebuilt(
    appId: string,
    versionId: string,
    prebuiltId: string,
    options?: ModelDeletePrebuiltOptionalParams
  ): Promise<ModelDeletePrebuiltResponse>;
  /**
   * Deletes a sublist of a specific list entity model from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list entity extractor ID.
   * @param subListId The sublist ID.
   * @param options The options parameters.
   */
  deleteSubList(
    appId: string,
    versionId: string,
    clEntityId: string,
    subListId: number,
    options?: ModelDeleteSubListOptionalParams
  ): Promise<ModelDeleteSubListResponse>;
  /**
   * Updates one of the list entity's sublists in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list entity extractor ID.
   * @param subListId The sublist ID.
   * @param wordListBaseUpdateObject A sublist update object containing the new canonical form and the
   *                                 list of words.
   * @param options The options parameters.
   */
  updateSubList(
    appId: string,
    versionId: string,
    clEntityId: string,
    subListId: number,
    wordListBaseUpdateObject: WordListBaseUpdateObject,
    options?: ModelUpdateSubListOptionalParams
  ): Promise<ModelUpdateSubListResponse>;
  /**
   * Suggests example utterances that would improve the accuracy of the intent model in a version of the
   * application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param intentId The intent classifier ID.
   * @param options The options parameters.
   */
  listIntentSuggestions(
    appId: string,
    versionId: string,
    intentId: string,
    options?: ModelListIntentSuggestionsOptionalParams
  ): Promise<ModelListIntentSuggestionsResponse>;
  /**
   * Get suggested example utterances that would improve the accuracy of the entity model in a version of
   * the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The target entity extractor model to enhance.
   * @param options The options parameters.
   */
  listEntitySuggestions(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListEntitySuggestionsOptionalParams
  ): Promise<ModelListEntitySuggestionsResponse>;
  /**
   * Adds a sublist to an existing list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param clEntityId The list entity extractor ID.
   * @param wordListCreateObject Words list.
   * @param options The options parameters.
   */
  addSubList(
    appId: string,
    versionId: string,
    clEntityId: string,
    wordListCreateObject: WordListObject,
    options?: ModelAddSubListOptionalParams
  ): Promise<ModelAddSubListResponse>;
  /**
   * Adds a customizable prebuilt domain along with all of its intent and entity models in a version of
   * the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param prebuiltDomainObject A prebuilt domain create object containing the name of the domain.
   * @param options The options parameters.
   */
  addCustomPrebuiltDomain(
    appId: string,
    versionId: string,
    prebuiltDomainObject: PrebuiltDomainCreateBaseObject,
    options?: ModelAddCustomPrebuiltDomainOptionalParams
  ): Promise<ModelAddCustomPrebuiltDomainResponse>;
  /**
   * Adds a customizable prebuilt intent model to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param prebuiltDomainModelCreateObject A model object containing the name of the customizable
   *                                        prebuilt intent and the name of the domain to which this model belongs.
   * @param options The options parameters.
   */
  addCustomPrebuiltIntent(
    appId: string,
    versionId: string,
    prebuiltDomainModelCreateObject: PrebuiltDomainModelCreateObject,
    options?: ModelAddCustomPrebuiltIntentOptionalParams
  ): Promise<ModelAddCustomPrebuiltIntentResponse>;
  /**
   * Gets information about customizable prebuilt intents added to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listCustomPrebuiltIntents(
    appId: string,
    versionId: string,
    options?: ModelListCustomPrebuiltIntentsOptionalParams
  ): Promise<ModelListCustomPrebuiltIntentsResponse>;
  /**
   * Adds a prebuilt entity model to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param prebuiltDomainModelCreateObject A model object containing the name of the prebuilt entity and
   *                                        the name of the domain to which this model belongs.
   * @param options The options parameters.
   */
  addCustomPrebuiltEntity(
    appId: string,
    versionId: string,
    prebuiltDomainModelCreateObject: PrebuiltDomainModelCreateObject,
    options?: ModelAddCustomPrebuiltEntityOptionalParams
  ): Promise<ModelAddCustomPrebuiltEntityResponse>;
  /**
   * Gets all prebuilt entities used in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listCustomPrebuiltEntities(
    appId: string,
    versionId: string,
    options?: ModelListCustomPrebuiltEntitiesOptionalParams
  ): Promise<ModelListCustomPrebuiltEntitiesResponse>;
  /**
   * Gets all prebuilt intent and entity model information used in a version of this application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listCustomPrebuiltModels(
    appId: string,
    versionId: string,
    options?: ModelListCustomPrebuiltModelsOptionalParams
  ): Promise<ModelListCustomPrebuiltModelsResponse>;
  /**
   * Deletes a prebuilt domain's models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param domainName Domain name.
   * @param options The options parameters.
   */
  deleteCustomPrebuiltDomain(
    appId: string,
    versionId: string,
    domainName: string,
    options?: ModelDeleteCustomPrebuiltDomainOptionalParams
  ): Promise<ModelDeleteCustomPrebuiltDomainResponse>;
  /**
   * Creates a single child in an existing entity model hierarchy in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param childEntityModelCreateObject A model object containing the name of the new child model and
   *                                     its children.
   * @param options The options parameters.
   */
  addEntityChild(
    appId: string,
    versionId: string,
    entityId: string,
    childEntityModelCreateObject: ChildEntityModelCreateObject,
    options?: ModelAddEntityChildOptionalParams
  ): Promise<ModelAddEntityChildResponse>;
  /**
   * Gets information about the child's model contained in an hierarchical entity child model in a
   * version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param hChildId The hierarchical entity extractor child ID.
   * @param options The options parameters.
   */
  getHierarchicalEntityChild(
    appId: string,
    versionId: string,
    hEntityId: string,
    hChildId: string,
    options?: ModelGetHierarchicalEntityChildOptionalParams
  ): Promise<ModelGetHierarchicalEntityChildResponse>;
  /**
   * Renames a single child in an existing hierarchical entity model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param hChildId The hierarchical entity extractor child ID.
   * @param hierarchicalChildModelUpdateObject Model object containing new name of the hierarchical
   *                                           entity child.
   * @param options The options parameters.
   */
  updateHierarchicalEntityChild(
    appId: string,
    versionId: string,
    hEntityId: string,
    hChildId: string,
    hierarchicalChildModelUpdateObject: Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchema,
    options?: ModelUpdateHierarchicalEntityChildOptionalParams
  ): Promise<ModelUpdateHierarchicalEntityChildResponse>;
  /**
   * Deletes a hierarchical entity extractor child in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param hChildId The hierarchical entity extractor child ID.
   * @param options The options parameters.
   */
  deleteHierarchicalEntityChild(
    appId: string,
    versionId: string,
    hEntityId: string,
    hChildId: string,
    options?: ModelDeleteHierarchicalEntityChildOptionalParams
  ): Promise<ModelDeleteHierarchicalEntityChildResponse>;
  /**
   * Creates a single child in an existing composite entity model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param compositeChildModelCreateObject A model object containing the name of the new composite child
   *                                        model.
   * @param options The options parameters.
   */
  addCompositeEntityChild(
    appId: string,
    versionId: string,
    cEntityId: string,
    compositeChildModelCreateObject: PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchema,
    options?: ModelAddCompositeEntityChildOptionalParams
  ): Promise<ModelAddCompositeEntityChildResponse>;
  /**
   * Deletes a composite entity extractor child from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param cChildId The hierarchical entity extractor child ID.
   * @param options The options parameters.
   */
  deleteCompositeEntityChild(
    appId: string,
    versionId: string,
    cEntityId: string,
    cChildId: string,
    options?: ModelDeleteCompositeEntityChildOptionalParams
  ): Promise<ModelDeleteCompositeEntityChildResponse>;
  /**
   * Gets information about the regular expression entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listRegexEntityInfos(
    appId: string,
    versionId: string,
    options?: ModelListRegexEntityInfosOptionalParams
  ): Promise<ModelListRegexEntityInfosResponse>;
  /**
   * Adds a regular expression entity model to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param regexEntityExtractorCreateObj A model object containing the name and regex pattern for the
   *                                      new regular expression entity extractor.
   * @param options The options parameters.
   */
  createRegexEntityModel(
    appId: string,
    versionId: string,
    regexEntityExtractorCreateObj: RegexModelCreateObject,
    options?: ModelCreateRegexEntityModelOptionalParams
  ): Promise<ModelCreateRegexEntityModelResponse>;
  /**
   * Get information about the Pattern.Any entity models in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param options The options parameters.
   */
  listPatternAnyEntityInfos(
    appId: string,
    versionId: string,
    options?: ModelListPatternAnyEntityInfosOptionalParams
  ): Promise<ModelListPatternAnyEntityInfosResponse>;
  /**
   * Adds a pattern.any entity extractor to a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param extractorCreateObject A model object containing the name and explicit list for the new
   *                              Pattern.Any entity extractor.
   * @param options The options parameters.
   */
  createPatternAnyEntityModel(
    appId: string,
    versionId: string,
    extractorCreateObject: PatternAnyModelCreateObject,
    options?: ModelCreatePatternAnyEntityModelOptionalParams
  ): Promise<ModelCreatePatternAnyEntityModelResponse>;
  /**
   * Get all roles for an entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity Id
   * @param options The options parameters.
   */
  listEntityRoles(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListEntityRolesOptionalParams
  ): Promise<ModelListEntityRolesResponse>;
  /**
   * Create an entity role in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity model ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreateEntityRoleOptionalParams
  ): Promise<ModelCreateEntityRoleResponse>;
  /**
   * Get a prebuilt entity's roles in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity Id
   * @param options The options parameters.
   */
  listPrebuiltEntityRoles(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListPrebuiltEntityRolesOptionalParams
  ): Promise<ModelListPrebuiltEntityRolesResponse>;
  /**
   * Create a role for a prebuilt entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity model ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createPrebuiltEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreatePrebuiltEntityRoleOptionalParams
  ): Promise<ModelCreatePrebuiltEntityRoleResponse>;
  /**
   * Get all roles for a list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity Id
   * @param options The options parameters.
   */
  listClosedListEntityRoles(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListClosedListEntityRolesOptionalParams
  ): Promise<ModelListClosedListEntityRolesResponse>;
  /**
   * Create a role for a list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity model ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createClosedListEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreateClosedListEntityRoleOptionalParams
  ): Promise<ModelCreateClosedListEntityRoleResponse>;
  /**
   * Get all roles for a regular expression entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity Id
   * @param options The options parameters.
   */
  listRegexEntityRoles(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListRegexEntityRolesOptionalParams
  ): Promise<ModelListRegexEntityRolesResponse>;
  /**
   * Create a role for an regular expression entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity model ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createRegexEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreateRegexEntityRoleOptionalParams
  ): Promise<ModelCreateRegexEntityRoleResponse>;
  /**
   * Get all roles for a composite entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param options The options parameters.
   */
  listCompositeEntityRoles(
    appId: string,
    versionId: string,
    cEntityId: string,
    options?: ModelListCompositeEntityRolesOptionalParams
  ): Promise<ModelListCompositeEntityRolesResponse>;
  /**
   * Create a role for a composite entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createCompositeEntityRole(
    appId: string,
    versionId: string,
    cEntityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreateCompositeEntityRoleOptionalParams
  ): Promise<ModelCreateCompositeEntityRoleResponse>;
  /**
   * Get all roles for a Pattern.any entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity Id
   * @param options The options parameters.
   */
  listPatternAnyEntityRoles(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListPatternAnyEntityRolesOptionalParams
  ): Promise<ModelListPatternAnyEntityRolesResponse>;
  /**
   * Create a role for an Pattern.any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity model ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createPatternAnyEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreatePatternAnyEntityRoleOptionalParams
  ): Promise<ModelCreatePatternAnyEntityRoleResponse>;
  /**
   * Get all roles for a hierarchical entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param options The options parameters.
   */
  listHierarchicalEntityRoles(
    appId: string,
    versionId: string,
    hEntityId: string,
    options?: ModelListHierarchicalEntityRolesOptionalParams
  ): Promise<ModelListHierarchicalEntityRolesResponse>;
  /**
   * Create a role for an hierarchical entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createHierarchicalEntityRole(
    appId: string,
    versionId: string,
    hEntityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreateHierarchicalEntityRoleOptionalParams
  ): Promise<ModelCreateHierarchicalEntityRoleResponse>;
  /**
   * Get all roles for a prebuilt entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity Id
   * @param options The options parameters.
   */
  listCustomPrebuiltEntityRoles(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelListCustomPrebuiltEntityRolesOptionalParams
  ): Promise<ModelListCustomPrebuiltEntityRolesResponse>;
  /**
   * Create a role for a prebuilt entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity model ID.
   * @param entityRoleCreateObject An entity role object containing the name of role.
   * @param options The options parameters.
   */
  createCustomPrebuiltEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    entityRoleCreateObject: EntityRoleCreateObject,
    options?: ModelCreateCustomPrebuiltEntityRoleOptionalParams
  ): Promise<ModelCreateCustomPrebuiltEntityRoleResponse>;
  /**
   * Get the explicit (exception) list of the pattern.any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The Pattern.Any entity id.
   * @param options The options parameters.
   */
  getExplicitList(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelGetExplicitListOptionalParams
  ): Promise<ModelGetExplicitListResponse>;
  /**
   * Add a new exception to the explicit list for the Pattern.Any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The Pattern.Any entity extractor ID.
   * @param item The new explicit list item.
   * @param options The options parameters.
   */
  addExplicitListItem(
    appId: string,
    versionId: string,
    entityId: string,
    item: ExplicitListItemCreateObject,
    options?: ModelAddExplicitListItemOptionalParams
  ): Promise<ModelAddExplicitListItemResponse>;
  /**
   * Gets information about a regular expression entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param regexEntityId The regular expression entity model ID.
   * @param options The options parameters.
   */
  getRegexEntityInfo(
    appId: string,
    versionId: string,
    regexEntityId: string,
    options?: ModelGetRegexEntityInfoOptionalParams
  ): Promise<ModelGetRegexEntityInfoResponse>;
  /**
   * Updates the regular expression entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param regexEntityId The regular expression entity extractor ID.
   * @param regexEntityUpdateObject An object containing the new entity name and regex pattern.
   * @param options The options parameters.
   */
  updateRegexEntityModel(
    appId: string,
    versionId: string,
    regexEntityId: string,
    regexEntityUpdateObject: RegexModelUpdateObject,
    options?: ModelUpdateRegexEntityModelOptionalParams
  ): Promise<ModelUpdateRegexEntityModelResponse>;
  /**
   * Deletes a regular expression entity from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param regexEntityId The regular expression entity extractor ID.
   * @param options The options parameters.
   */
  deleteRegexEntityModel(
    appId: string,
    versionId: string,
    regexEntityId: string,
    options?: ModelDeleteRegexEntityModelOptionalParams
  ): Promise<ModelDeleteRegexEntityModelResponse>;
  /**
   * Gets information about the Pattern.Any model in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity extractor ID.
   * @param options The options parameters.
   */
  getPatternAnyEntityInfo(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelGetPatternAnyEntityInfoOptionalParams
  ): Promise<ModelGetPatternAnyEntityInfoResponse>;
  /**
   * Updates the name and explicit (exception) list of a Pattern.Any entity model in a version of the
   * application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The Pattern.Any entity extractor ID.
   * @param patternAnyUpdateObject An object containing the explicit list of the Pattern.Any entity.
   * @param options The options parameters.
   */
  updatePatternAnyEntityModel(
    appId: string,
    versionId: string,
    entityId: string,
    patternAnyUpdateObject: PatternAnyModelUpdateObject,
    options?: ModelUpdatePatternAnyEntityModelOptionalParams
  ): Promise<ModelUpdatePatternAnyEntityModelResponse>;
  /**
   * Deletes a Pattern.Any entity extractor from a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The Pattern.Any entity extractor ID.
   * @param options The options parameters.
   */
  deletePatternAnyEntityModel(
    appId: string,
    versionId: string,
    entityId: string,
    options?: ModelDeletePatternAnyEntityModelOptionalParams
  ): Promise<ModelDeletePatternAnyEntityModelResponse>;
  /**
   * Get one role for a given entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelGetEntityRoleOptionalParams
  ): Promise<ModelGetEntityRoleResponse>;
  /**
   * Update a role for a given entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updateEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdateEntityRoleOptionalParams
  ): Promise<ModelUpdateEntityRoleResponse>;
  /**
   * Delete an entity role in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deleteEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelDeleteEntityRoleOptionalParams
  ): Promise<ModelDeleteEntityRoleResponse>;
  /**
   * Get one role for a given prebuilt entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getPrebuiltEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelGetPrebuiltEntityRoleOptionalParams
  ): Promise<ModelGetPrebuiltEntityRoleResponse>;
  /**
   * Update a role for a given prebuilt entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updatePrebuiltEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdatePrebuiltEntityRoleOptionalParams
  ): Promise<ModelUpdatePrebuiltEntityRoleResponse>;
  /**
   * Delete a role in a prebuilt entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deletePrebuiltEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelDeletePrebuiltEntityRoleOptionalParams
  ): Promise<ModelDeletePrebuiltEntityRoleResponse>;
  /**
   * Get one role for a given list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getClosedListEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelGetClosedListEntityRoleOptionalParams
  ): Promise<ModelGetClosedListEntityRoleResponse>;
  /**
   * Update a role for a given list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updateClosedListEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdateClosedListEntityRoleOptionalParams
  ): Promise<ModelUpdateClosedListEntityRoleResponse>;
  /**
   * Delete a role for a given list entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deleteClosedListEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelDeleteClosedListEntityRoleOptionalParams
  ): Promise<ModelDeleteClosedListEntityRoleResponse>;
  /**
   * Get one role for a given regular expression entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getRegexEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelGetRegexEntityRoleOptionalParams
  ): Promise<ModelGetRegexEntityRoleResponse>;
  /**
   * Update a role for a given regular expression entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updateRegexEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdateRegexEntityRoleOptionalParams
  ): Promise<ModelUpdateRegexEntityRoleResponse>;
  /**
   * Delete a role for a given regular expression in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deleteRegexEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelDeleteRegexEntityRoleOptionalParams
  ): Promise<ModelDeleteRegexEntityRoleResponse>;
  /**
   * Get one role for a given composite entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getCompositeEntityRole(
    appId: string,
    versionId: string,
    cEntityId: string,
    roleId: string,
    options?: ModelGetCompositeEntityRoleOptionalParams
  ): Promise<ModelGetCompositeEntityRoleResponse>;
  /**
   * Update a role for a given composite entity in a version of the application
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updateCompositeEntityRole(
    appId: string,
    versionId: string,
    cEntityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdateCompositeEntityRoleOptionalParams
  ): Promise<ModelUpdateCompositeEntityRoleResponse>;
  /**
   * Delete a role for a given composite entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param cEntityId The composite entity extractor ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deleteCompositeEntityRole(
    appId: string,
    versionId: string,
    cEntityId: string,
    roleId: string,
    options?: ModelDeleteCompositeEntityRoleOptionalParams
  ): Promise<ModelDeleteCompositeEntityRoleResponse>;
  /**
   * Get one role for a given Pattern.any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getPatternAnyEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelGetPatternAnyEntityRoleOptionalParams
  ): Promise<ModelGetPatternAnyEntityRoleResponse>;
  /**
   * Update a role for a given Pattern.any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updatePatternAnyEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdatePatternAnyEntityRoleOptionalParams
  ): Promise<ModelUpdatePatternAnyEntityRoleResponse>;
  /**
   * Delete a role for a given Pattern.any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deletePatternAnyEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelDeletePatternAnyEntityRoleOptionalParams
  ): Promise<ModelDeletePatternAnyEntityRoleResponse>;
  /**
   * Get one role for a given hierarchical entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getHierarchicalEntityRole(
    appId: string,
    versionId: string,
    hEntityId: string,
    roleId: string,
    options?: ModelGetHierarchicalEntityRoleOptionalParams
  ): Promise<ModelGetHierarchicalEntityRoleResponse>;
  /**
   * Update a role for a given hierarchical entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updateHierarchicalEntityRole(
    appId: string,
    versionId: string,
    hEntityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdateHierarchicalEntityRoleOptionalParams
  ): Promise<ModelUpdateHierarchicalEntityRoleResponse>;
  /**
   * Delete a role for a given hierarchical role in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param hEntityId The hierarchical entity extractor ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deleteHierarchicalEntityRole(
    appId: string,
    versionId: string,
    hEntityId: string,
    roleId: string,
    options?: ModelDeleteHierarchicalEntityRoleOptionalParams
  ): Promise<ModelDeleteHierarchicalEntityRoleResponse>;
  /**
   * Get one role for a given prebuilt entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId entity ID.
   * @param roleId entity role ID.
   * @param options The options parameters.
   */
  getCustomEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelGetCustomEntityRoleOptionalParams
  ): Promise<ModelGetCustomEntityRoleResponse>;
  /**
   * Update a role for a given prebuilt entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role ID.
   * @param entityRoleUpdateObject The new entity role.
   * @param options The options parameters.
   */
  updateCustomPrebuiltEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    entityRoleUpdateObject: EntityRoleUpdateObject,
    options?: ModelUpdateCustomPrebuiltEntityRoleOptionalParams
  ): Promise<ModelUpdateCustomPrebuiltEntityRoleResponse>;
  /**
   * Delete a role for a given prebuilt entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The entity ID.
   * @param roleId The entity role Id.
   * @param options The options parameters.
   */
  deleteCustomEntityRole(
    appId: string,
    versionId: string,
    entityId: string,
    roleId: string,
    options?: ModelDeleteCustomEntityRoleOptionalParams
  ): Promise<ModelDeleteCustomEntityRoleResponse>;
  /**
   * Get the explicit (exception) list of the pattern.any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The Pattern.Any entity Id.
   * @param itemId The explicit list item Id.
   * @param options The options parameters.
   */
  getExplicitListItem(
    appId: string,
    versionId: string,
    entityId: string,
    itemId: number,
    options?: ModelGetExplicitListItemOptionalParams
  ): Promise<ModelGetExplicitListItemResponse>;
  /**
   * Updates an explicit (exception) list item for a Pattern.Any entity in a version of the application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The Pattern.Any entity extractor ID.
   * @param itemId The explicit list item ID.
   * @param item The new explicit list item.
   * @param options The options parameters.
   */
  updateExplicitListItem(
    appId: string,
    versionId: string,
    entityId: string,
    itemId: number,
    item: ExplicitListItemUpdateObject,
    options?: ModelUpdateExplicitListItemOptionalParams
  ): Promise<ModelUpdateExplicitListItemResponse>;
  /**
   * Delete an item from the explicit (exception) list for a Pattern.any entity in a version of the
   * application.
   * @param appId The application ID.
   * @param versionId The version ID.
   * @param entityId The pattern.any entity id.
   * @param itemId The explicit list item which will be deleted.
   * @param options The options parameters.
   */
  deleteExplicitListItem(
    appId: string,
    versionId: string,
    entityId: string,
    itemId: number,
    options?: ModelDeleteExplicitListItemOptionalParams
  ): Promise<ModelDeleteExplicitListItemResponse>;
}
