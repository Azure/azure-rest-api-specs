import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace purviewdatacatalog;

@route("/administration/globalizeDataAssets")
@post
op administrationGlobalizeDataAssets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationGlobalAssetCleanupRequest,
  void
>;

@route("/administration/backfillDomainParentObject")
@post
op administrationBackfillDomainParentObject is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBusinessDomainObjectBackfillRequest,
  void
>;

@route("/administration/findInconsistentGraphRecords")
@post
op administrationFindInconsistentGraphRecords is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBusinessDomainObjectBackfillRequest,
  void
>;

@route("/administration/findAssetsWithMandatoryMissingProperties")
@post
op administrationFindAssetsWithMandatoryMissingProperties is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationAssetMissingPropertiesRequest,
  void
>;

@route("/administration/batchBackfillBillingEvents")
@post
op administrationBatchBackfillBillingEvents is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBillingEventBackfillRequest,
  void
>;

@route("/attributes/{name}")
@put
op attributeName is Azure.Core.Foundations.Operation<
  {
    @path
    name: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelMetadataAttribute;
  },
  void
>;

@route("/attributes")
@get
op getAttribute is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;

    @query("orderBy")
    orderBy?: string;
  },
  void
>;

@route("/attributes/{attributeId}/GetAsync")
@get
op attributeAttributeId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    attributeId: string;
  },
  void
>;

@route("/attributes/{attributeId}/DeleteAsync")
@delete
op attribute is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    attributeId: string;
  },
  void
>;

@route("/attributes/{attributeId}/relationships")
@post
op attributesAttributeIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    attributeId: string;

    @query("entityType")
    entityType?: unknown;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsMetadataAttributeMetadataAttributeRelationship;
  },
  void
>;

@route("/attributes/{attributeId}/relationships")
@delete
op deleteAttribute is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    attributeId: string;

    @query("entityType")
    entityType?: unknown;

    @format("uuid")
    @query("entityId")
    entityId?: string;
  },
  void
>;

@route("/attributes/{attributeId}/relationships")
@get
op getsAttribute is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    attributeId: string;

    @query("entityType")
    entityType?: unknown;
  },
  void
>;

@route("/attributes/instances")
@post
op attributeInstanceInstances is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelAttributeInstance;
  },
  void
>;

@route("/attributes/instances")
@get
op attributeInstance is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;

    @query("orderBy")
    orderBy?: string;
  },
  void
>;

@route("/attributes/instances/{instanceId}")
@put
op attributeInstanceInstanceId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelAttributeInstance;
  },
  void
>;

@route("/attributes/instances/{instanceId}")
@get
op getAttributeInstance is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;
  },
  void
>;

@route("/attributes/instances/{instanceId}")
@delete
op deleteAttributeInstance is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;
  },
  void
>;

@route("/attributes/instances/{instanceId}/relationships")
@post
op attributeInstanceInstanceIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;

    @query("entityType")
    entityType?: unknown;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsMetadataAttributeAttributeInstanceRelationship;
  },
  void
>;

@route("/attributes/instances/{instanceId}/relationships")
@delete
op deletesAttributeInstance is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;

    @query("entityType")
    entityType?: unknown;

    @format("uuid")
    @query("entityId")
    entityId?: string;
  },
  void
>;

@route("/attributes/instances/{instanceId}/relationships")
@get
op getsAttributeInstance is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    instanceId: string;

    @query("entityType")
    entityType?: unknown;
  },
  void
>;

@route("/billing/getaggregate")
@post
op billingGetaggregate is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryModelsServiceBillingBillingRequest,
  void
>;

@route("/billing/getaggregates")
@post
op billingGetaggregates is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryModelsServiceBillingBillingRequest,
  void
>;

@route("/snapshots/catalog/latest")
@get
op catalogSnapshotLatest is Azure.Core.Foundations.Operation<{}, void>;

@route("/snapshots/catalog/latest/metadata")
@get
op catalogSnapshotLatestMetadata is Azure.Core.Foundations.Operation<{}, void>;

@route("/snapshots/catalog/history/{snapshotId}")
@get
op catalogSnapshotHistorySnapshotId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    snapshotId: string;
  },
  void
>;

