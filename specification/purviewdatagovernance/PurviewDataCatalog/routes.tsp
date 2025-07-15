import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/administration/globalizeDataAssets")
@post
op administrationGlobalizeDataAssets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationGlobalAssetCleanupRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/administration/backfillDomainParentObject")
@post
op administrationBackfillDomainParentObject is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBusinessDomainObjectBackfillRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/administration/findInconsistentGraphRecords")
@post
op administrationFindInconsistentGraphRecords is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBusinessDomainObjectBackfillRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/administration/findAssetsWithMandatoryMissingProperties")
@post
op administrationFindAssetsWithMandatoryMissingProperties is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationAssetMissingPropertiesRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/administration/batchBackfillBillingEvents")
@post
op administrationBatchBackfillBillingEvents is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsAdministrationBillingEventBackfillRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/{name}")
@put
op attributeName is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    name: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelMetadataAttribute;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes")
@get
op getAttribute is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/{attributeId}/GetAsync")
@get
op attributeAttributeId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    attributeId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/{attributeId}/DeleteAsync")
@delete
op attribute is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    attributeId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/{attributeId}/relationships")
@post
op attributesAttributeIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    attributeId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsMetadataAttributeMetadataAttributeRelationship;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/{attributeId}/relationships")
@delete
op deleteAttribute is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    attributeId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/{attributeId}/relationships")
@get
op getsAttribute is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    attributeId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances")
@post
op attributeInstanceInstances is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelAttributeInstance;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances")
@get
op attributeInstance is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances/{instanceId}")
@put
op attributeInstanceInstanceId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelAttributeInstance;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances/{instanceId}")
@get
op getAttributeInstance is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances/{instanceId}")
@delete
op deleteAttributeInstance is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances/{instanceId}/relationships")
@post
op attributeInstanceInstanceIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsMetadataAttributeAttributeInstanceRelationship;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances/{instanceId}/relationships")
@delete
op deletesAttributeInstance is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/attributes/instances/{instanceId}/relationships")
@get
op getsAttributeInstance is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    instanceId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/billing/getaggregate")
@post
op billingGetaggregate is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryModelsServiceBillingBillingRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/billing/getaggregates")
@post
op billingGetaggregates is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryModelsServiceBillingBillingRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/latest")
@get
op catalogSnapshotLatest is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/latest/metadata")
@get
op catalogSnapshotLatestMetadata is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/history/{snapshotId}")
@get
op catalogSnapshotHistorySnapshotId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    snapshotId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/history/{snapshotId}/metadata")
@get
op catalogSnapshotHistorySnapshotIdMetadata is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    snapshotId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/history")
@get
op catalogSnapshotHistory is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/configure/install/{repeatIntervalMinutes}")
@post
op catalogSnapshotConfigureInstallRepeatIntervalMinutes is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    repeatIntervalMinutes: int32;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/configure/uninstall")
@post
op catalogSnapshotConfigureUninstall is Azure.Core.Foundations.Operation<
  {},
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/snapshots/catalog/configure/status")
@get
op catalogSnapshotConfigureStatus is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns")
@post
op postCriticalDataColumn is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataColumn,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns")
@get
op criticalDataColumn is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** The unique identifier (UUID) of the resource. */
    @query("assetId")
    assetId?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns/{criticalDataColumnId}")
@get
op criticalDataColumnCriticalDataColumnId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataColumnId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@post
op criticalDataColumnCriticalDataColumnIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataColumnId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** to avoid */
    @bodyRoot
    body?: Record<string>;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@get
op getCriticalDataColumn is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataColumnId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@delete
op deleteCriticalDataColumn is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("criticalDataElementId")
    criticalDataElementId?: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId: string;

    /** to avoid */
    @path
    criticalDataColumnId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements")
@post
op postCriticalDataElement is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements")
@get
op getCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("keyword")
    keyword?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}")
@get
op getCriticalDataElementCriticalDataElementId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataElementId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}")
@put
op putCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataElementId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}")
@delete
op deleteCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataElementId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/query")
@post
op criticalDataElementQuery is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("duplicatecheck")
    duplicatecheck?: int32;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCriticalDataElementCriticalDataElementQueryRequest;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/facets")
@post
op criticalDataElementFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCriticalDataElementCriticalDataElementFacetRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op criticalDataElementCriticalDataElementIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataElementId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** to avoid */
    @bodyRoot
    body?: Record<string>;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@get
op getsCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataElementId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op deletesCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    criticalDataElementId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/{name}")
@put
op customMetadataName is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    name: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelCustomMetadata;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata")
@get
op getCustomMetadata is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/query")
@post
op customMetadataQuery is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsCustomMetadataCustomMetadataQueryRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/{metadataId}/GetAsync")
@get
op customMetadataMetadataId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    metadataId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/{metadataId}/DeleteAsync")
@delete
op deleteCustomMetadata is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    metadataId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/{metadataId}/relationships")
@post
op postCustomMetadata is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    metadataId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelCustomMetadataRelationship;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/{metadataId}/relationships")
@delete
op deletesCustomMetadata is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    metadataId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/customMetadata/{metadataId}/relationships")
@get
op customMetadata is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    metadataId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets")
@get
op getDataAsset is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("orderBy")
    orderBy?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets")
@post
op postDataAsset is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelDataAsset,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/query")
@post
op postDataAssetQuery is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataAssetDataAssetQueryRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/{dataAssetId}")
@get
op dataAssetDataAssetId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataAssetId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/{dataAssetId}")
@put
op putDataAsset is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataAssetId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelDataAsset;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/{dataAssetId}")
@delete
op deleteDataAsset is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataAssetId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/{dataAssetId}/relationships")
@get
op dataAssetDataAssetIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataAssetId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/{dataAssetId}/relationships")
@post
op dataAsset is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataAssetId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** to avoid */
    @bodyRoot
    body: Record<string>;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataAssets/{dataAssetId}/relationships")
@delete
op deletesDataAsset is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataAssetId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/controlplane/account")
@put
op putDataGovernanceApp is Azure.Core.Foundations.Operation<
  MicrosoftAzureProjectBabylonMetadataModelsAccountServiceModel,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/controlplane/account/{accountId}")
@delete
op dataGovernanceAppAccountAccountId is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    accountId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftAzureProjectBabylonMetadataModelsAccountServiceModel;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts")
@get
op getDataProduct is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts")
@post
op postDataProduct is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelDataProduct,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/query")
@post
op dataProductQuery is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("duplicatecheck")
    duplicatecheck?: int32;

    /** to avoid */
    @query("dataProductOwner")
    dataProductOwner?: boolean;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataProductQueryRequest;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/facets")
@post
op dataProductFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataProductFacetRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/{dataProductId}")
@get
op dataProductDataProductId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataProductId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/{dataProductId}")
@put
op putDataProduct is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataProductId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelDataProduct;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/{dataProductId}")
@delete
op deleteDataProduct is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataProductId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/{dataProductId}/relationships")
@get
op dataProductDataProductIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataProductId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/{dataProductId}/relationships")
@post
op postsDataProduct is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataProductId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** to avoid */
    @bodyRoot
    body?: Record<string>;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/dataProducts/{dataProductId}/relationships")
@delete
op deletesDataProduct is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    dataProductId: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/businessdomains")
@get
op getDomain is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("$skipToken")
    $skipToken?: string;

    /** to avoid */
    @query("writeOnly")
    writeOnly?: boolean;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/businessdomains")
@post
op postDomain is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelDomain,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/businessdomains/{domainId}")
@put
op domainDomainId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    domainId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelDomain;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/businessdomains/{domainId}")
@get
op domain is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    domainId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/businessdomains/{domainId}")
@delete
op deleteDomain is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    domainId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/internal/resolve/policyeffectiveterms")
@post
op internalResolvePolicyeffectiveterms is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("dataProductId")
    dataProductId?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/internal/resolve/policyeffectiveCriticalDataElements")
@post
op internalResolvePolicyeffectiveCriticalDataElements is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("dataProductId")
    dataProductId?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/internal/dataAssets/queryPublished")
@post
op internalDataAssetsQueryPublished is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsDataAssetDataAssetQueryRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives")
@get
op getOkr is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("keyword")
    keyword?: string;

    /** to avoid */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives")
@post
op postOkr is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalProperties,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/query")
@post
op okrQuery is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("duplicatecheck")
    duplicatecheck?: int32;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsObjectiveQueryRequest;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/facets")
@post
op okrFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsObjectiveFacetRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}")
@put
op okrObjectiveId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelObjectiveWithAdditionalProperties;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}")
@get
op okr is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}")
@delete
op deleteOkr is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/keyResults")
@get
op okrObjectiveIdKeyResults is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/keyResults")
@post
op postsOkr is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelKeyResult;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@get
op okrObjectiveIdKeyResultsKeyResultId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;

    /** The unique identifier (UUID) of the resource. */
    @path
    keyResultId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@put
