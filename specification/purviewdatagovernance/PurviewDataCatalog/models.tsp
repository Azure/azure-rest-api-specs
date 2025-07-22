import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@doc("CatalogModelStatus")
union CatalogModelStatus {
  @doc("The status is Draft.")
  Draft: "DRAFT",

  @doc("The status is published.")
  Published: "PUBLISHED",

  @doc("The status is Expired.")
  Expired: "EXPIRED",

  string,
}
@doc("CatalogModelCriticalDataElementDataTypeEnum")
union CatalogModelCriticalDataElementDataTypeEnum {
  @doc("The status is Text.")
  Text: "TEXT",

  @doc("The status is Number.")
  Number: "NUMBER",

  @doc("The status is DateTime.")
  DateTime: "DATETIME",

  @doc("The status is Boolean.")
  Boolean: "BOOLEAN",

  string,
}
@doc("SharedEntityStatus")
union SharedEntityStatus {
  @doc("The status is Draft.")
  Draft: "Draft",

  @doc("The status is published.")
  Published: "Published",

  @doc("The status is Expired.")
  Expired: "Expired",

  string,
}

@doc("CatalogModelSystemDataWithExpired")
model CatalogModelSystemDataWithExpired {
  @doc("The created time of the record.")
  createdAt?: utcDateTime;

  @doc("The user who created the record.")
  createdBy?: Azure.Core.uuid;

  @doc("The user who Last modified the record.")
  lastModifiedAt?: utcDateTime;

  @doc("The user who last modified the record.")
  lastModifiedBy?: Azure.Core.uuid;

  @doc("The expiration time of the record.")
  expiredAt?: utcDateTime;

  @doc("The user who expired the record.")
  expiredBy?: Azure.Core.uuid;
}
@doc("CatalogModelContactsValueInner")
model CatalogModelContactsValueInner {
  @doc("The unique identifier of the contact.")
  id?: Azure.Core.uuid;

  @doc("The description of the contact.")
  description?: string;
}
@doc("CatalogModelManagedAttribute")
model CatalogModelManagedAttribute {
  @doc("The name of the managed attribute.")
  name?: string;
}
@doc("CatalogModelCriticalDataElement represents a critical data element in the catalog.")
model CatalogModelCriticalDataElement {
  @doc("The unique identifier of the critical data element.")
  status?: CatalogModelStatus;

  @doc("The status of the critical data element.")
  dataType?: CatalogModelCriticalDataElementDataTypeEnum;

  @doc("The unique identifier of the critical data element.")
  id?: Azure.Core.uuid;

  @doc("The name of the critical data element.")
  name?: string;

  @doc("The system data of the critical data element.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The unique identifier of the critical data element.")
  domain?: Azure.Core.uuid;

  @doc("The description of the critical data element.")
  description?: string;

  @doc("The contacts associated with the critical data element.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("The tags associated with the critical data element.")
  managedAttributes?: CatalogModelManagedAttribute[];
}

@doc("EntityCategory")
union EntityCategory {
  @doc("The DOMAIN associated with the critical data element.")
  Domain: "DOMAIN",

  @doc("The DATAPRODUCT associated with the critical data element.")
  DataProduct: "DATAPRODUCT",

  @doc("The TERM associated with the critical data element.")
  Term: "TERM",

  @doc("The DATAASSET associated with the critical data element.")
  DataAsset: "DATAASSET",

  @doc("The OBJECTIVE associated with the critical data element.")
  Objective: "OBJECTIVE",

  @doc("The KEYRESULT associated with the critical data element.")
  KeyResult: "KEYRESULT",

  @doc("The CRITICALDATAELEMENT associated with the critical data element.")
  CriticalDataElement: "CRITICALDATAELEMENT",

  @doc("The CRITICALDATACOLUMN associated with the critical data element.")
  CriticalDataColumn: "CRITICALDATACOLUMN",

  @doc("The CUSTOMMETADATA associated with the critical data element.")
  CustomMetadata: "CUSTOMMETADATA",

  @doc("The ATTRIBUTE associated with the critical data element.")
  Attribute: "ATTRIBUTE",

  @doc("The ATTRIBUTEINSTANCE associated with the critical data element.")
  AttributeInstance: "ATTRIBUTEINSTANCE",

  @doc("The WORKFLOW associated with the critical data element.")
  Workflow: "WORKFLOW",

  @doc("The CATALOGSNAPSHOT associated with the critical data element.")
  CatalogSnapshot: "CATALOGSNAPSHOT",

  @doc("The WORKFLOWRUN associated with the critical data element.")
  WorkflowRun: "WORKFLOWRUN",

  string,
}

@doc("CatalogApiServiceOrderBy.")
model CatalogApiServiceOrderBy {
  @doc("The field to order by.")
  field?: string;

  @doc("The direction of the order.")
  direction?: string;
}

@doc("SharedSearchManageAttributeSearchFilter.")
model SharedSearchManageAttributeSearchFilter {
  @doc("The field to filter by.")
  field?: string;

  @doc("The operator to use for the filter.")
  operator?: string;

  @doc("The value to filter by.")
  value?: string;

  @doc("The type of the value.")
  type?: string;
}

@doc("CriticalDataElementQueryRequest.")
model CriticalDataElementQueryRequest {
  @doc("To Skip how many records.")
  skip?: int32 = 0;

  @doc("To return how many records.")
  top?: int32;

  @doc("To order the records.")
  orderby?: CatalogApiServiceOrderBy[];

  @doc("To filter by Ids.")
  ids?: string[];

  @doc("To filter by domain Ids.")
  domainIds?: string[];

  @doc("To filter by name keyword.")
  nameKeyword?: string;

  @doc("To filter by owners.")
  owners?: string[];

  @doc("To filter by status.")
  status?: SharedEntityStatus;

  @doc("To filter by multiple status.")
  multiStatus?: SharedEntityStatus[];

  @doc("To filter by managed attributes.")
  managedAttributes?: SharedSearchManageAttributeSearchFilter[];
}

@doc("ModelsFacetRequestObject.")
model ModelsFacetRequestObject {
  @doc("name")
  name?: string;
}

@doc("CriticalDataElementFacetRequest.")
model CriticalDataElementFacetRequest {
  @doc("To filter by Ids.")
  ids?: string[];

  @doc("To filter by domain Ids.")
  domainIds?: string[];

  @doc("To filter by name keyword.")
  nameKeyword?: string;

  @doc("To filter by owners.")
  owners?: string[];

  @doc("To filter by status.")
  status?: SharedEntityStatus;

  @doc("To filter by multiple status.")
  multiStatus?: SharedEntityStatus[];

  @doc("To filter by multiple facets.")
  facets?: ModelsFacetRequestObject[];
}

@doc("InputProperties.")
model InputProperties {
  @doc("The first additional property.")
  prop1?: string[];

  @doc("The second additional property.")
  prop2?: string[];

  @doc("The third additional property.")
  prop3?: string[];
}

@doc("CatalogModelCriticalDataColumn.")
model CatalogModelCriticalDataColumn {
  @doc("The third additional property.")
  id?: Azure.Core.uuid;

  @doc("The name of the critical data column.")
  name?: string;

  @doc("The name of the systemData.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The name of the domain.")
  domain?: Azure.Core.uuid;

  @doc("The name of the asset.")
  assetId?: Azure.Core.uuid;

  @doc("The description of the critical data column.")
  description?: string;

  @doc("The classifications of the critical data column.")
  classifications?: string[];

  @doc("The data type of the critical data column.")
  dataType?: string;

  @doc("The name of the asset.")
  assetName?: string;
}

@doc("InputbodyProperties.")
model InputbodyProperties {
  @doc("systemData.")
  systemData?: string[];

  @doc("description.")
  description?: string;

  @doc("description.")
  relationshipType?: string;

  @doc("Unique identifier of the asset.")
  assetId?: Azure.Core.uuid;
}

@doc("SystemData.")
model SystemData {
  @doc("lastModifiedAt.")
  lastModifiedAt?: string;

  @doc("Unique identifier of the asset.")
  lastModifiedBy?: Azure.Core.uuid;

  @doc("createdAt.")
  createdAt?: string;

  @doc("Unique identifier of the asset.")
  createdBy?: Azure.Core.uuid;
}

@doc("RelationshipWrapper.")
model RelationshipWrapper {
  @doc("systemData.")
  systemData?: SystemData;

  @doc("description.")
  description?: string;

  @doc("relationshipType.")
  relationshipType?: string;

  @doc("Unique identifier of the entity.")
  entityId?: Azure.Core.uuid;
}

@doc("CatalogModelDataAssetSource.")
model CatalogModelDataAssetSource {
  @doc("Type of the asset.")
  type?: string;

  @doc("Unique identifier of the entity.")
  assetId?: Azure.Core.uuid;

  @doc("Type of the asset.")
  assetType?: string;

  @doc(".Type properties of the asset.")
  assetAttributes?: string[];

  @doc("Fully qualified name.")
  fqn?: string;

  @doc("Name of the account.")
  accountName?: string;

  @doc("FIXME: (utcDateTime) Please double check that this is the correct type for your scenario")
  lastRefreshedAt?: utcDateTime;

  @doc("Name of the user who last refreshed the asset.")
  lastRefreshedBy?: string;
}
@doc("Schema of the asset.")
model CatalogModelDataAssetSchema {
  @doc("Name of the asset.")
  name?: string;

  @doc("Description of the asset.")
  description?: string;

  @doc("Classifications of the asset.")
  classifications?: string[];

  @doc("Type of the asset.")
  type?: string;
}

@doc("CatalogModelDataAsset.")
model CatalogModelDataAsset {
  @doc("Unique identifier of the asset.")
  id?: Azure.Core.uuid;

  @doc("Name of the asset.")
  name?: string;

  @doc("System data associated with the asset.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("Description of the asset.")
  description?: string;

  @doc("Domain of the asset.")
  domain?: string;

  @doc("Source of the asset.")
  source?: CatalogModelDataAssetSource;

  @doc("Contacts associated with the asset.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("Classifications associated with the asset.")
  classifications?: string[];

  @doc("Unique identifier of the entity.")
  sensitivityLabel?: Azure.Core.uuid;

  @doc("Type of the asset.")
  type?: string;

  @doc("Schema of the asset.")
  schema?: CatalogModelDataAssetSchema[];

  @doc("Lineage information associated with the asset.")
  lineage?: string[];

  @doc("Data quality score of the asset.")
  dataQualityScore?: float64;

  @doc("URL to open the asset in the catalog.")
  openInUrl?: string;

  @doc("Type properties of the asset.")
  typeProperties?: string[];
}

@doc("DataAssetDataAssetQueryRequest.")
model DataAssetDataAssetQueryRequest {
  @doc("To Skip how many records.")
  skip?: int32 = 0;

  @doc("To return how many records.")
  top?: int32;

  @doc("To order the records.")
  orderby?: CatalogApiServiceOrderBy[];

  @doc("To filter by Ids.")
  ids?: string[];

  @doc("To filter by domain Ids.")
  domainIds?: string[];

  @doc("To filter by name keyword.")
  nameKeyword?: string;

  @doc("To filter by owners.")
  owners?: string[];

  @doc("To filter by data map asset Ids.")
  dataMapAssetIds?: string[];
}

@doc("FacetValue.")
model FacetValue {
  @doc("The value of the facet.")
  value: string;

  @doc("The count of items in the facet.")
  count: string;
}
@doc("FacetsResponse.")
model FacetsResponse {
  @doc("The list of facets.")
  facets: Record<FacetValue[]>;
}

@doc("Response containing a list of critical data columns.")
model CriticalDataColumnsResponse {
  @doc("The list of critical data columns.")
  value: CatalogModelCriticalDataColumn[];
}

@doc("Response containing a list of critical data elements.")
model CriticalDataElementsResponse {
  @doc("The list of critical data elements.")
  value: CatalogModelCriticalDataElement[];
}

@doc("Response containing a list of data assets.")
model DataAssetsResponse {
  @doc("The list of data assets.")
  value: CatalogModelDataAsset[];
}

@doc("Response containing a list of relationship wrappers.")
model RelationshipWrappersResponse {
  @doc("The list of relationships.")
  value: RelationshipWrapper[];
}

@doc("CatalogModelDataProductTypeEnum")
union CatalogModelDataProductTypeEnum {
  @doc("The status is Master.")
  Master: "Master",

  @doc("The status is Reference.")
  Reference: "Reference",

  @doc("The status is Analytical.")
  Analytical: "Analytical",

  @doc("The status is AI.")
  AI: "AI",

  @doc("The status is MasterDataAndReferenceData.")
  MasterDataAndReferenceData: "MasterDataAndReferenceData",

  @doc("The status is BusinessSystemOrApplication.")
  BusinessSystemOrApplication: "BusinessSystemOrApplication",

  @doc("The status is ModelTypes.")
  ModelTypes: "ModelTypes",

  @doc("The status is DashboardsOrReports.")
  DashboardsOrReports: "DashboardsOrReports",

  @doc("The status is Operational.")
  Operational: "Operational",

  @doc("The status is MLAITrainingDataSet.")
  MLAITrainingDataSet: "MLAITrainingDataSet",

  @doc("The status is MLAITestingDataSet.")
  MLAITestingDataSet: "MLAITestingDataSet",

  @doc("The status is TransactionalDataset.")
  TransactionalDataset: "TransactionalDataset",

  @doc("The status is AnalyticsModel.")
  AnalyticsModel: "AnalyticsModel",

  @doc("The status is SemanticModel.")
  SemanticModel: "SemanticModel",

  string,
}

@doc("UpdateFrequencyEnum")
union UpdateFrequencyEnum {
  @doc("The status is Hourly.")
  Hourly: "Hourly",

  @doc("The status is Daily.")
  Daily: "Daily",

  @doc("The status is Weekly.")
  Weekly: "Weekly",

  @doc("The status is Monthly.")
  Monthly: "Monthly",

  @doc("The status is Quarterly.")
  Quarterly: "Quarterly",

  @doc("The status is Yearly.")
  Yearly: "Yearly",

  string,
}

@doc("Microsoft Purview Data Governance Catalog Model Data Product.")
model CatalogModelDataProduct {
  @doc("The status of the data product.")
  status?: CatalogModelStatus;

  @doc("The type of the data product.")
  type?: CatalogModelDataProductTypeEnum;

  @doc("The update frequency of the data product.")
  updateFrequency?: UpdateFrequencyEnum;

  @doc("The managed attributes associated with the data product.")
  managedAttributes?: CatalogModelManagedAttribute[];

  @doc("The unique identifier of the data product.")
  id?: Azure.Core.uuid;

  @doc("The name of the data product.")
  name?: string;

  @doc("The system data of the data product.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The domain of the data product.")
  domain?: Azure.Core.uuid;

  @doc("The description of the data product.")
  description?: string;

  @doc("The business use of the data product.")
  businessUse?: string;

  @doc("The contacts associated with the data product.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("The terms of use for the data product.")
  termsOfUse?: CatalogModelExternalLink[];

  @doc("The documentation links for the data product.")
  documentation?: CatalogModelExternalLink[];

  @doc("The sensitivity label of the data product.")
  sensitivityLabel?: string;

  @doc("Whether the data product is endorsed.")
  endorsed?: boolean;

  @doc("The number of active subscribers.")
  activeSubscriberCount?: int32;

  @doc("The data quality score of the data product.")
  dataQualityScore?: float64;

  @doc("The target audience for the data product.")
  audience?: AudienceEnum[];

  @doc("Additional properties of the data product.")
  additionalProperties?: CatalogModelDataProductAllOfAdditionalProperties;
}

@doc("External link model for data product.")
model CatalogModelExternalLink {
  @doc("The URL of the external link.")
  url?: string;

  @doc("The name of the external link.")
  name?: string;

  @doc("The data asset identifier associated with the link.")
  dataAssetId?: Azure.Core.uuid;
}

@doc("Audience enumeration for data products.")
union AudienceEnum {
  @doc("Data Engineer audience.")
  DataEngineer: "Data Engineer",

  @doc("BI Engineer audience.")
  BIEngineer: "BI Engineer",

  @doc("Data Analyst audience.")
  DataAnalyst: "Data Analyst",

  @doc("Data Scientist audience.")
  DataScientist: "Data Scientist",

  @doc("Business Analyst audience.")
  BusinessAnalyst: "Business Analyst",

  @doc("Software Engineer audience.")
  SoftwareEngineer: "Software Engineer",

  @doc("Business User audience.")
  BusinessUser: "Business User",

  @doc("Executive audience.")
  Executive: "Executive",

  string,
}

@doc("Additional properties for data product model.")
model CatalogModelDataProductAllOfAdditionalProperties {
  @doc("The number of assets in the data product.")
  assetCount?: int64;
}

@doc("Response containing a list of data products.")
model DataProductResponse {
  @doc("The list of data products.")
  value: CatalogModelDataProduct[];
}

@doc("DataProductQueryRequest.")
model DataProductQueryRequest {
  @doc("To Skip how many records.")
  skip?: int32 = 0;

  @doc("To return how many records.")
  top?: int32;

  @doc("To order the records.")
  orderby?: CatalogApiServiceOrderBy[];

  @doc("To filter by Ids.")
  ids?: string[];

  @doc("To filter by domain Ids.")
  domainIds?: string[];

  @doc("To filter by name keyword.")
  nameKeyword?: string;

  @doc("To filter by type.")
  type?: string;

  @doc("To filter by multiple types.")
  types?: string[];

  @doc("To filter by owners.")
  owners?: string[];

  @doc("To filter by status.")
  status?: SharedEntityStatus;

  @doc("To filter by multiple status.")
  multiStatus?: SharedEntityStatus[];

  @doc("To filter by managed attributes.")
  managedAttributes?: SharedSearchManageAttributeSearchFilter[];
}

@doc("DataProductFacetRequest.")
model DataProductFacetRequest {
  @doc("To filter by Ids.")
  ids?: string[];

  @doc("To filter by domain Ids.")
  domainIds?: string[];

  @doc("To filter by name keyword.")
  nameKeyword?: string;

  @doc("To filter by owners.")
  owners?: string[];

  @doc("To filter by status.")
  status?: SharedEntityStatus;

  @doc("To filter by multiple status.")
  multiStatus?: SharedEntityStatus[];

  @doc("To filter by type.")
  type?: string;

  @doc("To filter by multiple types.")
  types?: string[];

  @doc("To filter by multiple facets.")
  facets?: ModelsFacetRequestObject[];
}

@doc("Catalog model domain.")
model CatalogModelDomain {
  @doc("The status of the domain.")
  status?: CatalogModelStatus;

  @doc("The type of the domain.")
  type?: CatalogModelDomainTypeEnum;

  @doc("The unique identifier of the domain.")
  id?: Azure.Core.uuid;

  @doc("The name of the domain.")
  name?: string;

  @doc("Whether the domain is restricted.")
  isRestricted?: boolean;

  @doc("The system data of the domain.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The description of the domain.")
  description?: string;

  @doc("The parent domain identifier.")
  parentId?: Azure.Core.uuid;

  @doc("The thumbnail properties of the domain.")
  thumbnail?: CatalogModelDomainAllOfThumbnail;

  @doc("The list of platform domains.")
  domains?: CatalogModelPlatformDomain[];

  @doc("The managed attributes associated with the domain.")
  managedAttributes?: CatalogModelManagedAttribute[];
}

@doc("CatalogModelDomainTypeEnum")
union CatalogModelDomainTypeEnum {
  @doc("The status is FunctionalUnit.")
  FunctionalUnit: "FunctionalUnit",

  @doc("The status is LineOfBusiness.")
  LineOfBusiness: "LineOfBusiness",

  @doc("The status is DataDomain.")
  DataDomain: "DataDomain",

  @doc("The status is Regulatory.")
  Regulatory: "Regulatory",

  @doc("The status is Project.")
  Project: "Project",

  string,
}

@doc("Catalog model domain thumbnail properties.")
model CatalogModelDomainAllOfThumbnail {
  @doc("The color of the thumbnail.")
  color?: string;
}

@doc("Catalog model platform domain.")
model CatalogModelPlatformDomain {
  @doc("The name of the platform domain.")
  name?: string;

  @doc("The friendly name of the platform domain.")
  friendlyName?: string;

  @doc("The related collections of the platform domain.")
  relatedCollections?: CatalogModelRelatedCollection[];
}

@doc("Catalog model related collection.")
model CatalogModelRelatedCollection {
  @doc("The name of the related collection.")
  name?: string;

  @doc("The friendly name of the related collection.")
  friendlyName?: string;

  @doc("The parent collection of the related collection.")
  parentCollection?: CatalogModelRelatedCollectionParentCollection;
}

@doc("Catalog model related collection parent collection.")
model CatalogModelRelatedCollectionParentCollection {
  @doc("The type of the parent collection.")
  type?: RelatedCollectionParentCollectionTypeEnum;

  @doc("The reference name of the parent collection.")
  refName?: string;
}

@doc("Related collection parent collection type enumeration.")
union RelatedCollectionParentCollectionTypeEnum {
  @doc("Collection reference type.")
  CollectionReference: "CollectionReference",

  string,
}

@doc("Response containing a list of domains.")
model CatalogModelDomainResponse {
  @doc("The list of domains.")
  value: CatalogModelDomain[];
}
@doc("ControllersModelsPolicyAddAdminRequest.")
model ControllersModelsPolicyAddAdminRequest {
  @doc("userObjectId")
  userObjectId?: string;
}
