import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataMap;

@doc("Enum for business attribute update behavior")
enum BusinessAttributeUpdateBehavior {
  @doc("Ignore the business attribute payload for update.")
  ignore,
  @doc("Replace all the business attributes using the payload.")
  replace,
  @doc("Merge the business attributes. Business attributes will not be updated if not provided.")
  merge,
}

@doc("Status - can be active or deleted")
enum Status {
  @doc("The status is active.")
  ACTIVE,
  @doc("The status is deleted.")
  DELETED,
}

@doc("Status for term assignment")
enum AtlasTermAssignmentStatus {
  @doc("The status is discovered.")
  DISCOVERED,
  @doc("The status is proposed.")
  PROPOSED,
  @doc("The status is imported.")
  IMPORTED,
  @doc("The status is validated.")
  VALIDATED,
  @doc("The status is deprecated.")
  DEPRECATED,
  @doc("The status is obsolete.")
  OBSOLETE,
  @doc("Other status.")
  OTHER,
}

@doc("Type for sorting")
enum SortType {
  @doc("No sorting order")
  NONE,
  @doc("Use ascending order for sorting")
  ASC,
  @doc("Use descending order for sorting")
  DESC,
}

@doc("Status for import")
enum ImportStatus {
  @doc("Success")
  SUCCESS,
  @doc("Failed")
  FAILED,
}

@doc("Status for atlas term relationship")
enum AtlasTermRelationshipStatus {
  @doc("draft")
  DRAFT,
  @doc("active")
  ACTIVE,
  @doc("deprecated")
  DEPRECATED,
  @doc("obsolete")
  OBSOLETE,
  @doc("other")
  OTHER,
}

@doc("Status for term")
enum TermStatus {
  @doc("draft")
  Draft,
  @doc("approved")
  Approved,
  @doc("alert")
  Alert,
  @doc("expired")
  Expired,
}

@doc("Status for atlas relationship")
enum StatusAtlasRelationship {
  @doc("active")
  ACTIVE,
  @doc("deleted")
  DELETED,
}

@doc("Direction")
enum Direction {
  @doc("both")
  BOTH,
  @doc("input")
  INPUT,
  @doc("output")
  OUTPUT,
}

@doc("Lineage direction")
enum LineageDirection {
  @doc("input")
  INPUT,
  @doc("output")
  OUTPUT,
  @doc("both")
  BOTH,
}

@doc("Cardinality")
enum Cardinality {
  @doc("single")
  SINGLE,
  @doc("list")
  LIST,
  @doc("set")
  SET,
}

@doc("Type Category")
enum TypeCategory {
  @doc("primitive")
  PRIMITIVE,
  @doc("object id type")
  OBJECT_ID_TYPE,
  @doc("enum")
  ENUM,
  @doc("struct")
  STRUCT,
  @doc("classification")
  CLASSIFICATION,
  @doc("entity")
  ENTITY,
  @doc("array")
  ARRAY,
  @doc("map")
  MAP,
  @doc("relationship")
  RELATIONSHIP,
  @doc("term template")
  TERM_TEMPLATE,
}

@doc("Rounding Mode")
enum RoundingMode {
  @doc("up")
  UP,
  @doc("down")
  DOWN,
  @doc("ceiling")
  CEILING,
  @doc("floor")
  FLOOR,
  @doc("half up")
  HALF_UP,
  @doc("half down")
  HALF_DOWN,
  @doc("half even")
  HALF_EVEN,
  @doc("unnecessary")
  UNNECESSARY,
}

@doc("Relationship Category")
enum RelationshipCategory {
  @doc("association")
  ASSOCIATION,
  @doc("aggregation")
  AGGREGATION,
  @doc("composition")
  COMPOSITION,
}

@doc("Type")
enum Typedef {
  @doc("enum")
  `enum`,
  @doc("entity")
  entity,
  @doc("classification")
  classification,
  @doc("relationship")
  relationship,
  @doc("struct")
  struct,
  @doc("term template")
  term_template,
}

@doc("Search Filter Operator")
enum SearchFilterOperator {
  @doc("equal")
  eq,
  @doc("not equal")
  ne,
  @doc("greater than")
  gt,
  @doc("less than")
  lt,
  @doc("greater than or equal to")
  ge,
  @doc("less than or equal to")
  le,
  @doc("contains")
  contains,
  @doc("start with")
  startswith,
  @doc("prefix")
  prefix,
  @doc("time range")
  timerange,
  @doc("exists")
  exists,
}

