import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TagContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Tag-operation link details.
 */
@parentResource(TagContract)
model TagOperationLinkContract
  is Azure.ResourceManager.ProxyResource<TagOperationLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = TagOperationLinkContract,
    KeyName = "operationLinkId",
    SegmentName = "operationLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface TagOperationLinkContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = TagContract,
          KeyName = "tagId",
          SegmentName = "tags",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = TagOperationLinkContract,
        KeyName = "operationLinkId",
        SegmentName = "operationLinks",
        NamePattern = "^[^*#&+:<>?]+$"
      >>
    > {}

@armResourceOperations
interface TagOperationLinkContracts {
  /**
   * Gets the operation link for the tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagOperationLink_Get")
  get is TagOperationLinkContractOps.Read<TagOperationLinkContract>;

  /**
   * Adds an operation to the specified tag via link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagOperationLink_CreateOrUpdate")
  createOrUpdate is TagOperationLinkContractOps.CreateOrUpdateSync<TagOperationLinkContract>;

  /**
   * Deletes the specified operation from the specified tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagOperationLink_Delete")
  delete is TagOperationLinkContractOps.DeleteSync<TagOperationLinkContract>;

  /**
   * Lists a collection of the operation links associated with a tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TagOperationLink_ListByProduct")
  listByProduct is TagOperationLinkContractOps.List<
    TagOperationLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| operationId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagOperationLinkCollection>
  >;
}
@armResourceOperations
interface WorkspaceTagOperationLinkOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = TagContract,
          KeyName = "tagId",
          SegmentName = "tags",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = TagOperationLinkContract,
        KeyName = "operationLinkId",
        SegmentName = "operationLinks",
        NamePattern = "^[^*#&+:<>?]+$"
      >>
    > {}

@armResourceOperations
interface WorkspaceTagOperationLink {
  /**
   * Gets the operation link for the tag.
   */
  get is WorkspaceTagOperationLinkOps.Read<TagOperationLinkContract>;

  /**
   * Adds an operation to the specified tag via link.
   */
  createOrUpdate is WorkspaceTagOperationLinkOps.CreateOrUpdateSync<TagOperationLinkContract>;

  /**
   * Deletes the specified operation from the specified tag.
   */
  delete is WorkspaceTagOperationLinkOps.DeleteSync<TagOperationLinkContract>;

  /**
   * Lists a collection of the operation links associated with a tag.
   */
  listByProduct is WorkspaceTagOperationLinkOps.List<
    TagOperationLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| operationId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagOperationLinkCollection>
  >;
}

@@maxLength(TagOperationLinkContract.name, 80);
@@minLength(TagOperationLinkContract.name, 1);
@@doc(TagOperationLinkContract.name,
  "Tag-operation link identifier. Must be unique in the current API Management service instance."
);
@@doc(TagOperationLinkContract.properties,
  "Tag-API link entity contract properties."
);
@@doc(TagOperationLinkContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceTagOperationLink.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
