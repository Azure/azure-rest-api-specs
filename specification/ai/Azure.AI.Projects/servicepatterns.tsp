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

    create is BuildingBlocks.RepeatableCoreOps.ResourceCreateWithServiceProvidedName<TEntityType>;

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

      @Http.bodyRoot body: TEntityType;
    },
    TResponse
  >;

  namespace BuildingBlocks {
    alias CoreOps = Azure.Core.StandardResourceOperations;
    alias RepeatableCoreOps = Azure.Core.ResourceOperations<Azure.Core.Traits.SupportsRepeatableRequests>;
  }
}
