import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataCatalogClient;

union MicrosoftPurviewDataGovernanceBillingServiceClientEntitiesBillingType {
  integer,
  `0`: 0,
}

union MicrosoftPurviewDataGovernanceCatalogModelStatus {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
}

union MicrosoftPurviewDataGovernanceCatalogModelMetadataAttributeFieldTypeEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
  `7`: 7,
  `8`: 8,
  `9`: 9,
  `10`: 10,
  `11`: 11,
}

union MicrosoftPurviewActiveGlossaryModelsServiceSharedRelationshipType {
  integer,
  `0`: 0,
  `1`: 1,
  `2`: 2,
}

union MicrosoftPurviewDataGovernanceCatalogModelAttributeInstanceFieldTypeEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
  `7`: 7,
  `8`: 8,
  `9`: 9,
  `10`: 10,
  `11`: 11,
}

union MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElementDataTypeEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
}

union MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus {
  integer,
  `0`: 0,
  `1`: 1,
  `2`: 2,
}

union MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationshipRelationshipTypeEnum {
  integer,
  `1`: 1,
  `2`: 2,
}

union MicrosoftPurviewDataGovernanceCatalogModelDataProductTypeEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
  `7`: 7,
  `8`: 8,
  `9`: 9,
  `10`: 10,
  `11`: 11,
  `12`: 12,
  `13`: 13,
  `14`: 14,
  `15`: 15,
}

union MicrosoftPurviewDataGovernanceCatalogModelDataProductUpdateFrequencyEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
}

union MicrosoftPurviewDataGovernanceCatalogModelDataProductAudienceEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
  `7`: 7,
  `8`: 8,
}

union MicrosoftPurviewDataGovernanceCatalogModelDomainStatusEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
}

union MicrosoftPurviewDataGovernanceCatalogModelDomainTypeEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
}

union MicrosoftPurviewDataGovernanceCatalogModelRelatedCollectionParentCollectionTypeEnum {
  integer,
  `1`: 1,
}

union MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalPropertiesStatusEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
}

union MicrosoftPurviewDataGovernanceCatalogModelObjectiveAdditionalPropertiesOverallStatusEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
}

union MicrosoftPurviewActiveGlossaryModelsServiceOkrObjectiveStatus {
  integer,
  `0`: 0,
  `1`: 1,
  `2`: 2,
}

union MicrosoftPurviewDataGovernanceCatalogModelKeyResultStatusEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
}

union MicrosoftPurviewDataGovernanceCatalogModelConceptType {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
}

union MicrosoftPurviewDataGovernanceCatalogModelWorkflowMetadataStatusEnum {
  integer,
  `1`: 1,
  `2`: 2,
}

union MicrosoftPurviewDataGovernanceCatalogModelApproverMetadataActionEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
}

union MicrosoftPurviewDataGovernanceCatalogModelWorkflowRunsStatusEnum {
  integer,
  `1`: 1,
  `2`: 2,
  `3`: 3,
}

