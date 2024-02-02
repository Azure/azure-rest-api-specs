import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using Azure.ClientGenerator.Core;

namespace PurviewDataMap;

model OkResponse<T> {
  @statusCode
  status: 200;

  @body
  data: T;
}

op AtlasImportOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {},
  TraitContexts extends TraitContext = TraitContext.Undefined
> is Azure.Core.Foundations.Operation<
  TParams &
    TraitProperties<
      Traits &
        NoConditionalRequests &
        NoRepeatableRequests &
        NoClientRequestId,
      TraitLocation.Parameters,
      TraitContext.Action
    >,
  TResponse &
    TraitProperties<
      Traits &
        NoConditionalRequests &
        NoRepeatableRequests &
        NoClientRequestId,
      TraitLocation.Response,
      TraitContext.Action
    >,
  Traits & NoConditionalRequests & NoRepeatableRequests & NoClientRequestId,
  AtlasErrorResponse
>;

alias MultipartFormDataRequestHeadersTraits = Azure.Core.Traits.RequestHeadersTrait<{
  @doc("The content type for the operation. Always multipart/form-data for this operation.")
  @header("content-type")
  contentType: "multipart/form-data";
}>;

interface Entity {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Create or update an entity.
Existing entity is matched using its unique guid if
supplied or by its unique attributes eg: qualifiedName.
Map and array of
collections are not well supported. E.g., array<array<int>>, array<map<string,
int>>.
For each contact type, the maximum number of contacts is 20.
""")
  @route("/atlas/v2/entity")
  @post
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Used to define the update behavior for business attributes when updating
entities.
""")
      @query
      businessAttributeUpdateBehavior?: BusinessAttributeUpdateBehavior;

      @doc("""
The collection where entities will be moved to. Only specify a value if you
need to move an entity to another collection.
""")
      @query
      collectionId?: string;

      @doc("Atlas entity with extended information.")
      @body
      body: AtlasEntityWithExtInfo;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/prefer-csv-collection-format" "This is an existing Atlas API"
  @doc("List entities in bulk identified by its GUIDs.")
  @route("/atlas/v2/entity/bulk")
  @get
  listByGuids is Azure.Core.Foundations.Operation<
    {
      @doc("An array of GUIDs of entities to list.")
      @query({
        format: "multi",
      })
      guid: string[];

      @doc("Whether to return minimal information for referred entities.")
      @query
      minExtInfo?: boolean;

      @doc("Whether to ignore relationship attributes.")
      @query
      ignoreRelationships?: boolean;
    },
    AtlasEntitiesWithExtInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Create or update entities in bulk.
Existing entity is matched using its unique
guid if supplied or by its unique attributes eg: qualifiedName.
Map and array
of collections are not well supported. E.g., array<array<int>>,
array<map<string, int>>.
For each contact type, the maximum number of contacts
is 20.
""")
  @route("/atlas/v2/entity/bulk")
  @post
  bulkCreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The collection where entities will be moved to. Only specify a value if you
need to move an entity to another collection.
""")
      @query
      collectionId?: string;

      @doc("""
Used to define the update behavior for business attributes when updating
entities.
""")
      @query
      businessAttributeUpdateBehavior?: BusinessAttributeUpdateBehavior;

      @doc("An array of entities to create or update.")
      @body
      body: AtlasEntitiesWithExtInfo;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/prefer-csv-collection-format" "This is an existing Atlas API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Delete a list of entities in bulk identified by their GUIDs or unique
