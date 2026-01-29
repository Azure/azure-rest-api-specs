import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewUnifiedCatalog;

@doc("Status of a catalog model entity indicating its lifecycle state.")
union CatalogModelStatus {
  @doc("The entity is in draft state.")
  Draft: "DRAFT",

  @doc("The entity is published and active.")
  Published: "PUBLISHED",

  @doc("The entity has expired and is no longer active.")
  Expired: "EXPIRED",

  string,
}

@doc("Data types supported for critical data elements.")
union CatalogModelCriticalDataElementDataTypeEnum {
  @doc("Text data type.")
  Text: "TEXT",

  @doc("Numeric data type.")
  Number: "NUMBER",

  @doc("Date and time data type.")
  DateTime: "DATETIME",

  @doc("Boolean data type.")
  Boolean: "BOOLEAN",

  string,
}

@doc("Status of shared entities in the catalog.")
union SharedEntityStatus {
  @doc("The entity is in draft state.")
  Draft: "Draft",

  @doc("The entity is published and active.")
  Published: "Published",

  @doc("The entity has expired and is no longer active.")
  Expired: "Expired",

  string,
}

@doc("System metadata with expiration information for catalog entities.")
model CatalogModelSystemDataWithExpired {
  @doc("The timestamp when the record was created.")
  createdAt?: utcDateTime;

  @doc("The unique identifier of the user who created the record.")
  createdBy?: uuid;

  @doc("The timestamp when the record was last modified.")
  lastModifiedAt?: utcDateTime;

  @doc("The unique identifier of the user who last modified the record.")
  lastModifiedBy?: uuid;

  @doc("The timestamp when the record expires.")
  expiredAt?: utcDateTime;

  @doc("The unique identifier of the user who expired the record.")
  expiredBy?: uuid;
}

@doc("Contact information for catalog entities.")
model CatalogModelContactsValueInner {
  @doc("The unique identifier of the contact.")
  id?: uuid;

  @doc("A description or note about the contact.")
  description?: string;
}

@doc("Managed attribute configuration for catalog entities.")
model CatalogModelManagedAttribute {
  @doc("The name of the managed attribute.")
  name?: string;

  @doc("The value of the attribute.")
  value?: string;

  @doc("Whether this attribute is required.")
  isRequired?: boolean;
}

