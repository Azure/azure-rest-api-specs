import * as coreClient from "@azure/core-client";

/** Object model for creating a phraselist model. */
export interface PhraselistCreateObject {
  /** List of comma-separated phrases that represent the Phraselist. */
  phrases?: string;
  /** The Phraselist name. */
  name?: string;
  /** An interchangeable phrase list feature serves as a list of synonyms for training. A non-exchangeable phrase list serves as separate features for training. So, if your non-interchangeable phrase list contains 5 phrases, they will be mapped to 5 separate features. You can think of the non-interchangeable phrase list as an additional bag of words to add to LUIS existing vocabulary features. It is used as a lexicon lookup feature where its value is 1 if the lexicon contains a given word or 0 if it doesn’t.  Default value is true. */
  isExchangeable?: boolean;
  /** Indicates if the Phraselist is enabled for all models in the application. */
  enabledForAllModels?: boolean;
}

/** Error response when invoking an operation on the API. */
export interface ErrorResponse {
  /** Describes unknown properties. The value of an unknown property can be of "any" type. */
  [property: string]: any;
  errorType?: string;
}

/** The base class Features-related response objects inherit from. */
export interface FeatureInfoObject {
  /** A six-digit ID used for Features. */
  id?: number;
  /** The name of the Feature. */
  name?: string;
  /** Indicates if the feature is enabled. */
  isActive?: boolean;
  /** Indicates if the feature is enabled for all models in the application. */
  enabledForAllModels?: boolean;
}

/** Model Features, including Patterns and Phraselists. */
export interface FeaturesResponseObject {
  /** List of Phraselist Features. */
  phraselistFeatures?: PhraseListFeatureInfo[];
  /** List of Pattern features. */
  patternFeatures?: PatternFeatureInfo[];
}

/** Object model for updating a Phraselist. */
export interface PhraselistUpdateObject {
  /** List of comma-separated phrases that represent the Phraselist. */
  phrases?: string;
  /** The Phraselist name. */
  name?: string;
  /** Indicates if the Phraselist is enabled. */
  isActive?: boolean;
  /** An exchangeable phrase list feature are serves as single feature to the LUIS underlying training algorithm. It is used as a lexicon lookup feature where its value is 1 if the lexicon contains a given word or 0 if it doesn’t. Think of an exchangeable as a synonyms list. A non-exchangeable phrase list feature has all the phrases in the list serve as separate features to the underlying training algorithm. So, if you your phrase list feature contains 5 phrases, they will be mapped to 5 separate features. You can think of the non-exchangeable phrase list feature as an additional bag of words that you are willing to add to LUIS existing vocabulary features. Think of a non-exchangeable as set of different words. Default value is true. */
  isExchangeable?: boolean;
  /** Indicates if the Phraselist is enabled for all models in the application. */
  enabledForAllModels?: boolean;
}

/** Response of an Operation status. */
export interface OperationStatus {
  /** Status Code. */
  code?: OperationStatusType;
  /** Status details. */
  message?: string;
}

/** A labeled example utterance. */
export interface ExampleLabelObject {
  /** The example utterance. */
  text?: string;
  /** The identified entities within the example utterance. */
  entityLabels?: EntityLabelObject[];
  /** The identified intent representing the example utterance. */
  intentName?: string;
}

/** Defines the entity type and position of the extracted entity within the example. */
export interface EntityLabelObject {
  /** The entity type. */
  entityName: string;
  /** The index within the utterance where the extracted entity starts. */
  startCharIndex: number;
  /** The index within the utterance where the extracted entity ends. */
  endCharIndex: number;
  /** The role the entity plays in the utterance. */
  role?: string;
  /** The identified entities within the example utterance. */
  children?: EntityLabelObject[];
}

/** Response when adding a labeled example utterance. */
export interface LabelExampleResponse {
  /** The example utterance. */
  utteranceText?: string;
  /** The newly created sample ID. */
  exampleId?: number;
}

/** Response when adding a batch of labeled example utterances. */
export interface BatchLabelExample {
  /** Response when adding a labeled example utterance. */
  value?: LabelExampleResponse;
  hasError?: boolean;
  /** Response of an Operation status. */
  error?: OperationStatus;
}

/** A prediction and label pair of an example. */
export interface LabeledUtterance {
  /** ID of Labeled Utterance. */
  id?: number;
  /** The utterance. For example, "What's the weather like in seattle?" */
  text?: string;
  /** The utterance tokenized. */
  tokenizedText?: string[];
  /** The intent matching the example. */
  intentLabel?: string;
  /** The entities matching the example. */
  entityLabels?: EntityLabel[];
  /** List of suggested intents. */
  intentPredictions?: IntentPrediction[];
  /** List of suggested entities. */
  entityPredictions?: EntityPrediction[];
}

/** Defines the entity type and position of the extracted entity within the example. */
export interface EntityLabel {
  /** The entity type. */
  entityName: string;
  /** The index within the utterance where the extracted entity starts. */
  startTokenIndex: number;
  /** The index within the utterance where the extracted entity ends. */
  endTokenIndex: number;
  /** The role of the predicted entity. */
  role?: string;
  /** The role id for the predicted entity. */
  roleId?: string;
  children?: EntityLabel[];
}

/** A suggested intent. */
export interface IntentPrediction {
  /** The intent's name */
  name?: string;
  /** The intent's score, based on the prediction model. */
  score?: number;
}

/** A suggested entity. */
export interface EntityPrediction {
  /** The entity's name */
  entityName: string;
  /** The index within the utterance where the extracted entity starts. */
  startTokenIndex: number;
  /** The index within the utterance where the extracted entity ends. */
  endTokenIndex: number;
  /** The actual token(s) that comprise the entity. */
  phrase: string;
  children?: EntityPrediction[];
}

/** Object model for creating a new entity extractor. */
export interface ModelCreateObject {
  /** Name of the new entity extractor. */
  name?: string;
}

/** Base type used in entity types. */
export interface ModelInfo {
  /** The ID of the Entity Model. */
  id: string;
  /** Name of the Entity Model. */
  name?: string;
  /** The type ID of the Entity Model. */
  typeId?: number;
  /** Full name of the entity type. */
  readableType: ReadableType;
}

/** An entity extractor create object. */
export interface EntityModelCreateObject {
  /** Child entities. */
  children?: ChildEntityModelCreateObject[];
  /** Entity name. */
  name?: string;
}

/** A child entity extractor create object. */
export interface ChildEntityModelCreateObject {
  /** Child entities. */
  children?: ChildEntityModelCreateObject[];
  /** Entity name. */
  name?: string;
  /** The instance of model name */
  instanceOf?: string;
}

/** The base child entity type. */
export interface ChildEntity {
  /** The ID (GUID) belonging to a child entity. */
  id: string;
  /** The name of a child entity. */
  name?: string;
  /** Instance of Model. */
  instanceOf?: string;
  /** The type ID of the Entity Model. */
  typeId?: number;
  /** Full name of the entity type. */
  readableType?: ReadableType;
  /** List of children */
  children?: ChildEntity[];
}

/** Sublist of items for a list entity. */
export interface SubClosedList {
  /** The standard form that the list represents. */
  canonicalForm?: string;
  /** List of synonym words. */
  list?: string[];
}

/** Object model for creating a list entity. */
export interface ClosedListModelCreateObject {
  /** Sublists for the feature. */
  subLists?: WordListObject[];
  /** Name of the list entity. */
  name?: string;
}

/** Sublist of items for a list entity. */
export interface WordListObject {
  /** The standard form that the list represents. */
  canonicalForm?: string;
  /** List of synonym words. */
  list?: string[];
}

/** Available Prebuilt entity model for using in an application. */
export interface AvailablePrebuiltEntityModel {
  /** The entity name. */
  name?: string;
  /** The entity description and usage information. */
  description?: string;
  /** Usage examples. */
  examples?: string;
}

