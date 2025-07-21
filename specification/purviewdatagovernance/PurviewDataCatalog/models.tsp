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
  Draft: "DRAFT",

  @doc("The status is published.")
  Published: "PUBLISHED",

  @doc("The status is Expired.")
  Expired: "EXPIRED",

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
  skip?: int32;

  @doc("To return how many records.")
  top?: int32;

  @doc("To order the records.")
  orderBy?: CatalogApiServiceOrderBy[];

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
