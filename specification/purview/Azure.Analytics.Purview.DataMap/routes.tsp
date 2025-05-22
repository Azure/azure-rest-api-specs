import "@azure-tools/typespec-azure-core";
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

namespace PurviewDataMap;

@doc("The ApiVersion query parameter for Atlas API.")
model AtlasApiVersionParameter {
  @doc("The API version to use for this operation.")
  @query("api-version")
  @minLength(1)
  apiVersion?: string;
}

alias AtlasApiVersionParameterTraits = Azure.Core.Traits.VersionParameterTrait<AtlasApiVersionParameter>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
@doc("The operation defined for Atlas APIs")
op AtlasOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse,
  Traits extends TypeSpec.Reflection.Model = {}
>(
  ...TraitProperties<Traits, TraitLocation.ApiVersionParameter>,
  ...TParams,
): TResponse | AtlasErrorResponse;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
op AtlasRpcOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {},
  TraitContexts extends TraitContext = TraitContext.Undefined
> is AtlasOperation<
  TParams & TraitProperties<Traits, TraitLocation.Parameters>,
  TResponse & TraitProperties<Traits, TraitLocation.Response, TraitContexts>,
  Traits
>;

alias OkResponse<T> = {
  @statusCode
  status: 200;

  @bodyRoot
  data: T;
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
op AtlasImportOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {},
  TraitContexts extends TraitContext = TraitContext.Undefined
> is AtlasOperation<
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
  Traits
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
  createOrUpdate is AtlasOperation<
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
    } & BodyParameter<AtlasEntityWithExtInfo>,
    EntityMutationResult,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("List entities in bulk identified by its GUIDs.")
  @route("/atlas/v2/entity/bulk")
  @get
  listByGuids is AtlasOperation<
    {
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing Atlas API"
      @doc("An array of GUIDs of entities to list.")
      @query(#{ explode: true })
      guid: string[];

      @doc("Whether to return minimal information for referred entities.")
      @query
      minExtInfo?: boolean;

      @doc("Whether to ignore relationship attributes.")
      @query
      ignoreRelationships?: boolean;
    },
    AtlasEntitiesWithExtInfo,
    AtlasApiVersionParameterTraits
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
  bulkCreateOrUpdate is AtlasOperation<
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
    } & BodyParameter<AtlasEntitiesWithExtInfo>,
    EntityMutationResult,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing Atlas API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Delete a list of entities in bulk identified by their GUIDs or unique
    attributes.
    """)
  @route("/atlas/v2/entity/bulk")
  @delete
  bulkDelete is AtlasOperation<
    {
      @doc("An array of GUIDs of entities to delete.")
      @query(#{ explode: true })
      guid: string[];
    },
    EntityMutationResult,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Associate a classification to multiple entities in bulk.")
  @route("/atlas/v2/entity/bulk/classification")
  @post
  addClassification is AtlasOperation<
    BodyParameter<ClassificationAssociateOptions>,
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get complete definition of an entity given its GUID.")
  @route("/atlas/v2/entity/guid/{guid}")
  @get
  get is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Update entity partially - create or update entity attribute identified by its
    GUID.
    Supports only primitive attribute type and entity references.
    It does not support updating complex types like arrays, and maps.
    Null updates are not possible.
    """)
  @route("/atlas/v2/entity/guid/{guid}")
  @put
  partialUpdateAttributeByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The name of the attribute.")
      @query
      name: string;

      #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
      @doc("The value of the attribute.")
      @bodyRoot
      body: unknown;
    },
    EntityMutationResult,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete an entity identified by its GUID.")
  @route("/atlas/v2/entity/guid/{guid}")
  @delete
  delete is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    EntityMutationResult,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get classification for a given entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classification/{classificationName}")
  @get
  getClassification is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The name of the classification.")
      @path
      classificationName: string;
    },
    AtlasClassification,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete a given classification from an existing entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classification/{classificationName}")
  @delete
  removeClassification is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("The name of the classification.")
      @path
      classificationName: string;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("List classifications for a given entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classifications")
  @get
  getClassifications is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    AtlasClassifications,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Add classifications to an existing entity represented by a GUID.")
  @route("/atlas/v2/entity/guid/{guid}/classifications")
  @post
  addClassifications is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("An array of classifications to be added.")
      @bodyRoot
      body: AtlasClassification[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Update classifications to an existing entity represented by a guid.")
  @route("/atlas/v2/entity/guid/{guid}/classifications")
  @put
  updateClassifications is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("An array of classifications to be updated.")
      @bodyRoot
      body: AtlasClassification[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  getByUniqueAttributes is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  partialUpdateByUniqueAttributes is AtlasOperation<
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
    } & BodyParameter<AtlasEntityWithExtInfo>,
    EntityMutationResult,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  deleteByUniqueAttribute is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Delete a given classification from an entity identified by its type and unique
    attributes.
    """)
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/classification/{classificationName}")
  @delete
  removeClassificationByUniqueAttribute is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Add classification to the entity identified by its type and unique attributes.")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/classifications")
  @post
  addClassificationsByUniqueAttribute is AtlasOperation<
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
      @bodyRoot
      body: AtlasClassification[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Update classification on an entity identified by its type and unique attributes.")
  @route("/atlas/v2/entity/uniqueAttribute/type/{typeName}/classifications")
  @put
  updateClassificationsByUniqueAttribute is AtlasOperation<
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
      @bodyRoot
      body: AtlasClassification[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Set classifications on entities in bulk.")
  @route("/atlas/v2/entity/bulk/setClassifications")
  @post
  bulkSetClassifications is AtlasOperation<
    BodyParameter<AtlasEntityHeaders>,
    OkResponse<string[]>,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  listByUniqueAttributes is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get entity header given its GUID.")
  @route("/atlas/v2/entity/guid/{guid}/header")
  @get
  getHeader is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    AtlasEntityHeader,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Remove business metadata from an entity.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata")
  @delete
  removeBusinessMetadata is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("Business metadata payload")
      @bodyRoot
      body: Record<Record<unknown>>;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Add business metadata to an entity.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata")
  @post
  addOrUpdateBusinessMetadata is AtlasOperation<
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
      @bodyRoot
      body: Record<Record<unknown>>;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an Atlas existing api"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete business metadata attributes from an entity.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata/{businessMetadataName}")
  @delete
  removeBusinessMetadataAttributes is AtlasOperation<
    {
      @doc("BusinessMetadata name")
      @path
      businessMetadataName: string;

      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("Business metadata attribute payload")
      @bodyRoot
      body: Record<unknown>;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an Atlas existing api"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Add or update business metadata attributes.")
  @route("/atlas/v2/entity/guid/{guid}/businessmetadata/{businessMetadataName}")
  @post
  addOrUpdateBusinessMetadataAttributes is AtlasOperation<
    {
      @doc("BusinessMetadata name")
      @path
      businessMetadataName: string;

      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("Business metadata attribute payload")
      @bodyRoot
      body: Record<unknown>;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the sample Template for uploading/creating bulk BusinessMetaData")
  @route("/atlas/v2/entity/businessmetadata/import/template")
  @get
  getSampleBusinessMetadataTemplate is AtlasRpcOperation<
    {},
    {
      @header contentType: "application/octet-stream";
      @bodyRoot body: bytes;
    },
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Upload the file for creating Business Metadata in BULK")
  @route("/atlas/v2/entity/businessmetadata/import")
  @post
  importBusinessMetadata is AtlasImportOperation<
    BodyParameter<BusinessMetadataOptions>,
    BulkImportResult,
    MultipartFormDataRequestHeadersTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Delete given labels to a given entity.")
  @route("/atlas/v2/entity/guid/{guid}/labels")
  @delete
  removeLabels is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("set of labels to be deleted")
      @bodyRoot
      body?: string[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Set labels to a given entity.")
  @route("/atlas/v2/entity/guid/{guid}/labels")
  @post
  setLabels is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("set of labels to be set to the entity")
      @bodyRoot
      body?: string[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Add given labels to a given entity.")
  @route("/atlas/v2/entity/guid/{guid}/labels")
  @put
  addLabel is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;

      @doc("set of labels to be added")
      @bodyRoot
      body?: string[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  removeLabelsByUniqueAttribute is AtlasOperation<
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
      @bodyRoot
      body?: string[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  setLabelsByUniqueAttribute is AtlasOperation<
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
      @bodyRoot
      body?: string[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  addLabelsByUniqueAttribute is AtlasOperation<
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
      @bodyRoot
      body?: string[];
    },
    void,
    {}
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
    } & BodyParameter<MoveEntitiesOptions>,
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
    separately using 'GET /datamap/api/atlas/v2/glossary/{glossaryId}/terms'
    and 'GET '/datamap/api/atlas/v2/glossary/{glossaryId}/categories'.
    """)
  @route("/atlas/v2/glossary")
  @get
  list is AtlasOperation<
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
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Create a glossary.")
  @route("/atlas/v2/glossary")
  @post
  create is AtlasOperation<BodyParameter<AtlasGlossary>, AtlasGlossary, {}>;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Create glossary category in bulk.")
  @route("/atlas/v2/glossary/categories")
  @post
  createCategories is AtlasOperation<
    {
      @doc("An array of glossary category definitions to be created.")
      @bodyRoot
      body: AtlasGlossaryCategory[];
    },
    OkResponse<AtlasGlossaryCategory[]>,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Create a glossary category.")
  @route("/atlas/v2/glossary/category")
  @post
  createCategory is AtlasOperation<
    BodyParameter<AtlasGlossaryCategory>,
    AtlasGlossaryCategory,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get specific glossary category by its GUID.")
  @route("/atlas/v2/glossary/category/{categoryId}")
  @get
  getCategory is AtlasOperation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;
    },
    AtlasGlossaryCategory,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Update the given glossary category by its GUID.")
  @route("/atlas/v2/glossary/category/{categoryId}")
  @put
  updateCategory is AtlasOperation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;
    } & BodyParameter<AtlasGlossaryCategory>,
    AtlasGlossaryCategory,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete a glossary category.")
  @route("/atlas/v2/glossary/category/{categoryId}")
  @delete
  deleteCategory is AtlasOperation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
  @doc("""
    Update the glossary category partially. So far we only supports partial
    updating shortDescription and longDescription for category.
    """)
  @route("/atlas/v2/glossary/category/{categoryId}/partial")
  @put
  partialUpdateCategory is AtlasOperation<
    {
      @doc("The globally unique identifier of the category.")
      @path
      categoryId: string;

      @doc("""
        A map containing keys as attribute names and values as corresponding attribute
        values for partial update.
        """)
      @bodyRoot
      body: Record<string>;
    },
    AtlasGlossaryCategory,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Get all related categories (parent and children). Limit, offset, and sort
    parameters are currently not being enabled and won't work even they are passed.
    """)
  @route("/atlas/v2/glossary/category/{categoryId}/related")
  @get
  listRelatedCategories is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get all terms associated with the specific category.")
  @route("/atlas/v2/glossary/category/{categoryId}/terms")
  @get
  listCategoryTerms is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Create a glossary term.")
  @route("/atlas/v2/glossary/term")
  @post
  createTerm is AtlasOperation<
    {
      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;
    } & BodyParameter<AtlasGlossaryTerm>,
    AtlasGlossaryTerm,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Get a specific glossary term by its GUID. ")
  @route("/atlas/v2/glossary/term/{termId}")
  @get
  getTerm is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;
    },
    AtlasGlossaryTerm,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update the given glossary term by its GUID.")
  @route("/atlas/v2/glossary/term/{termId}")
  @put
  updateTerm is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;
    } & BodyParameter<AtlasGlossaryTerm>,
    AtlasGlossaryTerm,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete a glossary term.")
  @route("/atlas/v2/glossary/term/{termId}")
  @delete
  deleteTerm is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Should use unknown to model Object"
  @doc("""
    Update the glossary term partially. So far we only supports partial updating
    shortDescription, longDescription, abbreviation, usage and status for term.
    """)
  @route("/atlas/v2/glossary/term/{termId}/partial")
  @put
  partialUpdateTerm is AtlasOperation<
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
      @bodyRoot
      body: Record<string>;
    },
    AtlasGlossaryTerm,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Create glossary terms in bulk.")
  @route("/atlas/v2/glossary/terms")
  @post
  createTerms is AtlasOperation<
    {
      @doc("Whether include term hierarchy")
      @query
      includeTermHierarchy?: boolean;

      @doc("An array of glossary term definitions to be created in bulk.")
      @bodyRoot
      body: AtlasGlossaryTerm[];
    },
    OkResponse<AtlasGlossaryTerm[]>,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    List all related objects assigned with the specified term. Recommend using
    limit/offset to get pagination result.
    """)
  @route("/atlas/v2/glossary/terms/{termId}/assignedEntities")
  @get
  listEntitiesAssignedWithTerm is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Assign the given term to the provided list of related objects. Recommend using
    small batches with multiple API calls.
    
    [Entities Create Or Update
    operation](https://learn.microsoft.com/en-us/rest/api/purview/datamapdataplane/entity/bulk-create-or-update?tabs=HTTP)
    is an alternative to assign a term to multiple entities.
    """)
  @route("/atlas/v2/glossary/terms/{termId}/assignedEntities")
  @post
  assignTermToEntities is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("An array of related object IDs to which the term has to be associated.")
      @bodyRoot
      body: AtlasRelatedObjectId[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "This is Atlas API behavior"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete the term assignment for the given list of related objects.")
  @route("/atlas/v2/glossary/terms/{termId}/assignedEntities")
  @delete
  deleteTermAssignmentFromEntities is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary term.")
      @path
      termId: string;

      @doc("An array of related object IDs from which the term has to be dissociated.")
      @bodyRoot
      body: AtlasRelatedObjectId[];
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
    Get all related terms for a specific term by its GUID. Limit, offset, and sort
    parameters are currently not being enabled and won't work even they are passed.
    """)
  @route("/atlas/v2/glossary/terms/{termId}/related")
  @get
  listRelatedTerms is AtlasOperation<
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
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get a specific Glossary by its GUID.")
  @route("/atlas/v2/glossary/{glossaryId}")
  @get
  get is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;
    },
    AtlasGlossary,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("Update the given glossary.")
  @route("/atlas/v2/glossary/{glossaryId}")
  @put
  update is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;

      @doc("Whether ignore terms and categories")
      @query
      ignoreTermsAndCategories?: boolean;
    } & BodyParameter<AtlasGlossary>,
    AtlasGlossary,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Delete a glossary. Will delete underlying terms/categories together. Recommend
    separate delete terms and categories.
    """)
  @route("/atlas/v2/glossary/{glossaryId}")
  @delete
  delete is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Get the categories belonging to a specific glossary. Recommend using
    limit/offset to get pagination result.
    """)
  @route("/atlas/v2/glossary/{glossaryId}/categories")
  @get
  listCategories is AtlasOperation<
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
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Get the category headers belonging to a specific glossary. Recommend using
    limit/offset to get pagination result.
    """)
  @route("/atlas/v2/glossary/{glossaryId}/categories/headers")
  @get
  listCategoriesHeaders is AtlasOperation<
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
    {}
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
  getDetailed is AtlasOperation<
    {
      @doc("The globally unique identifier for glossary.")
      @path
      glossaryId: string;
    },
    AtlasGlossaryExtInfo,
    AtlasApiVersionParameterTraits
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
  partialUpdate is AtlasOperation<
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
      @bodyRoot
      body: Record<string>;
    },
    AtlasGlossary,
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("""
    Get terms belonging to a specific glossary. Recommend using limit/offset to get
    pagination result.
    """)
  @route("/atlas/v2/glossary/{glossaryId}/terms")
  @get
  listTerms is AtlasOperation<
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
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Get term headers belonging to a specific glossary. Recommend using limit/offset
    to get pagination result.
    """)
  @route("/atlas/v2/glossary/{glossaryId}/terms/headers")
  @get
  listTermHeaders is AtlasOperation<
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
    {}
  >;
}

