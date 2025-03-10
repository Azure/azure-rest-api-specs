import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

@Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace ServicePatterns {

    @friendlyName("{name}ByVersion", TModel)
    model FriendlyNamePaged<TModel extends Reflection.Model> is Azure.Core.Page<TModel> {
    }

    #suppress "@azure-tools/typespec-azure-core/no-private-usage" "We are providing a common API pattern"
    @Rest.autoRoute
    op VersionedItemOperation<TModel extends Reflection.Model> is Azure.Core.RpcOperation<
        { ... Rest.Resource.KeysOf<TModel>, @Http.path @Rest.segment("versions") version: string }, FriendlyNamePaged<TModel>
    >;

    @Http.delete op VersionedDelete<TModel extends Reflection.Model> is VersionedItemOperation<TModel>;

    @Http.get op VersionedGet<TModel extends Reflection.Model> is VersionedItemOperation<TModel>;

    #suppress "@azure-tools/typespec-azure-core/no-private-usage" "We are providing a common API pattern"
    @Rest.actionSeparator("/")
    @Azure.Core.Foundations.Private.ensureVerb("ListVersions", "GET")
    @Http.get op ListVersions<TModel extends Reflection.Model, ListParameters extends Reflection.Model>  is Azure.Core.ResourceAction<TModel, ListParameters, FriendlyNamePaged<TModel>>;

    @Http.put op CreateOrUpdate<TModel extends Reflection.Model> is VersionedItemOperation<TModel>;

    interface VersionedCrudl<TModel extends Reflection.Model, ListParameters extends Reflection.Model = {}> {
        op listLatest is Azure.Core.ResourceList<TModel>;

        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The operation template is friendlyName:d as listVersions."
        #suppress "@azure-tools/typespec-azure-core/friendly-name" "When used in an operation group, we expect this to not repeat the name of the model type"
        @friendlyName("listVersions")
        op versions is ListVersions<TModel, ListParameters>;
        
        op get is VersionedGet<TModel>;
        op delete is VersionedDelete<TModel>;
        op createOrUpdate is CreateOrUpdate<TModel>;
    }
}