@route("/snapshots/catalog/history/{snapshotId}/metadata")
@get
op catalogSnapshotHistorySnapshotIdMetadata is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    snapshotId: string;
  },
  void
>;

@route("/snapshots/catalog/history")
@get
op catalogSnapshotHistory is Azure.Core.Foundations.Operation<{}, void>;

@route("/snapshots/catalog/configure/install/{repeatIntervalMinutes}")
@post
op catalogSnapshotConfigureInstallRepeatIntervalMinutes is Azure.Core.Foundations.Operation<
  {
    @path
    repeatIntervalMinutes: int32;
  },
  void
>;

@route("/snapshots/catalog/configure/uninstall")
@post
op catalogSnapshotConfigureUninstall is Azure.Core.Foundations.Operation<
  {},
  void
>;

@route("/snapshots/catalog/configure/status")
@get
op catalogSnapshotConfigureStatus is Azure.Core.Foundations.Operation<{}, void>;

@route("/criticalDataColumns")
@post
op postCriticalDataColumn is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataColumn,
  void
>;

@route("/criticalDataColumns")
@get
op criticalDataColumn is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @format("uuid")
    @query("assetId")
    assetId?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;

    @query("orderBy")
    orderBy?: string;
  },
  void
>;

@route("/criticalDataColumns/{criticalDataColumnId}")
@get
op criticalDataColumnCriticalDataColumnId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataColumnId: string;
  },
  void
>;

@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@post
op criticalDataColumnCriticalDataColumnIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataColumnId: string;

    @query("entityType")
    entityType: unknown;

    @bodyRoot
    body?: Record<unknown>;
  },
  void
>;

@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@get
op getCriticalDataColumn is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataColumnId: string;

    @query("entityType")
    entityType: unknown;
  },
  void
>;

@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@delete
op deleteCriticalDataColumn is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("criticalDataElementId")
    criticalDataElementId?: string;

    @query("entityType")
    entityType: unknown;

    @format("uuid")
    @query("entityId")
    entityId: string;

    @path
    criticalDataColumnId: string;
  },
  void
>;

@route("/criticalDataElements")
@post
op postCriticalDataElement is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement,
  void
>;

@route("/criticalDataElements")
@get
op getCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @query("keyword")
    keyword?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;

    @query("orderBy")
    orderBy?: string;
  },
  void
>;

@route("/criticalDataElements/{criticalDataElementId}")
@get
op getCriticalDataElementCriticalDataElementId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataElementId: string;
  },
  void
>;

@route("/criticalDataElements/{criticalDataElementId}")
@put
op putCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataElementId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement;
  },
  void
>;

@route("/criticalDataElements/{criticalDataElementId}")
@delete
op deleteCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataElementId: string;
  },
  void
>;

@route("/criticalDataElements/query")
@post
op criticalDataElementQuery is Azure.Core.Foundations.Operation<
  {
    @query("duplicatecheck")
    duplicatecheck?: int32;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCriticalDataElementCriticalDataElementQueryRequest;
  },
  void
>;

@route("/criticalDataElements/facets")
@post
op criticalDataElementFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCriticalDataElementCriticalDataElementFacetRequest,
  void
>;

@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op criticalDataElementCriticalDataElementIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataElementId: string;

    @query("entityType")
    entityType: unknown;

    @bodyRoot
    body?: Record<unknown>;
  },
  void
>;

@route("/criticalDataElements/{criticalDataElementId}/relationships")
@get
op getsCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataElementId: string;

    @query("entityType")
    entityType: unknown;
  },
  void
>;

@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op deletesCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    criticalDataElementId: string;

    @query("entityType")
    entityType: unknown;

    @format("uuid")
    @query("entityId")
    entityId: string;
  },
  void
>;

@route("/customMetadata/{name}")
@put
op customMetadataName is Azure.Core.Foundations.Operation<
  {
    @path
    name: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelCustomMetadata;
  },
  void
>;

@route("/customMetadata")
@get
op getCustomMetadata is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;

    @query("orderBy")
    orderBy?: string;
  },
  void
>;

@route("/customMetadata/query")
@post
op customMetadataQuery is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCustomMetadataCustomMetadataQueryRequest,
  void
>;

@route("/customMetadata/{metadataId}/GetAsync")
@get
op customMetadataMetadataId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    metadataId: string;
  },
  void
