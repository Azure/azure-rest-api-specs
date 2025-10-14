import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgeactionsbasemodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Cdn")
@service({
  title: "Microsoft.Cdn/EdgeAction"
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
@versioned(Versions)
namespace Microsoft.Cdn;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-09-01-preview`
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"

model EdgeAction is TrackedResource<EdgeActionProperties> {
  @path
  @doc("The name of the Edge Action")
  @segment("edgeActions")
  @key("edgeActionName")
  @visibility("read")
  name: smallString;
  
  @doc("The sku type of the edge action")
  sku: SkuType;
}

@parentResource(EdgeAction)
model EdgeActionVersion is TrackedResource<EdgeActionVersionProperties> {
  @path
  @doc("The name of the Edge Action version")
  @segment("versions")
  @key("version")
  @visibility("read")
  name: smallString;
}

@parentResource(EdgeAction)
model EdgeActionExecutionFilter is TrackedResource<EdgeActionExecutionFilterProperties> {
  @path
  @doc("The name of the execution filter")
  @segment("executionFilters")
  @key("executionFilter")
  @visibility("read")
  name: smallString;
}

model EdgeActionOperation is ProxyResource<EdgeActionOperationProperties> {
  @path
  @doc("The operation id")
  @segment("edgeActionOperations")
  @key("operationId")
  @visibility("read")
  name: smallString;
}

@armResourceOperations
interface EdgeActionOperations {
    get is ArmResourceRead<EdgeActionOperation>;
    listByResourceGroup is ArmResourceListByParent<EdgeActionOperation>;
    listBySubscription is ArmListBySubscription<EdgeActionOperation>;
}

@armResourceOperations
interface EdgeActions {
    get is ArmResourceRead<EdgeAction>;
    create is ArmResourceCreateOrUpdateAsync<EdgeAction>;
    update is ArmResourcePatchAsync<EdgeAction, EdgeActionProperties>;
    delete is ArmResourceDeleteWithoutOkAsync<EdgeAction>;
    listByResourceGroup is ArmResourceListByParent<EdgeAction>;
    listBySubscription is ArmListBySubscription<EdgeAction>;
    addAttachment is ArmResourceActionAsync<EdgeAction, EdgeActionAttachment, EdgeActionAttachmentResponse>;
    deleteAttachment is ArmResourceActionAsync<EdgeAction, EdgeActionAttachment, EmptyBody>;
}

@armResourceOperations
interface EdgeActionVersions {
    get is ArmResourceRead<EdgeActionVersion>;
    create is ArmResourceCreateOrUpdateAsync<EdgeActionVersion>;
    update is ArmResourcePatchAsync<EdgeActionVersion, EdgeActionVersionProperties>;
    delete is ArmResourceDeleteWithoutOkAsync<EdgeActionVersion>;
    listByResourceGroup is ArmResourceListByParent<EdgeActionVersion>;
    listBySubscription is ArmListBySubscription<EdgeActionVersion>;
    deployVersionCode is ArmResourceActionAsync<EdgeActionVersion, VersionCode, EdgeActionVersionProperties>;
    getVersionCode is ArmResourceActionAsync<EdgeActionVersion, EmptyBody, VersionCode>;
    swapDefault is ArmResourceActionAsync<EdgeActionVersion, EmptyBody, EmptyBody>;
}

@armResourceOperations
interface EdgeActionExecutionFilters {
    get is ArmResourceRead<EdgeActionExecutionFilter>;
    create is ArmResourceCreateOrUpdateAsync<EdgeActionExecutionFilter>;
    update is ArmResourcePatchAsync<EdgeActionExecutionFilter, EdgeActionExecutionFilterProperties>;
    delete is ArmResourceDeleteWithoutOkAsync<EdgeActionExecutionFilter>;
    listByResourceGroup is ArmResourceListByParent<EdgeActionExecutionFilter>;
    listBySubscription is ArmListBySubscription<EdgeActionExecutionFilter>;
}