@doc("Represents a critical data element in the catalog with metadata and relationships.")
@resource("criticalDataElements")
model CriticalDataElement {
  @doc("The current status of the critical data element.")
  status?: CatalogModelStatus;

  @doc("The data type of the critical data element.")
  dataType?: CatalogModelCriticalDataElementDataTypeEnum;

  @doc("The unique identifier of the critical data element.")
  @key("criticalDataElementId")
  @visibility(Lifecycle.Create)
  id: uuid;

  @doc("The name of the critical data element.")
  name?: string;

  @doc("System metadata including creation and modification information.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The unique identifier of the domain this element belongs to.")
  domain?: uuid;

  @doc("A detailed description of the critical data element.")
  description?: string;

  @doc("The contacts associated with this critical data element.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("Managed attributes associated with this critical data element.")
  managedAttributes?: CatalogModelManagedAttribute[];
}

@doc("Categories of entities that can be managed in the catalog.")
union EntityCategory {
  @doc("Domain entity category.")
  Domain: "DOMAIN",

  @doc("Data product entity category.")
  DataProduct: "DATAPRODUCT",

  @doc("Term entity category.")
  Term: "TERM",

  @doc("Data asset entity category.")
  DataAsset: "DATAASSET",

  @doc("Objective entity category.")
  Objective: "OBJECTIVE",

  @doc("Key result entity category.")
  KeyResult: "KEYRESULT",

  @doc("Critical data element entity category.")
  CriticalDataElement: "CRITICALDATAELEMENT",

  @doc("Critical data column entity category.")
  CriticalDataColumn: "CRITICALDATACOLUMN",

  @doc("Custom metadata entity category.")
  CustomMetadata: "CUSTOMMETADATA",

  @doc("Attribute entity category.")
  Attribute: "ATTRIBUTE",

  @doc("Attribute instance entity category.")
  AttributeInstance: "ATTRIBUTEINSTANCE",

  @doc("Workflow entity category.")
  Workflow: "WORKFLOW",

  @doc("Catalog snapshot entity category.")
  CatalogSnapshot: "CATALOGSNAPSHOT",

  @doc("Workflow run entity category.")
  WorkflowRun: "WORKFLOWRUN",

  string,
}

@doc("Ordering configuration for API service results.")
model CatalogApiServiceOrderBy {
  @doc("The field name to order by.")
  field?: string;

  @doc("The sort direction (ascending or descending).")
  direction?: string;
}

@doc("Filter configuration for searching managed attributes.")
model SharedSearchManageAttributeSearchFilter {
  @doc("The field name to filter on. Example: 'All Attributes Types.AttributeName'")
  field?: string;

  @doc("The comparison operator to use for filtering. Example: 'ne' , 'eq' ,'gt' , 'ge' , 'lt' , 'le', 'contains' ,'notcontains', 'prefix','eq-any'")
  operator?: string;

  @doc("The value to compare against. Example: '2', 'LAST_24H', LAST_7D','LAST_30D',LAST_365D','MORE_THAN_365D'")
  value?: string;

  @doc("The data type of the filter value. Example: 'int','date','double','float',richtext','short','string','boolean','multiChoice'")
  type?: string;
}

@doc("Request parameters for querying critical data elements.")
model CriticalDataElementQueryRequest {
  @doc("Number of items to skip.")
  skip?: int32;

  @doc("Number of items to return.")
  top?: int32;

  @doc("Ordering criteria for the results.")
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

@doc("DataElementProperties.")
model DataElementProperties {
  @doc("The first additional property.")
  description?: string;

  @doc("The second additional property.")
  entityId?: string;

  @doc("The third additional property.")
  relationshipType?: string;
}

@doc("CriticalDataColumn.")
@resource("criticalDataColumns")
model CriticalDataColumn {
  @doc("The third additional property.")
  id?: uuid;

  @doc("name of the column.")
  name: string;

  @doc("Gets or Sets SystemData.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The identifier of the critical data column.")
  @key("criticalDataColumnId")
  @visibility(Lifecycle.Create)
  domain: uuid;

  @doc("The Id of the asset.")
  assetId: uuid;

  @doc("The description of the critical data column.")
  description?: string;

  @doc("A list of classification labels.")
  classifications?: string[];

  @doc("The data type of the critical data column.")
  dataType?: string;

  @doc("The name of the asset.")
  assetName: string;
}

@doc("Properties for critical data column relationships.")
model CriticalDataColumnProperties {
  @doc("System metadata for the relationship.")
  systemData?: SystemData;

  @doc("Description of the relationship.")
  description?: string;

  @doc("Type of the relationship.")
  relationshipType?: string;

  @doc("Unique identifier of the associated asset.")
  assetId?: uuid;

  @doc("Name of the associated asset.")
  entityId: uuid;
}

@doc("Request body for creating relationships with critical data column properties.")
model CriticalDataColumnRelationshipRequest {
  ...Record<CriticalDataColumnProperties>;
}

@doc("System metadata for tracking entity lifecycle.")
model SystemData {
  @doc("The timestamp when the entity was last modified.")
  lastModifiedAt?: utcDateTime;

  @doc("The unique identifier of the user who last modified the entity.")
  lastModifiedBy?: uuid;

  @doc("The timestamp when the entity was created.")
  createdAt?: string;

  @doc("Unique identifier of the asset.")
  createdBy?: uuid;
}

@doc("CDC Relationship information between entities.")
@resource("relationships")
@parentResource(CriticalDataColumn)
model CdcRelationship {
  @doc("System metadata for the relationship.")
  systemData?: SystemData;

  @doc("Description of the relationship.")
  description?: string;

  @doc("Type of the relationship.")
  relationshipType?: string;

  @doc("Unique identifier of the related entity.")
  @key
  @visibility(Lifecycle.Create)
  entityId: uuid;
}

@resource("relationships")
@parentResource(CriticalDataElement)
@doc("Relationship information between entities.")
model CdeRelationship {
  @doc("Type of the relationship.")
  relationshipType?: string;

  @doc("Unique identifier of the related entity.")
  @key
  @visibility(Lifecycle.Create)
  entityId: uuid;
}

@doc("Source information for data assets.")
model CatalogModelDataAssetSource {
  @doc("The type of the data source.")
  type?: string;

  @doc("Unique identifier of the asset.")
  assetId?: uuid;

  @doc("The type of the asset.")
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

@doc("DataAsset.")
@resource("dataAssets")
model DataAsset {
  @doc("The data asset identifier.")
  @key("dataAssetId")
  @visibility(Lifecycle.Create)
  id: uuid;

  @doc("Name of the asset.")
  name: string;

  @doc("System data associated with the asset.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("A description about the relationship.")
  description?: string;

  @doc("Link to the owning domain.")
  domain?: string;

  @doc("Source of the asset.")
  source?: CatalogModelDataAssetSource;

  @doc("Contacts associated with the asset.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("A list of classification labels.")
  classifications?: string[];

  @doc("Only one label is allowed. A GUID of the information protection label.")
  sensitivityLabel?: uuid;

  @doc("type of the data asset.")
  type?: string;

  @doc("Schema of the asset.")
  schema?: CatalogModelDataAssetSchema[];

  @doc("Data quality score for the data asset.")
  dataQualityScore?: float64;

  @doc("A redirection link..")
  openInUrl?: url;

  @doc("Type properties of the asset.")
  typeProperties?: Record<string>;
}

@doc("DataAssetQueryRequest.")
model DataAssetQueryRequest {
  @doc("Number of items to skip.")
  skip?: int32;

  @doc("Number of items to return.")
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

  @doc("includingOrphans true or false")
  includingOrphans?: boolean;
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

// @doc("Response containing a list of critical data columns.")
// @pagedResult
// model CriticalDataColumnsResponse {
//   @doc("The list of critical data columns.")
//   @pageItems
//   value: CriticalDataColumn[];

//   @doc("The link to the next page of results.")
//   @nextLink
//   nextLink?: string;
// }

@doc("Response containing a list of critical data elements.")
model CriticalDataElementsResponse {
  @doc("The list of critical data elements.")
  @pageItems
  value: CriticalDataElement[];

  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
}

@doc("Response containing a list of data assets.")
model DataAssetsResponse {
  @doc("The list of data assets.")
  @pageItems
  value: DataAsset[];

  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
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
@resource("dataProducts")
model DataProduct {
  @doc("The status of the data product.")
  status?: CatalogModelStatus;

  @doc("The type of the data product.")
  type?: CatalogModelDataProductTypeEnum;

  @doc("The update frequency of the data product.")
  updateFrequency?: UpdateFrequencyEnum;

  @doc("The managed attributes associated with the data product.")
  managedAttributes?: CatalogModelManagedAttribute[];

  @doc("The unique identifier of the data product.")
  @key("dataProductId")
  @visibility(Lifecycle.Create)
  id: uuid;

  @doc("The name of the data product.")
  name?: string;

  @doc("The system data of the data product.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The domain of the data product.")
  domain?: uuid;

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
  url?: url;

  @doc("The name of the external link.")
  name?: string;

  @doc("The data asset identifier associated with the link.")
  dataAssetId?: uuid;
}

@doc("Audience enumeration for data products.")
union AudienceEnum {
  @doc("Data Engineer audience.")
  DataEngineer: "DataEngineer",

  @doc("BI Engineer audience.")
  BIEngineer: "BIEngineer",

  @doc("Data Analyst audience.")
  DataAnalyst: "DataAnalyst",

  @doc("Data Scientist audience.")
  DataScientist: "DataScientist",

  @doc("Business Analyst audience.")
  BusinessAnalyst: "BusinessAnalyst",

  @doc("Software Engineer audience.")
  SoftwareEngineer: "SoftwareEngineer",

  @doc("Business User audience.")
  BusinessUser: "BusinessUser",

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
  @pageItems
  value: DataProduct[];

  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
}

@doc("DataProductQueryRequest.")
model DataProductQueryRequest {
  @doc("Number of items to skip.")
  skip?: int32;

  @doc("Number of items to return.")
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
@resource("businessdomains")
model Domain {
  @doc("The status of the domain.")
  status?: CatalogModelStatus;

  @doc("The type of the domain.")
  type?: CatalogModelDomainTypeEnum;

  @doc("The unique identifier of the domain.")
  @key("domainId")
  @visibility(Lifecycle.Create)
  id: uuid;

  @doc("The name of the domain.")
  name?: string;

  @doc("Whether the domain is restricted.")
  isRestricted?: boolean;

  @doc("The system data of the domain.")
  systemData: CatalogModelSystemDataWithExpired;

  @doc("The description of the domain.")
  description?: string;

  @doc("Identifier of the domain to retrieve.")
  parentId: uuid;

  @doc("The thumbnail properties of the domain.")
  thumbnail: CatalogModelDomainAllOfThumbnail;

  @doc("The list of platform domains.")
  domains: CatalogModelPlatformDomain[];

  @doc("The managed attributes associated with the domain.")
  managedAttributes: CatalogModelManagedAttribute[];
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

// @doc("Response containing a list of domains.")
// @pagedResult
// model DomainResponse {
//   @doc("The list of domains.")
//   @pageItems
//   value: Domain[];

//   @doc("The link to the next page of results.")
//   @nextLink
//   nextLink?: string;
// }

@doc("ControllersModelsPolicyAddAdminRequest.")
model ControllersModelsPolicyAddAdminRequest {
  @doc("userObjectId")
  userObjectId?: string;
}

@doc("Microsoft Purview Data Governance Catalog Model Term.")
@resource("terms")
model Term {
  @doc("The status of the term.")
  status: CatalogModelStatus;

  @doc("The unique identifier of the term.")
  @key("termId")
  @visibility(Lifecycle.Create)
  id: uuid;

  @doc("The name of the term.")
  name: string;

  @doc("The system data of the term.")
  systemData?: CatalogModelSystemDataWithExpired;

  @doc("The description of the term.")
  description?: string;

  @doc("The contacts associated with the term.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("The domain associated with the term.")
  domain: uuid;

  @doc("The parent term identifier.")
  parentId?: uuid;

  @doc("The list of acronyms for the term.")
  acronyms?: string[];

  @doc("The resources associated with the term.")
  resources?: CatalogModelTermResource[];

  @doc("Whether the term is a leaf node.")
  isLeaf?: boolean;

  @doc("The managed attributes associated with the term.")
  managedAttributes?: CatalogModelManagedAttribute[];
}

@doc("Catalog model term resource.")
model CatalogModelTermResource {
  @doc("The name of the resource.")
  name?: string;

  @doc("The URL of the resource.")
  url?: url;
}

@doc("Response containing a list of terms.")
model TermResponse {
  @doc("The list of terms.")
  @pageItems
  value: Term[];

  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
}

@doc("Term query request model.")
model TermQueryRequest {
  @doc("Number of items to skip.")
  skip?: int32;

  @doc("Number of items to return.")
  top?: int32;

  @doc("Order by specifications for the query.")
  orderby?: CatalogApiServiceOrderBy[];

  @doc("Filter by term IDs.")
  ids?: string[];

  @doc("Filter by domain IDs.")
  domainIds?: string[];

  @doc("Filter by name keyword.")
  nameKeyword?: string;

  @doc("Filter by term status.")
  status?: CatalogModelStatus;

  @doc("Filter by multiple term statuses.")
  multiStatus?: CatalogModelStatus[];

  @doc("Filter by term owners.")
  owners?: string[];

  @doc("Filter by term acronyms.")
  acronyms?: string[];

  @doc("Filter by managed attributes.")
  managedAttributes?: SharedSearchManageAttributeSearchFilter[];
}

@doc("TermFacetRequest.")
model TermFacetRequest {
  @doc("To filter by Ids.")
  ids?: string[];

  @doc("To filter by domain Ids.")
  domainIds?: string[];

  @doc("To filter by name keyword.")
  nameKeyword?: string;

  @doc("To filter by owners.")
  owners?: string[];

  @doc("To filter by acronyms.")
  acronyms?: string[];

  @doc("To filter by status.")
  status?: SharedEntityStatus;

  @doc("To filter by multiple status.")
  multiStatus?: SharedEntityStatus[];

  @doc("To filter by multiple facets.")
  facets?: ModelsFacetRequestObject[];
}

@doc("TermRelationship.")
@resource("relationships")
@parentResource(Term)
model TermRelationship {
  @doc("System metadata for the term relationship.")
  systemData?: SystemData;

  @doc("description for the term relationship")
  description?: string;

  @doc("The unique identifier of the entity.")
  @key
  @visibility(Lifecycle.Create)
  entityId: uuid;

  @doc("The type of the term relationship.")
  relationshipType?: TermRelationshipType;
}

// @doc("Response containing a list of term relationships.")
// @pagedResult
// model TermRelationshipResponse {
//   @doc("The list of term relationships.")
//   @pageItems
//   value: TermRelationship[];

//   @doc("The link to the next page of results.")
//   @nextLink
//   nextLink?: string;
// }

@doc("TermRelationshipType")
union TermRelationshipType {
  @doc("The status is Related.")
  Related: "Related",

  @doc("The status is Synonym.")
  Synonym: "Synonym",

  @doc("The status is Parent.")
  Parent: "Parent",

  string,
}

@doc("Objective with additional properties model.")
@resource("objectives")
model ObjectiveWithAdditionalProperties {
  @doc("The status of the objective.")
  status?: OkrSharedEntityStatus;

  @doc("The system data associated with the objective.")
  systemData?: OkrSystemDataWithExpired;

  @doc("The unique identifier of the objective.")
  @key("objectiveId")
  @visibility(Lifecycle.Create)
  id: uuid;

  @doc("The definition of the objective.")
  definition: string;

  @doc("The domain associated with the objective.")
  domain?: uuid;

  @doc("The target date for the objective.")
  targetDate?: utcDateTime;

  @doc("The contacts associated with the objective.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("Additional properties for the objective.")
  additionalProperties?: ObjectiveAdditionalProperties;
}

@doc("OkrSharedEntityStatus")
union OkrSharedEntityStatus {
  @doc("The status is Draft.")
  Draft: "Draft",

  @doc("The status is published.")
  Published: "Published",

  @doc("The status is Closed.")
  Closed: "Closed",

  string,
}

@doc("OkrSystemDataWithExpired")
model OkrSystemDataWithExpired {
  @doc("The created time of the record.")
  createdAt?: utcDateTime;

  @doc("The user who created the record.")
  createdBy?: uuid;

  @doc("The user who Last modified the record.")
  lastModifiedAt?: utcDateTime;

  @doc("The user who last modified the record.")
  lastModifiedBy?: uuid;

  @doc("The time when the record was closed.")
  closedAt?: utcDateTime;

  @doc("The user who closed the record.")
  closedBy?: uuid;
}

@doc("Additional properties for objective model.")
model ObjectiveAdditionalProperties {
  @doc("The overall status of the objective.")
  overallStatus?: OverallStatusEnum;

  @doc("The overall progress of the objective.")
  overallProgress?: float64;

  @doc("The overall goal value for the objective.")
  overallGoal?: float64;

  @doc("The maximum value for the objective.")
  overallMax?: float64;

  @doc("The number of key results associated with the objective.")
  keyResultsCount?: int64;
}

@doc("OverallStatusEnum")
union OverallStatusEnum {
  @doc("The status is NotTracked.")
  NotTracked: "NotTracked",

  @doc("The status is OnTrack.")
  OnTrack: "OnTrack",

  @doc("The status is Behind.")
  Behind: "Behind",

  @doc("The status is AtRisk.")
  AtRisk: "AtRisk",

  string,
}

@doc("Response containing a list of objectives with additional properties.")
model ObjectiveWithAdditionalPropertiesResponse {
  @doc("The list of objectives with additional properties.")
  @pageItems
  value: ObjectiveWithAdditionalProperties[];

  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
}

@doc("ObjectiveQueryRequest.")
model ObjectiveQueryRequest {
  @doc("Number of items to skip.")
  skip?: int32;

  @doc("Number of items to return.")
  top?: int32;

  @doc("Order by specifications for the query.")
  orderby?: CatalogApiServiceOrderBy[];

  @doc("Filter by objective IDs.")
  ids?: string[];

  @doc("Filter by domain IDs.")
  domainIds?: string[];

  @doc("Filter by objective definition.")
  definition?: string;

  @doc("Filter by objective status.")
  status?: OkrSharedEntityStatus;

  @doc("Filter by multiple objective statuses.")
  multiStatus?: OkrSharedEntityStatus[];

  @doc("Filter by objective owners.")
  owners?: string[];

  @doc("To filter by managed attributes.")
  managedAttributes?: SharedSearchManageAttributeSearchFilter[];
}

@doc("Objective facet request model.")
model ObjectiveFacetRequest {
  @doc("Filter by objective IDs.")
  ids?: string[];

  @doc("Filter by domain IDs.")
  domainIds?: string[];

  @doc("Filter by objective definition.")
  definition?: string;

  @doc("Filter by objective owners.")
  owners?: string[];

  @doc("Filter by objective status.")
  status?: OkrSharedEntityStatus;

  @doc("Filter by multiple objective statuses.")
  multiStatus?: OkrSharedEntityStatus[];

  @doc("Filter by facet objects.")
  facets?: FacetRequestObject[];
}

@doc("Facet request object model.")
model FacetRequestObject {
  @doc("The name of the facet.")
  name?: string;
}

@doc("Additional properties for objective query.")
model ObjectiveQueryAdditionalProperties {
  @doc("The overall status of the objective.")
  status?: OkrSharedEntityStatus;

  @doc("The system data associated with the objective.")
  systemData?: OkrSystemDataWithExpired;

  @doc("The unique identifier of the objective.")
  id?: uuid;

  @doc("The definition of the objective.")
  definition?: string;

  @doc("The domain associated with the objective.")
  domain?: uuid;

  @doc("The target date for the objective.")
  targetDate?: utcDateTime;

  @doc("The contacts associated with the objective.")
  contacts?: Record<CatalogModelContactsValueInner[]>;

  @doc("Additional properties for objective query.")
  additionalProperties?: OverallStatusEnum;
}

@doc("Microsoft Purview Data Governance Catalog Key Result.")
@resource("keyResults")
@parentResource(ObjectiveWithAdditionalProperties)
model KeyResult {
  @doc("The status of the key result.")
  status: OverallStatusEnum;

  @doc("The system data associated with the key result.")
  systemData?: SystemData;

  @doc("The unique identifier of the key result.")
  id?: uuid;

  @doc("The definition of the key result.")
  definition?: string;

  @doc("The unique identifier of the domain.")
  @key
  @visibility(Lifecycle.Create)
  domainId: uuid;

  @doc("The progress of the key result.")
  progress?: float64;

  @doc("The goal value for the key result.")
  goal?: float64;

  @doc("The maximum value for the key result.")
  max?: float64;
}

// @doc("Response containing a list of key results.")
// @pagedResult
// model ModelKeyResultResponse {
//   @doc("The list of key results.")
//   @pageItems
//   value: KeyResult[];

//   @doc("The link to the next page of results.")
//   @nextLink
//   nextLink?: string;
// }

@doc("Catalog model key result.")
model CatalogModelKeyResult {
  @doc("The status of the key result.")
  status?: OverallStatusEnum;

  @doc("The system data associated with the key result.")
  systemData?: SystemData;

  @doc("The unique identifier of the key result.")
  id?: uuid;

  @doc("The definition of the key result.")
  definition?: string;

  @doc("The unique identifier of the domain.")
  domainId?: uuid;

  @doc("The progress of the key result.")
  progress?: float64;

  @doc("The goal value for the key result.")
  goal?: float64;

  @doc("The maximum value for the key result.")
  max?: float64;
}

@doc("Response containing a list of key results.")
model CatalogModelKeyResultResponse {
  @doc("The list of key results.")
  @pageItems
  value: CatalogModelKeyResult[];

  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
}

alias CriticalDataElementIdParameters = {
  @doc("The unique identifier of the critical data element.")
  criticalDataElementId: uuid;
};

alias DataElementPropertiesBody = {
  @doc("The input properties for creating the relationship.")
  body: DataElementProperties;
};

alias CriticalDataElementQueryRequestBody = {
  @doc("The request body containing query criteria.")
  body: CriticalDataElementQueryRequest;
};

alias Duplicatecheck = {
  @doc("The number of duplicate checks to perform.")
  duplicatecheck?: int32;
};

@doc("The number of duplicate checks to perform.")
model DeleteResponse {
  @doc("Delete response.")
  @statusCode
  status: 204;
}

@doc("The number of duplicate checks to perform.")
model CreateCriticalDataElementResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: CriticalDataElement;
}

@doc("The number of duplicate checks to perform.")
model CreateCriticalDataColumnResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: CriticalDataColumn;
}

alias CriticalDataColumnIdParameters = {
  @doc("The unique identifier of the critical data Column.")
  criticalDataColumnId: uuid;
};

@doc("The number of duplicate checks to perform.")
model CreateDataAssetResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: DataAsset;
}

alias DataAssetIdParameter = {
  @doc("The unique identifier of the critical data asset.")
  dataAssetId: uuid;
};

@doc("Relationship information between entities.")
@resource("relationships")
@parentResource(DataAsset)
model DataAssetRelationship {
  @doc("System metadata for the relationship.")
  systemData?: SystemData;

  @doc("Description of the relationship.")
  description?: string;

  @doc("Type of the relationship.")
  relationshipType?: string;

  @doc("Unique identifier of the related entity.")
  @key
  @visibility(Lifecycle.Create)
  entityId: uuid;
}

@doc("The number of duplicate checks to perform.")
model CreateDataProductResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: DataProduct;
}

alias DataProductIdParameter = {
  @doc("The unique identifier of the critical data product.")
  dataProductId: uuid;
};

@doc("Relationship information between entities.")
@resource("relationships")
@parentResource(DataProduct)
model DataProductRelationship {
  @doc("System metadata for the relationship.")
  systemData?: SystemData;

  @doc("Description of the relationship.")
  description?: string;

  @doc("Type of the relationship.")
  relationshipType?: string;

  @doc("Unique identifier of the related entity.")
  @key
  @visibility(Lifecycle.Create)
  entityId: uuid;
}

@doc("The number of duplicate checks to perform.")
model CreateDomainResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: Domain;
}

alias DomainIdParameter = {
  @doc("The unique identifier of the critical data domain.")
  domainId: uuid;
};

@doc("The number of duplicate checks to perform.")
model CreateTermResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: Term;
}

alias TermIdParameter = {
  @doc("The unique identifier of the critical data term or Parent term identifier.")
  termId: uuid;
};

@doc("The number of duplicate checks to perform.")
model CreateObjectiveResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: ObjectiveWithAdditionalProperties;
}

alias ObjectiveIdParameter = {
  @doc("The unique identifier of the critical data objective.")
  objectiveId: uuid;
};

@doc("The number of duplicate checks to perform.")
model CreateKeyResultResponse {
  @doc("Create response.")
  @statusCode
  status: 201;

  @doc("The request body containing query criteria.")
  @bodyRoot
  body: KeyResult;
}

alias GetKeyResultParameter = {
  @doc("The unique identifier of the critical data objective.")
  objectiveId: uuid;

  @doc("The unique identifier of the key result (OKR).")
  keyResultId: uuid;
};

@doc("Create request for a critical data column.")
model CreateCriticalDataColumnRequest {
  @doc("The critical data column to create.")
  @body
  criticalDataColumn: CriticalDataColumn;
}

@doc("Create request for a critical data element.")
model CreateCriticalDataElementRequest {
  @doc("The critical data element to create.")
  @body
  criticalDataElement: CriticalDataElement;
}

@doc("CatalogResponse.")
model CatalogResponse {
  @doc("The list of catalog values.")
  values: CatalogValue[];

  @doc("The continuation token for pagination.")
  skipToken?: string;
}

@doc("CatalogValue.")
model CatalogValue {
  @doc("The name of the catalog.")
  name: string;

  @doc("The unique identifier of the catalog.")
  id: string;

  @doc("The version of the catalog.")
  version: int32;

  @doc("The properties of the catalog.")
  properties: CatalogProperties;
}

@doc("CatalogProperties.")
model CatalogProperties {
  @doc("The description of the catalog.")
  description?: string;

  @doc("The type of the catalog.")
  decisionRules?: DecisionRule[];

  @doc("The attribute rules of the catalog.")
  attributeRules?: AttributeRule[];

  @doc("The entity reference of the catalog.")
  entity: EntityReference;

  @doc("The parent entity name of the catalog.")
  parentEntityName?: string;
}

@doc("DecisionRule.")
model DecisionRule {
  @doc("The kind of decision rule.")
  kind: string;

  @doc("The unique identifier of the decision rule.")
  effect: string;

  @doc("The name of the decision rule.")
  dnfCondition: Condition[][];
}

@doc("AttributeRule.")
model AttributeRule {
  @doc("The kind of attribute rule.")
  kind: string;

  @doc("The unique identifier of the attribute rule.")
  id: string;

  @doc("The name of the attribute rule.")
  name: string;

  @doc("The description of the attribute rule.")
  dnfCondition: Condition[][];
}

@doc("Condition.")
model Condition {
  @doc("The name of the attribute.")
  attributeName: string;

  @doc("The operator of the condition.")
  attributeValueIncludes?: string;

  @doc("The values included in the condition.")
  attributeValueIncludedIn?: string[];

  @doc("The rule from which the condition is derived.")
  fromRule?: string;
}

@doc("EntityReference.")
model EntityReference {
  @doc("The type of the entity.")
  type: string;

  @doc("The reference name of the entity.")
  referenceName: string;
}

alias PolicyIdParameters = {
  @doc("The unique identifier of the policy.")
  policyId: uuid;
};