interface Discovery {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get data using search.")
  @route("/search/query")
  @post
  query is Azure.Core.Foundations.Operation<
    BodyParameter<QueryOptions>,
    QueryResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get search suggestions by query criteria.")
  @route("/search/suggest")
  @post
  suggest is Azure.Core.Foundations.Operation<
    BodyParameter<SuggestOptions>,
    SuggestResult,
    {},
    AtlasErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Get auto complete options.")
  @route("/search/autocomplete")
  @post
  autoComplete is Azure.Core.Foundations.Operation<
    BodyParameter<AutoCompleteOptions>,
    AutoCompleteResult,
    {},
    AtlasErrorResponse
  >;
}

interface Lineage {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get lineage info of the entity specified by GUID.")
  @route("/atlas/v2/lineage/{guid}")
  @get
  get is AtlasOperation<
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
    AtlasLineageInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing API"
  @doc("Return immediate next page lineage info about entity with pagination")
  @route("/lineage/{guid}/next")
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
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
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
  getByUniqueAttribute is AtlasOperation<
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
    {}
  >;
}

interface Relationship {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Create a new relationship between entities.")
  @route("/atlas/v2/relationship")
  @post
  create is AtlasOperation<
    BodyParameter<AtlasRelationship>,
    AtlasRelationship,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Update an existing relationship between entities.")
  @route("/atlas/v2/relationship")
  @put
  update is AtlasOperation<
    BodyParameter<AtlasRelationship>,
    AtlasRelationship,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get relationship information between entities by its GUID.")
  @route("/atlas/v2/relationship/guid/{guid}")
  @get
  get is AtlasOperation<
    {
      @doc("The globally unique identifier of the relationship.")
      @path
      guid: string;

      @doc("Limits whether includes extended information.")
      @query
      extendedInfo?: boolean;
    },
    AtlasRelationshipWithExtInfo,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete a relationship between entities by its GUID.")
  @route("/atlas/v2/relationship/guid/{guid}")
  @delete
  delete is AtlasOperation<
    {
      @doc("The globally unique identifier of the relationship.")
      @path
      guid: string;
    },
    void,
    {}
  >;
}