/** Explicit (exception) list item */
export interface ExplicitListItem {
  /** The explicit list item ID. */
  id?: number;
  /** The explicit list item value. */
  explicitListItem?: string;
}

/** An object containing the example utterance's text. */
export interface LabelTextObject {
  /** The ID of the Label. */
  id?: number;
  /** The text of the label. */
  text?: string;
}

/** Object model for updating an intent classifier. */
export interface ModelUpdateObject {
  /** The entity's new name. */
  name?: string;
}

/** An entity extractor update object. */
export interface EntityModelUpdateObject {
  /** Entity name. */
  name?: string;
  /** The instance of model name */
  instanceOf?: string;
}

/** An object containing the model feature information either the model name or feature name. */
export interface ModelFeatureInformation {
  /** The name of the model used. */
  modelName?: string;
  /** The name of the feature used. */
  featureName?: string;
  isRequired?: boolean;
}

/** A composite entity extractor. */
export interface CompositeEntityModel {
  /** Child entities. */
  children?: string[];
  /** Entity name. */
  name?: string;
}

/** Object model for updating a list entity. */
export interface ClosedListModelUpdateObject {
  /** The new sublists for the feature. */
  subLists?: WordListObject[];
  /** The new name of the list entity. */
  name?: string;
}

/** Object model for adding a batch of sublists to an existing list entity. */
export interface ClosedListModelPatchObject {
  /** Sublists to add. */
  subLists?: WordListObject[];
}

/** Object model for updating one of the list entity's sublists. */
export interface WordListBaseUpdateObject {
  /** The standard form that the list represents. */
  canonicalForm?: string;
  /** List of synonym words. */
  list?: string[];
}

/** Predicted/suggested intent. */
export interface IntentsSuggestionExample {
  /** The utterance. For example, "What's the weather like in seattle?" */
  text?: string;
  /** The tokenized utterance. */
  tokenizedText?: string[];
  /** Predicted/suggested intents. */
  intentPredictions?: IntentPrediction[];
  /** Predicted/suggested entities. */
  entityPredictions?: EntityPrediction[];
}

/** Predicted/suggested entity. */
export interface EntitiesSuggestionExample {
  /** The utterance. For example, "What's the weather like in seattle?" */
  text?: string;
  /** The utterance tokenized. */
  tokenizedText?: string[];
  /** Predicted/suggested intents. */
  intentPredictions?: IntentPrediction[];
  /** Predicted/suggested entities. */
  entityPredictions?: EntityPrediction[];
}

/** Properties for creating a new LUIS Application */
export interface ApplicationCreateObject {
  /** The culture for the new application. It is the language that your app understands and speaks. E.g.: "en-us". Note: the culture cannot be changed after the app is created. */
  culture: string;
  /** The domain for the new application. Optional. E.g.: Comics. */
  domain?: string;
  /** Description of the new application. Optional. */
  description?: string;
  /** The initial version ID. Optional. Default value is: "0.1" */
  initialVersionId?: string;
  /** Defines the scenario for the new application. Optional. E.g.: IoT. */
  usageScenario?: string;
  /** The name for the new application. */
  name: string;
}

/** Response containing the Application Info. */
export interface ApplicationInfoResponse {
  /** The ID (GUID) of the application. */
  id?: string;
  /** The name of the application. */
  name?: string;
  /** The description of the application. */
  description?: string;
  /** The culture of the application. For example, "en-us". */
  culture?: string;
  /** Defines the scenario for the new application. Optional. For example, IoT. */
  usageScenario?: string;
  /** The domain for the new application. Optional. For example, Comics. */
  domain?: string;
  /** Amount of model versions within the application. */
  versionsCount?: number;
  /** The version's creation timestamp. */
  createdDateTime?: string;
  /** The Runtime endpoint URL for this model version. */
  endpoints?: Record<string, unknown>;
  /** Number of calls made to this endpoint. */
  endpointHitsCount?: number;
  /** The version ID currently marked as active. */
  activeVersion?: string;
}

/** Exported Model - An exported LUIS Application. */
export interface LuisApp {
  /** Describes unknown properties. The value of an unknown property can be of "any" type. */
  [property: string]: any;
  /** The name of the application. */
  name?: string;
  /** The version ID of the application that was exported. */
  versionId?: string;
  /** The description of the application. */
  desc?: string;
  /** The culture of the application. E.g.: en-us. */
  culture?: string;
  /** List of intents. */
  intents?: HierarchicalModel[];
  /** List of entities. */
  entities?: HierarchicalModel[];
  /** List of list entities. */
  closedLists?: ClosedList[];
  /** List of composite entities. */
  composites?: HierarchicalModel[];
  /** List of hierarchical entities. */
  hierarchicals?: HierarchicalModel[];
  /** List of Pattern.Any entities. */
  patternAnyEntities?: PatternAny[];
  /** List of regular expression entities. */
  regexEntities?: RegexEntity[];
  /** List of prebuilt entities. */
  prebuiltEntities?: PrebuiltEntity[];
  /** List of pattern features. */
  regexFeatures?: JsonRegexFeature[];
  /** List of model features. */
  phraselists?: JsonModelFeature[];
  /** List of patterns. */
  patterns?: PatternRule[];
  /** List of example utterances. */
  utterances?: JsonUtterance[];
}

export interface HierarchicalModel {
  name?: string;
  children?: JsonChild[];
  features?: JsonModelFeatureInformation[];
  roles?: string[];
  inherits?: PrebuiltDomainObject;
}

export interface JsonChild {
  name?: string;
  instanceOf?: string;
  children?: JsonChild[];
  features?: JsonModelFeatureInformation[];
}

/** An object containing the model feature information either the model name or feature name. */
export interface JsonModelFeatureInformation {
  /** The name of the model used. */
  modelName?: string;
  /** The name of the feature used. */
  featureName?: string;
}

export interface PrebuiltDomainObject {
  domainName?: string;
  modelName?: string;
}

/** Exported Model - A list entity. */
export interface ClosedList {
  /** Name of the list entity. */
  name?: string;
  /** Sublists for the list entity. */
  subLists?: SubClosedList[];
  roles?: string[];
}

/** Pattern.Any Entity Extractor. */
export interface PatternAny {
  name?: string;
  explicitList?: string[];
  roles?: string[];
}

/** Regular Expression Entity Extractor. */
export interface RegexEntity {
  name?: string;
  regexPattern?: string;
  roles?: string[];
}

/** Prebuilt Entity Extractor. */
export interface PrebuiltEntity {
  name?: string;
  roles?: string[];
}

/** Exported Model - A Pattern feature. */
export interface JsonRegexFeature {
  /** The Regular Expression to match. */
  pattern?: string;
  /** Indicates if the Pattern feature is enabled. */
  activated?: boolean;
  /** Name of the feature. */
  name?: string;
}

/** Exported Model - Phraselist Model Feature. */
export interface JsonModelFeature {
  /** Indicates if the feature is enabled. */
  activated?: boolean;
  /** The Phraselist name. */
  name?: string;
  /** List of comma-separated phrases that represent the Phraselist. */
  words?: string;
  /** An interchangeable phrase list feature serves as a list of synonyms for training. A non-exchangeable phrase list serves as separate features for training. So, if your non-interchangeable phrase list contains 5 phrases, they will be mapped to 5 separate features. You can think of the non-interchangeable phrase list as an additional bag of words to add to LUIS existing vocabulary features. It is used as a lexicon lookup feature where its value is 1 if the lexicon contains a given word or 0 if it doesn’t.  Default value is true. */
  mode?: boolean;
  /** Indicates if the Phraselist is enabled for all models in the application. */
  enabledForAllModels?: boolean;
}

