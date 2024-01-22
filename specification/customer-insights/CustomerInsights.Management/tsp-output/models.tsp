import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CustomerInsights;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The data source type.
 */
enum DataSourceType {
  Connector,
  LinkInteraction,
  SystemDefault,
}

/**
 * The data source status.
 */
enum Status {
  None,
  Active,
  Deleted,
}

/**
 * Provisioning state.
 */
enum ProvisioningStates {
  Provisioning,
  Succeeded,
  Expiring,
  Deleting,
  HumanIntervention,
  Failed,
}

/**
 * Type of connector.
 */
enum ConnectorTypes {
  None,
  CRM,
  AzureBlob,
  Salesforce,
  ExchangeOnline,
  Outbound,
}

/**
 * Type of canonical property value.
 */
enum CanonicalPropertyValueType {
  Numeric,
  Categorical,
  DerivedCategorical,
  DerivedNumeric,
}

/**
 * Prediction model life cycle.  When prediction is in PendingModelConfirmation status, it is allowed to update the status to PendingFeaturing or Active through API.
 */
enum PredictionModelLifeCycle {
  New,
  Provisioning,
  ProvisioningFailed,
  PendingDiscovering,
  Discovering,
  PendingFeaturing,
  Featuring,
  FeaturingFailed,
  PendingTraining,
  Training,
  TrainingFailed,
  Evaluating,
  EvaluatingFailed,
  PendingModelConfirmation,
  Active,
  Deleted,
  HumanIntervention,
  Failed,
}

/**
 * Type of entity.
 */
@fixed
enum EntityTypes {
  None,
  Profile,
  Interaction,
  Relationship,
}

/**
 * The calculation window.
 */
@fixed
enum CalculationWindowTypes {
  Lifetime,
  Hour,
  Day,
  Week,
  Month,
}

/**
 * The computation function for the KPI.
 */
@fixed
enum KpiFunctions {
  Sum,
  Avg,
  Min,
  Max,
  Last,
  Count,
  None,
  CountDistinct,
}

/**
 * The Relationship Cardinality.
 */
@fixed
enum CardinalityTypes {
  OneToOne,
  OneToMany,
  ManyToMany,
}

/**
 * Link type.
 */
@fixed
enum LinkTypes {
  UpdateAlways,
  CopyIfNull,
}

/**
 * Supported permission types.
 */
@fixed
enum PermissionTypes {
  Read,
  Write,
  Manage,
}

/**
 * State of connector.
 */
@fixed
enum ConnectorStates {
  Creating,
  Created,
  Ready,
  Expiring,
  Deleting,
  Failed,
}

/**
 * The type of error management to use for the mapping.
 */
@fixed
enum ErrorManagementTypes {
  RejectAndContinue,
  StopImport,
  RejectUntilLimit,
}

/**
 * The frequency to update.
 */
@fixed
enum FrequencyTypes {
  Minute,
  Hour,
  Day,
  Week,
  Month,
}

/**
 * The type of completion operation.
 */
@fixed
enum CompletionOperationTypes {
  DoNothing,
  DeleteFile,
  MoveFile,
}

/**
 * State of connector mapping.
 */
@fixed
enum ConnectorMappingStates {
  Creating,
  Created,
  Failed,
  Ready,
  Running,
  Stopped,
  Expiring,
}

/**
 * Type of source entity.
 */
@fixed
enum EntityType {
  None,
  Profile,
  Interaction,
  Relationship,
}

/**
 * Determines whether this link is supposed to create or delete instances if Link is NOT Reference Only.
 */
@fixed
enum InstanceOperationType {
  Upsert,
  Delete,
}

/**
 * Type of roles.
 */
@fixed
enum RoleTypes {
  Admin,
  Reader,
  ManageAdmin,
  ManageReader,
  DataAdmin,
  DataReader,
}

/**
 * Properties of hub.
 */
model HubPropertiesFormat {
  /**
   * API endpoint URL of the hub.
   */
  @visibility("read")
  apiEndpoint?: string;

  /**
   * Web endpoint URL of the hub.
   */
  @visibility("read")
  webEndpoint?: string;

  /**
   * Provisioning state of the hub.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The bit flags for enabled hub features. Bit 0 is set to 1 indicates graph is enabled, or disabled if set to 0. Bit 1 is set to 1 indicates the hub is disabled, or enabled if set to 0.
   */
  tenantFeatures?: int32;

  /**
   * Billing settings of the hub.
   */
  hubBillingInfo?: HubBillingInfoFormat;
}

/**
 * Hub billing info.
 */