interface Type {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the businessMetadata definition for the given guid.")
  @route("/atlas/v2/types/businessmetadatadef/guid/{guid}")
  @get
  getBusinessMetadataDefByGuid is AtlasOperation<
    {
      @doc("businessMetadata guid")
      @path
      guid: string;
    },
    AtlasBusinessMetadataDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the businessMetadata definition by it's name (unique).")
  @route("/atlas/v2/types/businessmetadatadef/name/{name}")
  @get
  getBusinessMetadataDefByName is AtlasOperation<
    {
      @doc("businessMetadata name")
      @path
      name: string;
    },
    AtlasBusinessMetadataDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the classification definition for the given GUID.")
  @route("/atlas/v2/types/classificationdef/guid/{guid}")
  @get
  getClassificationDefByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the classification.")
      @path
      guid: string;
    },
    AtlasClassificationDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the classification definition by its name (unique).")
  @route("/atlas/v2/types/classificationdef/name/{name}")
  @get
  getClassificationDefByName is AtlasOperation<
    {
      @doc("The name of the classification.")
      @path
      name: string;
    },
    AtlasClassificationDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the Entity definition for the given GUID.")
  @route("/atlas/v2/types/entitydef/guid/{guid}")
  @get
  getEntityDefByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the entity.")
      @path
      guid: string;
    },
    AtlasEntityDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the entity definition by its name (unique).")
  @route("/atlas/v2/types/entitydef/name/{name}")
  @get
  getEntityDefByName is AtlasOperation<
    {
      @doc("The name of the entity.")
      @path
      name: string;
    },
    AtlasEntityDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the enum definition for the given GUID.")
  @route("/atlas/v2/types/enumdef/guid/{guid}")
  @get
  getEnumDefByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the enum.")
      @path
      guid: string;
    },
    AtlasEnumDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the enum definition by its name (unique).")
  @route("/atlas/v2/types/enumdef/name/{name}")
  @get
  getEnumDefByName is AtlasOperation<
    {
      @doc("The name of the enum.")
      @path
      name: string;
    },
    AtlasEnumDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the relationship definition for the given GUID.")
  @route("/atlas/v2/types/relationshipdef/guid/{guid}")
  @get
  getRelationshipDefByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the relationship.")
      @path
      guid: string;
    },
    AtlasRelationshipDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the relationship definition by its name (unique).")
  @route("/atlas/v2/types/relationshipdef/name/{name}")
  @get
  getRelationshipDefByName is AtlasOperation<
    {
      @doc("The name of the relationship.")
      @path
      name: string;
    },
    AtlasRelationshipDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the struct definition for the given GUID.")
  @route("/atlas/v2/types/structdef/guid/{guid}")
  @get
  getStructDefByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the struct.")
      @path
      guid: string;
    },
    AtlasStructDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the struct definition by its name (unique).")
  @route("/atlas/v2/types/structdef/name/{name}")
  @get
  getStructDefByName is AtlasOperation<
    {
      @doc("The name of the struct.")
      @path
      name: string;
    },
    AtlasStructDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the type definition for the given GUID.")
  @route("/atlas/v2/types/typedef/guid/{guid}")
  @get
  getByGuid is AtlasOperation<
    {
      @doc("The globally unique identifier of the type.")
      @path
      guid: string;
    },
    AtlasTypeDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Get the type definition by its name (unique).")
  @route("/atlas/v2/types/typedef/name/{name}")
  @get
  getByName is AtlasOperation<
    {
      @doc("The name of the type.")
      @path
      name: string;
    },
    AtlasTypeDef,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete API for type identified by its name.")
  @route("/atlas/v2/types/typedef/name/{name}")
  @delete
  delete is AtlasOperation<
    {
      @doc("The name of the type.")
      @path
      name: string;
    },
    void,
    {}
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("List all type definitions in bulk.")
  @route("/atlas/v2/types/typedefs")
  @get
  list is AtlasOperation<
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
    AtlasApiVersionParameterTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Create all atlas type definitions in bulk. Please avoid recreating existing types.
    """)
  @route("/atlas/v2/types/typedefs")
  @post
  bulkCreate is AtlasOperation<BodyParameter<AtlasTypesDef>, AtlasTypesDef, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("""
    Update all types in bulk, changes detected in the type definitions would be
    persisted.
    """)
  @route("/atlas/v2/types/typedefs")
  @put
  bulkUpdate is AtlasOperation<BodyParameter<AtlasTypesDef>, AtlasTypesDef, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is Atlas API, which does not require api version"
  @doc("Delete API for all types in bulk.")
  @route("/atlas/v2/types/typedefs")
  @delete
  bulkDelete is AtlasOperation<BodyParameter<AtlasTypesDef>, void, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is Atlas API"
  @doc("List all type definitions returned as a list of minimal information header.")
  @route("/atlas/v2/types/typedefs/headers")
  @get
  listHeaders is AtlasOperation<
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
    AtlasApiVersionParameterTraits
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