/** Pattern */
export interface PatternRule {
  /** The pattern text. */
  pattern?: string;
  /** The intent's name where the pattern belongs to. */
  intent?: string;
}

/** Exported Model - Utterance that was used to train the model. */
export interface JsonUtterance {
  /** The utterance. */
  text?: string;
  /** The matched intent. */
  intent?: string;
  /** The matched entities. */
  entities?: JsonEntity[];
}

/** Exported Model - Extracted Entity from utterance. */
export interface JsonEntity {
  /** The index within the utterance where the extracted entity starts. */
  startPos: number;
  /** The index within the utterance where the extracted entity ends. */
  endPos: number;
  /** The entity name. */
  entity: string;
  /** The role the entity plays in the utterance. */
  role?: string;
  children?: JsonEntity[];
}

/** Response containing user's endpoint keys and the endpoint URLs of the prebuilt Cortana applications. */
export interface PersonalAssistantsResponse {
  /** An a array of GUIDs, comprised of Azure Endpoint Keys and the Authoring API key. */
  endpointKeys?: string[];
  /** Endpoint URLs for prebuilt Cortana applications. */
  endpointUrls?: { [propertyName: string]: string };
}

/** Available culture for using in a new application. */
export interface AvailableCulture {
  /** The language name. */
  name?: string;
  /** The ISO value for the language. */
  code?: string;
}

/** Object model for updating the name or description of an application. */
export interface ApplicationUpdateObject {
  /** The application's new name. */
  name?: string;
  /** The application's new description. */
  description?: string;
}

/** Object model for cloning an application's version. */
export interface TaskUpdateObject {
  /** The new version for the cloned model. */
  version?: string;
}

/** Object model for publishing a specific application version. */
export interface ApplicationPublishObject {
  /** The version ID to publish. */
  versionId?: string;
  /** Indicates if the staging slot should be used, instead of the Production one. */
  isStaging?: boolean;
}

/** The base class "ProductionOrStagingEndpointInfo" inherits from. */
export interface EndpointInfo {
  /** The version ID to publish. */
  versionId?: string;
  /** Indicates if the staging slot should be used, instead of the Production one. */
  isStaging?: boolean;
  /** The Runtime endpoint URL for this model version. */
  endpointUrl?: string;
  /** The target region that the application is published to. */
  region?: string;
  /** The endpoint key. */
  assignedEndpointKey?: string;
  /** The endpoint's region. */
  endpointRegion?: string;
  /** Regions where publishing failed. */
  failedRegions?: string;
  /** Timestamp when was last published. */
  publishedDateTime?: string;
}

/** Object model of an application version. */
export interface VersionInfo {
  /** The version ID. E.g.: "0.1" */
  version: string;
  /** The version's creation timestamp. */
  createdDateTime?: Date;
  /** Timestamp of the last update. */
  lastModifiedDateTime?: Date;
  /** Timestamp of the last time the model was trained. */
  lastTrainedDateTime?: Date;
  /** Timestamp when was last published. */
  lastPublishedDateTime?: Date;
  /** The Runtime endpoint URL for this model version. */
  endpointUrl?: string;
  /** The endpoint key. */
  assignedEndpointKey?: { [propertyName: string]: string };
  /** External keys. */
  externalApiKeys?: Record<string, unknown>;
  /** Number of intents in this model. */
  intentsCount?: number;
  /** Number of entities in this model. */
  entitiesCount?: number;
  /** Number of calls made to this endpoint. */
  endpointHitsCount?: number;
  /** The current training status. */
  trainingStatus: TrainingStatus;
}

/** Response model when requesting to train the model. */
export interface EnqueueTrainingResponse {
  /** The train request status ID. */
  statusId?: number;
  /** The current training status. */
  status?: TrainingStatus;
}

/** Model Training Info. */
export interface ModelTrainingInfo {
  /** The ID (GUID) of the model. */
  modelId?: string;
  /** Model Training Details. */
  details?: ModelTrainingDetails;
}

/** Model Training Details. */
export interface ModelTrainingDetails {
  /** The train request status ID. */
  statusId?: number;
  /** The current training status. */
  status?: TrainingStatus;
  /** The count of examples used to train the model. */
  exampleCount?: number;
  /** When the model was trained. */
  trainingDateTime?: Date;
  /** Reason for the training failure. */
  failureReason?: string;
}

/** The application settings. */
export interface ApplicationSettings {
  /** The application ID. */
  id: string;
  /** Setting your application as public allows other people to use your application's endpoint using their own keys for billing purposes. */
  isPublic: boolean;
}

/** Object model for updating an application's settings. */
export interface ApplicationSettingUpdateObject {
  /** Setting your application as public allows other people to use your application's endpoint using their own keys. */
  isPublic?: boolean;
}

/** The application publish settings. */
export interface PublishSettings {
  /** The application ID. */
  id: string;
  /** Setting sentiment analysis as true returns the sentiment of the input utterance along with the response */
  isSentimentAnalysisEnabled: boolean;
  /** Enables speech priming in your app */
  isSpeechEnabled: boolean;
  /** Enables spell checking of the utterance. */
  isSpellCheckerEnabled: boolean;
}

/** Object model for updating an application's publish settings. */
export interface PublishSettingUpdateObject {
  /** Setting sentiment analysis as true returns the Sentiment of the input utterance along with the response */
  sentimentAnalysis?: boolean;
  /** Setting speech as public enables speech priming in your app */
  speech?: boolean;
  /** Setting spell checker as public enables spell checking the input utterance. */
  spellChecker?: boolean;
}

/** A model object containing the name of the custom prebuilt entity and the name of the domain to which this model belongs. */
export interface PrebuiltDomainCreateBaseObject {
  /** The domain name. */
  domainName?: string;
}

/** A model object containing the name of the custom prebuilt intent or entity and the name of the domain to which this model belongs. */
export interface PrebuiltDomainModelCreateObject {
  /** The domain name. */
  domainName?: string;
  /** The intent name or entity name. */
  modelName?: string;
}

/** Prebuilt Domain. */
export interface PrebuiltDomain {
  name?: string;
  culture?: string;
  description?: string;
  examples?: string;
  intents?: PrebuiltDomainItem[];
  entities?: PrebuiltDomainItem[];
}

export interface PrebuiltDomainItem {
  name?: string;
  description?: string;
  examples?: string;
}

/** A prebuilt domain create object containing the name and culture of the domain. */
export interface PrebuiltDomainCreateObject {
  /** The domain name. */
  domainName?: string;
  /** The culture of the new domain. */
  culture?: string;
}

export interface Paths9Fb7ZdAppsAppidVersionsVersionidHierarchicalentitiesHentityidChildrenHchildidPatchRequestbodyContentApplicationJsonSchema {
  name?: string;
}

export interface PathsZk9C4BAppsAppidVersionsVersionidCompositeentitiesCentityidChildrenPostRequestbodyContentApplicationJsonSchema {
  name?: string;
}

/** Model object for creating a regular expression entity model. */
export interface RegexModelCreateObject {
  /** The regular expression entity pattern. */
  regexPattern?: string;
  /** The model name. */
  name?: string;
}

/** Model object for creating a Pattern.Any entity model. */
export interface PatternAnyModelCreateObject {
  /** The model name. */
  name?: string;
  /** The Pattern.Any explicit list. */
  explicitList?: string[];
}

/** Entity extractor role */
export interface EntityRole {
  /** The entity role ID. */
  id?: string;
  /** The entity role name. */
  name?: string;
}

/** Object model for creating an entity role. */
export interface EntityRoleCreateObject {
  /** The entity role name. */
  name?: string;
}

/** Object model for creating an explicit (exception) list item. */
export interface ExplicitListItemCreateObject {
  /** The explicit list item. */
  explicitListItem?: string;
}

