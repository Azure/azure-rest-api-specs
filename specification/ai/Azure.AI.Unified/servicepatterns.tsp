import "@typespec/rest";

namespace ServicePatterns {

    @Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
    namespace Private {

        model VersionedShape {
            id: string;
            version: string;
        }

        alias ApiVersionParameter = {
          @Http.query `api-version`: string;
        };

        alias ErrorResponse = Azure.Core.Foundations.ErrorResponse;

        model Paged<TModel extends Reflection.Model> {
          @continuationToken
          @Http.header("continuationToken") `$skipToken`?: string;
          @Http.bodyRoot _: TModel[];
        }

        alias ListPaginationParameters = {
          @continuationToken
          @Http.query `$skipToken`?: string;
        };

        /**
         * List the latest version for each versioned {TModel}. Nothing more, nothing less!
         */
        op ListLatest<TModel extends Reflection.Model>(... ListPaginationParameters, ... ApiVersionParameter): Paged<TModel> | ErrorResponse;

        /**
         * List all versions of a given versioned model.
         */
        @Http.route("{id}/versions")
        op ListVersions<TModel extends Reflection.Model, TQueryParameters extends Reflection.Model>(id: string, ... TQueryParameters, ... ListPaginationParameters, ... ApiVersionParameter): Paged<TModel> | ErrorResponse;

        /**
         * Get the given given model version
         */
        @Http.route("{id}/versions/{version}")
        op ResourceRead<TModel extends VersionedShape>(... Rest.Resource.KeysOf<TModel>, version: string, ... ApiVersionParameter): TModel | ErrorResponse;

        @Http.route("{id}/versions/{version}")
        @Http.delete op ResourceDelete(id: string, version: string): void | ErrorResponse;

        @Http.route("{id}/versions")
        @Http.post op ResourceCreate<TModel extends VersionedShape>(@Http.path id: string, @Http.bodyRoot _: TModel, ... Azure.Core.RepeatabilityRequestHeaders, ... ApiVersionParameter): TModel & Azure.Core.RepeatabilityResponseHeaders| ErrorResponse;

        @Http.route("{id}/versions/{version}")
        @Http.patch op ResourceUpdate<TModel extends Reflection.Model>(@Http.path id: string, @Http.path version: string, @Http.bodyRoot _:  TModel, ... ApiVersionParameter): TModel | ErrorResponse;
    
    }

    @Http.route("{id}/versions/{version}:${name}")
    @Http.post op VersionedModelAction<name extends valueof string, TParams extends Reflection.Model, TResult>(@Http.path id: string, @Http.path version: string, ... TParams): TResult | Private.ErrorResponse;
    /**
     * Defines a versioned subresource without you having to create a dummy parent resource.
     * 
     * Usage:
     *     model MyModel is Versioned("mymodels") {
     *       name: string;
     *     }
     * 
     *     interface MyModels extends VersionedOperations<MyModel> {};
     */
    model Versioned {
        /**
         * The version of the object.
         */
        @visibility(Lifecycle.Read)
        version: string;

        @visibility(Lifecycle.Read)
        lastModified: utcDateTime;

        @visibility(Lifecycle.Read)
        createdTime: utcDateTime;
    };


    interface VersionedItemOperations<TModel extends Private.VersionedShape> {
        op get is Private.ResourceRead<TModel>;
        op delete is Private.ResourceDelete;
        op create is Private.ResourceCreate<TModel>;
        op update is Private.ResourceUpdate<TModel>;
    }

    interface VersionedCrudlOperations<TModel extends Private.VersionedShape, ListParameters extends Reflection.Model = {}> extends VersionedItemOperations<TModel> {
        /**
         * List the latest versions 
         */
        op listLatest is Private.ListLatest<TModel>;
        op listVersions is Private.ListVersions<TModel, ListParameters>;
    }
}