>;

@route("/customMetadata/{metadataId}/DeleteAsync")
@delete
op deleteCustomMetadata is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    metadataId: string;
  },
  void
>;

@route("/customMetadata/{metadataId}/relationships")
@post
op postCustomMetadata is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    metadataId: string;

    @query("entityType")
    entityType?: unknown;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationship;
  },
  void
>;

@route("/customMetadata/{metadataId}/relationships")
@delete
op deletesCustomMetadata is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    metadataId: string;

    @query("entityType")
    entityType?: unknown;

    @format("uuid")
    @query("entityId")
    entityId?: string;
  },
  void
>;

@route("/customMetadata/{metadataId}/relationships")
@get
op customMetadata is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    metadataId: string;

    @query("entityType")
    entityType?: unknown;
  },
  void
>;

@route("/dataAssets")
@get
op getDataAsset is Azure.Core.Foundations.Operation<
  {
    @query("orderBy")
    orderBy?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;
  },
  void
>;

@route("/dataAssets")
@post
op postDataAsset is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelDataAsset,
  void
>;

@route("/dataAssets/query")
@post
op postDataAssetQuery is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataAssetDataAssetQueryRequest,
  void
>;

@route("/dataAssets/{dataAssetId}")
@get
op dataAssetDataAssetId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataAssetId: string;
  },
  void
>;

@route("/dataAssets/{dataAssetId}")
@put
op putDataAsset is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataAssetId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelDataAsset;
  },
  void
>;

@route("/dataAssets/{dataAssetId}")
@delete
op deleteDataAsset is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataAssetId: string;
  },
  void
>;

@route("/dataAssets/{dataAssetId}/relationships")
@get
op dataAssetDataAssetIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataAssetId: string;

    @query("entityType")
    entityType: unknown;
  },
  void
>;

@route("/dataAssets/{dataAssetId}/relationships")
@post
op dataAsset is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataAssetId: string;

    @query("entityType")
    entityType: unknown;

    @bodyRoot
    body: Record<unknown>;
  },
  void
>;

@route("/dataAssets/{dataAssetId}/relationships")
@delete
op deletesDataAsset is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataAssetId: string;

    @query("entityType")
    entityType: unknown;

    @format("uuid")
    @query("entityId")
    entityId: string;
  },
  void
>;

@route("/controlplane/account")
@put
op putDataGovernanceApp is Azure.Core.Foundations.Operation<
  MicrosoftAzureProjectBabylonMetadataModelsAccountServiceModel,
  void
>;

@route("/controlplane/account/{accountId}")
@delete
op dataGovernanceAppAccountAccountId is Azure.Core.Foundations.Operation<
  {
    @path
    accountId: string;

    @bodyRoot
    body?: MicrosoftAzureProjectBabylonMetadataModelsAccountServiceModel;
  },
  void
>;

@route("/dataProducts")
@get
op getDataProduct is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @query("orderBy")
    orderBy?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;
  },
  void
>;

@route("/dataProducts")
@post
op postDataProduct is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelDataProduct,
  void
>;

@route("/dataProducts/query")
@post
op dataProductQuery is Azure.Core.Foundations.Operation<
  {
    @query("duplicatecheck")
    duplicatecheck?: int32;

    @query("dataProductOwner")
    dataProductOwner?: boolean;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataProductQueryRequest;
  },
  void
>;

@route("/dataProducts/facets")
@post
op dataProductFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataProductFacetRequest,
  void
>;

@route("/dataProducts/{dataProductId}")
@get
op dataProductDataProductId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataProductId: string;
  },
  void
>;

@route("/dataProducts/{dataProductId}")
@put
op putDataProduct is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataProductId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelDataProduct;
  },
  void
>;

@route("/dataProducts/{dataProductId}")
@delete
op deleteDataProduct is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataProductId: string;
  },
  void
>;

@route("/dataProducts/{dataProductId}/relationships")
@get
op dataProductDataProductIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataProductId: string;

    @query("entityType")
    entityType: unknown;
  },
  void
>;

@route("/dataProducts/{dataProductId}/relationships")
@post
op postsDataProduct is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataProductId: string;

    @query("entityType")
    entityType: unknown;

    @bodyRoot
    body?: Record<unknown>;
  },
  void