/** Model object for updating a regular expression entity model. */
export interface RegexModelUpdateObject {
  /** The regular expression entity pattern. */
  regexPattern?: string;
  /** The model name. */
  name?: string;
}

/** Model object for updating a Pattern.Any entity model. */
export interface PatternAnyModelUpdateObject {
  /** The model name. */
  name?: string;
  /** The Pattern.Any explicit list. */
  explicitList?: string[];
}

/** Object model for updating an entity role. */
export interface EntityRoleUpdateObject {
  /** The entity role name. */
  name?: string;
}

/** Model object for updating an explicit (exception) list item. */
export interface ExplicitListItemUpdateObject {
  /** The explicit list item. */
  explicitListItem?: string;
}

/** Object model for creating a pattern */
export interface PatternRuleCreateObject {
  /** The pattern text. */
  pattern?: string;
  /** The intent's name which the pattern belongs to. */
  intent?: string;
}

/** Pattern rule */
export interface PatternRuleInfo {
  /** The pattern ID. */
  id?: string;
  /** The pattern text. */
  pattern?: string;
  /** The intent's name where the pattern belongs to. */
  intent?: string;
}

/** Object model for updating a pattern. */
export interface PatternRuleUpdateObject {
  /** The pattern ID. */
  id?: string;
  /** The pattern text. */
  pattern?: string;
  /** The intent's name which the pattern belongs to. */
  intent?: string;
}

/** Object model of an application version setting. */
export interface AppVersionSettingObject {
  /** The application version setting name. */
  name?: string;
  /** The application version setting value. */
  value?: string;
}

/** Defines the Azure account information object. */
export interface AzureAccountInfoObject {
  /** The id for the Azure subscription. */
  azureSubscriptionId: string;
  /** The Azure resource group name. */
  resourceGroup: string;
  /** The Azure account name. */
  accountName: string;
}

/** Exported Model - An exported LUIS Application. */
export interface LuisAppV2 {
  /** Describes unknown properties. The value of an unknown property can be of "any" type. */
  [property: string]: any;
  /** Luis schema deserialization version. */
  luisSchemaVersion?: string;
  /** The name of the application. */
  name?: string;
  /** The version ID of the application that was exported. */
  versionId?: string;
  /** The description of the application. */
  desc?: string;
  /** The culture of the application. E.g.: en-us. */
  culture?: string;
  /** List of intents. */
  intents?: HierarchicalModelV2[];
  /** List of entities. */
  entities?: HierarchicalModelV2[];
  /** List of list entities. */
  closedLists?: ClosedList[];
  /** List of composite entities. */
  composites?: HierarchicalModelV2[];
  /** List of Pattern.Any entities. */
  patternAnyEntities?: PatternAny[];
  /** List of regular expression entities. */
  regexEntities?: RegexEntity[];
  /** List of prebuilt entities. */
  prebuiltEntities?: PrebuiltEntity[];
  /** List of pattern features. */
  regexFeatures?: JsonRegexFeature[];
  /** List of model features. */
  modelFeatures?: JsonModelFeature[];
  /** List of patterns. */
  patterns?: PatternRule[];
  /** List of example utterances. */
  utterances?: JsonUtterance[];
}

export interface HierarchicalModelV2 {
  name?: string;
  children?: string[];
  inherits?: PrebuiltDomainObject;
  roles?: string[];
}

/** List of user permissions. */
export interface UserAccessList {
  /** The email address of owner of the application. */
  owner?: string;
  emails?: string[];
}

export interface UserCollaborator {
  /** The email address of the user. */
  email?: string;
}

export interface CollaboratorsArray {
  /** The email address of the users. */
  emails?: string[];
}

/** Operation error details when invoking an operation on the API. */
export interface OperationError {
  code?: string;
  message?: string;
}

/** Phraselist Feature. */
export type PhraseListFeatureInfo = FeatureInfoObject & {
  /** A list of comma-separated values. */
  phrases?: string;
  /** An exchangeable phrase list feature are serves as single feature to the LUIS underlying training algorithm. It is used as a lexicon lookup feature where its value is 1 if the lexicon contains a given word or 0 if it doesn’t. Think of an exchangeable as a synonyms list. A non-exchangeable phrase list feature has all the phrases in the list serve as separate features to the underlying training algorithm. So, if you your phrase list feature contains 5 phrases, they will be mapped to 5 separate features. You can think of the non-exchangeable phrase list feature as an additional bag of words that you are willing to add to LUIS existing vocabulary features. Think of a non-exchangeable as set of different words. Default value is true. */
  isExchangeable?: boolean;
};

/** Pattern feature. */
export type PatternFeatureInfo = FeatureInfoObject & {
  /** The Regular Expression to match. */
  pattern?: string;
};

/** Intent Classifier. */
export type IntentClassifier = ModelInfo & {
  /** The domain name. */
  customPrebuiltDomainName?: string;
  /** The intent name or entity name. */
  customPrebuiltModelName?: string;
};

/** N-Depth Entity Extractor. */
export type NDepthEntityExtractor = ModelInfo & {
  /** The domain name. */
  customPrebuiltDomainName?: string;
  /** The intent name or entity name. */
  customPrebuiltModelName?: string;
  children?: ChildEntity[];
};

/** Hierarchical Entity Extractor. */
export type HierarchicalEntityExtractor = ModelInfo & {
  /** List of child entities. */
  children?: ChildEntity[];
};

/** A Composite Entity Extractor. */
export type CompositeEntityExtractor = ModelInfo & {
  /** List of child entities. */
  children?: ChildEntity[];
};

/** List Entity Extractor. */
export type ClosedListEntityExtractor = ModelInfo & {
  /** List of sublists. */
  subLists?: SubClosedListResponse[];
};

/** Prebuilt Entity Extractor. */
export type PrebuiltEntityExtractor = ModelInfo & {};

/** Entity Extractor. */
export type EntityExtractor = ModelInfo & {
  /** The domain name. */
  customPrebuiltDomainName?: string;
  /** The intent name or entity name. */
  customPrebuiltModelName?: string;
};

/** Regular Expression Entity Extractor. */
export type RegexEntityExtractor = ModelInfo & {
  /** The Regular Expression entity pattern. */
  regexPattern?: string;
};

/** Pattern.Any Entity Extractor. */
export type PatternAnyEntityExtractor = ModelInfo & {
  /** List of explicit (exception) list items */
  explicitList?: ExplicitListItem[];
};

/** A Custom Prebuilt model. */
export type CustomPrebuiltModel = ModelInfo & {};

/** An Entity Extractor model info. */
export type EntityModelInfo = ModelInfo & {
  /** List of Pattern.Any Entity Extractors. */
  roles?: EntityRole[];
};

/** A Hierarchical Child Entity. */
export type HierarchicalChildEntity = ChildEntity & {};

/** Sublist of items for a list entity. */
export type SubClosedListResponse = SubClosedList & {
  /** The sublist ID */
  id?: number;
};

export type ProductionOrStagingEndpointInfo = EndpointInfo & {};

/** An application model info. */
export type ModelInfoResponse = HierarchicalEntityExtractor &
  CompositeEntityExtractor &
  ClosedListEntityExtractor &
  IntentClassifier &
  EntityExtractor &
  RegexEntityExtractor &
  PatternAnyEntityExtractor &
  NDepthEntityExtractor & {};

/** Known values of {@link OperationStatusType} that the service accepts. */
export enum KnownOperationStatusType {
  Failed = "Failed",
  Failed = "FAILED",
  Success = "Success"
}

/**
 * Defines values for OperationStatusType. \
 * {@link KnownOperationStatusType} can be used interchangeably with OperationStatusType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Failed** \
 * **FAILED** \
 * **Success**
 */
export type OperationStatusType = string;

