import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

namespace Azure.AI.Projects.ServicePatterns {
  @Rest.autoRoute
  interface VersionedOperations<
    TEntityType extends Reflection.Model,
    TListLatestParameters extends Reflection.Model = {},
    TListVersionsParameters extends Reflection.Model = {}
  > {
    @Rest.action("versions")
    @Rest.actionSeparator("/")
    @Http.get
    listVersions is BuildingBlocks.CoreOps.ResourceAction<
      TEntityType,
      TListVersionsParameters,
      Azure.Core.Page<TEntityType>
    >;

    @Rest.listsResource(TEntityType)
    listLatest is Azure.Core.Foundations.ResourceList<
      TEntityType,
      TListLatestParameters,
      Azure.Core.Page<TEntityType>
    >;

    getVersion is Azure.Core.Foundations.ResourceOperation<
      TEntityType,
      {
        @Rest.segment("versions")
        @Http.path
        version: string;
      },
      Azure.Core.Foundations.ResourceOkResponse<TEntityType>
    >;

    @Http.delete
    deleteVersion is Azure.Core.Foundations.ResourceOperation<
      TEntityType,
      {
        @Rest.segment("versions")
        @Http.path
        version: string;
      },
      Http.NoContentResponse
    >;

    @Rest.actionSeparator("/")
    versions is BuildingBlocks.RepeatableCoreOps.ResourceAction<
      TEntityType,
      {
        @Http.bodyRoot body: TEntityType;
      },
      TEntityType
    >;

    @Http.put
    createVersion is Azure.Core.Foundations.ResourceOperation<
      TEntityType,
      {
        @Rest.segment("versions")
        @Http.path
        version: string;

        @Http.bodyRoot body: TEntityType;
      },
      Azure.Core.Foundations.ResourceCreatedOrOkResponse<TEntityType>
    >;
  }

  @Rest.action
  op VersionedResourceAction<
    TEntityType extends Reflection.Model,
    TParams,
    TResponse
  > is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    {
      @Rest.segment("versions")
      @Http.path
      version: string;

      @Http.bodyRoot body: TParams;
    },
    TResponse
  >;

  namespace BuildingBlocks {
    alias CoreOps = Azure.Core.StandardResourceOperations;
    alias RepeatableCoreOps = Azure.Core.ResourceOperations<Azure.Core.Traits.SupportsRepeatableRequests &
      Azure.Core.Traits.SupportsClientRequestId>;
  }
}