model HubBillingInfoFormat {
  /**
   * The sku name.
   */
  skuName?: string;

  /**
   * The minimum number of units will be billed. One unit is 10,000 Profiles and 100,000 Interactions.
   */
  @maxValue(10)
  @minValue(1)
  minUnits?: int32;

  /**
   * The maximum number of units can be used.  One unit is 10,000 Profiles and 100,000 Interactions.
   */
  @maxValue(10)
  @minValue(1)
  maxUnits?: int32;
}

/**
 * Common properties of Azure resource.
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * The profile type definition.
 */
model ProfileTypeDefinition extends EntityTypeDefinition {
  /**
   * The strong IDs.
   */
  strongIds?: StrongId[];
}

/**
 * Property/Properties which represent a unique ID.
 */
model StrongId {
  /**
   * The properties which make up the unique ID.
   */
  keyPropertyNames: string[];

  /**
   * The Name identifying the strong ID.
   */
  strongIdName: string;

  /**
   * Localized display name.
   */
  displayName?: Record<string>;

  /**
   * Localized descriptions.
   */
  description?: Record<string>;
}

/**
 * Describes an entity.
 */
model EntityTypeDefinition extends MetadataDefinitionBase {
  /**
   * The api entity set name. This becomes the odata entity set name for the entity Type being referred in this object.
   */
  apiEntitySetName?: string;

  /**
   * Type of entity.
   */
  entityType?: EntityTypes;

  /**
   * The properties of the Profile.
   */
  fields?: PropertyDefinition[];

  /**
   * The instance count.
   */
  instancesCount?: int32;

  /**
   * The last changed time for the type definition.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChangedUtc?: utcDateTime;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * The schema org link. This helps ACI identify and suggest semantic models.
   */
  schemaItemTypeLink?: string;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The timestamp property name. Represents the time when the interaction or profile update happened.
   */
  timestampFieldName?: string;

  /**
   * The name of the entity.
   */
  typeName?: string;
}

/**
 * Property definition.
 */
model PropertyDefinition {
  /**
   * Array value separator for properties with isArray set.
   */
  arrayValueSeparator?: string;

  /**
   * Describes valid values for an enum property.
   */
  enumValidValues?: ProfileEnumValidValuesFormat[];

  /**
   * Name of the property.
   */
  fieldName: string;

  /**
   * Type of the property.
   */
  fieldType: string;

  /**
   * Indicates if the property is actually an array of the fieldType above on the data api.
   */
  isArray?: boolean;

  /**
   * Indicates if the property is an enum.
   */
  isEnum?: boolean;

  /**
   * Indicates if the property is an flag enum.
   */
  isFlagEnum?: boolean;

  /**
   * Whether the property is an Image.
   */
  isImage?: boolean;

  /**
   * Whether the property is a localized string.
   */
  isLocalizedString?: boolean;

  /**
   * Whether the property is a name or a part of name.
   */
  isName?: boolean;

  /**
   * Whether property value is required on instances, IsRequired field only for Interaction. Profile Instance will not check for required field.
   */
  isRequired?: boolean;

  /**
   * The ID associated with the property.
   */
  propertyId?: string;

  /**
   * URL encoded schema.org item prop link for the property.
   */
  schemaItemPropLink?: string;

  /**
   * Max length of string. Used only if type is string.
   */
  maxLength?: int32;

  /**
   * Whether property is available in graph or not.
   */
  isAvailableInGraph?: boolean;

  /**
   * This is specific to interactions modeled as activities. Data sources are used to determine where data is stored and also in precedence rules.
   */
  @visibility("read")
  dataSourcePrecedenceRules?: DataSourcePrecedence[];
}

/**
 * Valid enum values in case of an enum property.
 */
model ProfileEnumValidValuesFormat {
  /**
   * The integer value of the enum member.
   */
  value?: int32;

  /**
   * Localized names of the enum member.
   */
  localizedValueNames?: Record<string>;
}

/**
 * The data source precedence is a way to know the precedence of each data source.
 */
model DataSourcePrecedence {
  /**
   * Data Source is a way for us to know the source of instances. A single type can have data coming in from multiple places. In activities we use this to determine precedence rules.
   */
  dataSource?: DataSource;

  /**
   * the precedence value.
   */
  precedence?: int32;
}

/**
 * Data Source is a way for us to know the source of instances. A single type can have data coming in from multiple places. In activities we use this to determine precedence rules.
 */
model DataSource {
  /**
   * The data source name
   */
  @visibility("read")
  name?: string;

  /**
   * The data source type.
   */
  @visibility("read")
  dataSourceType?: DataSourceType;

  /**
   * The data source status.
   */
  @visibility("read")
  status?: Status;

  /**
   * The data source ID.
   */
  @visibility("read")
  id?: int32;

  /**
   * The data source reference id.
   */
  @visibility("read")
  dataSourceReferenceId?: string;
}