/** Known values of {@link ReadableType} that the service accepts. */
export enum KnownReadableType {
  EntityExtractor = "Entity Extractor",
  ChildEntityExtractor = "Child Entity Extractor",
  HierarchicalEntityExtractor = "Hierarchical Entity Extractor",
  HierarchicalChildEntityExtractor = "Hierarchical Child Entity Extractor",
  CompositeEntityExtractor = "Composite Entity Extractor",
  ListEntityExtractor = "List Entity Extractor",
  PrebuiltEntityExtractor = "Prebuilt Entity Extractor",
  IntentClassifier = "Intent Classifier",
  PatternAnyEntityExtractor = "Pattern.Any Entity Extractor",
  ClosedListEntityExtractor = "Closed List Entity Extractor",
  RegexEntityExtractor = "Regex Entity Extractor"
}

/**
 * Defines values for ReadableType. \
 * {@link KnownReadableType} can be used interchangeably with ReadableType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Entity Extractor** \
 * **Child Entity Extractor** \
 * **Hierarchical Entity Extractor** \
 * **Hierarchical Child Entity Extractor** \
 * **Composite Entity Extractor** \
 * **List Entity Extractor** \
 * **Prebuilt Entity Extractor** \
 * **Intent Classifier** \
 * **Pattern.Any Entity Extractor** \
 * **Closed List Entity Extractor** \
 * **Regex Entity Extractor**
 */
export type ReadableType = string;
/** Defines values for TrainingStatus. */
export type TrainingStatus =
  | "NeedsTraining"
  | "InProgress"
  | "Trained"
  | "Queued"
  | "UpToDate"
  | "Fail"
  | "Success";

/** Optional parameters. */
export interface FeaturesAddPhraseListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addPhraseList operation. */
export type FeaturesAddPhraseListResponse = {
  /** The parsed response body. */
  body: number;
};

/** Optional parameters. */
export interface FeaturesListPhraseListsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listPhraseLists operation. */
export type FeaturesListPhraseListsResponse = PhraseListFeatureInfo[];

/** Optional parameters. */
export interface FeaturesListOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the list operation. */
export type FeaturesListResponse = FeaturesResponseObject;

/** Optional parameters. */
export interface FeaturesGetPhraseListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPhraseList operation. */
export type FeaturesGetPhraseListResponse = PhraseListFeatureInfo;

/** Optional parameters. */
export interface FeaturesUpdatePhraseListOptionalParams
  extends coreClient.OperationOptions {
  /** The new values for: - Just a boolean called IsActive, in which case the status of the feature will be changed. - Name, Pattern, Mode, and a boolean called IsActive to update the feature. */
  phraselistUpdateObject?: PhraselistUpdateObject;
}

/** Contains response data for the updatePhraseList operation. */
export type FeaturesUpdatePhraseListResponse = OperationStatus;

/** Optional parameters. */
export interface FeaturesDeletePhraseListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePhraseList operation. */
export type FeaturesDeletePhraseListResponse = OperationStatus;

/** Optional parameters. */
export interface FeaturesAddIntentFeatureOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addIntentFeature operation. */
export type FeaturesAddIntentFeatureResponse = OperationStatus;

/** Optional parameters. */
export interface FeaturesAddEntityFeatureOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addEntityFeature operation. */
export type FeaturesAddEntityFeatureResponse = OperationStatus;

/** Optional parameters. */
export interface ExamplesAddOptionalParams extends coreClient.OperationOptions {
  /** Toggles nested/flat format */
  enableNestedChildren?: boolean;
}

/** Contains response data for the add operation. */
export type ExamplesAddResponse = LabelExampleResponse;

/** Optional parameters. */
export interface ExamplesBatchOptionalParams
  extends coreClient.OperationOptions {
  /** Toggles nested/flat format */
  enableNestedChildren?: boolean;
}

/** Contains response data for the batch operation. */
export type ExamplesBatchResponse = BatchLabelExample[];

/** Optional parameters. */
export interface ExamplesListOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
  /** Toggles nested/flat format */
  enableNestedChildren?: boolean;
}

/** Contains response data for the list operation. */
export type ExamplesListResponse = LabeledUtterance[];

/** Optional parameters. */
export interface ExamplesDeleteOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the delete operation. */
export type ExamplesDeleteResponse = OperationStatus;

/** Optional parameters. */
export interface ModelAddIntentOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addIntent operation. */
export type ModelAddIntentResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListIntentsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listIntents operation. */
export type ModelListIntentsResponse = IntentClassifier[];

/** Optional parameters. */
export interface ModelAddEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addEntity operation. */
export type ModelAddEntityResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListEntitiesOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listEntities operation. */
export type ModelListEntitiesResponse = NDepthEntityExtractor[];

/** Optional parameters. */
export interface ModelListHierarchicalEntitiesOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listHierarchicalEntities operation. */
export type ModelListHierarchicalEntitiesResponse = HierarchicalEntityExtractor[];

/** Optional parameters. */
export interface ModelListCompositeEntitiesOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listCompositeEntities operation. */
export type ModelListCompositeEntitiesResponse = CompositeEntityExtractor[];

/** Optional parameters. */
export interface ModelListClosedListsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listClosedLists operation. */
export type ModelListClosedListsResponse = ClosedListEntityExtractor[];

/** Optional parameters. */
export interface ModelAddClosedListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addClosedList operation. */
export type ModelAddClosedListResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelAddPrebuiltOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addPrebuilt operation. */
export type ModelAddPrebuiltResponse = PrebuiltEntityExtractor[];

/** Optional parameters. */
export interface ModelListPrebuiltsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listPrebuilts operation. */
export type ModelListPrebuiltsResponse = PrebuiltEntityExtractor[];

/** Optional parameters. */
export interface ModelListPrebuiltEntitiesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listPrebuiltEntities operation. */
export type ModelListPrebuiltEntitiesResponse = AvailablePrebuiltEntityModel[];

/** Optional parameters. */
export interface ModelListModelsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listModels operation. */
export type ModelListModelsResponse = ModelInfoResponse[];

/** Optional parameters. */
export interface ModelExamplesOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the examples operation. */
export type ModelExamplesResponse = LabelTextObject[];

/** Optional parameters. */
export interface ModelGetIntentOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getIntent operation. */
export type ModelGetIntentResponse = IntentClassifier;

/** Optional parameters. */
export interface ModelUpdateIntentOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateIntent operation. */
export type ModelUpdateIntentResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteIntentOptionalParams
  extends coreClient.OperationOptions {
  /** If true, deletes the intent's example utterances. If false, moves the example utterances to the None intent. The default value is false. */
  deleteUtterances?: boolean;
}

/** Contains response data for the deleteIntent operation. */
export type ModelDeleteIntentResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getEntity operation. */
export type ModelGetEntityResponse = NDepthEntityExtractor;

/** Optional parameters. */
export interface ModelDeleteEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteEntity operation. */
export type ModelDeleteEntityResponse = OperationStatus;

/** Optional parameters. */
export interface ModelUpdateEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateEntityChild operation. */
export type ModelUpdateEntityChildResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetIntentFeaturesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getIntentFeatures operation. */
export type ModelGetIntentFeaturesResponse = ModelFeatureInformation[];

/** Optional parameters. */
export interface ModelReplaceIntentFeaturesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the replaceIntentFeatures operation. */
export type ModelReplaceIntentFeaturesResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteIntentFeatureOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteIntentFeature operation. */
export type ModelDeleteIntentFeatureResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetEntityFeaturesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getEntityFeatures operation. */
export type ModelGetEntityFeaturesResponse = ModelFeatureInformation[];