attributes.
""")
  @route("/atlas/v2/entity/bulk")
  @delete
  bulkDelete is Azure.Core.Foundations.Operation<
    {
      @doc("An array of GUIDs of entities to delete.")
      @query({
        format: "multi",
      })
      guid: string[];
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Associate a classification to multiple entities in bulk.")
  @route("/atlas/v2/entity/bulk/classification")
  @post
  addClassification is Azure.Core.Foundations.Operation<
    {
      @doc("The request to associate a classification to multiple entities.")
      @body
      body: ClassificationAssociateOptions;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get complete definition of an entity given its GUID.")
  @route("/atlas/v2/entity/guid/{guid}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("Whether to return minimal information for referred entities.")
      @query
      minExtInfo?: boolean;

      @doc("Whether to ignore relationship attributes.")
      @query
      ignoreRelationships?: boolean;
    },
    AtlasEntityWithExtInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Update entity partially - create or update entity attribute identified by its
GUID.
Supports only primitive attribute type and entity references.
It does not support updating complex types like arrays, and maps.
Null updates are not possible.
""")
  @route("/atlas/v2/entity/guid/{guid}")
  @put
  partialUpdateAttributeByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The name of the attribute.")
      @query
      name: string;

      #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
      @doc("The value of the attribute.")
      @body
      body: unknown;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete an entity identified by its GUID.")
  @route("/atlas/v2/entity/guid/{guid}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get classification for a given entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classification/{classificationName}")
  @get
  getClassification is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The name of the classification.")
      @path
      classificationName: string;
    },
    AtlasClassification,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete a given classification from an existing entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classification/{classificationName}")
  @delete
  removeClassification is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The name of the classification.")
      @path
      classificationName: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("List classifications for a given entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classifications")
  @get
  getClassifications is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    AtlasClassifications,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Add classifications to an existing entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classifications")
  @post
  addClassifications is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("An array of classifications to be added.")
      @body
      body: AtlasClassification[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update classifications to an existing entity represented by a guid.")
  @route("/atlas/v2/entity/guid/{guid}/classifications")
  @put
  updateClassifications is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("An array of classifications to be updated.")
      @body
      body: AtlasClassification[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get complete definition of an entity given its type and unique attribute.

In
addition to the typeName path parameter, attribute key-value pair(s) can be
provided in the following format:
attr:\\<attrName>=<attrValue>.

NOTE: The
attrName and attrValue should be unique across entities, eg.
qualifiedName.

The REST request would look something like this:
GET
/v2/entity/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}")
  @get
  getByUniqueAttributes is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("Whether to return minimal information for referred entities.")
      @query
      minExtInfo?: boolean;

      @doc("Whether to ignore relationship attributes.")
      @query
      ignoreRelationships?: boolean;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;
    },
    AtlasEntityWithExtInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Update entity partially - Allow a subset of attributes to be updated on an
entity which is identified by its type and unique attribute eg:
Referenceable.qualifiedName. Null updates are not possible.

In addition to the
typeName path parameter, attribute key-value pair(s) can be provided in the
following format:

attr:<attrName>=<attrValue>.
NOTE: The attrName and
attrValue should be unique across entities, eg. qualifiedName.

The REST
request would look something like this:
PUT
/v2/entity/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}")
  @put
  partialUpdateByUniqueAttributes is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;

      @doc("Atlas entity with extended information.")
      @body
      body: AtlasEntityWithExtInfo;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Delete an entity identified by its type and unique attributes.
In addition to
the typeName path parameter, attribute key-value pair(s) can be provided in the
following format:
attr:\\<attrName>=\\<attrValue>.
NOTE: The attrName and
attrValue should be unique across entities, eg. qualifiedName.

The REST
request would look something like this:
DELETE
/v2/entity/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}")
  @delete
  deleteByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Delete a given classification from an entity identified by its type and unique
