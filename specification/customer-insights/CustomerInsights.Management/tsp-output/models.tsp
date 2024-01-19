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

@doc("The data source type.")
enum DataSourceType {
  Connector,
  LinkInteraction,
  SystemDefault,
}

@doc("The data source status.")
enum Status {
  None,
  Active,
  Deleted,
}

@doc("Provisioning state.")
enum ProvisioningStates {
  Provisioning,
  Succeeded,
  Expiring,
  Deleting,
  HumanIntervention,
  Failed,
}

@doc("Type of connector.")
enum ConnectorTypes {
  None,
  CRM,
  AzureBlob,
  Salesforce,
  ExchangeOnline,
  Outbound,
}

@doc("Type of canonical property value.")
enum CanonicalPropertyValueType {
  Numeric,
  Categorical,
  DerivedCategorical,
  DerivedNumeric,
}

@doc("Prediction model life cycle.  When prediction is in PendingModelConfirmation status, it is allowed to update the status to PendingFeaturing or Active through API.")
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

@doc("Type of entity.")
@fixed
enum EntityTypes {
  None,
  Profile,
  Interaction,
  Relationship,
}

@doc("The calculation window.")
@fixed
enum CalculationWindowTypes {
  Lifetime,
  Hour,
  Day,
  Week,
  Month,
}

@doc("The computation function for the KPI.")
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

@doc("The Relationship Cardinality.")
@fixed
enum CardinalityTypes {
  OneToOne,
  OneToMany,
  ManyToMany,
}

@doc("Link type.")
@fixed
enum LinkTypes {
  UpdateAlways,
  CopyIfNull,
}

@doc("Supported permission types.")
@fixed
enum PermissionTypes {
  Read,
  Write,
  Manage,
}

@doc("State of connector.")
@fixed
enum ConnectorStates {
  Creating,
  Created,
  Ready,
  Expiring,
  Deleting,
  Failed,
}

@doc("The type of error management to use for the mapping.")
@fixed
enum ErrorManagementTypes {
  RejectAndContinue,
  StopImport,
  RejectUntilLimit,
}

@doc("The frequency to update.")
@fixed
enum FrequencyTypes {
  Minute,
  Hour,
  Day,
  Week,
  Month,
}

@doc("The type of completion operation.")
@fixed
enum CompletionOperationTypes {
  DoNothing,
  DeleteFile,
  MoveFile,
}

@doc("State of connector mapping.")
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

@doc("Type of source entity.")
@fixed
enum EntityType {
  None,
  Profile,
  Interaction,
  Relationship,
}

@doc("Determines whether this link is supposed to create or delete instances if Link is NOT Reference Only.")
@fixed
enum InstanceOperationType {
  Upsert,
  Delete,
}

@doc("Type of roles.")
@fixed
enum RoleTypes {
  Admin,
  Reader,
  ManageAdmin,
  ManageReader,
  DataAdmin,
  DataReader,
}

@doc("Properties of hub.")
model HubPropertiesFormat {
  @doc("API endpoint URL of the hub.")
  @visibility("read")
  apiEndpoint?: string;

  @doc("Web endpoint URL of the hub.")
  @visibility("read")
  webEndpoint?: string;

  @doc("Provisioning state of the hub.")
  @visibility("read")
  provisioningState?: string;

  @doc("The bit flags for enabled hub features. Bit 0 is set to 1 indicates graph is enabled, or disabled if set to 0. Bit 1 is set to 1 indicates the hub is disabled, or enabled if set to 0.")
  tenantFeatures?: int32;

  @doc("Billing settings of the hub.")
  hubBillingInfo?: HubBillingInfoFormat;
}

@doc("Hub billing info.")
model HubBillingInfoFormat {
  @doc("The sku name.")
  skuName?: string;

  @doc("The minimum number of units will be billed. One unit is 10,000 Profiles and 100,000 Interactions.")
  @maxValue(10)
  @minValue(1)
  minUnits?: int32;

  @doc("The maximum number of units can be used.  One unit is 10,000 Profiles and 100,000 Interactions.")
  @maxValue(10)
  @minValue(1)
  maxUnits?: int32;
}

@doc("Common properties of Azure resource.")
model Resource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Resource location.")
  location?: string;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("The profile type definition.")