/** Optional parameters. */
export interface ModelReplaceEntityFeaturesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the replaceEntityFeatures operation. */
export type ModelReplaceEntityFeaturesResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteEntityFeatureOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteEntityFeature operation. */
export type ModelDeleteEntityFeatureResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetHierarchicalEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getHierarchicalEntity operation. */
export type ModelGetHierarchicalEntityResponse = HierarchicalEntityExtractor;

/** Optional parameters. */
export interface ModelUpdateHierarchicalEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateHierarchicalEntity operation. */
export type ModelUpdateHierarchicalEntityResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteHierarchicalEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteHierarchicalEntity operation. */
export type ModelDeleteHierarchicalEntityResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetCompositeEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getCompositeEntity operation. */
export type ModelGetCompositeEntityResponse = CompositeEntityExtractor;

/** Optional parameters. */
export interface ModelUpdateCompositeEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateCompositeEntity operation. */
export type ModelUpdateCompositeEntityResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteCompositeEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteCompositeEntity operation. */
export type ModelDeleteCompositeEntityResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetClosedListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getClosedList operation. */
export type ModelGetClosedListResponse = ClosedListEntityExtractor;

/** Optional parameters. */
export interface ModelUpdateClosedListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateClosedList operation. */
export type ModelUpdateClosedListResponse = OperationStatus;

/** Optional parameters. */
export interface ModelPatchClosedListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the patchClosedList operation. */
export type ModelPatchClosedListResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteClosedListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteClosedList operation. */
export type ModelDeleteClosedListResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetPrebuiltOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPrebuilt operation. */
export type ModelGetPrebuiltResponse = PrebuiltEntityExtractor;

/** Optional parameters. */
export interface ModelDeletePrebuiltOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePrebuilt operation. */
export type ModelDeletePrebuiltResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteSubListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteSubList operation. */
export type ModelDeleteSubListResponse = OperationStatus;

/** Optional parameters. */
export interface ModelUpdateSubListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateSubList operation. */
export type ModelUpdateSubListResponse = OperationStatus;

/** Optional parameters. */
export interface ModelListIntentSuggestionsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
  /** Toggles nested/flat format */
  enableNestedChildren?: boolean;
}

/** Contains response data for the listIntentSuggestions operation. */
export type ModelListIntentSuggestionsResponse = IntentsSuggestionExample[];

/** Optional parameters. */
export interface ModelListEntitySuggestionsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
  /** Toggles nested/flat format */
  enableNestedChildren?: boolean;
}

/** Contains response data for the listEntitySuggestions operation. */
export type ModelListEntitySuggestionsResponse = EntitiesSuggestionExample[];

/** Optional parameters. */
export interface ModelAddSubListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addSubList operation. */
export type ModelAddSubListResponse = {
  /** The parsed response body. */
  body: number;
};

/** Optional parameters. */
export interface ModelAddCustomPrebuiltDomainOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addCustomPrebuiltDomain operation. */
export type ModelAddCustomPrebuiltDomainResponse = {
  /** The parsed response body. */
  body: string[];
};

/** Optional parameters. */
export interface ModelAddCustomPrebuiltIntentOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addCustomPrebuiltIntent operation. */
export type ModelAddCustomPrebuiltIntentResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListCustomPrebuiltIntentsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCustomPrebuiltIntents operation. */
export type ModelListCustomPrebuiltIntentsResponse = IntentClassifier[];

/** Optional parameters. */
export interface ModelAddCustomPrebuiltEntityOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addCustomPrebuiltEntity operation. */
export type ModelAddCustomPrebuiltEntityResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListCustomPrebuiltEntitiesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCustomPrebuiltEntities operation. */
export type ModelListCustomPrebuiltEntitiesResponse = EntityExtractor[];

/** Optional parameters. */
export interface ModelListCustomPrebuiltModelsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCustomPrebuiltModels operation. */
export type ModelListCustomPrebuiltModelsResponse = CustomPrebuiltModel[];

/** Optional parameters. */
export interface ModelDeleteCustomPrebuiltDomainOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteCustomPrebuiltDomain operation. */
export type ModelDeleteCustomPrebuiltDomainResponse = OperationStatus;

/** Optional parameters. */
export interface ModelAddEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addEntityChild operation. */
export type ModelAddEntityChildResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelGetHierarchicalEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getHierarchicalEntityChild operation. */
export type ModelGetHierarchicalEntityChildResponse = HierarchicalChildEntity;

/** Optional parameters. */
export interface ModelUpdateHierarchicalEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateHierarchicalEntityChild operation. */
export type ModelUpdateHierarchicalEntityChildResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteHierarchicalEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteHierarchicalEntityChild operation. */
export type ModelDeleteHierarchicalEntityChildResponse = OperationStatus;

/** Optional parameters. */
export interface ModelAddCompositeEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addCompositeEntityChild operation. */
export type ModelAddCompositeEntityChildResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelDeleteCompositeEntityChildOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteCompositeEntityChild operation. */
export type ModelDeleteCompositeEntityChildResponse = OperationStatus;

/** Optional parameters. */
export interface ModelListRegexEntityInfosOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listRegexEntityInfos operation. */
export type ModelListRegexEntityInfosResponse = RegexEntityExtractor[];

/** Optional parameters. */
export interface ModelCreateRegexEntityModelOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createRegexEntityModel operation. */
export type ModelCreateRegexEntityModelResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListPatternAnyEntityInfosOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listPatternAnyEntityInfos operation. */
export type ModelListPatternAnyEntityInfosResponse = PatternAnyEntityExtractor[];

/** Optional parameters. */
export interface ModelCreatePatternAnyEntityModelOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createPatternAnyEntityModel operation. */
export type ModelCreatePatternAnyEntityModelResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listEntityRoles operation. */
export type ModelListEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreateEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createEntityRole operation. */
export type ModelCreateEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListPrebuiltEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listPrebuiltEntityRoles operation. */
export type ModelListPrebuiltEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreatePrebuiltEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createPrebuiltEntityRole operation. */
export type ModelCreatePrebuiltEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListClosedListEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listClosedListEntityRoles operation. */
export type ModelListClosedListEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreateClosedListEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createClosedListEntityRole operation. */
export type ModelCreateClosedListEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListRegexEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listRegexEntityRoles operation. */
export type ModelListRegexEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreateRegexEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createRegexEntityRole operation. */
export type ModelCreateRegexEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListCompositeEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCompositeEntityRoles operation. */
export type ModelListCompositeEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreateCompositeEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createCompositeEntityRole operation. */
export type ModelCreateCompositeEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListPatternAnyEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listPatternAnyEntityRoles operation. */
export type ModelListPatternAnyEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreatePatternAnyEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createPatternAnyEntityRole operation. */
export type ModelCreatePatternAnyEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListHierarchicalEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listHierarchicalEntityRoles operation. */
export type ModelListHierarchicalEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreateHierarchicalEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createHierarchicalEntityRole operation. */
export type ModelCreateHierarchicalEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelListCustomPrebuiltEntityRolesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCustomPrebuiltEntityRoles operation. */
export type ModelListCustomPrebuiltEntityRolesResponse = EntityRole[];

/** Optional parameters. */
export interface ModelCreateCustomPrebuiltEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the createCustomPrebuiltEntityRole operation. */
export type ModelCreateCustomPrebuiltEntityRoleResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface ModelGetExplicitListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getExplicitList operation. */
export type ModelGetExplicitListResponse = ExplicitListItem[];

/** Optional parameters. */
export interface ModelAddExplicitListItemOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addExplicitListItem operation. */
export type ModelAddExplicitListItemResponse = {
  /** The parsed response body. */
  body: number;
};

/** Optional parameters. */
export interface ModelGetRegexEntityInfoOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getRegexEntityInfo operation. */
export type ModelGetRegexEntityInfoResponse = RegexEntityExtractor;

