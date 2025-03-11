import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

@Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace ServicePatterns {

    namespace Private {
        alias FoundryPaged<TModel> = {
            continuationToken: string;
        };
        
        alias Ops = Azure.Core.StandardResourceOperations;
        alias ResourceList<TModel extends Reflection.Model, TParams extends Reflection.Model> = Ops.ResourceList<TModel, Azure.Core.Traits.QueryParametersTrait<TParams>>;
        alias RetryableOps = Azure.Core.ResourceOperations<
            Azure.Core.Traits.NoConditionalRequests & 
            Azure.Core.Traits.SupportsClientRequestId &
            Azure.Core.Traits.SupportsRepeatableRequests>;

        /**
         * Empty parent resource for versioned CRUDL. Should not be used directly; only intended to be used
         * by the `Versioned` model template.
         */
        @Rest.resource(collection)
        model ParentResource<collection extends valueof string> {
            @key
            id: string;
        }

        @friendlyName("{name}ByVersion", TModel)
        model _FriendlyNamePaged<TModel extends Reflection.Model> is Azure.Core.Page<TModel> {
        }

        /**
         * List the latest version of a versioned model
         */
        @Http.route(collectionRoute)
        op ListLatest<collectionRoute extends valueof string, TModel extends Reflection.Model>(... Azure.Core.Foundations.ApiVersionParameter): _FriendlyNamePaged<TModel> | Azure.Core.Foundations.ErrorResponse;
    }

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
    @Rest.parentResource(Private.ParentResource<collection>)
    @Rest.resource("versions")
    model Versioned<collection extends valueof string> {
        ... Rest.Resource.ParentKeysOf<Private.ParentResource<collection>>;

        @key
        version: string;
    }

    interface VersionedOperations<collectionRoute extends valueof string, TModel extends Reflection.Model, ListParameters extends Reflection.Model = {}> {
        /**
         * List the latest versions 
         */
        op listLatest is Private.ListLatest<collectionRoute, TModel>;
        op listVersions is Private.ResourceList<TModel, ListParameters>;
        
        op get is Private.Ops.ResourceRead<TModel>;
        op delete is Private.Ops.ResourceDelete<TModel>;
        op create is Private.RetryableOps.ResourceCreateWithServiceProvidedName<TModel>;
        op createOrReplace is Private.Ops.ResourceCreateOrReplace<TModel>;
    }
}