model ProfileTypeDefinition extends EntityTypeDefinition {
  @doc("The strong IDs.")
  strongIds?: StrongId[];
}

@doc("Property/Properties which represent a unique ID.")
model StrongId {
  @doc("The properties which make up the unique ID.")
  keyPropertyNames: string[];

  @doc("The Name identifying the strong ID.")
  strongIdName: string;

  @doc("Localized display name.")
  displayName?: Record<string>;

  @doc("Localized descriptions.")
  description?: Record<string>;
}

@doc("Describes an entity.")
model EntityTypeDefinition extends MetadataDefinitionBase {
  @doc("The api entity set name. This becomes the odata entity set name for the entity Type being referred in this object.")
  apiEntitySetName?: string;

  @doc("Type of entity.")
  entityType?: EntityTypes;

  @doc("The properties of the Profile.")
  fields?: PropertyDefinition[];

  @doc("The instance count.")
  instancesCount?: int32;

  @doc("The last changed time for the type definition.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChangedUtc?: utcDateTime;

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("The schema org link. This helps ACI identify and suggest semantic models.")
  schemaItemTypeLink?: string;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("The timestamp property name. Represents the time when the interaction or profile update happened.")
  timestampFieldName?: string;

  @doc("The name of the entity.")
  typeName?: string;
}

@doc("Property definition.")
model PropertyDefinition {
  @doc("Array value separator for properties with isArray set.")
  arrayValueSeparator?: string;

  @doc("Describes valid values for an enum property.")
  enumValidValues?: ProfileEnumValidValuesFormat[];

  @doc("Name of the property.")
  fieldName: string;

  @doc("Type of the property.")
  fieldType: string;

  @doc("Indicates if the property is actually an array of the fieldType above on the data api.")
  isArray?: boolean;

  @doc("Indicates if the property is an enum.")
  isEnum?: boolean;

  @doc("Indicates if the property is an flag enum.")
  isFlagEnum?: boolean;

  @doc("Whether the property is an Image.")
  isImage?: boolean;

  @doc("Whether the property is a localized string.")
  isLocalizedString?: boolean;

  @doc("Whether the property is a name or a part of name.")
  isName?: boolean;

  @doc("Whether property value is required on instances, IsRequired field only for Interaction. Profile Instance will not check for required field.")
  isRequired?: boolean;

  @doc("The ID associated with the property.")
  propertyId?: string;

  @doc("URL encoded schema.org item prop link for the property.")
  schemaItemPropLink?: string;

  @doc("Max length of string. Used only if type is string.")
  maxLength?: int32;

  @doc("Whether property is available in graph or not.")
  isAvailableInGraph?: boolean;

  @doc("This is specific to interactions modeled as activities. Data sources are used to determine where data is stored and also in precedence rules.")
  @visibility("read")
  dataSourcePrecedenceRules?: DataSourcePrecedence[];
}

@doc("Valid enum values in case of an enum property.")
model ProfileEnumValidValuesFormat {
  @doc("The integer value of the enum member.")
  value?: int32;

  @doc("Localized names of the enum member.")
  localizedValueNames?: Record<string>;
}

@doc("The data source precedence is a way to know the precedence of each data source.")
model DataSourcePrecedence {
  @doc("Data Source is a way for us to know the source of instances. A single type can have data coming in from multiple places. In activities we use this to determine precedence rules.")
  dataSource?: DataSource;

  @doc("the precedence value.")
  precedence?: int32;
}

@doc("Data Source is a way for us to know the source of instances. A single type can have data coming in from multiple places. In activities we use this to determine precedence rules.")
model DataSource {
  @doc("The data source name")
  @visibility("read")
  name?: string;

  @doc("The data source type.")
  @visibility("read")
  dataSourceType?: DataSourceType;

  @doc("The data source status.")
  @visibility("read")
  status?: Status;

  @doc("The data source ID.")
  @visibility("read")
  id?: int32;

  @doc("The data source reference id.")
  @visibility("read")
  dataSourceReferenceId?: string;
}

@doc("The Metadata definition base.")
model MetadataDefinitionBase {
  @doc("The attributes for the Type.")
  attributes?: Record<string[]>;

  @doc("Localized descriptions for the property.")
  description?: Record<string>;

  @doc("Localized display names for the property.")
  displayName?: Record<string>;

  @doc("Any custom localized attributes for the Type.")
  localizedAttributes?: Record<Record<string>>;

  @doc("Small Image associated with the Property or EntityType.")
  smallImage?: string;

  @doc("Medium Image associated with the Property or EntityType.")
  mediumImage?: string;

  @doc("Large Image associated with the Property or EntityType.")
  largeImage?: string;
}

@doc("Defines the KPI Threshold limits.")
model KpiDefinition {
  @doc("The mapping entity type.")
  entityType: EntityTypes;

  @doc("The mapping entity name.")
  entityTypeName: string;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("The KPI name.")
  @visibility("read")
  kpiName?: string;

  @doc("Localized display name for the KPI.")
  displayName?: Record<string>;

  @doc("Localized description for the KPI.")
  description?: Record<string>;

  @doc("The calculation window.")
  calculationWindow: CalculationWindowTypes;

  @doc("Name of calculation window field.")
  calculationWindowFieldName?: string;

  @doc("The computation function for the KPI.")
  function: KpiFunctions;

  @doc("The computation expression for the KPI.")
  expression: string;

  @doc("The unit of measurement for the KPI.")
  unit?: string;

  @doc("The filter expression for the KPI.")
  filter?: string;

  @doc("the group by properties for the KPI.")
  groupBy?: string[];

  @doc("The KPI GroupByMetadata.")
  @visibility("read")
  groupByMetadata?: KpiGroupByMetadata[];

  @doc("The participant profiles.")
  @visibility("read")
  participantProfilesMetadata?: KpiParticipantProfilesMetadata[];

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("The KPI thresholds.")
  thresHolds?: KpiThresholds;

  @doc("The aliases.")
  aliases?: KpiAlias[];

  @doc("The KPI extracts.")
  extracts?: KpiExtract[];
}

@doc("The KPI GroupBy field metadata.")
model KpiGroupByMetadata {
  @doc("The display name.")
  displayName?: Record<string>;

  @doc("The name of the field.")
  fieldName?: string;

  @doc("The type of the field.")
  fieldType?: string;
}

@doc("The KPI participant profile metadata.")
model KpiParticipantProfilesMetadata {
  @doc("Name of the type.")
  typeName: string;
}

@doc("Defines the KPI Threshold limits.")
model KpiThresholds {
  @doc("The lower threshold limit.")
  lowerLimit: float32;

  @doc("The upper threshold limit.")
  upperLimit: float32;

  @doc("Whether or not the KPI is an increasing KPI.")
  increasingKpi: boolean;
}

@doc("The KPI alias.")
model KpiAlias {
  @doc("KPI alias name.")
  aliasName: string;

  @doc("The expression.")
  expression: string;
}

@doc("The KPI extract.")
model KpiExtract {
  @doc("KPI extract name.")
  extractName: string;

  @doc("The expression.")
  expression: string;
}

@doc("The Interaction Type Definition")
model InteractionTypeDefinition extends EntityTypeDefinition {
  @doc("The id property names. Properties which uniquely identify an interaction instance.")
  idPropertyNames?: string[];

  @doc("Profiles that participated in the interaction.")
  participantProfiles?: Participant[];

  @doc("The primary participant property name for an interaction ,This is used to logically represent the agent of the interaction, Specify the participant name here from ParticipantName.")
  primaryParticipantProfilePropertyName?: string;

  @doc("This is specific to interactions modeled as activities. Data sources are used to determine where data is stored and also in precedence rules.")
  @visibility("read")
  dataSourcePrecedenceRules?: DataSourcePrecedence[];

  @doc("Default data source is specifically used in cases where data source is not specified in an instance.")
  defaultDataSource?: DataSource;

  @doc("An interaction can be tagged as an activity only during create. This enables the interaction to be editable and can enable merging of properties from multiple data sources based on precedence, which is defined at a link level.")
  isActivity?: boolean;
}

@doc("Describes a profile type participating in an interaction.")
model Participant {
  @doc("Profile type name.")
  profileTypeName: string;

  @doc("The property references.")
  participantPropertyReferences: ParticipantPropertyReference[];

  @doc("Participant name.")
  participantName: string;

  @doc("Localized display name.")
  displayName?: Record<string>;

  @doc("Localized descriptions.")
  description?: Record<string>;

  @doc("The role that the participant is playing in the interaction.")
  role?: string;
}

@doc("The participant property reference.")
model ParticipantPropertyReference {
  @doc("The source property that maps to the target property.")
  sourcePropertyName: string;

  @doc("The target property that maps to the source property.")
  targetPropertyName: string;
}

@doc("The response of suggest relationship links operation.")
model SuggestRelationshipLinksResponse {
  @doc("The interaction name.")
  @visibility("read")
  interactionName?: string;

  @doc("Suggested relationships for the type.")
  @visibility("read")
  suggestedRelationships?: RelationshipsLookup[];
}

@doc("The definition of suggested relationship for the type.")
model RelationshipsLookup {
  @doc("The relationship profile.")
  @visibility("read")
  profileName?: string;

  @doc("The property references for the profile type.")
  @visibility("read")
  profilePropertyReferences?: ParticipantProfilePropertyReference[];

  @doc("The related profile.")
  @visibility("read")
  relatedProfileName?: string;

  @doc("The property references for the related profile type.")
  @visibility("read")
  relatedProfilePropertyReferences?: ParticipantProfilePropertyReference[];

  @doc("The name of existing Relationship.")
  @visibility("read")
  existingRelationshipName?: string;
}

@doc("The participant profile property reference.")
model ParticipantProfilePropertyReference {
  @doc("The source interaction property that maps to the target profile property.")
  interactionPropertyName: string;

  @doc("The target profile property that maps to the source interaction property.")
  profilePropertyName: string;
}

@doc("The definition of Relationship.")
model RelationshipDefinition {
  @doc("The Relationship Cardinality.")
  cardinality?: CardinalityTypes;

  @doc("Localized display name for the Relationship.")
  displayName?: Record<string>;

  @doc("Localized descriptions for the Relationship.")
  description?: Record<string>;

  @doc("The expiry date time in UTC.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTimeUtc?: utcDateTime;

  @doc("The properties of the Relationship.")
  fields?: PropertyDefinition[];

  @doc("Optional property to be used to map fields in profile to their strong ids in related profile.")
  lookupMappings?: RelationshipTypeMapping[];

  @doc("Profile type.")
  profileType: string;

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("The Relationship name.")
  @visibility("read")
  relationshipName?: string;

  @doc("Related profile being referenced.")
  relatedProfileType: string;

  @doc("The relationship guid id.")
  @visibility("read")
  relationshipGuidId?: string;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;
}

@doc("Maps fields in Profile to their corresponding StrongIds in Related Profile.")
model RelationshipTypeMapping {
  @doc("Maps a profile property with the StrongId of related profile. This is an array to support StrongIds that are composite key as well.")
  fieldMappings: RelationshipTypeFieldMapping[];
}

@doc("Map a field of profile to its corresponding StrongId in Related Profile.")
model RelationshipTypeFieldMapping {
  @doc("Specifies the fieldName in profile.")
  profileFieldName: string;

  @doc("Specifies the KeyProperty (from StrongId) of the related profile.")
  relatedProfileKeyProperty: string;
}

@doc("The definition of relationship link.")
model RelationshipLinkDefinition {
  @doc("Localized display name for the Relationship Link.")
  displayName?: Record<string>;

  @doc("Localized descriptions for the Relationship Link.")
  description?: Record<string>;

  @doc("The InteractionType associated with the Relationship Link.")
  interactionType: string;

  @doc("The name of the Relationship Link.")
  @visibility("read")
  linkName?: string;

  @doc("The mappings between Interaction and Relationship fields.")
  mappings?: RelationshipLinkFieldMapping[];

  @doc("The property references for the Profile of the Relationship.")
  profilePropertyReferences: ParticipantProfilePropertyReference[];

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("The property references for the Related Profile of the Relationship.")
  relatedProfilePropertyReferences: ParticipantProfilePropertyReference[];

  @doc("The Relationship associated with the Link.")
  relationshipName: string;

  @doc("The relationship guid id.")
  @visibility("read")
  relationshipGuidId?: string;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;
}

@doc("The fields mapping for Relationships.")
model RelationshipLinkFieldMapping {
  @doc("The field name on the Interaction Type.")
  interactionFieldName: string;

  @doc("Link type.")
  linkType?: LinkTypes;

  @doc("The field name on the Relationship metadata.")
  relationshipFieldName: string;
}

@doc("The authorization policy.")
model AuthorizationPolicy {
  @doc("Name of the policy.")
  @visibility("read")
  policyName?: string;

  @doc("The permissions associated with the policy.")
  permissions: PermissionTypes[];

  @doc("Primary key associated with the policy.")
  primaryKey?: string;

  @doc("Secondary key associated with the policy.")
  secondaryKey?: string;
}

@doc("Properties of connector.")
model Connector {
  @doc("ID of the connector.")
  @visibility("read")
  connectorId?: int32;

  @doc("Name of the connector.")
  connectorName?: string;

  @doc("Type of connector.")
  connectorType: ConnectorTypes;

  @doc("Display name of the connector.")
  displayName?: string;

  @doc("Description of the connector.")
  description?: string;

  @doc("The connector properties.")
  connectorProperties: Record<Record<unknown>>;

  @doc("The created time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("State of connector.")
  @visibility("read")
  state?: ConnectorStates;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("If this is an internal connector.")
  isInternal?: boolean;
}

@doc("The connector mapping definition.")
model ConnectorMapping {
  @doc("The connector name.")
  @visibility("read")
  connectorName?: string;

  @doc("Type of connector.")
  connectorType?: ConnectorTypes;

  @doc("The created time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("Defines which entity type the file should map to.")
  entityType: EntityTypes;

  @doc("The mapping entity name.")
  entityTypeName: string;

  @doc("The connector mapping name")
  @visibility("read")
  connectorMappingName?: string;

  @doc("Display name for the connector mapping.")
  displayName?: string;

  @doc("The description of the connector mapping.")
  description?: string;

  @doc("The DataFormat ID.")
  @visibility("read")
  dataFormatId?: string;

  @doc("The properties of the mapping.")
  mappingProperties: ConnectorMappingProperties;

  @doc("The next run time based on customer's settings.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTime?: utcDateTime;

  @doc("The RunId.")
  @visibility("read")
  runId?: string;

  @doc("State of connector mapping.")
  @visibility("read")
  state?: ConnectorMappingStates;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;
}

@doc("The connector mapping properties.")
model ConnectorMappingProperties {
  @doc("The folder path for the mapping.")
  folderPath?: string;

  @doc("The file filter for the mapping.")
  fileFilter?: string;

  @doc("If the file contains a header or not.")
  hasHeader?: boolean;

  @doc("The error management setting for the mapping.")
  errorManagement: ConnectorMappingErrorManagement;

  @doc("The format of mapping property.")
  format: ConnectorMappingFormat;

  @doc("The availability of mapping property.")
  availability: ConnectorMappingAvailability;

  @doc("Ingestion mapping information at property level.")
  structure: ConnectorMappingStructure[];

  @doc("The operation after import is done.")
  completeOperation: ConnectorMappingCompleteOperation;
}

@doc("The error management.")
model ConnectorMappingErrorManagement {
  @doc("The type of error management to use for the mapping.")
  errorManagementType: ErrorManagementTypes;

  @doc("The error limit allowed while importing data.")
  errorLimit?: int32;
}

@doc("Connector mapping property format.")
model ConnectorMappingFormat {
  @doc("The type mapping format.")
  formatType: "TextFormat";

  @doc("The character that signifies a break between columns.")
  columnDelimiter?: string;

  @doc("The oData language.")
  acceptLanguage?: string;

  @doc("Quote character, used to indicate enquoted fields.")
  quoteCharacter?: string;

  @doc("Escape character for quotes, can be the same as the quoteCharacter.")
  quoteEscapeCharacter?: string;

  @doc("Character separating array elements.")
  arraySeparator?: string;
}

@doc("Connector mapping property availability.")
model ConnectorMappingAvailability {
  @doc("The frequency to update.")
  frequency?: FrequencyTypes;

  @doc("The interval of the given frequency to use.")
  interval: int32;
}

@doc("Connector mapping property structure.")
model ConnectorMappingStructure {
  @doc("The property name of the mapping entity.")
  propertyName: string;

  @doc("The column name of the import file.")
  columnName: string;

  @doc("Custom format specifier for input parsing.")
  customFormatSpecifier?: string;

  @doc("Indicates if the column is encrypted.")
  isEncrypted?: boolean;
}

@doc("The complete operation.")
model ConnectorMappingCompleteOperation {
  @doc("The type of completion operation.")
  completionOperationType?: CompletionOperationTypes;

  @doc("The destination folder where files will be moved to once the import is done.")
  destinationFolder?: string;
}

@doc("Definition of WidgetType.")
model WidgetType {
  @doc("Name of the widget type.")
  @visibility("read")
  widgetTypeName?: string;

  @doc("Definition for widget type.")
  definition: string;

  @doc("Description for widget type.")
  description?: string;

  @doc("Localized display name for the widget type.")
  displayName?: Record<string>;

  @doc("The image URL.")
  imageUrl?: string;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("The widget version.")
  widgetVersion?: string;

  @doc("Date time when widget type was last modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changed?: utcDateTime;

  @doc("Date time when widget type was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;
}

@doc("The view in Customer 360 web application.")
model View {
  @doc("Name of the view.")
  @visibility("read")
  viewName?: string;

  @doc("the user ID.")
  userId?: string;

  @doc("the hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("Localized display name for the view.")
  displayName?: Record<string>;

  @doc("View definition.")
  definition: string;

  @doc("Date time when view was last modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changed?: utcDateTime;

  @doc("Date time when view was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;
}

@doc("The definition of Link.")
model LinkDefinition {
  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("The link name.")
  @visibility("read")
  linkName?: string;

  @doc("Type of source entity.")
  sourceEntityType: EntityType;

  @doc("Type of target entity.")
  targetEntityType: EntityType;

  @doc("Name of the source Entity Type.")
  sourceEntityTypeName: string;

  @doc("Name of the target Entity Type.")
  targetEntityTypeName: string;

  @doc("Localized display name for the Link.")
  displayName?: Record<string>;

  @doc("Localized descriptions for the Link.")
  description?: Record<string>;

  @doc("The set of properties mappings between the source and target Types.")
  mappings?: TypePropertiesMapping[];

  @doc("The properties that represent the participating profile.")
  participantPropertyReferences: ParticipantPropertyReference[];

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Indicating whether the link is reference only link. This flag is ignored if the Mappings are defined. If the mappings are not defined and it is set to true, links processing will not create or update profiles.")
  referenceOnly?: boolean;

  @doc("Determines whether this link is supposed to create or delete instances if Link is NOT Reference Only.")
  operationType?: InstanceOperationType;
}

@doc("Metadata for a Link's property mapping.")
model TypePropertiesMapping {
  @doc(" Property name on the source Entity Type.")
  sourcePropertyName: string;

  @doc("Property name on the target Entity Type.")
  targetPropertyName: string;

  @doc("Link type.")
  linkType?: LinkTypes;
}

@doc("The response of list role assignment operation.")
model RoleListResult is Azure.Core.Page<RoleResourceFormat>;

@doc("The role resource format.")
model RoleResourceFormat extends ProxyResource {
  @doc("The Role definition.")
  properties?: Role;
}

@doc("The Role definition.")
model Role {
  @doc("The role name.")
  roleName?: string;

  @doc("The description of the role.")
  description?: string;
}

@doc("The Role Assignment definition.")
model RoleAssignment {
  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("The name of the metadata object.")
  @visibility("read")
  assignmentName?: string;

  @doc("Localized display names for the metadata.")
  displayName?: Record<string>;

  @doc("Localized description for the metadata.")
  description?: Record<string>;

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Type of roles.")
  role: RoleTypes;

  @doc("The principals being assigned to.")
  principals: AssignmentPrincipal[];

  @doc("Profiles set for the assignment.")
  profiles?: ResourceSetDescription;

  @doc("Interactions set for the assignment.")
  interactions?: ResourceSetDescription;

  @doc("Links set for the assignment.")
  links?: ResourceSetDescription;

  @doc("Kpis set for the assignment.")
  kpis?: ResourceSetDescription;

  @doc("Sas Policies set for the assignment.")
  sasPolicies?: ResourceSetDescription;

  @doc("Connectors set for the assignment.")
  connectors?: ResourceSetDescription;

  @doc("Views set for the assignment.")
  views?: ResourceSetDescription;

  @doc("The Role assignments set for the relationship links.")
  relationshipLinks?: ResourceSetDescription;

  @doc("The Role assignments set for the relationships.")
  relationships?: ResourceSetDescription;

  @doc("Widget types set for the assignment.")
  widgetTypes?: ResourceSetDescription;

  @doc("The Role assignments set for the assignment.")
  roleAssignments?: ResourceSetDescription;

  @doc("Widget types set for the assignment.")
  conflationPolicies?: ResourceSetDescription;

  @doc("The Role assignments set for the assignment.")
  segments?: ResourceSetDescription;
}

@doc("The AssignmentPrincipal")
model AssignmentPrincipal {
  @doc("The principal id being assigned to.")
  principalId: string;

  @doc("The Type of the principal ID.")
  principalType: string;

  @doc("Other metadata for the principal.")
  principalMetadata?: Record<string>;
}

@doc("The resource set description.")
model ResourceSetDescription {
  @doc("The elements included in the set.")
  elements?: string[];

  @doc("The elements that are not included in the set, in case elements contains '*' indicating 'all'.")
  exceptions?: string[];
}

@doc("Input type for getting image upload url.")
model GetImageUploadUrlInput {
  @doc("Type of entity. Can be Profile or Interaction.")
  entityType?: string;

  @doc("Name of the entity type.")
  entityTypeName?: string;

  @doc("Relative path of the image.")
  relativePath?: string;
}

@doc("The image definition.")
model ImageDefinition {
  @doc("Whether image exists already.")
  imageExists?: boolean;

  @doc("Content URL for the image blob.")
  contentUrl?: string;

  @doc("Relative path of the image.")
  relativePath?: string;
}

@doc("The prediction definition.")
model Prediction {
  @doc("Description of the prediction.")
  description?: Record<string>;

  @doc("Display name of the prediction.")
  displayName?: Record<string>;

  @doc("Interaction types involved in the prediction.")
  involvedInteractionTypes?: string[];

  @doc("KPI types involved in the prediction.")
  involvedKpiTypes?: string[];

  @doc("Relationships involved in the prediction.")
  involvedRelationships?: string[];

  @doc("Negative outcome expression.")
  negativeOutcomeExpression: string;

  @doc("Positive outcome expression.")
  positiveOutcomeExpression: string;

  @doc("Primary profile type.")
  primaryProfileType: string;

  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningStates;

  @doc("Name of the prediction.")
  predictionName?: string;

  @doc("Scope expression.")
  scopeExpression: string;

  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("Whether do auto analyze.")
  autoAnalyze: boolean;

  @doc("Definition of the link mapping of prediction.")
  mappings: PredictionMappings;

  @doc("Score label.")
  scoreLabel: string;

  @doc("The prediction grades.")
  grades?: PredictionGradesItem[];

  @doc("System generated entities.")
  @visibility("read")
  systemGeneratedEntities?: PredictionSystemGeneratedEntities;
}

@doc("Definition of the link mapping of prediction.")
model PredictionMappings {
  @doc("The score of the link mapping.")
  score: string;

  @doc("The grade of the link mapping.")
  grade: string;

  @doc("The reason of the link mapping.")
  reason: string;
}

@doc("The definition of a prediction grade.")
model PredictionGradesItem {
  @doc("Name of the grade.")
  gradeName?: string;

  @doc("Minimum score threshold.")
  minScoreThreshold?: int32;

  @doc("Maximum score threshold.")
  maxScoreThreshold?: int32;
}

@doc("System generated entities.")
model PredictionSystemGeneratedEntities {
  @doc("Generated interaction types.")
  generatedInteractionTypes?: string[];

  @doc("Generated links.")
  generatedLinks?: string[];

  @doc("Generated KPIs.")
  generatedKpis?: Record<string>;
}

@doc("The training results of the prediction.")
model PredictionTrainingResults {
  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("Score name.")
  @visibility("read")
  scoreName?: string;

  @doc("Prediction distribution.")
  @visibility("read")
  predictionDistribution?: PredictionDistributionDefinition;

  @doc("Canonical profiles.")
  @visibility("read")
  canonicalProfiles?: CanonicalProfileDefinition[];

  @doc("Instance count of the primary profile.")
  @visibility("read")
  primaryProfileInstanceCount?: int32;
}

@doc("The definition of the prediction distribution.")
model PredictionDistributionDefinition {
  @doc("Total positive in the distribution.")
  totalPositives?: int32;

  @doc("Total negatives in the distribution.")
  totalNegatives?: int32;

  @doc("Distributions of the prediction.")
  distributions?: PredictionDistributionDefinitionDistributionsItem[];
}

@doc("The definition of a prediction distribution.")
model PredictionDistributionDefinitionDistributionsItem {
  @doc("Score threshold.")
  scoreThreshold?: int32;

  @doc("Number of positives.")
  positives?: int32;

  @doc("Number of negatives.")
  negatives?: int32;

  @doc("Number of positives above threshold.")
  positivesAboveThreshold?: int32;

  @doc("Number of negatives above threshold.")
  negativesAboveThreshold?: int32;
}

@doc("Definition of canonical profile.")
model CanonicalProfileDefinition {
  @doc("Canonical profile ID.")
  canonicalProfileId?: int32;

  @doc("Properties of the canonical profile.")
  properties?: CanonicalProfileDefinitionPropertiesItem[];
}

@doc("The definition of a canonical profile property.")
model CanonicalProfileDefinitionPropertiesItem {
  @doc("Profile name.")
  profileName?: string;

  @doc("Property name of profile.")
  profilePropertyName?: string;

  @doc("The rank.")
  rank?: int32;

  @doc("Type of canonical property value.")
  type?: CanonicalPropertyValueType;

  @doc("Value of the canonical property.")
  value?: string;
}

@doc("The prediction model status.")
model PredictionModelStatus {
  @doc("The hub name.")
  @visibility("read")
  tenantId?: string;

  @doc("The prediction name.")
  @visibility("read")
  predictionName?: string;

  @doc("The prediction GUID ID.")
  @visibility("read")
  predictionGuidId?: string;

  @doc("Prediction model life cycle.  When prediction is in PendingModelConfirmation status, it is allowed to update the status to PendingFeaturing or Active through API.")
  status: PredictionModelLifeCycle;

  @doc("The model status message.")
  @visibility("read")
  message?: string;

  @doc("Count of the training set.")
  @visibility("read")
  trainingSetCount?: int32;

  @doc("Count of the test set.")
  @visibility("read")
  testSetCount?: int32;

  @doc("Count of the validation set.")
  @visibility("read")
  validationSetCount?: int32;

  @doc("The training accuracy.")
  @visibility("read")
  trainingAccuracy?: float32;

  @doc("The signals used.")
  @visibility("read")
  signalsUsed?: int32;

  @doc("Version of the model.")
  @visibility("read")
  modelVersion?: string;
}

@doc("Salesforce discover setting.")
model SalesforceDiscoverSetting {
  @doc("The salesforce connection string secret URL.")
  salesforceConnectionStringSecretUrl: string;
}

@doc("Salesforce table.")
model SalesforceTable {
  @doc("Indicating whether this instance is profile.")
  isProfile?: string;

  @doc("The table category.")
  tableCategory: string;

  @doc("The name of the table.")
  tableName: string;

  @doc("The table remarks.")
  tableRemarks?: string;

  @doc("The table schema.")
  tableSchema: string;
}

@doc("The Salesforce connector properties.")
model SalesforceConnectorProperties {
  @doc("The user settings.")
  usersetting: SalesforceDiscoverSetting;

  @doc("The Salesforce tables.")
  salesforcetables: SalesforceTable[];
}

@doc("The Azure Blob connector properties.")
model AzureBlobConnectorProperties {
  @doc("The connection KeyVault URL.")
  connectionKeyVaultUrl: string;
}

@doc("The CRM connector properties.")
model CrmConnectorProperties {
  @doc("The connection string.")
  connectionString?: string;

  @doc("The organization ID.")
  organizationId: string;

  @doc("The organization URL.")
  organizationUrl: string;

  @doc("The entities like account, contact, opportunity.")
  entities: CrmConnectorEntities[];

  @doc("The access token.")
  accessToken?: string;
}

@doc("The CRM connector entities.")
model CrmConnectorEntities {
  @doc("The logical name.")
  logicalName: string;

  @doc("The display name.")
  displayName?: string;

  @doc("Indicating whether this is profile.")
  isProfile?: boolean;
}

@doc("The enriching KPI definition.")
model EnrichingKpi extends KpiDefinition {}