/**
 * The Metadata definition base.
 */
model MetadataDefinitionBase {
  /**
   * The attributes for the Type.
   */
  attributes?: Record<string[]>;

  /**
   * Localized descriptions for the property.
   */
  description?: Record<string>;

  /**
   * Localized display names for the property.
   */
  displayName?: Record<string>;

  /**
   * Any custom localized attributes for the Type.
   */
  localizedAttributes?: Record<Record<string>>;

  /**
   * Small Image associated with the Property or EntityType.
   */
  smallImage?: string;

  /**
   * Medium Image associated with the Property or EntityType.
   */
  mediumImage?: string;

  /**
   * Large Image associated with the Property or EntityType.
   */
  largeImage?: string;
}

/**
 * Defines the KPI Threshold limits.
 */
model KpiDefinition {
  /**
   * The mapping entity type.
   */
  entityType: EntityTypes;

  /**
   * The mapping entity name.
   */
  entityTypeName: string;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The KPI name.
   */
  @visibility("read")
  kpiName?: string;

  /**
   * Localized display name for the KPI.
   */
  displayName?: Record<string>;

  /**
   * Localized description for the KPI.
   */
  description?: Record<string>;

  /**
   * The calculation window.
   */
  calculationWindow: CalculationWindowTypes;

  /**
   * Name of calculation window field.
   */
  calculationWindowFieldName?: string;

  /**
   * The computation function for the KPI.
   */
  function: KpiFunctions;

  /**
   * The computation expression for the KPI.
   */
  expression: string;

  /**
   * The unit of measurement for the KPI.
   */
  unit?: string;

  /**
   * The filter expression for the KPI.
   */
  filter?: string;

  /**
   * the group by properties for the KPI.
   */
  groupBy?: string[];

  /**
   * The KPI GroupByMetadata.
   */
  @visibility("read")
  groupByMetadata?: KpiGroupByMetadata[];

  /**
   * The participant profiles.
   */
  @visibility("read")
  participantProfilesMetadata?: KpiParticipantProfilesMetadata[];

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * The KPI thresholds.
   */
  thresHolds?: KpiThresholds;

  /**
   * The aliases.
   */
  aliases?: KpiAlias[];

  /**
   * The KPI extracts.
   */
  extracts?: KpiExtract[];
}

/**
 * The KPI GroupBy field metadata.
 */
model KpiGroupByMetadata {
  /**
   * The display name.
   */
  displayName?: Record<string>;

  /**
   * The name of the field.
   */
  fieldName?: string;

  /**
   * The type of the field.
   */
  fieldType?: string;
}

/**
 * The KPI participant profile metadata.
 */
model KpiParticipantProfilesMetadata {
  /**
   * Name of the type.
   */
  typeName: string;
}

/**
 * Defines the KPI Threshold limits.
 */
model KpiThresholds {
  /**
   * The lower threshold limit.
   */
  lowerLimit: decimal;

  /**
   * The upper threshold limit.
   */
  upperLimit: decimal;

  /**
   * Whether or not the KPI is an increasing KPI.
   */
  increasingKpi: boolean;
}

/**
 * The KPI alias.
 */
model KpiAlias {
  /**
   * KPI alias name.
   */
  aliasName: string;

  /**
   * The expression.
   */
  expression: string;
}

/**
 * The KPI extract.
 */
model KpiExtract {
  /**
   * KPI extract name.
   */
  extractName: string;

  /**
   * The expression.
   */
  expression: string;
}

/**
 * The Interaction Type Definition
 */
model InteractionTypeDefinition extends EntityTypeDefinition {
  /**
   * The id property names. Properties which uniquely identify an interaction instance.
   */
  idPropertyNames?: string[];

  /**
   * Profiles that participated in the interaction.
   */
  participantProfiles?: Participant[];

  /**
   * The primary participant property name for an interaction ,This is used to logically represent the agent of the interaction, Specify the participant name here from ParticipantName.
   */
  primaryParticipantProfilePropertyName?: string;

  /**
   * This is specific to interactions modeled as activities. Data sources are used to determine where data is stored and also in precedence rules.
   */
  @visibility("read")
  dataSourcePrecedenceRules?: DataSourcePrecedence[];

  /**
   * Default data source is specifically used in cases where data source is not specified in an instance.
   */
  defaultDataSource?: DataSource;

  /**
   * An interaction can be tagged as an activity only during create. This enables the interaction to be editable and can enable merging of properties from multiple data sources based on precedence, which is defined at a link level.
   */
  isActivity?: boolean;
}

/**
 * Describes a profile type participating in an interaction.
 */