/** Optional parameters. */
export interface ModelUpdateRegexEntityModelOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateRegexEntityModel operation. */
export type ModelUpdateRegexEntityModelResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteRegexEntityModelOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteRegexEntityModel operation. */
export type ModelDeleteRegexEntityModelResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetPatternAnyEntityInfoOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPatternAnyEntityInfo operation. */
export type ModelGetPatternAnyEntityInfoResponse = PatternAnyEntityExtractor;

/** Optional parameters. */
export interface ModelUpdatePatternAnyEntityModelOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePatternAnyEntityModel operation. */
export type ModelUpdatePatternAnyEntityModelResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeletePatternAnyEntityModelOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePatternAnyEntityModel operation. */
export type ModelDeletePatternAnyEntityModelResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getEntityRole operation. */
export type ModelGetEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdateEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateEntityRole operation. */
export type ModelUpdateEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteEntityRole operation. */
export type ModelDeleteEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetPrebuiltEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPrebuiltEntityRole operation. */
export type ModelGetPrebuiltEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdatePrebuiltEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePrebuiltEntityRole operation. */
export type ModelUpdatePrebuiltEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeletePrebuiltEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePrebuiltEntityRole operation. */
export type ModelDeletePrebuiltEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetClosedListEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getClosedListEntityRole operation. */
export type ModelGetClosedListEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdateClosedListEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateClosedListEntityRole operation. */
export type ModelUpdateClosedListEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteClosedListEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteClosedListEntityRole operation. */
export type ModelDeleteClosedListEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetRegexEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getRegexEntityRole operation. */
export type ModelGetRegexEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdateRegexEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateRegexEntityRole operation. */
export type ModelUpdateRegexEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteRegexEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteRegexEntityRole operation. */
export type ModelDeleteRegexEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetCompositeEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getCompositeEntityRole operation. */
export type ModelGetCompositeEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdateCompositeEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateCompositeEntityRole operation. */
export type ModelUpdateCompositeEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteCompositeEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteCompositeEntityRole operation. */
export type ModelDeleteCompositeEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetPatternAnyEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPatternAnyEntityRole operation. */
export type ModelGetPatternAnyEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdatePatternAnyEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePatternAnyEntityRole operation. */
export type ModelUpdatePatternAnyEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeletePatternAnyEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePatternAnyEntityRole operation. */
export type ModelDeletePatternAnyEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetHierarchicalEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getHierarchicalEntityRole operation. */
export type ModelGetHierarchicalEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdateHierarchicalEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateHierarchicalEntityRole operation. */
export type ModelUpdateHierarchicalEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteHierarchicalEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteHierarchicalEntityRole operation. */
export type ModelDeleteHierarchicalEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetCustomEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getCustomEntityRole operation. */
export type ModelGetCustomEntityRoleResponse = EntityRole;

/** Optional parameters. */
export interface ModelUpdateCustomPrebuiltEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateCustomPrebuiltEntityRole operation. */
export type ModelUpdateCustomPrebuiltEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteCustomEntityRoleOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteCustomEntityRole operation. */
export type ModelDeleteCustomEntityRoleResponse = OperationStatus;

/** Optional parameters. */
export interface ModelGetExplicitListItemOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getExplicitListItem operation. */
export type ModelGetExplicitListItemResponse = ExplicitListItem;

/** Optional parameters. */
export interface ModelUpdateExplicitListItemOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateExplicitListItem operation. */
export type ModelUpdateExplicitListItemResponse = OperationStatus;

/** Optional parameters. */
export interface ModelDeleteExplicitListItemOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteExplicitListItem operation. */
export type ModelDeleteExplicitListItemResponse = OperationStatus;

/** Optional parameters. */
export interface AppsAddOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the add operation. */
export type AppsAddResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface AppsListOptionalParams extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the list operation. */
export type AppsListResponse = ApplicationInfoResponse[];

/** Optional parameters. */
export interface AppsImportOptionalParams extends coreClient.OperationOptions {
  /** The application name to create. If not specified, the application name will be read from the imported object. If the application name already exists, an error is returned. */
  appName?: string;
}

/** Contains response data for the import operation. */
export type AppsImportResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface AppsListCortanaEndpointsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listCortanaEndpoints operation. */
export type AppsListCortanaEndpointsResponse = PersonalAssistantsResponse;

/** Optional parameters. */
export interface AppsListDomainsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listDomains operation. */
export type AppsListDomainsResponse = {
  /** The parsed response body. */
  body: string[];
};

/** Optional parameters. */
export interface AppsListUsageScenariosOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listUsageScenarios operation. */
export type AppsListUsageScenariosResponse = {
  /** The parsed response body. */
  body: string[];
};

/** Optional parameters. */
export interface AppsListSupportedCulturesOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listSupportedCultures operation. */
export type AppsListSupportedCulturesResponse = AvailableCulture[];

/** Optional parameters. */
export interface AppsDownloadQueryLogsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the downloadQueryLogs operation. */
export type AppsDownloadQueryLogsResponse = {
  /**
   * BROWSER ONLY
   *
   * The response body as a browser Blob.
   * Always `undefined` in node.js.
   */
  blobBody?: Promise<Blob>;
  /**
   * NODEJS ONLY
   *
   * The response body as a node.js Readable stream.
   * Always `undefined` in the browser.
   */
  readableStreamBody?: NodeJS.ReadableStream;
};

/** Optional parameters. */
export interface AppsGetOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type AppsGetResponse = ApplicationInfoResponse;

/** Optional parameters. */
export interface AppsUpdateOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the update operation. */
export type AppsUpdateResponse = OperationStatus;

/** Optional parameters. */
export interface AppsDeleteOptionalParams extends coreClient.OperationOptions {
  /** A flag to indicate whether to force an operation. */
  force?: boolean;
}

/** Contains response data for the delete operation. */
export type AppsDeleteResponse = OperationStatus;

/** Optional parameters. */
export interface AppsPublishOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the publish operation. */
export type AppsPublishResponse = ProductionOrStagingEndpointInfo;

/** Optional parameters. */
export interface AppsGetSettingsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getSettings operation. */
export type AppsGetSettingsResponse = ApplicationSettings;

/** Optional parameters. */
export interface AppsUpdateSettingsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updateSettings operation. */
export type AppsUpdateSettingsResponse = OperationStatus;

/** Optional parameters. */
export interface AppsGetPublishSettingsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getPublishSettings operation. */
export type AppsGetPublishSettingsResponse = PublishSettings;

/** Optional parameters. */
export interface AppsUpdatePublishSettingsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePublishSettings operation. */
export type AppsUpdatePublishSettingsResponse = OperationStatus;

/** Optional parameters. */
export interface AppsListEndpointsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listEndpoints operation. */
export type AppsListEndpointsResponse = { [propertyName: string]: string };

/** Optional parameters. */
export interface AppsListAvailableCustomPrebuiltDomainsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableCustomPrebuiltDomains operation. */
export type AppsListAvailableCustomPrebuiltDomainsResponse = PrebuiltDomain[];

/** Optional parameters. */
export interface AppsAddCustomPrebuiltDomainOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addCustomPrebuiltDomain operation. */
export type AppsAddCustomPrebuiltDomainResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface AppsListAvailableCustomPrebuiltDomainsForCultureOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listAvailableCustomPrebuiltDomainsForCulture operation. */
export type AppsListAvailableCustomPrebuiltDomainsForCultureResponse = PrebuiltDomain[];

/** Optional parameters. */
export interface AppsPackagePublishedApplicationAsGzipOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the packagePublishedApplicationAsGzip operation. */
export type AppsPackagePublishedApplicationAsGzipResponse = {
  /**
   * BROWSER ONLY
   *
   * The response body as a browser Blob.
   * Always `undefined` in node.js.
   */
  blobBody?: Promise<Blob>;
  /**
   * NODEJS ONLY
   *
   * The response body as a node.js Readable stream.
   * Always `undefined` in the browser.
   */
  readableStreamBody?: NodeJS.ReadableStream;
};