union MicrosoftPurviewActiveGlossaryModelsServiceEntityCategory {
  integer,
  `0`: 0,
  `1`: 1,
  `2`: 2,
  `3`: 3,
  `4`: 4,
  `5`: 5,
  `6`: 6,
  `7`: 7,
  `8`: 8,
  `9`: 9,
  `10`: 10,
  `11`: 11,
  `12`: 12,
  `13`: 13,
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationGlobalAssetCleanupRequest {
  dryRun?: boolean;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBusinessDomainObjectBackfillRequest {
  dryRun?: boolean;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationAssetMissingPropertiesRequest {
  dryRun?: boolean;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBillingEventBackfillRequest {
  events?: MicrosoftPurviewDataGovernanceBillingServiceClientEntitiesExtendedBillingEvent[];
}

model MicrosoftPurviewDataGovernanceBillingServiceClientEntitiesExtendedBillingEvent {
  logOnly?: boolean;
  billingEvent?: MicrosoftPurviewDataGovernanceBillingServiceClientEntitiesBillingEvent;
}

model MicrosoftPurviewDataGovernanceBillingServiceClientEntitiesBillingEvent {
  @format("uuid")
  id?: string;

  recordType?: int32;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  operation?: string;

  @format("uuid")
  organizationId?: string;

  userType?: int32;
  userKey?: string;
  workload?: string;
  resultStatus?: string;
  objectId?: string;
  userId?: string;
  clientIP?: string;
  scope?: int32;
  appAccessContext?: MicrosoftPurviewDataGovernanceAuditAPIEntitiesPartnerAuditRecordAppAccessContext;
  solutionName?: string;
  solutionScenario?: string;
  consumptionValue?: float64;
  consumptionValueUnit?: string;
  consumptionType?: string;
  billingType?: MicrosoftPurviewDataGovernanceBillingServiceClientEntitiesBillingType;
  additionalInfo?: string;
  correlationId?: string;
  tags?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingEndDate?: utcDateTime;

  reportingDimensions?: string;
  billingRegion?: string;
  resourceId?: string;
}

model MicrosoftPurviewDataGovernanceAuditAPIEntitiesPartnerAuditRecordAppAccessContext {
  aadSessionId?: string;
  apiId?: string;
  clientAppId?: string;
  clientAppName?: string;
  correlationId?: string;
  uniqueTokenId?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issuedAtTime?: utcDateTime;
}

model MicrosoftPurviewDataGovernanceCatalogModelMetadataAttribute {
  status?: MicrosoftPurviewDataGovernanceCatalogModelStatus;
  fieldType?: MicrosoftPurviewDataGovernanceCatalogModelMetadataAttributeFieldTypeEnum;

  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;
  description?: string;
  defaultValue?: string;

  @format("uuid")
  domain?: string;

  isOptional?: boolean;
  choices?: MicrosoftPurviewDataGovernanceCatalogModelChoice[];
}

model MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @format("uuid")
  createdBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  @format("uuid")
  lastModifiedBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiredAt?: utcDateTime;

  @format("uuid")
  expiredBy?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelChoice {
  value?: string;
  ordinal?: int32;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsMetadataAttributeMetadataAttributeRelationship {
  description?: string;

  @format("uuid")
  entityId?: string;

  relationshipType?: MicrosoftPurviewActiveGlossaryModelsServiceSharedRelationshipType;
}

model MicrosoftPurviewDataGovernanceCatalogModelAttributeInstance {
  fieldType?: MicrosoftPurviewDataGovernanceCatalogModelAttributeInstanceFieldTypeEnum;

  @format("uuid")
  id?: string;

  name?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @format("uuid")
  createdBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  @format("uuid")
  lastModifiedBy?: string;

  @format("uuid")
  domain?: string;

  @format("uuid")
  attributeId?: string;

  value?: string;
  choices?: MicrosoftPurviewDataGovernanceCatalogModelChoice[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsMetadataAttributeAttributeInstanceRelationship {
  @format("uuid")
  entityId?: string;

  relationshipType?: MicrosoftPurviewActiveGlossaryModelsServiceSharedRelationshipType;

  @format("uuid")
  value?: string;
}

model MicrosoftPurviewActiveGlossaryModelsServiceBillingBillingRequest {
  aggregationType?: string;
  aggregationByProperties?: string[];
  dimensions?: string[];
  tags?: string[];
  filters?: MicrosoftPurviewActiveGlossaryModelsServiceBillingFilterConditions[];
  dimensionFilters?: MicrosoftPurviewActiveGlossaryModelsServiceBillingFilter[];
  tagFilters?: MicrosoftPurviewActiveGlossaryModelsServiceBillingFilter[];
  binFunction?: string;
}

model MicrosoftPurviewActiveGlossaryModelsServiceBillingFilterConditions {
  filterProperty?: string;
  filterCondition?: string;
  filterValue?: string;
}

model MicrosoftPurviewActiveGlossaryModelsServiceBillingFilter {
  name?: string;
  value?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelCriticalDataColumn {
  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;

  @format("uuid")
  domain?: string;

  @format("uuid")
  assetId?: string;

  description?: string;
  classifications?: string[];
  dataType?: string;
  assetName?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement {
  status?: MicrosoftPurviewDataGovernanceCatalogModelStatus;
  dataType?: MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElementDataTypeEnum;

  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;

  @format("uuid")
  domain?: string;

  description?: string;

  /**
   * Dictionary of
   * <components·hxkref·schemas·microsoft-purview-datagovernance-catalog-model-criticaldataelement·properties·contacts·additionalproperties>
   */
  contacts?: Record<MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner[]>;

  managedAttributes?: MicrosoftPurviewDataGovernanceCatalogModelManagedAttribute[];
}

model MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner {
  @format("uuid")
  id?: string;

  description?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelManagedAttribute {
  name?: string;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCriticalDataElementCriticalDataElementQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  owners?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus[];
  managedAttributes?: MicrosoftPurviewActiveGlossaryModelsServiceSharedSearchManageAttributeSearchFilter[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy {
  field?: string;
  direction?: string;
}

model MicrosoftPurviewActiveGlossaryModelsServiceSharedSearchManageAttributeSearchFilter {
  field?: string;
  operator?: string;

  /**
   * Anything
   */
  value?: unknown;

  type?: string;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCriticalDataElementCriticalDataElementFacetRequest {
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  owners?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus[];
  facets?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsFacetRequestObject[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsFacetRequestObject {
  name?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelCustomMetadata {
  status?: MicrosoftPurviewDataGovernanceCatalogModelStatus;

  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;
  description?: string;

  /**
   * Dictionary of
   * <components·1u7h6ji·schemas·microsoft-purview-datagovernance-catalog-model-custommetadata·properties·contacts·additionalproperties>
   */
  contacts?: Record<MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner[]>;

  @format("uuid")
  domain?: string;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCustomMetadataCustomMetadataQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  owners?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
}

model MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationship {
  relationshipType?: MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationshipRelationshipTypeEnum;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemData;
  description?: string;

  @format("uuid")
  entityId?: string;

  properties?: MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationshipProperties;
}

model MicrosoftPurviewDataGovernanceCatalogModelSystemData {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @format("uuid")
  createdBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  @format("uuid")
  lastModifiedBy?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationshipProperties {
  value?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelDataAsset {
  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;
  description?: string;

  @format("uuid")
  domain?: string;

  source?: MicrosoftPurviewDataGovernanceCatalogModelDataAssetSource;

  /**
   * Dictionary of
   * <components·q49vw8·schemas·microsoft-purview-datagovernance-catalog-model-dataasset·properties·contacts·additionalproperties>
   */
  contacts?: Record<MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner[]>;

  classifications?: string[];

  @format("uuid")
  sensitivityLabel?: string;

  type?: string;
  schema?: MicrosoftPurviewDataGovernanceCatalogModelDataAssetSchema[];

  /**
   * Anything
   */
  lineage?: unknown;

  dataQualityScore?: float64;
  openInURL?: string;

  /**
   * Anything
   */
  typeProperties?: unknown;
}

model MicrosoftPurviewDataGovernanceCatalogModelDataAssetSource {
  type?: string;

  @format("uuid")
  assetId?: string;

  assetType?: string;

  /**
   * Anything
   */
  assetAttributes?: unknown;

  fqn?: string;
  accountName?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefreshedAt?: utcDateTime;

  @format("uuid")
  lastRefreshedBy?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelDataAssetSchema {
  name?: string;
  description?: string;
  classifications?: string[];
  type?: string;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataAssetDataAssetQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  owners?: string[];
  dataMapAssetIds?: string[];
}

model MicrosoftAzureProjectBabylonMetadataModelsAccountServiceModel {
  accountStatusModel?: MicrosoftAzureProjectBabylonMetadataModelsAccountStatusModel;
  auditModel?: MicrosoftAzureProjectBabylonMetadataModelsAuditModel;
  cloudConnectors?: MicrosoftAzureProjectBabylonMetadataModelsCloudConnectors;

  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  createdBy?: string;

  @visibility(Lifecycle.Read)
  createdByObjectId?: string;

  @visibility(Lifecycle.Read)
  createMode?: string;

  dataFactoryAccount?: MicrosoftAzureProjectBabylonMetadataModelsDataFactoryAccount;

  @visibility(Lifecycle.Read)
  defaultCatalogId?: string;

  @visibility(Lifecycle.Read)
  defaultCollectionName?: string;

  encryption?: MicrosoftAzureProjectBabylonMetadataModelsEncryptionModel;
  endpoints?: MicrosoftAzureProjectBabylonMetadataModelsAccountEndpoints;
  eventHubAccessKeyInfo?: MicrosoftAzureProjectBabylonMetadataModelsEventHubAccessKeyInfo;

  @visibility(Lifecycle.Read)
  hookKafkaConfigurations?: MicrosoftAzureProjectBabylonMetadataModelsHookKafkaConfigurationServiceModel[];

  @visibility(Lifecycle.Read)
  id?: string;

  identity?: MicrosoftAzureProjectBabylonMetadataModelsManagedIdentityInfo;
  ingestionStorageModel?: MicrosoftAzureProjectBabylonMetadataModelsIngestionStorageModel;

  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  location?: string;

  @visibility(Lifecycle.Read)
  managedResourcesPublicNetworkAccess?: string;

  mergeInfo?: MicrosoftAzureProjectBabylonMetadataModelsMergeInfoModel;

  @visibility(Lifecycle.Read)
  name?: string;

  networkAcls?: MicrosoftAzureProjectBabylonMetadataModelsNetworkAcls;
  notificationKafkaConfigurations?: MicrosoftAzureProjectBabylonMetadataModelsNotificationKafkaConfigurationServiceModel;
  previousAccountState?: MicrosoftAzureProjectBabylonMetadataModelsPreviousAccountStateServiceModel;

  @visibility(Lifecycle.Read)
  privateLinkIds?: int32[];

  processingStorageModel?: MicrosoftAzureProjectBabylonMetadataModelsProcessingStorageModel;

  @visibility(Lifecycle.Read)
  provisioningState?: string;

  reconciliationConfig?: MicrosoftAzureProjectBabylonMetadataModelsReconciliationConfigServiceModel;

  @visibility(Lifecycle.Read)
  resourceId?: string;

  @visibility(Lifecycle.Read)
  resourceType?: string;

  sku?: MicrosoftAzureProjectBabylonMetadataModelsAccountSkuModel;

  @visibility(Lifecycle.Read)
  softDeleteRetentionInDays?: int32;

  @visibility(Lifecycle.Read)
  storageAccounts?: MicrosoftAzureProjectBabylonMetadataModelsManagedResourceServiceModel[];

  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Dictionary of <string>
   */
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  @visibility(Lifecycle.Read)
  tenantId?: string;

  @visibility(Lifecycle.Read)
  useArtifactStore?: boolean;
}

model MicrosoftAzureProjectBabylonMetadataModelsAccountStatusModel {
  accountExceptionMessageModel?: MicrosoftAzureProjectBabylonMetadataModelsAccountExceptionMessageModel;
  accountProvisioningState?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsAccountExceptionMessageModel {
  correlationId?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  exceptionDateTime?: utcDateTime;

  exceptionErrorCode?: string;
  exceptionMessage?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsAuditModel {
  auditIngestionEndpoint?: string;
  tenantForest?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsCloudConnectors {
  @visibility(Lifecycle.Read)
  awsExternalId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsDataFactoryAccount {
  apiVersion?: string;
  baseManagementUri?: string;
  factoryId?: string;
  location?: string;
  name?: string;
  processingStorageLinkedServiceName?: string;
  resourceGroup?: string;
  subscription?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsEncryptionModel {
  systemMasterKey?: MicrosoftAzureProjectBabylonMetadataModelsKeyEncryptionKey;
}

model MicrosoftAzureProjectBabylonMetadataModelsKeyEncryptionKey {
  id?: string;
  keyVaultResourceId?: string;
  type?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsAccountEndpoints {
  @visibility(Lifecycle.Read)
  catalog?: string;

  @visibility(Lifecycle.Read)
  scan?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsEventHubAccessKeyInfo {
  eventHubName?: string;
  externalKeys?: MicrosoftAzureProjectBabylonMetadataModelsEventHubAccessKeys;
  internalKeys?: MicrosoftAzureProjectBabylonMetadataModelsEventHubAccessKeys;
  managedResource?: boolean;
  resourceGroup?: string;
  subscriptionId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsEventHubAccessKeys {
  keyName?: string;
  primaryConnectionString?: string;
  secondaryConnectionString?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsHookKafkaConfigurationServiceModel {
  consumerGroup?: string;
  credentials?: MicrosoftAzureProjectBabylonMetadataModelsCredentials;
  eventHubResourceId?: string;
  eventHubType?: string;
  eventStreamingState?: string;
  eventStreamingType?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsCredentials {
  identityId?: string;
  type?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsManagedIdentityInfo {
  clientId?: string;
  identityUrl?: string;
  managedIdentityType?: string;
  principalId?: string;
  tenantId?: string;

  /**
   * Dictionary of
   * <Microsoft.Azure.ProjectBabylon.Metadata.Models.UserAssignedIdentityModel>
   */
  userAssignedIdentities?: Record<MicrosoftAzureProjectBabylonMetadataModelsUserAssignedIdentityModel>;
}

model MicrosoftAzureProjectBabylonMetadataModelsUserAssignedIdentityModel {
  authenticationEndpoint?: string;
  clientId?: string;
  clientSecretUrl?: string;
  principalId?: string;
  tenantId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsIngestionStorageModel {
  dnsZone?: string;
  endpointSuffix?: string;
  location?: string;
  name?: string;
  primaryEndpoint?: string;
  publicNetworkAccess?: string;
  resourceId?: string;
  sku?: string;

  @format("uuid")
  tenantId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsMergeInfoModel {
  @format("uuid")
  accountId?: string;

  accountLocation?: string;
  accountResourceId?: string;
  mergeStatus?: string;
  typeOfAccount?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsNetworkAcls {
  defaultAction?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsNotificationKafkaConfigurationServiceModel {
  credentials?: MicrosoftAzureProjectBabylonMetadataModelsCredentials;
  eventHubResourceId?: string;
  eventHubType?: string;
  eventStreamingState?: string;
  eventStreamingType?: string;
  partitionId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsPreviousAccountStateServiceModel {
  resourceType?: string;
  sku?: MicrosoftAzureProjectBabylonMetadataModelsAccountSkuModel;
}

model MicrosoftAzureProjectBabylonMetadataModelsAccountSkuModel {
  capacity?: int32;
  name?: string;
  version?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsProcessingStorageModel {
  dnsZone?: string;
  endpointSuffix?: string;
  location?: string;
  name?: string;
  primaryEndpoint?: string;
  resourceId?: string;
  sku?: string;

  @format("uuid")
  tenantId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsReconciliationConfigServiceModel {
  reconciliationStatus?: string;

  @format("uuid")
  tenantId?: string;
}

model MicrosoftAzureProjectBabylonMetadataModelsManagedResourceServiceModel {
  @visibility(Lifecycle.Read)
  dnsZone?: string;

  @visibility(Lifecycle.Read)
  endpointSuffix?: string;

  @visibility(Lifecycle.Read)
  location?: string;

  @visibility(Lifecycle.Read)
  name?: string;

  @visibility(Lifecycle.Read)
  primaryEndpoint?: string;

  @visibility(Lifecycle.Read)
  resourceId?: string;

  @visibility(Lifecycle.Read)
  sku?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelDataProduct {
  status?: MicrosoftPurviewDataGovernanceCatalogModelStatus;
  type?: MicrosoftPurviewDataGovernanceCatalogModelDataProductTypeEnum;
  updateFrequency?: MicrosoftPurviewDataGovernanceCatalogModelDataProductUpdateFrequencyEnum;
  managedAttributes?: MicrosoftPurviewDataGovernanceCatalogModelManagedAttribute[];

  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;

  @format("uuid")
  domain?: string;

  description?: string;
  businessUse?: string;

  /**
   * Dictionary of
   * <components·dc89vp·schemas·microsoft-purview-datagovernance-catalog-model-dataproduct·properties·contacts·additionalproperties>
   */
  contacts?: Record<MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner[]>;

  termsOfUse?: MicrosoftPurviewDataGovernanceCatalogModelExternalLink[];
  documentation?: MicrosoftPurviewDataGovernanceCatalogModelExternalLink[];
  sensitivityLabel?: string;
  endorsed?: boolean;
  activeSubscriberCount?: int32;
  dataQualityScore?: float64;
  audience?: MicrosoftPurviewDataGovernanceCatalogModelDataProductAudienceEnum[];
  additionalProperties?: MicrosoftPurviewDataGovernanceCatalogModelDataProductAllOfAdditionalProperties;
}

model MicrosoftPurviewDataGovernanceCatalogModelExternalLink {
  url?: string;
  name?: string;

  @format("uuid")
  dataAssetId?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelDataProductAllOfAdditionalProperties {
  assetCount?: int64;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataProductQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  type?: string;
  types?: string[];
  owners?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus[];
  managedAttributes?: MicrosoftPurviewActiveGlossaryModelsServiceSharedSearchManageAttributeSearchFilter[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataProductFacetRequest {
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  owners?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus[];
  type?: string;
  types?: string[];
  facets?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsFacetRequestObject[];
}

model MicrosoftPurviewDataGovernanceCatalogModelDomain {
  status?: MicrosoftPurviewDataGovernanceCatalogModelDomainStatusEnum;
  type?: MicrosoftPurviewDataGovernanceCatalogModelDomainTypeEnum;

  @format("uuid")
  id?: string;

  name?: string;
  isRestricted?: boolean;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;
  description?: string;

  @format("uuid")
  parentId?: string;

  thumbnail?: MicrosoftPurviewDataGovernanceCatalogModelDomainAllOfThumbnail;
  domains?: MicrosoftPurviewDataGovernanceCatalogModelPlatformDomain[];
  managedAttributes?: MicrosoftPurviewDataGovernanceCatalogModelManagedAttribute[];
}

model MicrosoftPurviewDataGovernanceCatalogModelDomainAllOfThumbnail {
  color?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelPlatformDomain {
  name?: string;
  friendlyName?: string;
  relatedCollections?: MicrosoftPurviewDataGovernanceCatalogModelRelatedCollection[];
}

model MicrosoftPurviewDataGovernanceCatalogModelRelatedCollection {
  name?: string;
  friendlyName?: string;
  parentCollection?: MicrosoftPurviewDataGovernanceCatalogModelRelatedCollectionParentCollection;
}

model MicrosoftPurviewDataGovernanceCatalogModelRelatedCollectionParentCollection {
  type?: MicrosoftPurviewDataGovernanceCatalogModelRelatedCollectionParentCollectionTypeEnum;
  refName?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalProperties {
  status?: MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalPropertiesStatusEnum;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithClosed;

  @format("uuid")
  id?: string;

  definition?: string;

  @format("uuid")
  domain?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetDate?: utcDateTime;

  /**
   * Dictionary of
   * <components·1qqzdxi·schemas·microsoft-purview-datagovernance-catalog-model-objectivewithadditionalproperties·properties·contacts·additionalproperties>
   */
  contacts?: Record<MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner[]>;

  additionalProperties?: MicrosoftPurviewDataGovernanceCatalogModelObjectiveAdditionalProperties;
}

model MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithClosed {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @format("uuid")
  createdBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  @format("uuid")
  lastModifiedBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  closedAt?: utcDateTime;

  @format("uuid")
  closedBy?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelObjectiveAdditionalProperties {
  overallStatus?: MicrosoftPurviewDataGovernanceCatalogModelObjectiveAdditionalPropertiesOverallStatusEnum;
  overallProgress?: float64;
  overallGoal?: float64;
  overallMax?: float64;
  keyResultsCount?: int64;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsObjectiveQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  iDs?: string[];
  domainIDs?: string[];
  definition?: string;
  status?: MicrosoftPurviewActiveGlossaryModelsServiceOkrObjectiveStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceOkrObjectiveStatus[];
  owners?: string[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsObjectiveFacetRequest {
  iDs?: string[];
  domainIDs?: string[];
  definition?: string;
  owners?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceOkrObjectiveStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceOkrObjectiveStatus[];
  facets?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsFacetRequestObject[];
}

model MicrosoftPurviewDataGovernanceCatalogModelKeyResult {
  status?: MicrosoftPurviewDataGovernanceCatalogModelKeyResultStatusEnum;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemData;

  @format("uuid")
  id?: string;

  definition?: string;

  @format("uuid")
  domainId?: string;

  progress?: float64;
  goal?: float64;
  max?: float64;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsPolicyAddAdminRequest {
  userObjectId?: string;
}

model MicrosoftPurviewDataGovernanceCatalogModelTerm {
  status?: MicrosoftPurviewDataGovernanceCatalogModelStatus;

  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemDataWithExpired;
  description?: string;

  /**
   * Dictionary of
   * <components·qhlu6r·schemas·microsoft-purview-datagovernance-catalog-model-term·properties·contacts·additionalproperties>
   */
  contacts?: Record<MicrosoftPurviewDataGovernanceCatalogModelContactsValueInner[]>;

  @format("uuid")
  domain?: string;

  @format("uuid")
  parentId?: string;

  acronyms?: string[];
  resources?: MicrosoftPurviewDataGovernanceCatalogModelTermResource[];
  isLeaf?: boolean;
  managedAttributes?: MicrosoftPurviewDataGovernanceCatalogModelManagedAttribute[];
}

model MicrosoftPurviewDataGovernanceCatalogModelTermResource {
  name?: string;
  url?: string;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus[];
  owners?: string[];
  acronyms?: string[];
  managedAttributes?: MicrosoftPurviewActiveGlossaryModelsServiceSharedSearchManageAttributeSearchFilter[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermFacetRequest {
  iDs?: string[];
  domainIDs?: string[];
  nameKeyword?: string;
  owners?: string[];
  acronyms?: string[];
  status?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus;
  multiStatus?: MicrosoftPurviewActiveGlossaryModelsServiceSharedEntityStatus[];
  facets?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsFacetRequestObject[];
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermRelationship {
  description?: string;

  @format("uuid")
  entityId?: string;

  relationshipType?: MicrosoftPurviewActiveGlossaryModelsServiceSharedRelationshipType;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermsMoveRequest {
  @format("uuid")
  destinationDomainId?: string;

  termIds?: string[];
}

model MicrosoftPurviewDataGovernanceCatalogModelWorkflows {
  @format("uuid")
  id?: string;

  name?: string;
  systemData?: MicrosoftPurviewDataGovernanceCatalogModelSystemData;

  @format("uuid")
  domain?: string;

  workflowMetadata?: MicrosoftPurviewDataGovernanceCatalogModelWorkflowMetadata[];
}

model MicrosoftPurviewDataGovernanceCatalogModelWorkflowMetadata {
  conceptType?: MicrosoftPurviewDataGovernanceCatalogModelConceptType;
  status?: MicrosoftPurviewDataGovernanceCatalogModelWorkflowMetadataStatusEnum;
  approverMetadata?: MicrosoftPurviewDataGovernanceCatalogModelApproverMetadata[];
}

model MicrosoftPurviewDataGovernanceCatalogModelApproverMetadata {
  action?: MicrosoftPurviewDataGovernanceCatalogModelApproverMetadataActionEnum;
  approvers?: MicrosoftPurviewDataGovernanceCatalogModelApprovers[];
}

model MicrosoftPurviewDataGovernanceCatalogModelApprovers {
  @format("uuid")
  id?: string;

  description?: string;
  email?: string;
}

model MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsWorkflowRunQueryRequest {
  skip?: int32;
  top?: int32;
  orderBy?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsOrderBy[];
  conceptId?: string;
  conceptType?: MicrosoftPurviewDataGovernanceCatalogModelConceptType;
  workflowRunAction?: MicrosoftPurviewDataGovernanceCatalogModelApproverMetadataActionEnum;
  workflowRunStatus?: MicrosoftPurviewDataGovernanceCatalogModelWorkflowRunsStatusEnum;
  domain?: string;
  conceptName?: string;

  @format("uuid")
  createdBy?: string;
}