@doc("""
An instance of an entity along with extended info - like hive_table,
hive_database.
""")
model AtlasEntityWithExtInfo {
  ...AtlasEntityExtInfo;

  @doc("An instance of an entity - like hive_table, hive_database.")
  entity?: AtlasEntity;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("An instance of an entity - like hive_table, hive_database.")
model AtlasEntity {
  ...AtlasStruct;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknow> to model Map<String,Object>"
  @doc("Business attributes")
  businessAttributes?: Record<unknown>;

  @doc("An array of classifications.")
  classifications?: AtlasClassification[];

  @doc("The created time of the record.")
  createTime?: int64;

  @doc("The user who created the record.")
  createdBy?: string;

  @doc("Custom Attribute")
  customAttributes?: Record<string>;

  @doc("The GUID of the entity.")
  guid?: string;

  @doc("The home ID of the entity.")
  homeId?: string;

  @doc("The collection ID of the entity.")
  @visibility("read")
  collectionId?: string;

  @doc("Whether it is a shell entity")
  isIncomplete?: boolean;

  @doc("labels")
  labels?: string[];

  @doc("An array of term assignment headers indicating the meanings of the entity.")
  meanings?: AtlasTermAssignmentHeader[];

  @doc("Used to record the provenance of an instance of an entity or relationship.")
  provenanceType?: int32;

  @doc("Determines if there's a proxy.")
  proxy?: boolean;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknow> to model Map<String,Object>"
  @doc("The attributes of relationship.")
  relationshipAttributes?: Record<unknown>;

  @doc("""
Status of the entity - can be active or deleted. Deleted entities are not
removed.
""")
  status?: Status;

  @doc("The update time of the record.")
  updateTime?: int64;

  @doc("The user who updated the record.")
  updatedBy?: string;

  @doc("The version of the entity.")
  version?: int64;

  @doc("The dictionary of contacts for entities. Key could be Expert or Owner.")
  contacts?: Record<ContactBasic[]>;
}

@doc("""
An instance of a classification; it doesn't have an identity, this object
exists only when associated with an entity.
""")
model AtlasClassification {
  ...AtlasStruct;

  @doc("The GUID of the entity.")
  entityGuid?: string;

  @doc("""
Status of the entity - can be active or deleted. Deleted entities are not
removed.
""")
  entityStatus?: Status;

  @doc("Determines if propagations will be removed on entity deletion.")
  removePropagationsOnEntityDelete?: boolean;

  @doc("An array of time boundaries indicating validity periods.")
  validityPeriods?: TimeBoundary[];
}

@doc("Captures time-boundary details")
model TimeBoundary {
  @doc("The end of the time boundary.")
  endTime?: string;

  @doc("The start of the time boundary.")
  startTime?: string;

  @doc("The timezone of the time boundary.")
  timeZone?: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("""
Captures details of struct contents. Not instantiated directly, used only via
AtlasEntity, AtlasClassification.
""")
model AtlasStruct {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknow> to model Map<String,Object>"
  @doc("The attributes of the struct.")
  attributes?: Record<unknown>;

  @doc("The name of the type.")
  typeName?: string;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "It follows the rule"
  @doc("ETag for concurrency control.")
  lastModifiedTS?: string;
}

@doc("The header for term assignment.")
model AtlasTermAssignmentHeader {
  @doc("The confidence of the term assignment.")
  confidence?: int32;

  @doc("The user who created the record.")
  createdBy?: string;

  @doc("The description of the term assignment.")
  description?: string;

  @doc("The display text.")
  displayText?: string;

  @doc("The expression of the term assignment.")
  expression?: string;

  @doc("The GUID of the relationship.")
  relationGuid?: string;

  @doc("The status of terms assignment.")
  status?: AtlasTermAssignmentStatus;

  @doc("The steward of the term.")
  steward?: string;

  @doc("The GUID of the term.")
  termGuid?: string;
}

@doc("ContactBasic")
model ContactBasic {
  @doc("Azure Active Directory object Id.")
  id?: string;

  @doc("additional information to describe this contact.")
  info?: string;
}

@doc("""
An instance of an entity along with extended info - like hive_table,
hive_database.
""")
model AtlasEntityExtInfo {
  @doc("The referred entities.")
  referredEntities?: Record<AtlasEntity>;
}

@doc("The mutation response of entity.")
model EntityMutationResponse {
  @doc("A map of GUID assignments with entities.")
  guidAssignments?: Record<string>;

  @doc("The entity headers of mutated entities.")
  mutatedEntities?: Record<AtlasEntityHeader[]>;

  @doc("An array of entity headers that partially updated.")
  partialUpdatedEntities?: AtlasEntityHeader[];
}

@doc("An instance of an entity - like hive_table, hive_database.")
model AtlasEntityHeader {
  ...AtlasStruct;

  @doc("An array of classification names.")
  classificationNames?: string[];

  @doc("An array of classifications.")
  classifications?: AtlasClassification[];

  @doc("The display text.")
  displayText?: string;

  @doc("The GUID of the record.")
  guid?: string;

  @doc("Whether it is a shell entity")
  isIncomplete?: boolean;

  @doc("labels")
  labels?: string[];

  @doc("An array of meanings.")
  meaningNames?: string[];

  @doc("An array of term assignment headers.")
  meanings?: AtlasTermAssignmentHeader[];

  @doc("""
Status of the entity - can be active or deleted. Deleted entities are not
removed.
""")
  status?: Status;
}

@doc("An error response from the service")
@error
model ErrorResponse {
  @doc("The request ID.")
  requestId?: string;

  @doc("The error code.")
  errorCode?: string;

  @doc("The error message.")
  errorMessage?: string;
}

@doc("""
An instance of an entity along with extended info - like hive_table,
hive_database.
""")
model AtlasEntitiesWithExtInfo {
  ...AtlasEntityExtInfo;

  @doc("An array of entities.")
  entities?: AtlasEntity[];
}

@doc("The request for classification association.")
model ClassificationAssociateRequest {
  @doc("""
An instance of a classification; it doesn't have an identity, this object
exists only when associated with an entity.
""")
  classification?: AtlasClassification;

  @doc("The GUID of the entity.")
  entityGuids?: string[];
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("REST serialization friendly list.")
model AtlasClassifications {
  ...PList;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "It follows the rule"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("Paginated-list, for returning search results.")
model PList {
  @doc("An array of objects.")
  list?: unknown[];

  @doc("The size of the page.")
  pageSize?: int32;

  @doc("The sorted by field.")
  sortBy?: string;

  @doc("to specify whether the result should be sorted? If yes, whether asc or desc.")
  sortType?: SortType;

  @doc("The start index of the page.")
  startIndex?: int32;

  @doc("The total count of items.")
  totalCount?: int32;
}

@doc("An instance of an entity header map.")
model AtlasEntityHeaders {
  @doc("The description of the guid header map,")
  guidHeaderMap?: Record<AtlasEntityHeader>;
}

@doc("example")
model BulkImportResponse {
  @doc("failed importInfoList")
  failedImportInfoList?: ImportInfo[];

  @doc("successful importInfoList")
  successImportInfoList?: ImportInfo[];
}

@doc("ImportInfo")
model ImportInfo {
  @doc("childObjectName")
  childObjectName?: string;

  @doc("importStatus")
  importStatus?: ImportStatus;

  @doc("parentObjectName")
  parentObjectName?: string;

  @doc("remarks")
  remarks?: string;
}

@doc("MoveEntitiesRequest")
model MoveEntitiesRequest {
  @doc("An array of entity guids to be moved to target collection.")
  entityGuids?: string[];
}

@doc("The glossary object.")
model AtlasGlossary {
  ...AtlasGlossaryBaseObject;

  @doc("An array of categories.")
  categories?: AtlasRelatedCategoryHeader[];

  @doc("The language of the glossary.")
  language?: string;

  @doc("An array of related term headers.")
  terms?: AtlasRelatedTermHeader[];

  @doc("The usage of the glossary.")
  usage?: string;
}

@doc("The header of the related category.")
model AtlasRelatedCategoryHeader {
  @doc("The GUID of the category.")
  categoryGuid?: string;

  @doc("The description of the category header.")
  description?: string;

  @doc("The display text.")
  displayText?: string;

  @doc("The GUID of the parent category.")
  parentCategoryGuid?: string;

  @doc("The GUID of the relationship.")
  relationGuid?: string;
}

@doc("The header of the related term.")
model AtlasRelatedTermHeader {
  @doc("The description of the related term.")
  description?: string;

  @doc("The display text.")
  displayText?: string;

  @doc("The expression of the term.")
  expression?: string;

  @doc("The GUID of the relationship.")
  relationGuid?: string;

  @doc("The status of term relationship.")
  status?: AtlasTermRelationshipStatus;

  @doc("The steward of the term.")
  steward?: string;

  @doc("The GUID of the term.")
  termGuid?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "It follows the rule"
@doc("The glossary base object.")
model AtlasGlossaryBaseObject {
  ...AtlasBaseModelObject;

  @doc("An array of classifications.")
  classifications?: AtlasClassification[];

  @doc("The long version description.")
  longDescription?: string;

  @doc("The name of the glossary object.")
  name?: string;

  @doc("The qualified name of the glossary object.")
  qualifiedName?: string;

  @doc("The short version of description.")
  shortDescription?: string;

  @doc("ETag for concurrency control.")
  lastModifiedTS?: string;

  @doc("The created time of the record.")
  createTime?: int64;

  @doc("The user who created the record.")
  createdBy?: string;

  @doc("The update time of the record.")
  updateTime?: int64;

  @doc("The user who updated the record.")
  updatedBy?: string;
}

@doc("The base model object.")
model AtlasBaseModelObject {
  @doc("The GUID of the object.")
  guid?: string;
}

@doc("The glossary category.")
model AtlasGlossaryCategory {
  ...AtlasGlossaryBaseObject;

  @doc("The glossary header with basic information.")
  anchor?: AtlasGlossaryHeader;

  @doc("An array of children categories.")
  childrenCategories?: AtlasRelatedCategoryHeader[];

  @doc("The header of the related category.")
  parentCategory?: AtlasRelatedCategoryHeader;

  @doc("An array of related term headers.")
  terms?: AtlasRelatedTermHeader[];
}

@doc("The glossary header with basic information.")
model AtlasGlossaryHeader {
  @doc("The display text.")
  displayText?: string;

  @doc("The GUID of the glossary.")
  glossaryGuid?: string;

  @doc("The GUID of the relationship.")
  relationGuid?: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("The glossary term.")
model AtlasGlossaryTerm {
  ...AtlasGlossaryBaseObject;

  @doc("The abbreviation of the term.")
  abbreviation?: string;

  @doc("The name of the template.")
  templateName?: unknown[];

  @doc("The glossary header with basic information.")
  anchor?: AtlasGlossaryHeader;

  @doc("An array of related term headers as antonyms.")
  antonyms?: AtlasRelatedTermHeader[];

  @doc("Status of the AtlasGlossaryTerm")
  status?: TermStatus;

  @doc("The nick name of the term.")
  nickName?: string;

  @doc("The hierarchy information of the term.")
  hierarchyInfo?: PurviewObjectId[];

  @doc("An array of resource link for term")
  resources?: ResourceLink[];

  @doc("The dictionary of contacts for terms. Key could be Expert or Steward.")
  contacts?: Record<ContactBasic[]>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknown> to model Map<String,Object>"
  @doc("""
The custom attributes of the term, which is map<string,map<string,object>>.
The
key of the first layer map is term template name.
""")
  attributes?: Record<Record<unknown>>;

  @doc("An array of related object IDs.")
  assignedEntities?: AtlasRelatedObjectId[];

  @doc("An array of term categorization headers.")
  categories?: AtlasTermCategorizationHeader[];

  @doc("An array of related term headers.")
  classifies?: AtlasRelatedTermHeader[];

  @doc("An array of examples.")
  examples?: string[];

  @doc("An array of related term headers indicating the is-a relationship.")
  isA?: AtlasRelatedTermHeader[];

  @doc("An array of preferred related term headers.")
  preferredTerms?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers that are preferred to.")
  preferredToTerms?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers that are replaced by.")
  replacedBy?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers for replacement.")
  replacementTerms?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers for see also.")
  seeAlso?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers as synonyms.")
  synonyms?: AtlasRelatedTermHeader[];

  @doc("An array of translated related term headers.")
  translatedTerms?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers for translation.")
  translationTerms?: AtlasRelatedTermHeader[];

  @doc("The usage of the term.")
  usage?: string;

  @doc("An array of related term headers as valid values.")
  validValues?: AtlasRelatedTermHeader[];

  @doc("An array of related term headers as valid values for other records.")
  validValuesFor?: AtlasRelatedTermHeader[];
}

@doc("PurviewObjectId")
model PurviewObjectId {
  ...AtlasObjectId;

  @doc("Name")
  name?: string;

  @doc("Display text")
  displayText?: string;

  @doc("Item path")
  itemPath?: string;

  @doc("Resource Id")
  resourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknown> to model Map<String,Object>"
  @doc("Dictionary of <any>")
  properties?: Record<unknown>;
}

@doc("Reference to an object-instance of a type - like entity.")
model AtlasObjectId {
  @doc("The GUID of the object.")
  guid?: string;

  @doc("The name of the type.")
  typeName?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknown> to model Map<String,Object>"
  @doc("The unique attributes of the object.")
  uniqueAttributes?: Record<unknown>;
}

@doc("ResourceLink")
model ResourceLink {
  @doc("Display name for url.")
  displayName?: string;

  @doc("web url. http or https")
  url?: string;
}

@doc("""
Reference to an object-instance of AtlasEntity type used in relationship
attribute values
""")
model AtlasRelatedObjectId {
  ...AtlasObjectId;

  @doc("The display text.")
  displayText?: string;

  @doc("""
Status of the entity - can be active or deleted. Deleted entities are not
removed.
""")
  entityStatus?: Status;

  @doc("Relationship type")
  relationshipType?: string;

  @doc("""
Captures details of struct contents. Not instantiated directly, used only via
AtlasEntity, AtlasClassification.
""")
  relationshipAttributes?: AtlasStruct;

  @doc("The GUID of the relationship.")
  relationshipGuid?: string;

  @doc("The enum of relationship status.")
  relationshipStatus?: StatusAtlasRelationship;
}

@doc("The basic information for term categorization.")
model AtlasTermCategorizationHeader {
  @doc("The GUID of the category.")
  categoryGuid?: string;

  @doc("The description of the record.")
  description?: string;

  @doc("The display text.")
  displayText?: string;

  @doc("The GUID of the relationship.")
  relationGuid?: string;

  @doc("The status of term relationship.")
  status?: AtlasTermRelationshipStatus;
}

@doc("The extended information of glossary.")
model AtlasGlossaryExtInfo {
  ...AtlasGlossary;

  @doc("The glossary category information.")
  categoryInfo?: Record<AtlasGlossaryCategory>;

  @doc("The glossary term information.")
  termInfo?: Record<AtlasGlossaryTerm>;
}

#suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
@doc("The search query of advanced search request.")
model SearchRequest {
  @doc("The keywords applied to all searchable fields.")
  keywords?: string;

  @doc("""
The limit of the number of the search result. default value is 50; maximum
value is 1000.
""")
  limit?: int32;

  @doc("""
The token used to get next batch of data. Default 'Null' to get the first
batch, and will return new token in each response unless there's no more data.
""")
  continuationToken?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is a flexible property"
  @doc("The sort order of search results, can specify multiple fields.")
  orderby?: unknown[];

  @doc("The filter for the search. See examples for the usage of supported filters.")
  filter?: unknown;

  @doc("The facets for search. See examples for the usage of supported facets.")
  facets?: SearchFacetItem[];

  @doc("The taxonomy setting for search.")
  taxonomySetting?: SearchRequestTaxonomySetting;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("The content of a search facet result item.")
model SearchFacetItem {

  @doc("The count of the facet item.")
  count?: int32;

  @doc("The name of the facet item.")
  facet?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
  @doc("Any object")
  sort?: unknown;
}

@doc("Taxonomy setting for search request")
model SearchRequestTaxonomySetting {
  @doc("Asset types")
  assetTypes?: string[];

  @doc("The content of a search facet result item.")
  facet?: SearchFacetItem;
}

@doc("The result of the search result.")
model SearchResult {
  @doc("""
The total number of search results (not the number of documents in a single
page).
""")
  @projectedName("json", "@search.count")
  searchCount?: int32;

  @doc("'True' if the '@search.count' is an approximate value and vise versa.")
  @projectedName("json", "@search.count.approximate")
  searchCountApproximate?: boolean;

  @doc("The token used to get next batch of data. Absent if there's no more data.")
  continuationToken?: string;

  @doc("""
A facet list that consists of index fields assetType ,classification,
contactId, and label. When the facet is specified in the request, the value of
the facet is returned as an element of @search.facets.
""")
  @projectedName("json", "@search.facets")
  searchFacets?: SearchFacetResultValue;

  @doc("Search result value")
  value?: SearchResultValue[];
}

@doc("""
A facet list that consists of index fields assetType ,classification,
contactId, and label. When the facet is specified in the request, the value of
the facet is returned as an element of @search.facets.
""")
model SearchFacetResultValue {
  @doc("Entity type")
  entityType?: SearchFacetItemValue[];

  @doc("Asset type")
  assetType?: SearchFacetItemValue[];

  @doc("Classification")
  classification?: SearchFacetItemValue[];

  @doc("Term")
  term?: SearchFacetItemValue[];

  @doc("Contact id")
  contactId?: SearchFacetItemValue[];

  @doc("Contact type")
  contactType?: SearchFacetItemValue[];

  @doc("Label")
  label?: SearchFacetItemValue[];

  @doc("Glossary type")
  glossaryType?: SearchFacetItemValue[];

  @doc("Term status")
  termStatus?: SearchFacetItemValue[];

  @doc("Term template")
  termTemplate?: SearchFacetItemValue[];
}

@doc("The content of a search facet result item.")
model SearchFacetItemValue {
  @doc("The count of the facet item.")
  count?: int32;

  @doc("The name of the facet item.")
  value?: string;
}

@doc("The value item of the search result.")
model SearchResultValue {
  @doc("""
The search score calculated by the search engine. The results are ordered by
search score by default.
""")
  @projectedName("json", "@search.score")
  searchScore?: float32;

  @doc("""
A highlight list that consists of index fields id ,qualifiedName, name,
description, entityType. When the keyword appears in those fields, the value of
the field, attached with emphasis mark, is returned as an element of
@search.highlights.
""")
  @projectedName("json", "@search.highlights")
  searchHighlights?: SearchHighlights;

  @doc("""
The object type of the record. Object type is the top-level property to
distinguish whether a record is an asset or a term.
""")
  objectType?: string;

  @doc("The create time of the record. The Unix epoch format.")
  createTime?: int64;

  @doc("The last update time of the record. The Unix epoch format.")
  updateTime?: int64;

  @doc("The GUID of the record.")
  id?: string;

  @doc("The name of the record.")
  name?: string;

  @doc("The qualified name of the record.")
  qualifiedName?: string;

  @doc("The type name of the asset.")
  entityType?: string;

  @doc("The description of the asset.")
  description?: string;

  @doc("The endorsement of the asset.")
  endorsement?: string;

  @doc("The owner of the record.")
  owner?: string;

  @doc("The classifications of the record.")
  classification?: string[];

  @doc("The labels of the asset.")
  label?: string[];

  @doc("The terms assigned to the asset.")
  term?: TermSearchResultValue[];

  @doc("The contacts of the asset.")
  contact?: ContactSearchResultValue[];

  @doc("The asset types of the asset.")
  assetType?: string[];

  @doc("""
The type name of the term. Could be AtlasGlossary, AtlasGlossaryTerm or
AtlasGlossaryCategory.
""")
  glossaryType?: string;

  @doc("The glossary name of the term.")
  glossary?: string;

  @doc("The status of the term.")
  termStatus?: string;

  @doc("The term template names used by the term.")
  termTemplate?: string[];

  @doc("The definition of the term.")
  longDescription?: string;
}

@doc("""
A highlight list that consists of index fields id ,qualifiedName, name,
description, entityType. When the keyword appears in those fields, the value of
the field, attached with emphasis mark, is returned as an element of
@search.highlights.
""")
model SearchHighlights {
  @doc("Id")
  id?: string[];

  @doc("Qualified name")
  qualifiedName?: string[];

  @doc("Name")
  name?: string[];

  @doc("Description")
  description?: string[];

  @doc("Entity type")
  entityType?: string[];
}

@doc("The context.")
model TermSearchResultValue {
  @doc("The name of the term.")
  name?: string;

  @doc("The name of the glossary which contains the term.")
  glossaryName?: string;

  @doc("The GUID of the term.")
  guid?: string;
}

@doc("The contact in the search and suggest result.")
model ContactSearchResultValue {
  @doc("The GUID of the contact.")
  id?: string;

  @doc("The description of the contact.")
  info?: string;

  @doc("""
The type of the contact. It can be Expert or Owner for an entity. It can be
Expert or Steward for a glossary term.
""")
  contactType?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
@doc("The query of suggest request.")
model SuggestRequest {
  @doc("""
The keywords applied to all fields that support suggest operation. It must be
at least 1 character, and no more than 100 characters. In the index schema we
defined a default suggester which lists all the supported fields and specifies
a search mode.
""")
  keywords?: string;

  @doc("""
The number of suggestions we hope to return. The default value is 5. The value
must be a number between 1 and 100.
""")
  limit?: int32;

  @doc("The filter for the search.")
  filter?: unknown;
}

@doc("The result item of the search suggest.")
model SuggestResult {
  @doc("The result value")
  value?: SuggestResultValue[];
}

@doc("The value item of the search suggest.")
model SuggestResultValue {
  @doc("""
The search score calculated by the search engine. The results are ordered by
search score by default.
""")
  @projectedName("json", "@search.score")
  searchScore?: float32;

  @doc("""
The target text that contains the keyword as prefix. The keyword is wrapped
with emphasis mark.
""")
  @projectedName("json", "@search.text")
  searchText?: string;

  @doc("""
The object type of the record. Object type is the top-level property to
distinguish whether a record is an asset or a term.
""")
  objectType?: string;

  @doc("The create time of the record. The Unix epoch format.")
  createTime?: int64;

  @doc("The last update time of the record. The Unix epoch format.")
  updateTime?: int64;

  @doc("The GUID of the record.")
  id?: string;

  @doc("The name of the record.")
  name?: string;

  @doc("The qualified name of the record.")
  qualifiedName?: string;

  @doc("The type name of the asset.")
  entityType?: string;

  @doc("The description of the asset.")
  description?: string;

  @doc("The endorsement of the asset.")
  endorsement?: string;

  @doc("The owner of the record.")
  owner?: string;

  @doc("The classifications of the record.")
  classification?: string[];

  @doc("The labels of the asset.")
  label?: string[];

  @doc("The terms assigned to the asset.")
  term?: TermSearchResultValue[];

  @doc("The contacts of the asset.")
  contact?: ContactSearchResultValue[];

  @doc("The asset types of the asset.")
  assetType?: string[];

  @doc("""
The type name of the term. Could be AtlasGlossary, AtlasGlossaryTerm or
AtlasGlossaryCategory.
""")
  glossaryType?: string;

  @doc("The glossary name of the term.")
  glossary?: string;

  @doc("The status of the term.")
  termStatus?: string;

  @doc("The term template names used by the term.")
  termTemplate?: string[];

  @doc("The definition of the term.")
  longDescription?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
@doc("The query of autocomplete request.")
model AutoCompleteRequest {
  @doc("""
The keywords applied to all fields that support autocomplete operation. It must
be at least 1 character, and no more than 100 characters.
""")
  keywords?: string;

  @doc("""
The number of autocomplete results we hope to return. The default value is 50.
The value must be a number between 1 and 100.
""")
  limit?: int32;

  @doc("The filter for the autocomplete request.")
  filter?: unknown;
}

@doc("The result of the autocomplete request.")
model AutoCompleteResult {
  @doc("The result value")
  value?: AutoCompleteResultValue[];
}

@doc("The value item of the autocomplete suggest.")
model AutoCompleteResultValue {
  @doc("The completed term or phrase.")
  text?: string;

  @doc("The completed search query text.")
  queryPlusText?: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("The lineage information.")
model AtlasLineageInfo {
  @doc("The GUID of the base entity.")
  baseEntityGuid?: string;

  @doc("The GUID entity map.")
  guidEntityMap?: Record<AtlasEntityHeader>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use Recode<unknow> to model Map<String,Object>"
  @doc("The entity count in specific direction.")
  widthCounts?: Record<Record<unknown>>;

  @doc("The depth of lineage.")
  lineageDepth?: int32;

  @doc("The width of lineage.")
  lineageWidth?: int32;

  @doc("The number of children node.")
  childrenCount?: int32;

  @doc("The enum of lineage direction.")
  lineageDirection?: LineageDirection;

  @doc("An array of parentRelations relations.")
  parentRelations?: ParentRelation[];

  @doc("An array of lineage relations.")
  relations?: LineageRelation[];
}

@doc("The lineage parents relation with GUID of the parent entity and to child entity.")
model ParentRelation {
  @doc("The GUID of child entity.")
  childEntityId?: string;

  @doc("The GUID of relationship.")
  relationshipId?: string;

  @doc("The GUID of parent entity.")
  parentEntityId?: string;
}

@doc("The lineage relation with GUID of the from and to entity.")
model LineageRelation {
  @doc("The GUID of from-entity.")
  fromEntityId?: string;

  @doc("The GUID of relationship.")
  relationshipId?: string;

  @doc("The GUID of to-entity.")
  toEntityId?: string;
}

@doc("Atlas relationship instance.")
model AtlasRelationship {
  ...AtlasStruct;

  @doc("The created time of the record.")
  createTime?: int64;

  @doc("The user who created the record.")
  createdBy?: string;

  @doc("Reference to an object-instance of a type - like entity.")
  end1?: AtlasObjectId;

  @doc("Reference to an object-instance of a type - like entity.")
  end2?: AtlasObjectId;

  @doc("The GUID of the relationship.")
  guid?: string;

  @doc("The home ID of the relationship.")
  homeId?: string;

  @doc("The label of the relationship.")
  label?: string;

  @doc("Used to record the provenance of an instance of an entity or relationship")
  provenanceType?: int32;

  @doc("The enum of relationship status.")
  status?: StatusAtlasRelationship;

  @doc("The update time of the record.")
  updateTime?: int64;

  @doc("The user who updated the record.")
  updatedBy?: string;

  @doc("The version of the relationship.")
  version?: int64;
}

@doc("The relationship with extended information.")
model AtlasRelationshipWithExtInfo {
  @doc("The referred entity header.")
  referredEntities?: Record<AtlasEntityHeader>;

  @doc("Atlas relationship instance.")
  relationship?: AtlasRelationship;
}

@doc("class that captures details of a struct-type.")
model AtlasBusinessMetadataDef {
  ...AtlasStructDef;
}

@doc("class that captures details of a struct-type.")
model AtlasStructDef {
  ...AtlasBaseTypeDef;

  @doc("An array of attribute definitions.")
  attributeDefs?: AtlasAttributeDef[];
}

@doc("class that captures details of a struct-attribute.")
model AtlasAttributeDef {
  @doc("single-valued attribute or multi-valued attribute.")
  cardinality?: Cardinality;

  @doc("An array of constraints.")
  constraints?: AtlasConstraintDef[];

  @doc("The default value of the attribute.")
  defaultValue?: string;

  @doc("The description of the attribute.")
  description?: string;

  @doc("Determines if it is included in notification.")
  includeInNotification?: boolean;

  @doc("Determines if it is indexable.")
  isIndexable?: boolean;

  @doc("Determines if it is optional.")
  isOptional?: boolean;

  @doc("Determines if it unique.")
  isUnique?: boolean;

  @doc("The name of the attribute.")
  name?: string;

  @doc("The options for the attribute.")
  options?: Record<string>;

  @doc("The name of the type.")
  typeName?: string;

  @doc("The maximum count of the values.")
  valuesMaxCount?: int32;

  @doc("The minimum count of the values.")
  valuesMinCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
@doc("class that captures details of a constraint.")
model AtlasConstraintDef {
  @doc("The parameters of the constraint definition.")
  params?: Record<unknown>;

  @doc("The type of the constraint.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "It follows the rule"
@doc("Base class that captures common-attributes for all types.")
model AtlasBaseTypeDef {
  @doc("The enum of type category.")
  category?: TypeCategory;

  @doc("The created time of the record.")
  createTime?: int64;

  @doc("The user who created the record.")
  createdBy?: string;

  @doc("The date format.")
  dateFormatter?: DateFormat;

  @doc("The description of the type definition.")
  description?: string;

  @doc("The GUID of the type definition.")
  guid?: string;

  @doc("The name of the type definition.")
  name?: string;

  @doc("The options for the type definition.")
  options?: Record<string>;

  @doc("The service type.")
  serviceType?: string;

  @doc("The version of the type.")
  typeVersion?: string;

  @doc("The update time of the record.")
  updateTime?: int64;

  @doc("The user who updated the record.")
  updatedBy?: string;

  @doc("The version of the record.")
  version?: int64;

  @doc("ETag for concurrency control.")
  lastModifiedTS?: string;
}

@doc("The date format.")
model DateFormat {
  @doc("An array of available locales.")
  availableLocales?: string[];

  @doc("Calendar")
  calendar?: float32;

  @doc("The date format.")
  dateInstance?: DateFormat;

  @doc("The date format.")
  dateTimeInstance?: DateFormat;

  @doc("The date format.")
  instance?: DateFormat;

  @doc("Determines the leniency of the date format.")
  lenient?: boolean;

  @doc("The number format.")
  numberFormat?: NumberFormat;

  @doc("The date format.")
  timeInstance?: DateFormat;

  @doc("The timezone information.")
  timeZone?: TimeZone;
}

@doc("The number format.")
model NumberFormat {
  @doc("The number format.")
  availableLocales?: string[];

  @doc("The currency.")
  currency?: string;

  @doc("The number format.")
  currencyInstance?: NumberFormat;

  @doc("Determines if grouping is used.")
  groupingUsed?: boolean;

  @doc("The number format.")
  instance?: NumberFormat;

  @doc("The number format.")
  integerInstance?: NumberFormat;

  @doc("The maximum of fraction digits.")
  maximumFractionDigits?: int32;

  @doc("The maximum of integer digits.")
  maximumIntegerDigits?: int32;

  @doc("The minimum of fraction digits.")
  minimumFractionDigits?: int32;

  @doc("The minimum of integer digits.")
  minimumIntegerDigits?: int32;

  @doc("The number format.")
  numberInstance?: NumberFormat;

  @doc("Determines if only integer is parsed.")
  parseIntegerOnly?: boolean;

  @doc("The number format.")
  percentInstance?: NumberFormat;

  @doc("The enum of rounding mode.")
  roundingMode?: RoundingMode;
}

@doc("The timezone information.")
model TimeZone {
  @doc("The value of the daylight saving time.")
  dstSavings?: int32;

  @doc("The ID of the timezone.")
  id?: string;

  @doc("An array of available IDs.")
  availableIds?: string[];

  @doc("The timezone information.")
  default?: TimeZone;

  @doc("The display name of the timezone.")
  displayName?: string;

  @doc("The raw offset of the timezone.")
  rawOffset?: int32;
}

@doc("class that captures details of a classification-type.")
model AtlasClassificationDef {
  ...AtlasStructDef;

  @doc("""
Specifying a list of entityType names in the classificationDef, ensures that
classifications can
only be applied to those entityTypes.
<ul>
<li>Any subtypes
of the entity types inherit the restriction</li>
<li>Any classificationDef
subtypes inherit the parents entityTypes restrictions</li>
<li>Any
classificationDef subtypes can further restrict the parents entityTypes
restrictions by specifying a subset of the entityTypes</li>
<li>An empty
entityTypes list when there are no parent restrictions means there are no
restrictions</li>
<li>An empty entityTypes list when there are parent
restrictions means that the subtype picks up the parents
restrictions</li>
<li>If a list of entityTypes are supplied, where one inherits
from another, this will be rejected. This should encourage cleaner
classificationsDefs</li>
</ul>
""")
  entityTypes?: string[];

  @doc("An array of sub types.")
  subTypes?: string[];

  @doc("An array of super types.")
  superTypes?: string[];
}

@doc("class that captures details of a entity-type.")
model AtlasEntityDef {
  ...AtlasStructDef;

  @doc("An array of sub types.")
  subTypes?: string[];

  @doc("An array of super types.")
  superTypes?: string[];

  @doc("An array of relationship attributes.")
  relationshipAttributeDefs?: AtlasRelationshipAttributeDef[];
}

@doc("""
The relationshipEndDef represents an end of the relationship. The end of the
relationship is defined by a type, an
attribute name, cardinality and whether
it  is the container end of the relationship.
""")
model AtlasRelationshipAttributeDef {
  ...AtlasAttributeDef;

  @doc("Determines if it is a legacy attribute.")
  isLegacyAttribute?: boolean;

  @doc("The name of the relationship type.")
  relationshipTypeName?: string;
}

@doc("class that captures details of an enum-type.")
model AtlasEnumDef {
  ...AtlasBaseTypeDef;

  @doc("The default value.")
  defaultValue?: string;

  @doc("An array of enum element definitions.")
  elementDefs?: AtlasEnumElementDef[];
}

@doc("class that captures details of an enum-element.")
model AtlasEnumElementDef {
  @doc("The description of the enum element definition.")
  description?: string;

  @doc("The ordinal of the enum element definition.")
  ordinal?: int32;

  @doc("The value of the enum element definition.")
  value?: string;
}

@doc("""
AtlasRelationshipDef is a TypeDef that defines a relationship.
<p>
As with
other typeDefs the AtlasRelationshipDef has a name. Once created the
RelationshipDef has a guid.
The name and the guid are the 2 ways that the
RelationshipDef is identified.
<p>
RelationshipDefs have 2 ends, each of which
specify cardinality, an EntityDef type name and name and optionally
whether the
end is a container.
<p>
RelationshipDefs can have AttributeDefs - though only
primitive types are allowed. <br>
RelationshipDefs have a relationshipCategory
specifying the UML type of relationship required <br>
The way EntityDefs and
RelationshipDefs are intended to be used is that EntityDefs will define
AttributeDefs these AttributeDefs
will not specify an EntityDef type name as
their types.
<p>
RelationshipDefs introduce new attributes to the entity
instances. For example
<p>
EntityDef A might have attributes attr1,attr2,attr3
<br>
EntityDef B might have attributes attr4,attr5,attr6 <br>
RelationshipDef
AtoB might define 2 ends <br>

<pre>
   end1:  type A, name attr7
   end2:
type B, name attr8  </pre>

<p>
When an instance of EntityDef A is created, it
will have attributes attr1,attr2,attr3,attr7 <br>
When an instance of EntityDef
B is created, it will have attributes attr4,attr5,attr6,attr8
<p>
In this way
relationshipDefs can be authored separately from entityDefs and can inject
relationship attributes into
the entity instances
""")
model AtlasRelationshipDef {
  ...AtlasStructDef;

  @doc("""
The relationshipEndDef represents an end of the relationship. The end of the
relationship is defined by a type, an
attribute name, cardinality and whether
it  is the container end of the relationship.
""")
  endDef1?: AtlasRelationshipEndDef;

  @doc("""
The relationshipEndDef represents an end of the relationship. The end of the
relationship is defined by a type, an
attribute name, cardinality and whether
it  is the container end of the relationship.
""")
  endDef2?: AtlasRelationshipEndDef;

  @doc("""
The Relationship category determines the style of relationship around
containment and lifecycle.
UML terminology is used for the
values.
<p>
ASSOCIATION is a relationship with no containment. <br>
COMPOSITION
and AGGREGATION are containment relationships.
<p>
The difference being in the
lifecycles of the container and its children. In the COMPOSITION case,
the
children cannot exist without the container. For AGGREGATION, the life
cycles
of the container and children are totally independent.
""")
  relationshipCategory?: RelationshipCategory;

  @doc("The label of the relationship.")
  relationshipLabel?: string;
}

@doc("""
The relationshipEndDef represents an end of the relationship. The end of the
relationship is defined by a type, an
attribute name, cardinality and whether
it  is the container end of the relationship.
""")
model AtlasRelationshipEndDef {
  @doc("single-valued attribute or multi-valued attribute.")
  cardinality?: Cardinality;

  @doc("The description of the relationship end definition.")
  description?: string;

  @doc("Determines if it is container.")
  isContainer?: boolean;

  @doc("Determines if it is a legacy attribute.")
  isLegacyAttribute?: boolean;

  @doc("The name of the relationship end definition.")
  name?: string;

  @doc("The type of the relationship end.")
  type?: string;
}

@doc("The definitions of type.")
model AtlasTypeDef {
  ...AtlasBaseTypeDef;
  ...AtlasExtraTypeDef;
}

@doc("Extra properties for a type.")
model AtlasExtraTypeDef {
  @doc("""
Specifying a list of entityType names in the classificationDef, ensures that
classifications can
only be applied to those entityTypes.
<ul>
<li>Any subtypes
of the entity types inherit the restriction</li>
<li>Any classificationDef
subtypes inherit the parents entityTypes restrictions</li>
<li>Any
classificationDef subtypes can further restrict the parents entityTypes
restrictions by specifying a subset of the entityTypes</li>
<li>An empty
entityTypes list when there are no parent restrictions means there are no
restrictions</li>
<li>An empty entityTypes list when there are parent
restrictions means that the subtype picks up the parents
restrictions</li>
<li>If a list of entityTypes are supplied, where one inherits
from another, this will be rejected. This should encourage cleaner
classificationsDefs</li>
</ul>
""")
  entityTypes?: string[];

  @doc("An array of sub types.")
  subTypes?: string[];

  @doc("An array of super types.")
  superTypes?: string[];

  @doc("An array of relationship attributes.")
  relationshipAttributeDefs?: AtlasRelationshipAttributeDef[];

  @doc("The default value.")
  defaultValue?: string;

  @doc("An array of enum element definitions.")
  elementDefs?: AtlasEnumElementDef[];

  @doc("""
The relationshipEndDef represents an end of the relationship. The end of the
relationship is defined by a type, an
attribute name, cardinality and whether
it  is the container end of the relationship.
""")
  endDef1?: AtlasRelationshipEndDef;

  @doc("""
The relationshipEndDef represents an end of the relationship. The end of the
relationship is defined by a type, an
attribute name, cardinality and whether
it  is the container end of the relationship.
""")
  endDef2?: AtlasRelationshipEndDef;

  @doc("""
The Relationship category determines the style of relationship around
containment and lifecycle.
UML terminology is used for the
values.
<p>
ASSOCIATION is a relationship with no containment. <br>
COMPOSITION
and AGGREGATION are containment relationships.
<p>
The difference being in the
lifecycles of the container and its children. In the COMPOSITION case,
the
children cannot exist without the container. For AGGREGATION, the life
cycles
of the container and children are totally independent.
""")
  relationshipCategory?: RelationshipCategory;

  @doc("The label of the relationship.")
  relationshipLabel?: string;

  @doc("An array of attribute definitions.")
  attributeDefs?: AtlasAttributeDef[];
}

@doc("The definitions of types.")
model AtlasTypesDef {
  @doc("businessMetadataDefs")
  businessMetadataDefs?: AtlasBusinessMetadataDef[];

  @doc("An array of classification definitions.")
  classificationDefs?: AtlasClassificationDef[];

  @doc("An array of entity definitions.")
  entityDefs?: AtlasEntityDef[];

  @doc("An array of enum definitions.")
  enumDefs?: AtlasEnumDef[];

  @doc("An array of relationship definitions.")
  relationshipDefs?: AtlasRelationshipDef[];

  @doc("An array of struct definitions.")
  structDefs?: AtlasStructDef[];

  @doc("An array of term template definitions.")
  termTemplateDefs?: TermTemplateDef[];
}

@doc("Term template definition for glossary term.")
model TermTemplateDef {
  ...AtlasStructDef;
}

@doc("The basic information of the type definition.")
model AtlasTypeDefHeader {
  @doc("The enum of type category.")
  category?: TypeCategory;

  @doc("The GUID of the type definition.")
  guid?: string;

  @doc("The name of the type definition.")
  name?: string;
}

@discriminator("kind")
@doc("Base model for search filter")
model SearchFilter {

}


@doc("And filter for search")
model AndFilter extends SearchFilter {
  @doc("And filter for search")
  kind: "AndFilter";
  @doc("List of filters")
  @projectedName("json", "and")
  andFilters : SearchFilter[];
}

@doc("Not filter for search")
model NotFilter extends SearchFilter {
  @doc("Not filter for search")
  kind: "NotFilter";

  @doc("Not filter")
  @projectedName("json", "not")
  notFilters : SearchFilter;
}

@doc("Or filter for search")
model OrFilter extends SearchFilter {
  @doc("Or filter for search")
  kind: "OrFilter";
  @doc("List of filters")
  @projectedName("json", "or")
  orFilters : SearchFilter[];
}

@doc("Asset type filter for search")
model AssetTypeFilter extends SearchFilter {
  @doc("Asset type filter for search")
  kind: "AssetTypeFilter";
  @doc("Asset type name")
  assetType: string;
}

@doc("Attribute filter for search")
model AttributeFilter extends SearchFilter {
  @doc("Attribute filter for search")
  kind: "AttributeFilter";

  @doc("Attribute name")
  attributeName: string;
  @doc("Operator")
  operator: SearchFilterOperator;

  @doc("Attribute value")
  attributeValue: string;
}

@doc("Classification type filter for search")
model ClassificationFilter extends SearchFilter {
  @doc("Classification type filter for search")
  kind: "ClassificationFilter";
  @doc("Classification name")
  classificationName: string;
  @doc("Whether to include sub classifications")
  includeSubClassifications?: boolean;
}

@doc("Classification category filter for search")
model ClassificationCategoryFilter extends SearchFilter {
  @doc("Classification category filter for search")
  kind: "ClassificationCategoryFilter";
  @doc("Classification category")
  classificationCategory: string;
}

@doc("Collection id filter for search")
model CollectionIdFilter extends SearchFilter {
  @doc("Collection id filter for search")
  kind: "CollectionIdFilter";
  @doc("Collection id")
  collectionId: string;
}

@doc("Contact filter for search")
model ContactFilter extends SearchFilter {
  @doc("Contact filter for search")
  kind: "ContactFilter";
  @doc("Contact type")
  contactType?: string;
  @doc("Contact Id")
  contactId?: string;
}

@doc("Domain id filter for search")
model DomainIdFilter extends SearchFilter {
  @doc("Domain id filter for search")
  kind: "DomainIdFilter";
  @doc("Domain id")
  domainId: string;
}

@doc("Exists filter for search")
model ExistsFilter extends SearchFilter {
  @doc("Exists filter for search")
  kind: "ExistsFilter";
  @projectedName("json", "exists")
  @doc("Field")
  field: string;
}

@doc("File extension filter for search")
model FileExtensionFilter extends SearchFilter {
  @doc("File extension filter for search")
  kind: "FileExtensionFilter";
  @doc("File extension")
  fileExtension: string;
}

@doc("Label filter for search")
model LabelFilter extends SearchFilter {
  @doc("Label filter for search")
  kind: "LabelFilter";
  @doc("Label")
  label: string;
  @doc("Whether to include sub labels")
  includeSubLabels?: boolean;
}


@doc("Label filter for search")
model ObjectTypeFilter extends SearchFilter {
  @doc("Label filter for search")
  kind: "ObjectTypeFilter";
  @doc("Object type")
  objectType: string;
}

@doc("Path filter for search")
model PathFilter extends SearchFilter {
  @doc("Path filter for search")
  kind: "PathFilter";
  @doc("Path")
  path: string;
  @doc("Whether the path is parent path")
  isParent?: boolean;
}

@doc("Scan info filter for search")
model ScanInfoFilter extends SearchFilter {
  @doc("Scan info filter for search")
  kind: "ScanInfoFilter";
  @doc("Data source name")
  dataSourceName?: string;
  @doc("Scan name")
  scanName?: string;
}

@doc("Glossary filter for search")
model GlossaryFilter extends SearchFilter {
  @doc("Glossary filter for search")
  kind: "GlossaryFilter";
  @doc("Glossary type. Either AtlasGlossary or AtlasGlossaryType")
  glossaryType: string;
}

@doc("Id filter for search")
model IdFilter extends SearchFilter {
  @doc("Id filter for search")
  kind: "IdFilter";
  @doc("Id value")
  id: string;
}

@doc("Type filter for search")
model TypeFilter extends SearchFilter {
  @doc("Type filter for search")
  kind: "TypeFilter";
  @doc("Type name")
  typeName: string;
  @doc("Whether to include sub types")
  includeSubTypes?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
@doc("Create time filter for search")
model CreateTimeFilter extends SearchFilter {
  @doc("Create time filter for search")
  kind: "CreateTimeFilter";
  @doc("""
Either using a string 'LAST_24H|LAST_7D|LAST_30D|LAST_365D|MORE_THAN_365D', or using a map for example
{
  "operator": "lt",
  "timeThreshold": 1545580800000
}
to represent the time filter, operator must be one of gt/lt/gte/lte
""")
  createTime: unknown;
}

#suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
@doc("Update time filter for search")
model UpdateTimeFilter extends SearchFilter {
  @doc("Update time filter for search")
  kind: "UpdateTimeFilter";
  @doc("""
Either using a string 'LAST_24H|LAST_7D|LAST_30D|LAST_365D|MORE_THAN_365D', or using a map for example
{
  "operator": "lt",
  "timeThreshold": 1545580800000
}
to represent the time filter, operator must be one of gt/lt/gte/lte
""")
  updateTime: unknown;
}