model Participant {
  /**
   * Profile type name.
   */
  profileTypeName: string;

  /**
   * The property references.
   */
  participantPropertyReferences: ParticipantPropertyReference[];

  /**
   * Participant name.
   */
  participantName: string;

  /**
   * Localized display name.
   */
  displayName?: Record<string>;

  /**
   * Localized descriptions.
   */
  description?: Record<string>;

  /**
   * The role that the participant is playing in the interaction.
   */
  role?: string;
}

/**
 * The participant property reference.
 */
model ParticipantPropertyReference {
  /**
   * The source property that maps to the target property.
   */
  sourcePropertyName: string;

  /**
   * The target property that maps to the source property.
   */
  targetPropertyName: string;
}

/**
 * The response of suggest relationship links operation.
 */
model SuggestRelationshipLinksResponse {
  /**
   * The interaction name.
   */
  @visibility("read")
  interactionName?: string;

  /**
   * Suggested relationships for the type.
   */
  @visibility("read")
  suggestedRelationships?: RelationshipsLookup[];
}

/**
 * The definition of suggested relationship for the type.
 */
model RelationshipsLookup {
  /**
   * The relationship profile.
   */
  @visibility("read")
  profileName?: string;

  /**
   * The property references for the profile type.
   */
  @visibility("read")
  profilePropertyReferences?: ParticipantProfilePropertyReference[];

  /**
   * The related profile.
   */
  @visibility("read")
  relatedProfileName?: string;

  /**
   * The property references for the related profile type.
   */
  @visibility("read")
  relatedProfilePropertyReferences?: ParticipantProfilePropertyReference[];

  /**
   * The name of existing Relationship.
   */
  @visibility("read")
  existingRelationshipName?: string;
}

/**
 * The participant profile property reference.
 */
model ParticipantProfilePropertyReference {
  /**
   * The source interaction property that maps to the target profile property.
   */
  interactionPropertyName: string;

  /**
   * The target profile property that maps to the source interaction property.
   */
  profilePropertyName: string;
}

/**
 * The definition of Relationship.
 */