op putOkr is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;

    /** The unique identifier (UUID) of the resource. */
    @path
    keyResultId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelKeyResult;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@delete
op deletesOkr is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    objectiveId: string;

    /** The unique identifier (UUID) of the resource. */
    @path
    keyResultId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/relationships")
@post
op okrObjectiveIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    objectiveId: string;

    /** to avoid */
    @query("entityType")
    entityType?: string;

    /** to avoid */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @bodyRoot
    body?: Record<string>;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/relationships")
@delete
op deletes2Okr is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    objectiveId: string;

    /** to avoid */
    @query("entityType")
    entityType?: string;

    /** to avoid */
    @query("entityId")
    entityId?: string;

    /** to avoid */
    @query("relationshipType")
    relationshipType?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/objectives/{objectiveId}/relationships")
@get
op getsOkr is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @path
    objectiveId: string;

    /** to avoid */
    @query("entityType")
    entityType?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/policies")
@get
op policy is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("skipToken")
    skipToken?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/policies/addAdministrator")
@post
op policyAddAdministrator is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsPolicyAddAdminRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms")
@post
op postTerm is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelTerm,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms")
@get
op getsTerm is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** The unique identifier (UUID) of the resource. */
    @query("parentId")
    parentId?: string;

    /** to avoid */
    @query("keyword")
    keyword?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("depth")
    depth?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}")
@put
op termTermId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelTerm;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}")
@get
op term is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}")
@delete
op deleteTerm is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/query")
@post
op termQuery is Azure.Core.Foundations.Operation<
  {
    /** to avoid */
    @query("duplicatecheck")
    duplicatecheck?: int32;

    /** to avoid */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermQueryRequest;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/facets")
@post
op termFacets is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermFacetRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}/hierarchies")
@get
op termTermIdHierarchies is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}/relationships")
@post
op termTermIdRelationships is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;

    /** entityType */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** body */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermRelationship;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}/relationships")
@delete
op deletesTerm is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;

    /** entityType */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** relationshipType */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("relationshipType")
    relationshipType?: unknown;

    /** The unique identifier (UUID) of the resource. */
    @query("entityId")
    entityId?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/{termId}/relationships")
@get
op getTerm is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    termId: string;

    /** entityType */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("entityType")
    entityType?: unknown;

    /** relationshipType */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is unknown to the server."
    @query("relationshipType")
    relationshipType?: unknown;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/migration/state")
@get
op termMigrationState is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/migration/counts")
@get
op termMigrationCounts is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/migration/start")
@post
op termMigrationStart is Azure.Core.Foundations.Operation<{}, void>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/terms/migration/moveterms")
@post
op termMigrationMoveterms is Azure.Core.Foundations.Operation<
  MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsTermTermsMoveRequest,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflows")
@post
op workflows is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelWorkflows,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflows")
@get
op getWorkflows is Azure.Core.Foundations.Operation<
  {
    /** skipToken */
    @query("$skipToken")
    $skipToken?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflows/{workflowId}")
@get
op workflowsWorkflowId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    workflowId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflows/{workflowId}")
@put
op putWorkflows is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    workflowId: string;

    /** body */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelWorkflows;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflows/{workflowId}")
@delete
op deleteWorkflows is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    workflowId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflowRuns/{workflowRunId}")
@delete
op workflowsRunWorkflowRunId is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    workflowRunId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflowRuns")
@get
op workflowsRun is Azure.Core.Foundations.Operation<
  {
    /** skipToken */
    @query("$skipToken")
    $skipToken?: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflowRuns/queryRuns")
@post
op workflowsRunQueryRuns is Azure.Core.Foundations.Operation<
  {
    /** skipToken */
    @query("$skipToken")
    $skipToken?: string;

    /** body */
    @bodyRoot
    body?: MicrosoftPurviewActiveGlossaryCatalogApiServiceControllersModelsWorkflowRunQueryRequest;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflowRuns/{workflowRunId}/approve")
@post
op workflowsRunWorkflowRunIdApprove is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    workflowRunId: string;

    /** body */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelApprovers;
  },
  void
>;

/**
 * Rejects a workflow run with the specified approvers.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/workflowRuns/{workflowRunId}/reject")
@post
op workflowsRunWorkflowRunIdReject is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @path
    workflowRunId: string;

    /** body */
    @bodyRoot
    body?: MicrosoftPurviewDataGovernanceCatalogModelApprovers;
  },
  void
>;