/** Optional parameters. */
export interface AppsPackageTrainedApplicationAsGzipOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the packageTrainedApplicationAsGzip operation. */
export type AppsPackageTrainedApplicationAsGzipResponse = {
  /**
   * BROWSER ONLY
   *
   * The response body as a browser Blob.
   * Always `undefined` in node.js.
   */
  blobBody?: Promise<Blob>;
  /**
   * NODEJS ONLY
   *
   * The response body as a node.js Readable stream.
   * Always `undefined` in the browser.
   */
  readableStreamBody?: NodeJS.ReadableStream;
};

/** Optional parameters. */
export interface AppsImportV2AppOptionalParams
  extends coreClient.OperationOptions {
  /** The application name to create. If not specified, the application name will be read from the imported object. If the application name already exists, an error is returned. */
  appName?: string;
}

/** Contains response data for the importV2App operation. */
export type AppsImportV2AppResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface AppsImportLuFormatOptionalParams
  extends coreClient.OperationOptions {
  /** The application name to create. If not specified, the application name will be read from the imported object. If the application name already exists, an error is returned. */
  appName?: string;
}

/** Contains response data for the importLuFormat operation. */
export type AppsImportLuFormatResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VersionsCloneOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the clone operation. */
export type VersionsCloneResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VersionsListOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the list operation. */
export type VersionsListResponse = VersionInfo[];

/** Optional parameters. */
export interface VersionsGetOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type VersionsGetResponse = VersionInfo;

/** Optional parameters. */
export interface VersionsUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the update operation. */
export type VersionsUpdateResponse = OperationStatus;

/** Optional parameters. */
export interface VersionsDeleteOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the delete operation. */
export type VersionsDeleteResponse = OperationStatus;

/** Optional parameters. */
export interface VersionsExportOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the export operation. */
export type VersionsExportResponse = LuisApp;

/** Optional parameters. */
export interface VersionsImportOptionalParams
  extends coreClient.OperationOptions {
  /** The new versionId to import. If not specified, the versionId will be read from the imported object. */
  versionId?: string;
}

/** Contains response data for the import operation. */
export type VersionsImportResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VersionsDeleteUnlabelledUtteranceOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deleteUnlabelledUtterance operation. */
export type VersionsDeleteUnlabelledUtteranceResponse = OperationStatus;

/** Optional parameters. */
export interface VersionsImportV2AppOptionalParams
  extends coreClient.OperationOptions {
  /** The new versionId to import. If not specified, the versionId will be read from the imported object. */
  versionId?: string;
}

/** Contains response data for the importV2App operation. */
export type VersionsImportV2AppResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VersionsImportLuFormatOptionalParams
  extends coreClient.OperationOptions {
  /** The new versionId to import. If not specified, the versionId will be read from the imported object. */
  versionId?: string;
}

/** Contains response data for the importLuFormat operation. */
export type VersionsImportLuFormatResponse = {
  /** The parsed response body. */
  body: string;
};

/** Optional parameters. */
export interface VersionsExportLuFormatOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the exportLuFormat operation. */
export type VersionsExportLuFormatResponse = {
  /**
   * BROWSER ONLY
   *
   * The response body as a browser Blob.
   * Always `undefined` in node.js.
   */
  blobBody?: Promise<Blob>;
  /**
   * NODEJS ONLY
   *
   * The response body as a node.js Readable stream.
   * Always `undefined` in the browser.
   */
  readableStreamBody?: NodeJS.ReadableStream;
};

/** Optional parameters. */
export interface TrainTrainVersionOptionalParams
  extends coreClient.OperationOptions {
  /** An enum value specifying mode of training. */
  mode?: string;
}

/** Contains response data for the trainVersion operation. */
export type TrainTrainVersionResponse = EnqueueTrainingResponse;

/** Optional parameters. */
export interface TrainGetStatusOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the getStatus operation. */
export type TrainGetStatusResponse = ModelTrainingInfo[];

/** Optional parameters. */
export interface PatternAddPatternOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the addPattern operation. */
export type PatternAddPatternResponse = PatternRuleInfo;

/** Optional parameters. */
export interface PatternListPatternsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listPatterns operation. */
export type PatternListPatternsResponse = PatternRuleInfo[];

/** Optional parameters. */
export interface PatternUpdatePatternsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePatterns operation. */
export type PatternUpdatePatternsResponse = PatternRuleInfo[];

/** Optional parameters. */
export interface PatternBatchAddPatternsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the batchAddPatterns operation. */
export type PatternBatchAddPatternsResponse = PatternRuleInfo[];

/** Optional parameters. */
export interface PatternDeletePatternsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePatterns operation. */
export type PatternDeletePatternsResponse = OperationStatus;

/** Optional parameters. */
export interface PatternUpdatePatternOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the updatePattern operation. */
export type PatternUpdatePatternResponse = PatternRuleInfo;

/** Optional parameters. */
export interface PatternDeletePatternOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the deletePattern operation. */
export type PatternDeletePatternResponse = OperationStatus;

/** Optional parameters. */
export interface PatternListIntentPatternsOptionalParams
  extends coreClient.OperationOptions {
  /** The number of entries to skip. Default value is 0. */
  skip?: number;
  /** The number of entries to return. Maximum page size is 500. Default is 100. */
  take?: number;
}

/** Contains response data for the listIntentPatterns operation. */
export type PatternListIntentPatternsResponse = PatternRuleInfo[];

/** Optional parameters. */
export interface SettingsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type SettingsListResponse = AppVersionSettingObject[];

/** Optional parameters. */
export interface SettingsUpdateOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the update operation. */
export type SettingsUpdateResponse = OperationStatus;

/** Optional parameters. */
export interface AzureAccountsAssignToAppOptionalParams
  extends coreClient.OperationOptions {
  /** The Azure account information object. */
  azureAccountInfoObject?: AzureAccountInfoObject;
  /** The custom arm token header to use; containing the user's ARM token used to validate azure accounts information. */
  armToken?: string;
}

/** Contains response data for the assignToApp operation. */
export type AzureAccountsAssignToAppResponse = OperationStatus;

/** Optional parameters. */
export interface AzureAccountsGetAssignedOptionalParams
  extends coreClient.OperationOptions {
  /** The custom arm token header to use; containing the user's ARM token used to validate azure accounts information. */
  armToken?: string;
}

/** Contains response data for the getAssigned operation. */
export type AzureAccountsGetAssignedResponse = AzureAccountInfoObject[];

/** Optional parameters. */
export interface AzureAccountsRemoveFromAppOptionalParams
  extends coreClient.OperationOptions {
  /** The Azure account information object. */
  azureAccountInfoObject?: AzureAccountInfoObject;
  /** The custom arm token header to use; containing the user's ARM token used to validate azure accounts information. */
  armToken?: string;
}

/** Contains response data for the removeFromApp operation. */
export type AzureAccountsRemoveFromAppResponse = OperationStatus;

/** Optional parameters. */
export interface AzureAccountsListUserLuisAccountsOptionalParams
  extends coreClient.OperationOptions {
  /** The custom arm token header to use; containing the user's ARM token used to validate azure accounts information. */
  armToken?: string;
}

/** Contains response data for the listUserLuisAccounts operation. */
export type AzureAccountsListUserLuisAccountsResponse = AzureAccountInfoObject[];

/** Optional parameters. */
export interface LuisAuthoringClientOptionalParams
  extends coreClient.ServiceClientOptions {
  /** Overrides client endpoint. */
  endpoint?: string;
}
