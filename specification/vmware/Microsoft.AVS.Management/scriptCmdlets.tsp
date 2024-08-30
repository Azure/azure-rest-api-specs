namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface ScriptCmdlets {
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
    @operationId("ScriptCmdlets_List")
    list is ArmResourceListByParent<
        ScriptCmdlet,
        Response = ArmResponse<ResourceList<ScriptCmdlet, "{name}sList">>
    >;

    get is ArmResourceRead<ScriptCmdlet>;
}