attributes.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/classification/{classificationName}")
  @delete
  removeClassificationByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("The name of the classification.")
      @path
      classificationName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Add classification to the entity identified by its type and unique attributes.")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/classifications")
  @post
  addClassificationsByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;

      @doc("An array of classification to be added.")
      @body
      body: AtlasClassification[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update classification on an entity identified by its type and unique attributes.")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/classifications")
  @put
  updateClassificationsByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;

      @doc("An array of classification to be updated.")
      @body
      body: AtlasClassification[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Set classifications on entities in bulk.")
  @route("/atlas/v2/entity/bulk/setClassifications")
  @post
  bulkSetClassifications is Azure.Core.Foundations.Operation<
    {
      @doc("Atlas entity headers.")
      @body
      body: AtlasEntityHeaders;
    },
    OkResponse<string[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is Atlas API behavior"
  @doc("""
Bulk API to retrieve list of entities identified by its unique attributes.
In
addition to the typeName path parameter, attribute key-value pair(s) can be
provided in the following
format

typeName=\\<typeName>&attr_1:\\<attrName>=\\<attrValue>&attr_2:\\<attrName>=\\<attrValue>&attr_3:\\<attrName>=\\<attrValue>

NOTE:
The attrName should be an unique attribute for the given entity-type.
The REST
request would look something like this

GET
/v2/entity/bulk/uniqueAttribute/type/hive_db?attr_1:qualifiedName=db1@cl1&attr_2:qualifiedName=db2@cl1

Note:
at least one unique attribute must be provided.
""")
  @route("/atlas/v2/entity/bulk/uniqueAttribute/type/{typeName}")
  @get
  listByUniqueAttributes is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("Whether to return minimal information for referred entities.")
      @query
      minExtInfo?: boolean;

      @doc("Whether to ignore relationship attributes.")
      @query
      ignoreRelationships?: boolean;

      @doc("""
Qualified name of an entity. E.g. to find 2 entities you can set
attrs_1:qualifiedName=db1@cl1&attrs_2:qualifiedName=db2@cl1. (This is only an
example. qualifiedName can be changed to other unique attributes)
""")
      @query
      `attr_N:qualifiedName`?: string;
    },
    AtlasEntitiesWithExtInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get entity header given its GUID.")
  @route("/atlas/v2/entity/guid/{guid}/header")
  @get
  getHeader is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    AtlasEntityHeader,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Remove business metadata from an entity.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata")
  @delete
  removeBusinessMetadata is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("Business metadata payload")
      @body
      body: Record<Record<unknown>>;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Add business metadata to an entity.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata")
  @post
  addOrUpdateBusinessMetadata is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("""
Whether to overwrite the existing business metadata on the entity or not,
default is false.
""")
      @query("isOverwrite")
      overwrite?: boolean;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("BusinessMetadata payload")
      @body
      body: Record<Record<unknown>>;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an Atlas existing api"
  @doc("Delete business metadata attributes from an entity.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata/{businessMetadataName}")
  @delete
  removeBusinessMetadataAttributes is Azure.Core.Foundations.Operation<
    {
      @doc("BusinessMetadata name")
      @path
      businessMetadataName: string;

      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("Business metadata attribute payload")
      @body
      body: Record<unknown>;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an Atlas existing api"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
  @doc("Add or update business metadata attributes.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata/{businessMetadataName}")
  @post
  addOrUpdateBusinessMetadataAttributes is Azure.Core.Foundations.Operation<
    {
      @doc("BusinessMetadata name")
      @path
      businessMetadataName: string;

      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("Business metadata attribute payload")
      @body
      body: Record<unknown>;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the sample Template for uploading/creating bulk BusinessMetaData")
  @route("/atlas/v2/entity/businessmetadata/import/template")
  @get
  getSampleBusinessMetadataTemplate is Azure.Core.RpcOperation<
    {},
    {
      @header contentType: "application/octet-stream";
      @body body: bytes;
    },
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Upload the file for creating Business Metadata in BULK")
  @route("/atlas/v2/entity/businessmetadata/import")
  @post
  importBusinessMetadata is AtlasImportOperation<
    {
      @doc("InputStream of file")
      file: bytes;
    },
    BulkImportResult,
    MultipartFormDataRequestHeadersTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete given labels to a given entity.")
  @route("/atlas/v2/entity/guid/{guid}/labels")
  @delete
  removeLabels is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("set of labels to be deleted")
      @body
      body: string[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Set labels to a given entity.")
  @route("/atlas/v2/entity/guid/{guid}/labels")
  @post
  setLabels is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("set of labels to be set to the entity")
      @body
      body: string[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Add given labels to a given entity.")
  @route("/atlas/v2/entity/guid/{guid}/labels")
  @put
  addLabel is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("set of labels to be added")
      @body
      body: string[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Delete given labels to a given entity identified by its type and unique
attribute.

If labels is null/empty, no labels will be removed.

If any labels
in labels set are non-existing labels, they will be ignored, only existing
labels will be removed. In addition to the typeName path parameter, attribute
key-value pair(s) can be provided in the following format:
attr:<attrName>=<attrValue>. NOTE: The attrName and attrValue should be unique
across entities, eg. qualifiedName. The REST request would look something like
this: DELETE
/v2/entity/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/labels")
  @delete
  removeLabelsByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;

      @doc("set of labels to be deleted")
      @body
      body: string[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Set labels to a given entity identified by its type and unique attributes.

If
labels is null/empty, existing labels will all be removed.

In addition to the
typeName path parameter, attribute key-value pair(s) can be provided in the
following format: attr:<attrName>=<attrValue>.

NOTE: The attrName and
attrValue should be unique across entities, eg. qualifiedName.

The REST
request would look something like this: POST
/v2/entity/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/labels")
  @post
  setLabelsByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;

      @doc("set of labels to be set")
      @body
      body: string[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Add given labels to a given entity identified by its type and unique
attributes.

If labels is null/empty, no labels will be added.

In addition to
the typeName path parameter, attribute key-value pair(s) can be provided in the
following format: attr:<attrName>=<attrValue>.

NOTE: The attrName and
attrValue should be unique across entities, eg. qualifiedName.

The REST
request would look something like this: PUT
/v2/entity/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/labels")
  @put
  addLabelsByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;

      @doc("set of labels to be added")
      @body
      body: string[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Move existing entities to the target collection.")
  @route("/entity/moveTo")
  @post
  moveEntitiesToCollection is Azure.Core.Foundations.Operation<
    {
      @doc("The collection where entities will be moved to.")
      @query
      collectionId: string;

      @doc("Entity guids to be moved to target collection.")
      @body
      body: MoveEntitiesOptions;
    },
    EntityMutationResult,
    {},
    AtlasErrorResponse
  >;
}

interface Glossary {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get all glossaries. Recommend using limit/offset to get pagination result.
Recommend using 'ignoreTermsAndCategories=true' and fetch terms/categories
separately using 

 'GET /datamap/api/atlas/v2/glossary/{glossaryId}/terms'
and 

 'GET '/datamap/api/atlas/v2/glossary/{glossaryId}/categories'.
""")
  @route("/atlas/v2/glossary")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;

      @doc("Whether ignore terms and categories")
      @query
      ignoreTermsAndCategories?: boolean;
    },
    OkResponse<AtlasGlossary[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create a glossary.")
  @route("/atlas/v2/glossary")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("""
Glossary definition, terms & categories can be anchored to a glossary.
Using
the anchor attribute when creating the Term/Category.
""")
      @body
      body: AtlasGlossary;
    },
    AtlasGlossary,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create glossary category in bulk.")
  @route("/atlas/v2/glossary/categories")
  @post
  createCategories is Azure.Core.Foundations.Operation<
    {
      @doc("An array of glossary category definitions to be created.")
      @body
      body: AtlasGlossaryCategory[];
    },
    OkResponse<AtlasGlossaryCategory[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create a glossary category.")
  @route("/atlas/v2/glossary/category")
  @post
  createCategory is Azure.Core.Foundations.Operation<
    {
      @doc("""
The glossary category definition. A category must be anchored to a Glossary
when creating.
Optionally, terms belonging to the category and the hierarchy
can also be defined during creation.
""")
      @body
      body: AtlasGlossaryCategory;
    },
    AtlasGlossaryCategory,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get specific glossary category by its GUID.")
  @route("/atlas/v2/glossary/category/{categoryId}")
  @get
  getCategory is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;
    },
    AtlasGlossaryCategory,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update the given glossary category by its GUID.")
  @route("/atlas/v2/glossary/category/{categoryId}")
  @put
  updateCategory is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;

      @doc("The glossary category to be updated.")
      @body
      body: AtlasGlossaryCategory;
    },
    AtlasGlossaryCategory,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete a glossary category.")
  @route("/atlas/v2/glossary/category/{categoryId}")
  @delete
  deleteCategory is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
  @doc("""
Update the glossary category partially. So far we only supports partial
updating shortDescription and longDescription for category.
""")
  @route("/atlas/v2/glossary/category/{categoryId}/partial")
  @put
  partialUpdateCategory is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;

      @doc("""
A map containing keys as attribute names and values as corresponding attribute
values for partial update.
""")
      @body
      body: Record<string>;
    },
    AtlasGlossaryCategory,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get all related categories (parent and children). Limit, offset, and sort
parameters are currently not being enabled and won't work even they are passed.
""")
  @route("/atlas/v2/glossary/category/{categoryId}/related")
  @get
  listRelatedCategories is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<Record<AtlasRelatedCategoryHeader[]>>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get all terms associated with the specific category.")
  @route("/atlas/v2/glossary/category/{categoryId}/terms")
  @get
  listCategoryTerms is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<AtlasRelatedTermHeader[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create a glossary term.")
  @route("/atlas/v2/glossary/term")
  @post
  createTerm is Azure.Core.Foundations.Operation<
    {
      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;

      @doc("""
The glossary term definition. A term must be anchored to a Glossary at the time
of creation.
Optionally it can be categorized as well.
""")
      @body
      body: AtlasGlossaryTerm;
    },
    AtlasGlossaryTerm,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get a specific glossary term by its GUID. ")
  @route("/atlas/v2/glossary/term/{termId}")
  @get
  getTerm is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;
    },
    AtlasGlossaryTerm,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update the given glossary term by its GUID.")
  @route("/atlas/v2/glossary/term/{termId}")
  @put
  updateTerm is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;

      @doc("The glossary term to be updated.")
      @body
      body: AtlasGlossaryTerm;
    },
    AtlasGlossaryTerm,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete a glossary term.")
  @route("/atlas/v2/glossary/term/{termId}")
  @delete
  deleteTerm is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
  @doc("""
Update the glossary term partially. So far we only supports partial updating
shortDescription, longDescription, abbreviation, usage and status for term.
""")
  @route("/atlas/v2/glossary/term/{termId}/partial")
  @put
  partialUpdateTerm is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;

      @doc("""
A map containing keys as attribute names and values as corresponding attribute
values to be updated.
""")
      @body
      body: Record<string>;
    },
    AtlasGlossaryTerm,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create glossary terms in bulk.")
  @route("/atlas/v2/glossary/terms")
  @post
  createTerms is Azure.Core.Foundations.Operation<
    {
      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;

      @doc("An array of glossary term definitions to be created in bulk.")
      @body
      body: AtlasGlossaryTerm[];
    },
    OkResponse<AtlasGlossaryTerm[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
List all related objects assigned with the specified term. Recommend using
limit/offset to get pagination result.
""")
  @route("/atlas/v2/glossary/terms/{termId}/assignedEntities")
  @get
  listEntitiesAssignedWithTerm is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<AtlasRelatedObjectId[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Assign the given term to the provided list of related objects. Recommend using
small batches with multiple API calls.

[Entities Create Or Update
operation](https://learn.microsoft.com/en-us/rest/api/purview/datamapdataplane/entity/bulk-create-or-update?tabs=HTTP)
is an alternative to assign a term to multiple entities.
""")
  @route("/atlas/v2/glossary/terms/{termId}/assignedEntities")
  @post
  assignTermToEntities is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("An array of related object IDs to which the term has to be associated.")
      @body
      body: AtlasRelatedObjectId[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete the term assignment for the given list of related objects.")
  @route("/atlas/v2/glossary/terms/{termId}/assignedEntities")
  @delete
  deleteTermAssignmentFromEntities is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("An array of related object IDs from which the term has to be dissociated.")
      @body
      body: AtlasRelatedObjectId[];
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get all related terms for a specific term by its GUID. Limit, offset, and sort
parameters are currently not being enabled and won't work even they are passed.
""")
  @route("/atlas/v2/glossary/terms/{termId}/related")
  @get
  listRelatedTerms is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<Record<AtlasRelatedTermHeader[]>>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get a specific Glossary by its GUID.")
  @route("/atlas/v2/glossary/{glossaryId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;
    },
    AtlasGlossary,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update the given glossary.")
  @route("/atlas/v2/glossary/{glossaryId}")
  @put
  update is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("Whether ignore terms and categories")
      @query
      ignoreTermsAndCategories?: boolean;

      @doc("The glossary definition to be updated.")
      @body
      body: AtlasGlossary;
    },
    AtlasGlossary,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Delete a glossary. Will delete underlying terms/categories together. Recommend
separate delete terms and categories.
""")
  @route("/atlas/v2/glossary/{glossaryId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get the categories belonging to a specific glossary. Recommend using
limit/offset to get pagination result.
""")
  @route("/atlas/v2/glossary/{glossaryId}/categories")
  @get
  listCategories is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<AtlasGlossaryCategory[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get the category headers belonging to a specific glossary. Recommend using
limit/offset to get pagination result.
""")
  @route("/atlas/v2/glossary/{glossaryId}/categories/headers")
  @get
  listCategoriesHeaders is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<AtlasRelatedCategoryHeader[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get a specific glossary with detailed information. This API is not
recommend.

Recommend to fetch terms/categories details separately using 

GET /datamap/api/atlas/v2/glossary/{glossaryId}/terms and 

GET /datamap/api/atlas/v2/glossary/{glossaryId}/categories.
""")
  @route("/atlas/v2/glossary/{glossaryId}/detailed")
  @get
  getDetailed is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;
    },
    AtlasGlossaryExtInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
  @doc("""
Update the glossary partially. Some properties such as qualifiedName are not
allowed to be updated.

So far we only supports partial updating
shortDescription, longDescription, language and usage for glossary. 

Recommend
using 'ignoreTermsAndCategories=true' to reduce response body size.
""")
  @route("/atlas/v2/glossary/{glossaryId}/partial")
  @put
  partialUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("Whether ignore terms and categories")
      @query
      ignoreTermsAndCategories?: boolean;

      @doc("""
A map containing keys as attribute names and values as corresponding attribute
values.
""")
      @body
      body: Record<string>;
    },
    AtlasGlossary,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get terms belonging to a specific glossary. Recommend using limit/offset to get
pagination result.
""")
  @route("/atlas/v2/glossary/{glossaryId}/terms")
  @get
  listTerms is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<AtlasGlossaryTerm[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Get term headers belonging to a specific glossary. Recommend using limit/offset
to get pagination result.
""")
  @route("/atlas/v2/glossary/{glossaryId}/terms/headers")
  @get
  listTermHeaders is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The sort order, ASC (default) or DESC.")
      @query
      sort?: string;
    },
    OkResponse<AtlasRelatedTermHeader[]>,
    {},
    AtlasErrorResponse
  >;
}

interface Discovery {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get data using search.")
  @route("/search/query")
  @post
  query is Azure.Core.Foundations.Operation<
    {
      @doc("An object specifying the search criteria.")
      @body
      body: QueryOptions;
    },
    QueryResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get search suggestions by query criteria.")
  @route("/search/suggest")
  @post
  suggest is Azure.Core.Foundations.Operation<
    {
      @doc("An object specifying the suggest criteria.")
      @body
      body: SuggestOptions;
    },
    SuggestResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get auto complete options.")
  @route("/search/autocomplete")
  @post
  autoComplete is Azure.Core.Foundations.Operation<
    {
      @doc("An object specifying the autocomplete criteria.")
      @body
      body: AutoCompleteOptions;
    },
    AutoCompleteResult,
    {},
    AtlasErrorResponse
  >;
}

interface Lineage {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get lineage info of the entity specified by GUID.")
  @route("/atlas/v2/lineage/{guid}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The number of hops for lineage.")
      @query
      depth?: int32;

      @doc("The direction of the lineage, which could be INPUT, OUTPUT or BOTH.")
      @query
      direction: LineageDirection;
    },
    AtlasLineageInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Return immediate next page lineage info about entity with pagination")
  @route("/lineage/{guid}/next/")
  @get
  getNextPage is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The direction of the lineage, which could be INPUT, OUTPUT or BOTH.")
      @query
      direction: LineageDirection;

      @doc("The offset for pagination purpose.")
      @query
      offset?: int32;

      @doc("The page size - by default there is no paging.")
      @query
      limit?: int32;
    },
    AtlasLineageInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Return lineage info about entity.

In addition to the typeName path parameter,
attribute key-value pair(s) can be provided in the following
format

attr:[attrName]=[attrValue]

NOTE: The attrName and attrValue should be
unique across entities, eg. qualifiedName.

The REST request would look
something like this:

GET
/v2/lineage/uniqueAttribute/type/aType?attr:aTypeAttribute=someValue.
""")
  @route("/atlas/v2/lineage/uniqueAttribute/type/{typeName}")
  @get
  getByUniqueAttribute is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      typeName: string;

      @doc("The number of hops for lineage.")
      @query
      depth?: int32;

      @doc("The direction of the lineage, which could be INPUT, OUTPUT or BOTH.")
      @query
      direction: LineageDirection;

      @doc("""
The qualified name of the entity. (This is only an example. qualifiedName can
be changed to other unique attributes)
""")
      @query("attr:qualifiedName")
      attribute?: string;
    },
    AtlasLineageInfo,
    {},
    AtlasErrorResponse
  >;
}

interface Relationship {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create a new relationship between entities.")
  @route("/atlas/v2/relationship")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The AtlasRelationship object containing the information for the relationship to
be created.
""")
      @body
      body: AtlasRelationship;
    },
    AtlasRelationship,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update an existing relationship between entities.")
  @route("/atlas/v2/relationship")
  @put
  update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The AtlasRelationship object containing the information for the relationship to
be created.
""")
      @body
      body: AtlasRelationship;
    },
    AtlasRelationship,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get relationship information between entities by its GUID.")
  @route("/atlas/v2/relationship/guid/{guid}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the relationship.")
      @path
      guid: string;

      @doc("Limits whether includes extended information.")
      @query
      extendedInfo?: boolean;
    },
    AtlasRelationshipWithExtInfo,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete a relationship between entities by its GUID.")
  @route("/atlas/v2/relationship/guid/{guid}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the relationship.")
      @path
      guid: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;
}

interface Type {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the businessMetadata definition for the given guid.")
  @route("/atlas/v2/types/businessmetadatadef/guid/{guid}")
  @get
  getBusinessMetadataDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("businessMetadata guid")
      @path
      guid: string;
    },
    AtlasBusinessMetadataDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the businessMetadata definition by it's name (unique).")
  @route("/atlas/v2/types/businessmetadatadef/name/{name}")
  @get
  getBusinessMetadataDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("businessMetadata name")
      @path
      name: string;
    },
    AtlasBusinessMetadataDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the classification definition for the given GUID.")
  @route("/atlas/v2/types/classificationdef/guid/{guid}")
  @get
  getClassificationDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the classification.")
      @path
      guid: string;
    },
    AtlasClassificationDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the classification definition by its name (unique).")
  @route("/atlas/v2/types/classificationdef/name/{name}")
  @get
  getClassificationDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the classification.")
      @path
      name: string;
    },
    AtlasClassificationDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the Entity definition for the given GUID.")
  @route("/atlas/v2/types/entitydef/guid/{guid}")
  @get
  getEntityDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    AtlasEntityDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the entity definition by its name (unique).")
  @route("/atlas/v2/types/entitydef/name/{name}")
  @get
  getEntityDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the entity.")
      @path
      name: string;
    },
    AtlasEntityDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the enum definition for the given GUID.")
  @route("/atlas/v2/types/enumdef/guid/{guid}")
  @get
  getEnumDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the enum.")
      @path
      guid: string;
    },
    AtlasEnumDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the enum definition by its name (unique).")
  @route("/atlas/v2/types/enumdef/name/{name}")
  @get
  getEnumDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the enum.")
      @path
      name: string;
    },
    AtlasEnumDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the relationship definition for the given GUID.")
  @route("/atlas/v2/types/relationshipdef/guid/{guid}")
  @get
  getRelationshipDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the relationship.")
      @path
      guid: string;
    },
    AtlasRelationshipDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the relationship definition by its name (unique).")
  @route("/atlas/v2/types/relationshipdef/name/{name}")
  @get
  getRelationshipDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the relationship.")
      @path
      name: string;
    },
    AtlasRelationshipDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the struct definition for the given GUID.")
  @route("/atlas/v2/types/structdef/guid/{guid}")
  @get
  getStructDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the struct.")
      @path
      guid: string;
    },
    AtlasStructDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the struct definition by its name (unique).")
  @route("/atlas/v2/types/structdef/name/{name}")
  @get
  getStructDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the struct.")
      @path
      name: string;
    },
    AtlasStructDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the type definition for the given GUID.")
  @route("/atlas/v2/types/typedef/guid/{guid}")
  @get
  getByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the type.")
      @path
      guid: string;
    },
    AtlasTypeDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get the type definition by its name (unique).")
  @route("/atlas/v2/types/typedef/name/{name}")
  @get
  getByName is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      name: string;
    },
    AtlasTypeDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete API for type identified by its name.")
  @route("/atlas/v2/types/typedef/name/{name}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the type.")
      @path
      name: string;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("List all type definitions in bulk.")
  @route("/atlas/v2/types/typedefs")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("""
Whether include termtemplatedef when return all typedefs.
This is always true
when search filter type=term_template
""")
      @query
      includeTermTemplate?: boolean;

      @doc("Typedef name as search filter when get typedefs.")
      @query
      type?: TypeCategory;
    },
    AtlasTypesDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Create all atlas type definitions in bulk, only new definitions will be
