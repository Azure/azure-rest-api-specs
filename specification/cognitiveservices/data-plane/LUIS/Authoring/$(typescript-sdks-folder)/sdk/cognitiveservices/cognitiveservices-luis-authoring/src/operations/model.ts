import { Model } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { LuisAuthoringClientContext } from "../luisAuthoringClientContext";
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

/** Class representing a Model. */
export class ModelImpl implements Model {
  private readonly client: LuisAuthoringClientContext;

  /**
   * Initialize a new instance of the class Model class.
   * @param client Reference to the service client
   */
  constructor(client: LuisAuthoringClientContext) {
    this.client = client;
  }

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
  ): Promise<ModelAddIntentResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentCreateObject, options },
      addIntentOperationSpec
    );
  }

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
  ): Promise<ModelListIntentsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listIntentsOperationSpec
    );
  }

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
  ): Promise<ModelAddEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityModelCreateObject, options },
      addEntityOperationSpec
    );
  }

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
  ): Promise<ModelListEntitiesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listEntitiesOperationSpec
    );
  }

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
  ): Promise<ModelListHierarchicalEntitiesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listHierarchicalEntitiesOperationSpec
    );
  }

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
  ): Promise<ModelListCompositeEntitiesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listCompositeEntitiesOperationSpec
    );
  }

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
  ): Promise<ModelListClosedListsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listClosedListsOperationSpec
    );
  }

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
  ): Promise<ModelAddClosedListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, closedListModelCreateObject, options },
      addClosedListOperationSpec
    );
  }

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
  ): Promise<ModelAddPrebuiltResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, prebuiltExtractorNames, options },
      addPrebuiltOperationSpec
    );
  }

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
  ): Promise<ModelListPrebuiltsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listPrebuiltsOperationSpec
    );
  }

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
  ): Promise<ModelListPrebuiltEntitiesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listPrebuiltEntitiesOperationSpec
    );
  }

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
  ): Promise<ModelListModelsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listModelsOperationSpec
    );
  }

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
  ): Promise<ModelExamplesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, modelId, options },
      examplesOperationSpec
    );
  }

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
  ): Promise<ModelGetIntentResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, options },
      getIntentOperationSpec
    );
  }

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
  ): Promise<ModelUpdateIntentResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, modelUpdateObject, options },
      updateIntentOperationSpec
    );
  }

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
  ): Promise<ModelDeleteIntentResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, options },
      deleteIntentOperationSpec
    );
  }

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
  ): Promise<ModelGetEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      getEntityOperationSpec
    );
  }

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
  ): Promise<ModelDeleteEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      deleteEntityOperationSpec
    );
  }

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
  ): Promise<ModelUpdateEntityChildResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityModelUpdateObject, options },
      updateEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelGetIntentFeaturesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, options },
      getIntentFeaturesOperationSpec
    );
  }

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
  ): Promise<ModelReplaceIntentFeaturesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, featureRelationsUpdateObject, options },
      replaceIntentFeaturesOperationSpec
    );
  }

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
  ): Promise<ModelDeleteIntentFeatureResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, featureRelationDeleteObject, options },
      deleteIntentFeatureOperationSpec
    );
  }

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
  ): Promise<ModelGetEntityFeaturesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      getEntityFeaturesOperationSpec
    );
  }

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
  ): Promise<ModelReplaceEntityFeaturesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, featureRelationsUpdateObject, options },
      replaceEntityFeaturesOperationSpec
    );
  }

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
  ): Promise<ModelDeleteEntityFeatureResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, featureRelationDeleteObject, options },
      deleteEntityFeatureOperationSpec
    );
  }

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
  ): Promise<ModelGetHierarchicalEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, options },
      getHierarchicalEntityOperationSpec
    );
  }

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
  ): Promise<ModelUpdateHierarchicalEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, modelUpdateObject, options },
      updateHierarchicalEntityOperationSpec
    );
  }

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
  ): Promise<ModelDeleteHierarchicalEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, options },
      deleteHierarchicalEntityOperationSpec
    );
  }

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
  ): Promise<ModelGetCompositeEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, options },
      getCompositeEntityOperationSpec
    );
  }

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
  ): Promise<ModelUpdateCompositeEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, compositeModelUpdateObject, options },
      updateCompositeEntityOperationSpec
    );
  }

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
  ): Promise<ModelDeleteCompositeEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, options },
      deleteCompositeEntityOperationSpec
    );
  }

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
  ): Promise<ModelGetClosedListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, clEntityId, options },
      getClosedListOperationSpec
    );
  }

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
  ): Promise<ModelUpdateClosedListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, clEntityId, closedListModelUpdateObject, options },
      updateClosedListOperationSpec
    );
  }

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
  ): Promise<ModelPatchClosedListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, clEntityId, closedListModelPatchObject, options },
      patchClosedListOperationSpec
    );
  }

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
  ): Promise<ModelDeleteClosedListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, clEntityId, options },
      deleteClosedListOperationSpec
    );
  }

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
  ): Promise<ModelGetPrebuiltResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, prebuiltId, options },
      getPrebuiltOperationSpec
    );
  }

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
  ): Promise<ModelDeletePrebuiltResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, prebuiltId, options },
      deletePrebuiltOperationSpec
    );
  }

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
  ): Promise<ModelDeleteSubListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, clEntityId, subListId, options },
      deleteSubListOperationSpec
    );
  }

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
  ): Promise<ModelUpdateSubListResponse> {
    return this.client.sendOperationRequest(
      {
        appId,
        versionId,
        clEntityId,
        subListId,
        wordListBaseUpdateObject,
        options
      },
      updateSubListOperationSpec
    );
  }

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
  ): Promise<ModelListIntentSuggestionsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, intentId, options },
      listIntentSuggestionsOperationSpec
    );
  }

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
  ): Promise<ModelListEntitySuggestionsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listEntitySuggestionsOperationSpec
    );
  }

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
  ): Promise<ModelAddSubListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, clEntityId, wordListCreateObject, options },
      addSubListOperationSpec
    );
  }

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
  ): Promise<ModelAddCustomPrebuiltDomainResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, prebuiltDomainObject, options },
      addCustomPrebuiltDomainOperationSpec
    );
  }

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
  ): Promise<ModelAddCustomPrebuiltIntentResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, prebuiltDomainModelCreateObject, options },
      addCustomPrebuiltIntentOperationSpec
    );
  }

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
  ): Promise<ModelListCustomPrebuiltIntentsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listCustomPrebuiltIntentsOperationSpec
    );
  }

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
  ): Promise<ModelAddCustomPrebuiltEntityResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, prebuiltDomainModelCreateObject, options },
      addCustomPrebuiltEntityOperationSpec
    );
  }

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
  ): Promise<ModelListCustomPrebuiltEntitiesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listCustomPrebuiltEntitiesOperationSpec
    );
  }

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
  ): Promise<ModelListCustomPrebuiltModelsResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listCustomPrebuiltModelsOperationSpec
    );
  }

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
  ): Promise<ModelDeleteCustomPrebuiltDomainResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, domainName, options },
      deleteCustomPrebuiltDomainOperationSpec
    );
  }

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
  ): Promise<ModelAddEntityChildResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, childEntityModelCreateObject, options },
      addEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelGetHierarchicalEntityChildResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, hChildId, options },
      getHierarchicalEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelUpdateHierarchicalEntityChildResponse> {
    return this.client.sendOperationRequest(
      {
        appId,
        versionId,
        hEntityId,
        hChildId,
        hierarchicalChildModelUpdateObject,
        options
      },
      updateHierarchicalEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelDeleteHierarchicalEntityChildResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, hChildId, options },
      deleteHierarchicalEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelAddCompositeEntityChildResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, compositeChildModelCreateObject, options },
      addCompositeEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelDeleteCompositeEntityChildResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, cChildId, options },
      deleteCompositeEntityChildOperationSpec
    );
  }

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
  ): Promise<ModelListRegexEntityInfosResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listRegexEntityInfosOperationSpec
    );
  }

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
  ): Promise<ModelCreateRegexEntityModelResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, regexEntityExtractorCreateObj, options },
      createRegexEntityModelOperationSpec
    );
  }

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
  ): Promise<ModelListPatternAnyEntityInfosResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, options },
      listPatternAnyEntityInfosOperationSpec
    );
  }

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
  ): Promise<ModelCreatePatternAnyEntityModelResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, extractorCreateObject, options },
      createPatternAnyEntityModelOperationSpec
    );
  }

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
  ): Promise<ModelListEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreateEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityRoleCreateObject, options },
      createEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListPrebuiltEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listPrebuiltEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreatePrebuiltEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityRoleCreateObject, options },
      createPrebuiltEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListClosedListEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listClosedListEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreateClosedListEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityRoleCreateObject, options },
      createClosedListEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListRegexEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listRegexEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreateRegexEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityRoleCreateObject, options },
      createRegexEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListCompositeEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, options },
      listCompositeEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreateCompositeEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, entityRoleCreateObject, options },
      createCompositeEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListPatternAnyEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listPatternAnyEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreatePatternAnyEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityRoleCreateObject, options },
      createPatternAnyEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListHierarchicalEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, options },
      listHierarchicalEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreateHierarchicalEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, entityRoleCreateObject, options },
      createHierarchicalEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelListCustomPrebuiltEntityRolesResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      listCustomPrebuiltEntityRolesOperationSpec
    );
  }

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
  ): Promise<ModelCreateCustomPrebuiltEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, entityRoleCreateObject, options },
      createCustomPrebuiltEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetExplicitListResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      getExplicitListOperationSpec
    );
  }

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
  ): Promise<ModelAddExplicitListItemResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, item, options },
      addExplicitListItemOperationSpec
    );
  }

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
  ): Promise<ModelGetRegexEntityInfoResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, regexEntityId, options },
      getRegexEntityInfoOperationSpec
    );
  }

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
  ): Promise<ModelUpdateRegexEntityModelResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, regexEntityId, regexEntityUpdateObject, options },
      updateRegexEntityModelOperationSpec
    );
  }

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
  ): Promise<ModelDeleteRegexEntityModelResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, regexEntityId, options },
      deleteRegexEntityModelOperationSpec
    );
  }

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
  ): Promise<ModelGetPatternAnyEntityInfoResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      getPatternAnyEntityInfoOperationSpec
    );
  }

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
  ): Promise<ModelUpdatePatternAnyEntityModelResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, patternAnyUpdateObject, options },
      updatePatternAnyEntityModelOperationSpec
    );
  }

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
  ): Promise<ModelDeletePatternAnyEntityModelResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, options },
      deletePatternAnyEntityModelOperationSpec
    );
  }

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
  ): Promise<ModelGetEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      getEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdateEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, entityRoleUpdateObject, options },
      updateEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeleteEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      deleteEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetPrebuiltEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      getPrebuiltEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdatePrebuiltEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, entityRoleUpdateObject, options },
      updatePrebuiltEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeletePrebuiltEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      deletePrebuiltEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetClosedListEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      getClosedListEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdateClosedListEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, entityRoleUpdateObject, options },
      updateClosedListEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeleteClosedListEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      deleteClosedListEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetRegexEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      getRegexEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdateRegexEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, entityRoleUpdateObject, options },
      updateRegexEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeleteRegexEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      deleteRegexEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetCompositeEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, roleId, options },
      getCompositeEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdateCompositeEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, roleId, entityRoleUpdateObject, options },
      updateCompositeEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeleteCompositeEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, cEntityId, roleId, options },
      deleteCompositeEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetPatternAnyEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      getPatternAnyEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdatePatternAnyEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, entityRoleUpdateObject, options },
      updatePatternAnyEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeletePatternAnyEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      deletePatternAnyEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetHierarchicalEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, roleId, options },
      getHierarchicalEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdateHierarchicalEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, roleId, entityRoleUpdateObject, options },
      updateHierarchicalEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeleteHierarchicalEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, hEntityId, roleId, options },
      deleteHierarchicalEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetCustomEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      getCustomEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelUpdateCustomPrebuiltEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, entityRoleUpdateObject, options },
      updateCustomPrebuiltEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelDeleteCustomEntityRoleResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, roleId, options },
      deleteCustomEntityRoleOperationSpec
    );
  }

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
  ): Promise<ModelGetExplicitListItemResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, itemId, options },
      getExplicitListItemOperationSpec
    );
  }

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
  ): Promise<ModelUpdateExplicitListItemResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, itemId, item, options },
      updateExplicitListItemOperationSpec
    );
  }

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
  ): Promise<ModelDeleteExplicitListItemResponse> {
    return this.client.sendOperationRequest(
      { appId, versionId, entityId, itemId, options },
      deleteExplicitListItemOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const addIntentOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.intentCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listIntentsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "IntentClassifier" }
          }
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
const addEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityModelCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listEntitiesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "NDepthEntityExtractor" }
          }
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
const listHierarchicalEntitiesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/hierarchicalentities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "HierarchicalEntityExtractor"
            }
          }
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
const listCompositeEntitiesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/compositeentities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "CompositeEntityExtractor" }
          }
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
const listClosedListsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ClosedListEntityExtractor" }
          }
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
const addClosedListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.closedListModelCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const addPrebuiltOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/prebuilts",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "PrebuiltEntityExtractor" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.prebuiltExtractorNames,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listPrebuiltsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/prebuilts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "PrebuiltEntityExtractor" }
          }
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
const listPrebuiltEntitiesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/listprebuilts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "AvailablePrebuiltEntityModel"
            }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const listModelsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/models",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ModelInfoResponse" }
          }
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
const examplesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/models/{modelId}/examples",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "LabelTextObject" } }
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
    Parameters.modelId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getIntentOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IntentClassifier
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateIntentOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.modelUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteIntentOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.deleteUtterances],
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NDepthEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}",
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
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateEntityChildOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityModelUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getIntentFeaturesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}/features",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ModelFeatureInformation" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const replaceIntentFeaturesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}/features",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.featureRelationsUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteIntentFeatureOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}/features",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.featureRelationDeleteObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getEntityFeaturesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/features",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ModelFeatureInformation" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const replaceEntityFeaturesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/features",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.featureRelationsUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteEntityFeatureOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/features",
  httpMethod: "DELETE",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.featureRelationDeleteObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getHierarchicalEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.HierarchicalEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateHierarchicalEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.modelUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteHierarchicalEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}",
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
    Parameters.hEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getCompositeEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.CompositeEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateCompositeEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.compositeModelUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteCompositeEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}",
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
    Parameters.cEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getClosedListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ClosedListEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.clEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateClosedListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.closedListModelUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.clEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const patchClosedListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.closedListModelPatchObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.clEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteClosedListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}",
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
    Parameters.clEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getPrebuiltOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/prebuilts/{prebuiltId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrebuiltEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.prebuiltId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deletePrebuiltOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/prebuilts/{prebuiltId}",
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
    Parameters.prebuiltId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteSubListOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}/sublists/{subListId}",
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
    Parameters.clEntityId,
    Parameters.subListId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateSubListOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}/sublists/{subListId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.wordListBaseUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.clEntityId,
    Parameters.subListId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listIntentSuggestionsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/intents/{intentId}/suggest",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "IntentsSuggestionExample" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.take, Parameters.enableNestedChildren],
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.intentId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listEntitySuggestionsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/suggest",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "EntitiesSuggestionExample" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.take, Parameters.enableNestedChildren],
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const addSubListOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{clEntityId}/sublists",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Number" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.wordListCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.clEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const addCustomPrebuiltDomainOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltdomains",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: {
        type: { name: "Sequence", element: { type: { name: "Uuid" } } }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.prebuiltDomainObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const addCustomPrebuiltIntentOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltintents",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.prebuiltDomainModelCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listCustomPrebuiltIntentsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltintents",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "IntentClassifier" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const addCustomPrebuiltEntityOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltentities",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.prebuiltDomainModelCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listCustomPrebuiltEntitiesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltentities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityExtractor" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const listCustomPrebuiltModelsOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltmodels",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "CustomPrebuiltModel" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteCustomPrebuiltDomainOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/customprebuiltdomains/{domainName}",
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
    Parameters.domainName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const addEntityChildOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/children",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.childEntityModelCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getHierarchicalEntityChildOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/children/{hChildId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.HierarchicalChildEntity
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId,
    Parameters.hChildId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateHierarchicalEntityChildOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/children/{hChildId}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.hierarchicalChildModelUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId,
    Parameters.hChildId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteHierarchicalEntityChildOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/children/{hChildId}",
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
    Parameters.hEntityId,
    Parameters.hChildId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const addCompositeEntityChildOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/children",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.compositeChildModelCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteCompositeEntityChildOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/children/{cChildId}",
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
    Parameters.cEntityId,
    Parameters.cChildId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listRegexEntityInfosOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "RegexEntityExtractor" }
          }
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
const createRegexEntityModelOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.regexEntityExtractorCreateObj,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listPatternAnyEntityInfosOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternanyentities",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "PatternAnyEntityExtractor" }
          }
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
const createPatternAnyEntityModelOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternanyentities",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.extractorCreateObject,
  urlParameters: [Parameters.endpoint, Parameters.appId, Parameters.versionId],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listEntityRolesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listPrebuiltEntityRolesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/prebuilts/{entityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createPrebuiltEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/prebuilts/{entityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listClosedListEntityRolesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{entityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createClosedListEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/closedlists/{entityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listRegexEntityRolesOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities/{entityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createRegexEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities/{entityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listCompositeEntityRolesOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createCompositeEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listPatternAnyEntityRolesOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createPatternAnyEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listHierarchicalEntityRolesOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createHierarchicalEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const listCustomPrebuiltEntityRolesOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/customprebuiltentities/{entityId}/roles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: { type: { name: "Composite", className: "EntityRole" } }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createCustomPrebuiltEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/customprebuiltentities/{entityId}/roles",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Uuid" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleCreateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getExplicitListOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/explicitlist",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: {
          name: "Sequence",
          element: {
            type: { name: "Composite", className: "ExplicitListItem" }
          }
        }
      }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const addExplicitListItemOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/explicitlist",
  httpMethod: "POST",
  responses: {
    201: {
      bodyMapper: { type: { name: "Number" } }
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.item,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const getRegexEntityInfoOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities/{regexEntityId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RegexEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.regexEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateRegexEntityModelOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities/{regexEntityId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.regexEntityUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.regexEntityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteRegexEntityModelOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/regexentities/{regexEntityId}",
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
    Parameters.regexEntityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getPatternAnyEntityInfoOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PatternAnyEntityExtractor
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePatternAnyEntityModelOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.patternAnyUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deletePatternAnyEntityModelOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}",
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
    Parameters.entityId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteEntityRoleOperationSpec: coreClient.OperationSpec = {
  path: "/apps/{appId}/versions/{versionId}/entities/{entityId}/roles/{roleId}",
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
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getPrebuiltEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/prebuilts/{entityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePrebuiltEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/prebuilts/{entityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deletePrebuiltEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/prebuilts/{entityId}/roles/{roleId}",
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
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getClosedListEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/closedlists/{entityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateClosedListEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/closedlists/{entityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteClosedListEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/closedlists/{entityId}/roles/{roleId}",
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
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getRegexEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/regexentities/{entityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateRegexEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/regexentities/{entityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteRegexEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/regexentities/{entityId}/roles/{roleId}",
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
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getCompositeEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateCompositeEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.cEntityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteCompositeEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/compositeentities/{cEntityId}/roles/{roleId}",
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
    Parameters.cEntityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getPatternAnyEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePatternAnyEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deletePatternAnyEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/roles/{roleId}",
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
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getHierarchicalEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateHierarchicalEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.hEntityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteHierarchicalEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/hierarchicalentities/{hEntityId}/roles/{roleId}",
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
    Parameters.hEntityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getCustomEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/customprebuiltentities/{entityId}/roles/{roleId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EntityRole
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateCustomPrebuiltEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/customprebuiltentities/{entityId}/roles/{roleId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.entityRoleUpdateObject,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteCustomEntityRoleOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/customprebuiltentities/{entityId}/roles/{roleId}",
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
    Parameters.entityId,
    Parameters.roleId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getExplicitListItemOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/explicitlist/{itemId}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExplicitListItem
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.itemId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateExplicitListItemOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/explicitlist/{itemId}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.OperationStatus
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.item1,
  urlParameters: [
    Parameters.endpoint,
    Parameters.appId,
    Parameters.versionId,
    Parameters.entityId,
    Parameters.itemId
  ],
  headerParameters: [Parameters.contentType, Parameters.accept],
  mediaType: "json",
  serializer
};
const deleteExplicitListItemOperationSpec: coreClient.OperationSpec = {
  path:
    "/apps/{appId}/versions/{versionId}/patternanyentities/{entityId}/explicitlist/{itemId}",
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
    Parameters.entityId,
    Parameters.itemId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