>;

@route("/dataProducts/{dataProductId}/relationships")
@delete
op deletesDataProduct is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    dataProductId: string;

    @query("entityType")
    entityType: unknown;

    @format("uuid")
    @query("entityId")
    entityId: string;
  },
  void
>;

@route("/businessdomains")
@get
op getDomain is Azure.Core.Foundations.Operation<
  {
    @query("$skipToken")
    $skipToken?: string;

    @query("writeOnly")
    writeOnly?: boolean;
  },
  void
>;

@route("/businessdomains")
@post
op postDomain is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelDomain,
  void
>;

@route("/businessdomains/{domainId}")
@put
op domainDomainId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    domainId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelDomain;
  },
  void
>;

@route("/businessdomains/{domainId}")
@get
op domain is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    domainId: string;
  },
  void
>;

@route("/businessdomains/{domainId}")
@delete
op deleteDomain is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    domainId: string;
  },
  void
>;

@route("/internal/resolve/policyeffectiveterms")
@post
op internalResolvePolicyeffectiveterms is Azure.Core.Foundations.Operation<
  {
    @query("dataProductId")
    dataProductId?: string;
  },
  void
>;

@route("/internal/resolve/policyeffectiveCriticalDataElements")
@post
op internalResolvePolicyeffectiveCriticalDataElements is Azure.Core.Foundations.Operation<
  {
    @query("dataProductId")
    dataProductId?: string;
  },
  void
>;

@route("/internal/dataAssets/queryPublished")
@post
op internalDataAssetsQueryPublished is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataAssetDataAssetQueryRequest,
  void
>;

@route("/objectives")
@get
op getOkr is Azure.Core.Foundations.Operation<
  {
    @query("keyword")
    keyword?: string;

    @query("domainId")
    domainId?: string;

    @query("orderBy")
    orderBy?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;
  },
  void
>;

@route("/objectives")
@post
op postOkr is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalProperties,
  void
>;

@route("/objectives/query")
@post
op okrQuery is Azure.Core.Foundations.Operation<
  {
    @query("duplicatecheck")
    duplicatecheck?: int32;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsObjectiveQueryRequest;
  },
  void
>;

@route("/objectives/facets")
@post
op okrFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsObjectiveFacetRequest,
  void
>;

@route("/objectives/{objectiveId}")
@put
op okrObjectiveId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalProperties;
  },
  void
>;

@route("/objectives/{objectiveId}")
@get
op okr is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;
  },
  void
>;

@route("/objectives/{objectiveId}")
@delete
op deleteOkr is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;
  },
  void
>;

@route("/objectives/{objectiveId}/keyResults")
@get
op okrObjectiveIdKeyResults is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;
  },
  void
>;

@route("/objectives/{objectiveId}/keyResults")
@post
op postsOkr is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelKeyResult;
  },
  void
>;

@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@get
op okrObjectiveIdKeyResultsKeyResultId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;

    @format("uuid")
    @path
    keyResultId: string;
  },
  void
>;

@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@put
op putOkr is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;

    @format("uuid")
    @path
    keyResultId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelKeyResult;
  },
  void
>;

@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@delete
op deletesOkr is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    objectiveId: string;

    @format("uuid")
    @path
    keyResultId: string;
  },
  void
>;

@route("/objectives/{objectiveId}/relationships")
@post
op okrObjectiveIdRelationships is Azure.Core.Foundations.Operation<
  {
    @path
    objectiveId: string;

    @query("entityType")
    entityType?: string;

    @bodyRoot
    body?: Record<unknown>;
  },
  void
>;

@route("/objectives/{objectiveId}/relationships")
@delete
op deletes2Okr is Azure.Core.Foundations.Operation<
  {
    @path
    objectiveId: string;

    @query("entityType")
    entityType?: string;

    @query("entityId")
    entityId?: string;

    @query("relationshipType")
    relationshipType?: string;
  },
  void
>;

@route("/objectives/{objectiveId}/relationships")
@get
op getsOkr is Azure.Core.Foundations.Operation<
  {
    @path
    objectiveId: string;

    @query("entityType")
    entityType?: string;
  },
  void
>;