created.
Any changes to the existing definitions will be discarded.
""")
  @route("/atlas/v2/types/typedefs")
  @post
  bulkCreate is Azure.Core.Foundations.Operation<
    {
      @doc("A composite wrapper object with corresponding lists of the type definition.")
      @body
      body: AtlasTypesDef;
    },
    AtlasTypesDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
Update all types in bulk, changes detected in the type definitions would be
persisted.
""")
  @route("/atlas/v2/types/typedefs")
  @put
  bulkUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("A composite object that captures all type definition changes.")
      @body
      body: AtlasTypesDef;
    },
    AtlasTypesDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete API for all types in bulk.")
  @route("/atlas/v2/types/typedefs")
  @delete
  bulkDelete is Azure.Core.Foundations.Operation<
    {
      @doc("A composite object that captures all types to be deleted")
      @body
      body: AtlasTypesDef;
    },
    void,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("List all type definitions returned as a list of minimal information header.")
  @route("/atlas/v2/types/typedefs/headers")
  @get
  listHeaders is Azure.Core.Foundations.Operation<
    {
      @doc("""
Whether include termtemplatedef when return all typedefs.
This is always true
when search filter type=term_template
""")
      @query
      includeTermTemplate?: boolean;

      @doc("Typedef name as search filter when get typedefs.")
      @query
      type?: TypeCategory;
    },
    OkResponse<AtlasTypeDefHeader[]>,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get the term template definition for the given GUID.")
  @route("/types/termtemplatedef/guid/{guid}")
  @get
  getTermTemplateDefByGuid is Azure.Core.Foundations.Operation<
    {
      @doc("The globally unique identifier of the term template.")
      @path
      guid: string;
    },
    TermTemplateDef,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get the term template definition by its name (unique).")
  @route("/types/termtemplatedef/name/{name}")
  @get
  getTermTemplateDefByName is Azure.Core.Foundations.Operation<
    {
      @doc("The unique name of the term template.")
      @path
      name: string;
    },
    TermTemplateDef,
    {},
    AtlasErrorResponse
  >;
}