model RelationshipDefinition {
  /**
   * The Relationship Cardinality.
   */
  cardinality?: CardinalityTypes;

  /**
   * Localized display name for the Relationship.
   */
  displayName?: Record<string>;

  /**
   * Localized descriptions for the Relationship.
   */
  description?: Record<string>;

  /**
   * The expiry date time in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTimeUtc?: utcDateTime;

  /**
   * The properties of the Relationship.
   */
  fields?: PropertyDefinition[];

  /**
   * Optional property to be used to map fields in profile to their strong ids in related profile.
   */
  lookupMappings?: RelationshipTypeMapping[];

  /**
   * Profile type.
   */
  profileType: string;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * The Relationship name.
   */
  @visibility("read")
  relationshipName?: string;

  /**
   * Related profile being referenced.
   */
  relatedProfileType: string;

  /**
   * The relationship guid id.
   */
  @visibility("read")
  relationshipGuidId?: string;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * Maps fields in Profile to their corresponding StrongIds in Related Profile.
 */
model RelationshipTypeMapping {
  /**
   * Maps a profile property with the StrongId of related profile. This is an array to support StrongIds that are composite key as well.
   */
  fieldMappings: RelationshipTypeFieldMapping[];
}

/**
 * Map a field of profile to its corresponding StrongId in Related Profile.
 */
model RelationshipTypeFieldMapping {
  /**
   * Specifies the fieldName in profile.
   */
  profileFieldName: string;

  /**
   * Specifies the KeyProperty (from StrongId) of the related profile.
   */
  relatedProfileKeyProperty: string;
}

/**
 * The definition of relationship link.
 */
model RelationshipLinkDefinition {
  /**
   * Localized display name for the Relationship Link.
   */
  displayName?: Record<string>;

  /**
   * Localized descriptions for the Relationship Link.
   */
  description?: Record<string>;

  /**
   * The InteractionType associated with the Relationship Link.
   */
  interactionType: string;

  /**
   * The name of the Relationship Link.
   */
  @visibility("read")
  linkName?: string;

  /**
   * The mappings between Interaction and Relationship fields.
   */
  mappings?: RelationshipLinkFieldMapping[];

  /**
   * The property references for the Profile of the Relationship.
   */
  profilePropertyReferences: ParticipantProfilePropertyReference[];

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * The property references for the Related Profile of the Relationship.
   */
  relatedProfilePropertyReferences: ParticipantProfilePropertyReference[];

  /**
   * The Relationship associated with the Link.
   */
  relationshipName: string;

  /**
   * The relationship guid id.
   */
  @visibility("read")
  relationshipGuidId?: string;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * The fields mapping for Relationships.
 */
model RelationshipLinkFieldMapping {
  /**
   * The field name on the Interaction Type.
   */
  interactionFieldName: string;

  /**
   * Link type.
   */
  linkType?: LinkTypes;

  /**
   * The field name on the Relationship metadata.
   */
  relationshipFieldName: string;
}

/**
 * The authorization policy.
 */
model AuthorizationPolicy {
  /**
   * Name of the policy.
   */
  @visibility("read")
  policyName?: string;

  /**
   * The permissions associated with the policy.
   */
  permissions: PermissionTypes[];

  /**
   * Primary key associated with the policy.
   */
  primaryKey?: string;

  /**
   * Secondary key associated with the policy.
   */
  secondaryKey?: string;
}

/**
 * Properties of connector.
 */
model Connector {
  /**
   * ID of the connector.
   */
  @visibility("read")
  connectorId?: int32;

  /**
   * Name of the connector.
   */
  connectorName?: string;

  /**
   * Type of connector.
   */
  connectorType: ConnectorTypes;

  /**
   * Display name of the connector.
   */
  displayName?: string;

  /**
   * Description of the connector.
   */
  description?: string;

  /**
   * The connector properties.
   */
  connectorProperties: Record<Record<unknown>>;

  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * State of connector.
   */
  @visibility("read")
  state?: ConnectorStates;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * If this is an internal connector.
   */
  isInternal?: boolean;
}

/**
 * The connector mapping definition.
 */
model ConnectorMapping {
  /**
   * The connector name.
   */
  @visibility("read")
  connectorName?: string;

  /**
   * Type of connector.
   */
  connectorType?: ConnectorTypes;

  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * Defines which entity type the file should map to.
   */
  entityType: EntityTypes;

  /**
   * The mapping entity name.
   */
  entityTypeName: string;

  /**
   * The connector mapping name
   */
  @visibility("read")
  connectorMappingName?: string;

  /**
   * Display name for the connector mapping.
   */
  displayName?: string;

  /**
   * The description of the connector mapping.
   */
  description?: string;

  /**
   * The DataFormat ID.
   */
  @visibility("read")
  dataFormatId?: string;

  /**
   * The properties of the mapping.
   */
  mappingProperties: ConnectorMappingProperties;

  /**
   * The next run time based on customer's settings.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTime?: utcDateTime;

  /**
   * The RunId.
   */
  @visibility("read")
  runId?: string;

  /**
   * State of connector mapping.
   */
  @visibility("read")
  state?: ConnectorMappingStates;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * The connector mapping properties.
 */
model ConnectorMappingProperties {
  /**
   * The folder path for the mapping.
   */
  folderPath?: string;

  /**
   * The file filter for the mapping.
   */
  fileFilter?: string;

  /**
   * If the file contains a header or not.
   */
  hasHeader?: boolean;

  /**
   * The error management setting for the mapping.
   */
  errorManagement: ConnectorMappingErrorManagement;

  /**
   * The format of mapping property.
   */
  format: ConnectorMappingFormat;

  /**
   * The availability of mapping property.
   */
  availability: ConnectorMappingAvailability;

  /**
   * Ingestion mapping information at property level.
   */
  structure: ConnectorMappingStructure[];

  /**
   * The operation after import is done.
   */
  completeOperation: ConnectorMappingCompleteOperation;
}

/**
 * The error management.
 */
model ConnectorMappingErrorManagement {
  /**
   * The type of error management to use for the mapping.
   */
  errorManagementType: ErrorManagementTypes;

  /**
   * The error limit allowed while importing data.
   */
  errorLimit?: int32;
}

/**
 * Connector mapping property format.
 */
model ConnectorMappingFormat {
  /**
   * The type mapping format.
   */
  formatType: "TextFormat";

  /**
   * The character that signifies a break between columns.
   */
  columnDelimiter?: string;

  /**
   * The oData language.
   */
  acceptLanguage?: string;

  /**
   * Quote character, used to indicate enquoted fields.
   */
  quoteCharacter?: string;

  /**
   * Escape character for quotes, can be the same as the quoteCharacter.
   */
  quoteEscapeCharacter?: string;

  /**
   * Character separating array elements.
   */
  arraySeparator?: string;
}

/**
 * Connector mapping property availability.
 */
model ConnectorMappingAvailability {
  /**
   * The frequency to update.
   */
  frequency?: FrequencyTypes;

  /**
   * The interval of the given frequency to use.
   */
  interval: int32;
}

/**
 * Connector mapping property structure.
 */
model ConnectorMappingStructure {
  /**
   * The property name of the mapping entity.
   */
  propertyName: string;

  /**
   * The column name of the import file.
   */
  columnName: string;

  /**
   * Custom format specifier for input parsing.
   */
  customFormatSpecifier?: string;

  /**
   * Indicates if the column is encrypted.
   */
  isEncrypted?: boolean;
}

/**
 * The complete operation.
 */
model ConnectorMappingCompleteOperation {
  /**
   * The type of completion operation.
   */
  completionOperationType?: CompletionOperationTypes;

  /**
   * The destination folder where files will be moved to once the import is done.
   */
  destinationFolder?: string;
}

/**
 * Definition of WidgetType.
 */
model WidgetType {
  /**
   * Name of the widget type.
   */
  @visibility("read")
  widgetTypeName?: string;

  /**
   * Definition for widget type.
   */
  definition: string;

  /**
   * Description for widget type.
   */
  description?: string;

  /**
   * Localized display name for the widget type.
   */
  displayName?: Record<string>;

  /**
   * The image URL.
   */
  imageUrl?: string;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The widget version.
   */
  widgetVersion?: string;

  /**
   * Date time when widget type was last modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changed?: utcDateTime;

  /**
   * Date time when widget type was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;
}

/**
 * The view in Customer 360 web application.
 */
model View {
  /**
   * Name of the view.
   */
  @visibility("read")
  viewName?: string;

  /**
   * the user ID.
   */
  userId?: string;

  /**
   * the hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Localized display name for the view.
   */
  displayName?: Record<string>;

  /**
   * View definition.
   */
  definition: string;

  /**
   * Date time when view was last modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changed?: utcDateTime;

  /**
   * Date time when view was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;
}

/**
 * The definition of Link.
 */
model LinkDefinition {
  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The link name.
   */
  @visibility("read")
  linkName?: string;

  /**
   * Type of source entity.
   */
  sourceEntityType: EntityType;

  /**
   * Type of target entity.
   */
  targetEntityType: EntityType;

  /**
   * Name of the source Entity Type.
   */
  sourceEntityTypeName: string;

  /**
   * Name of the target Entity Type.
   */
  targetEntityTypeName: string;

  /**
   * Localized display name for the Link.
   */
  displayName?: Record<string>;

  /**
   * Localized descriptions for the Link.
   */
  description?: Record<string>;

  /**
   * The set of properties mappings between the source and target Types.
   */
  mappings?: TypePropertiesMapping[];

  /**
   * The properties that represent the participating profile.
   */
  participantPropertyReferences: ParticipantPropertyReference[];

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Indicating whether the link is reference only link. This flag is ignored if the Mappings are defined. If the mappings are not defined and it is set to true, links processing will not create or update profiles.
   */
  referenceOnly?: boolean;

  /**
   * Determines whether this link is supposed to create or delete instances if Link is NOT Reference Only.
   */
  operationType?: InstanceOperationType;
}

/**
 * Metadata for a Link's property mapping.
 */
model TypePropertiesMapping {
  /**
   *  Property name on the source Entity Type.
   */
  sourcePropertyName: string;

  /**
   * Property name on the target Entity Type.
   */
  targetPropertyName: string;

  /**
   * Link type.
   */
  linkType?: LinkTypes;
}

/**
 * The response of list role assignment operation.
 */
model RoleListResult is Azure.Core.Page<RoleResourceFormat>;

/**
 * The role resource format.
 */
model RoleResourceFormat extends ProxyResource {
  /**
   * The Role definition.
   */
  properties?: Role;
}

/**
 * The Role definition.
 */
model Role {
  /**
   * The role name.
   */
  roleName?: string;

  /**
   * The description of the role.
   */
  description?: string;
}

/**
 * The Role Assignment definition.
 */
model RoleAssignment {
  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The name of the metadata object.
   */
  @visibility("read")
  assignmentName?: string;

  /**
   * Localized display names for the metadata.
   */
  displayName?: Record<string>;

  /**
   * Localized description for the metadata.
   */
  description?: Record<string>;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Type of roles.
   */
  role: RoleTypes;

  /**
   * The principals being assigned to.
   */
  principals: AssignmentPrincipal[];

  /**
   * Profiles set for the assignment.
   */
  profiles?: ResourceSetDescription;

  /**
   * Interactions set for the assignment.
   */
  interactions?: ResourceSetDescription;

  /**
   * Links set for the assignment.
   */
  links?: ResourceSetDescription;

  /**
   * Kpis set for the assignment.
   */
  kpis?: ResourceSetDescription;

  /**
   * Sas Policies set for the assignment.
   */
  sasPolicies?: ResourceSetDescription;

  /**
   * Connectors set for the assignment.
   */
  connectors?: ResourceSetDescription;

  /**
   * Views set for the assignment.
   */
  views?: ResourceSetDescription;

  /**
   * The Role assignments set for the relationship links.
   */
  relationshipLinks?: ResourceSetDescription;

  /**
   * The Role assignments set for the relationships.
   */
  relationships?: ResourceSetDescription;

  /**
   * Widget types set for the assignment.
   */
  widgetTypes?: ResourceSetDescription;

  /**
   * The Role assignments set for the assignment.
   */
  roleAssignments?: ResourceSetDescription;

  /**
   * Widget types set for the assignment.
   */
  conflationPolicies?: ResourceSetDescription;

  /**
   * The Role assignments set for the assignment.
   */
  segments?: ResourceSetDescription;
}

/**
 * The AssignmentPrincipal
 */
model AssignmentPrincipal {
  /**
   * The principal id being assigned to.
   */
  principalId: string;

  /**
   * The Type of the principal ID.
   */
  principalType: string;

  /**
   * Other metadata for the principal.
   */
  principalMetadata?: Record<string>;
}

/**
 * The resource set description.
 */
model ResourceSetDescription {
  /**
   * The elements included in the set.
   */
  elements?: string[];

  /**
   * The elements that are not included in the set, in case elements contains '*' indicating 'all'.
   */
  exceptions?: string[];
}

/**
 * Input type for getting image upload url.
 */
model GetImageUploadUrlInput {
  /**
   * Type of entity. Can be Profile or Interaction.
   */
  entityType?: string;

  /**
   * Name of the entity type.
   */
  entityTypeName?: string;

  /**
   * Relative path of the image.
   */
  relativePath?: string;
}

/**
 * The image definition.
 */
model ImageDefinition {
  /**
   * Whether image exists already.
   */
  imageExists?: boolean;

  /**
   * Content URL for the image blob.
   */
  contentUrl?: string;

  /**
   * Relative path of the image.
   */
  relativePath?: string;
}

/**
 * The prediction definition.
 */
model Prediction {
  /**
   * Description of the prediction.
   */
  description?: Record<string>;

  /**
   * Display name of the prediction.
   */
  displayName?: Record<string>;

  /**
   * Interaction types involved in the prediction.
   */
  involvedInteractionTypes?: string[];

  /**
   * KPI types involved in the prediction.
   */
  involvedKpiTypes?: string[];

  /**
   * Relationships involved in the prediction.
   */
  involvedRelationships?: string[];

  /**
   * Negative outcome expression.
   */
  negativeOutcomeExpression: string;

  /**
   * Positive outcome expression.
   */
  positiveOutcomeExpression: string;

  /**
   * Primary profile type.
   */
  primaryProfileType: string;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningStates;

  /**
   * Name of the prediction.
   */
  predictionName?: string;

  /**
   * Scope expression.
   */
  scopeExpression: string;

  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Whether do auto analyze.
   */
  autoAnalyze: boolean;

  /**
   * Definition of the link mapping of prediction.
   */
  mappings: PredictionMappings;

  /**
   * Score label.
   */
  scoreLabel: string;

  /**
   * The prediction grades.
   */
  grades?: PredictionGradesItem[];

  /**
   * System generated entities.
   */
  @visibility("read")
  systemGeneratedEntities?: PredictionSystemGeneratedEntities;
}

/**
 * Definition of the link mapping of prediction.
 */
model PredictionMappings {
  /**
   * The score of the link mapping.
   */
  score: string;

  /**
   * The grade of the link mapping.
   */
  grade: string;

  /**
   * The reason of the link mapping.
   */
  reason: string;
}

/**
 * The definition of a prediction grade.
 */
model PredictionGradesItem {
  /**
   * Name of the grade.
   */
  gradeName?: string;

  /**
   * Minimum score threshold.
   */
  minScoreThreshold?: int32;

  /**
   * Maximum score threshold.
   */
  maxScoreThreshold?: int32;
}

/**
 * System generated entities.
 */
model PredictionSystemGeneratedEntities {
  /**
   * Generated interaction types.
   */
  generatedInteractionTypes?: string[];

  /**
   * Generated links.
   */
  generatedLinks?: string[];

  /**
   * Generated KPIs.
   */
  generatedKpis?: Record<string>;
}

/**
 * The training results of the prediction.
 */
model PredictionTrainingResults {
  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Score name.
   */
  @visibility("read")
  scoreName?: string;

  /**
   * Prediction distribution.
   */
  @visibility("read")
  predictionDistribution?: PredictionDistributionDefinition;

  /**
   * Canonical profiles.
   */
  @visibility("read")
  canonicalProfiles?: CanonicalProfileDefinition[];

  /**
   * Instance count of the primary profile.
   */
  @visibility("read")
  primaryProfileInstanceCount?: int64;
}

/**
 * The definition of the prediction distribution.
 */
model PredictionDistributionDefinition {
  /**
   * Total positive in the distribution.
   */
  totalPositives?: int64;

  /**
   * Total negatives in the distribution.
   */
  totalNegatives?: int64;

  /**
   * Distributions of the prediction.
   */
  distributions?: PredictionDistributionDefinitionDistributionsItem[];
}

/**
 * The definition of a prediction distribution.
 */
model PredictionDistributionDefinitionDistributionsItem {
  /**
   * Score threshold.
   */
  scoreThreshold?: int32;

  /**
   * Number of positives.
   */
  positives?: int64;

  /**
   * Number of negatives.
   */
  negatives?: int64;

  /**
   * Number of positives above threshold.
   */
  positivesAboveThreshold?: int64;

  /**
   * Number of negatives above threshold.
   */
  negativesAboveThreshold?: int64;
}

/**
 * Definition of canonical profile.
 */
model CanonicalProfileDefinition {
  /**
   * Canonical profile ID.
   */
  canonicalProfileId?: int32;

  /**
   * Properties of the canonical profile.
   */
  properties?: CanonicalProfileDefinitionPropertiesItem[];
}

/**
 * The definition of a canonical profile property.
 */
model CanonicalProfileDefinitionPropertiesItem {
  /**
   * Profile name.
   */
  profileName?: string;

  /**
   * Property name of profile.
   */
  profilePropertyName?: string;

  /**
   * The rank.
   */
  rank?: int32;

  /**
   * Type of canonical property value.
   */
  type?: CanonicalPropertyValueType;

  /**
   * Value of the canonical property.
   */
  value?: string;
}

/**
 * The prediction model status.
 */
model PredictionModelStatus {
  /**
   * The hub name.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The prediction name.
   */
  @visibility("read")
  predictionName?: string;

  /**
   * The prediction GUID ID.
   */
  @visibility("read")
  predictionGuidId?: string;

  /**
   * Prediction model life cycle.  When prediction is in PendingModelConfirmation status, it is allowed to update the status to PendingFeaturing or Active through API.
   */
  status: PredictionModelLifeCycle;

  /**
   * The model status message.
   */
  @visibility("read")
  message?: string;

  /**
   * Count of the training set.
   */
  @visibility("read")
  trainingSetCount?: int32;

  /**
   * Count of the test set.
   */
  @visibility("read")
  testSetCount?: int32;

  /**
   * Count of the validation set.
   */
  @visibility("read")
  validationSetCount?: int32;

  /**
   * The training accuracy.
   */
  @visibility("read")
  trainingAccuracy?: decimal;

  /**
   * The signals used.
   */
  @visibility("read")
  signalsUsed?: int32;

  /**
   * Version of the model.
   */
  @visibility("read")
  modelVersion?: string;
}

/**
 * Salesforce discover setting.
 */
model SalesforceDiscoverSetting {
  /**
   * The salesforce connection string secret URL.
   */
  salesforceConnectionStringSecretUrl: string;
}

/**
 * Salesforce table.
 */
model SalesforceTable {
  /**
   * Indicating whether this instance is profile.
   */
  isProfile?: string;

  /**
   * The table category.
   */
  tableCategory: string;

  /**
   * The name of the table.
   */
  tableName: string;

  /**
   * The table remarks.
   */
  tableRemarks?: string;

  /**
   * The table schema.
   */
  tableSchema: string;
}

/**
 * The Salesforce connector properties.
 */
model SalesforceConnectorProperties {
  /**
   * The user settings.
   */
  usersetting: SalesforceDiscoverSetting;

  /**
   * The Salesforce tables.
   */
  salesforcetables: SalesforceTable[];
}

/**
 * The Azure Blob connector properties.
 */
model AzureBlobConnectorProperties {
  /**
   * The connection KeyVault URL.
   */
  connectionKeyVaultUrl: string;
}

/**
 * The CRM connector properties.
 */
model CrmConnectorProperties {
  /**
   * The connection string.
   */
  connectionString?: string;

  /**
   * The organization ID.
   */
  organizationId: string;

  /**
   * The organization URL.
   */
  organizationUrl: string;

  /**
   * The entities like account, contact, opportunity.
   */
  entities: CrmConnectorEntities[];

  /**
   * The access token.
   */
  accessToken?: string;
}

/**
 * The CRM connector entities.
 */
model CrmConnectorEntities {
  /**
   * The logical name.
   */
  logicalName: string;

  /**
   * The display name.
   */
  displayName?: string;

  /**
   * Indicating whether this is profile.
   */
  isProfile?: boolean;
}

/**
 * The enriching KPI definition.
 */
model EnrichingKpi extends KpiDefinition {}