@route("/policies")
@get
op policy is Azure.Core.Foundations.Operation<
  {
    @query("skipToken")
    skipToken?: string;
  },
  void
>;

@route("/policies/addAdministrator")
@post
op policyAddAdministrator is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsPolicyAddAdminRequest,
  void
>;

@route("/terms")
@post
op postTerm is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelTerm,
  void
>;

@route("/terms")
@get
op getsTerm is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @query("domainId")
    domainId?: string;

    @format("uuid")
    @query("parentId")
    parentId?: string;

    @query("keyword")
    keyword?: string;

    @query("skip")
    skip?: int32;

    @query("top")
    top?: int32;

    @query("depth")
    depth?: int32;

    @query("orderBy")
    orderBy?: string;
  },
  void
>;

@route("/terms/{termId}")
@put
op termTermId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelTerm;
  },
  void
>;

@route("/terms/{termId}")
@get
op term is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;
  },
  void
>;

@route("/terms/{termId}")
@delete
op deleteTerm is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;
  },
  void
>;

@route("/terms/query")
@post
op termQuery is Azure.Core.Foundations.Operation<
  {
    @query("duplicatecheck")
    duplicatecheck?: int32;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermQueryRequest;
  },
  void
>;

@route("/terms/facets")
@post
op termFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermFacetRequest,
  void
>;

@route("/terms/{termId}/hierarchies")
@get
op termTermIdHierarchies is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;
  },
  void
>;

@route("/terms/{termId}/relationships")
@post
op termTermIdRelationships is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;

    @query("entityType")
    entityType?: unknown;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermRelationship;
  },
  void
>;

@route("/terms/{termId}/relationships")
@delete
op deletesTerm is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;

    @query("entityType")
    entityType?: unknown;

    @query("relationshipType")
    relationshipType?: unknown;

    @format("uuid")
    @query("entityId")
    entityId?: string;
  },
  void
>;

@route("/terms/{termId}/relationships")
@get
op getTerm is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    termId: string;

    @query("entityType")
    entityType?: unknown;

    @query("relationshipType")
    relationshipType?: unknown;
  },
  void
>;

@route("/terms/migration/state")
@get
op termMigrationState is Azure.Core.Foundations.Operation<{}, void>;

@route("/terms/migration/counts")
@get
op termMigrationCounts is Azure.Core.Foundations.Operation<{}, void>;

@route("/terms/migration/start")
@post
op termMigrationStart is Azure.Core.Foundations.Operation<{}, void>;

@route("/terms/migration/moveterms")
@post
op termMigrationMoveterms is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermsMoveRequest,
  void
>;

@route("/workflows")
@post
op workflows is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelWorkflows,
  void
>;

@route("/workflows")
@get
op getWorkflows is Azure.Core.Foundations.Operation<
  {
    @query("$skipToken")
    $skipToken?: string;
  },
  void
>;

@route("/workflows/{workflowId}")
@get
op workflowsWorkflowId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    workflowId: string;
  },
  void
>;

@route("/workflows/{workflowId}")
@put
op putWorkflows is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    workflowId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelWorkflows;
  },
  void
>;

@route("/workflows/{workflowId}")
@delete
op deleteWorkflows is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    workflowId: string;
  },
  void
>;

@route("/workflowRuns/{workflowRunId}")
@delete
op workflowsRunWorkflowRunId is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    workflowRunId: string;
  },
  void
>;

@route("/workflowRuns")
@get
op workflowsRun is Azure.Core.Foundations.Operation<
  {
    @query("$skipToken")
    $skipToken?: string;
  },
  void
>;

@route("/workflowRuns/queryRuns")
@post
op workflowsRunQueryRuns is Azure.Core.Foundations.Operation<
  {
    @query("$skipToken")
    $skipToken?: string;

    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsWorkflowRunQueryRequest;
  },
  void
>;

@route("/workflowRuns/{workflowRunId}/approve")
@post
op workflowsRunWorkflowRunIdApprove is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    workflowRunId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelApprovers;
  },
  void
>;

@route("/workflowRuns/{workflowRunId}/reject")
@post
op workflowsRunWorkflowRunIdReject is Azure.Core.Foundations.Operation<
  {
    @format("uuid")
    @path
    workflowRunId: string;

    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelApprovers;
  },
  void
>;