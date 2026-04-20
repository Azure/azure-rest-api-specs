import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./testedgeactionsbasemodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations interface defined in main CDN swagger, not in TestEdgeActions-specific swagger"
@armProviderNamespace
@service(#{ title: "Microsoft.Cdn/TestEdgeAction" })
@versioned(Versions)
@armCommonTypesVersion("v6")
namespace Microsoft.Cdn;

enum Versions {
  `2025-09-01-preview`,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "SKU property required at envelope level for backwards compatibility"
model TestEdgeAction is TrackedResource<TestEdgeActionProperties> {
  @path
  @doc("The name of the Test Edge Action")
  @segment("testEdgeActions")
  @key("testEdgeActionName")
  @visibility(Lifecycle.Read)
  name: testSmallString;

  @doc("The sku type of the test edge action")
  sku: TestSkuType;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
@@extension(TestEdgeAction.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
@@extension(TestEdgeAction.properties, "x-ms-mutability", #["read", "create"]);

@parentResource(TestEdgeAction)
model TestEdgeActionVersion
  is TrackedResource<TestEdgeActionVersionProperties> {
  @path
  @doc("The name of the Test Edge Action version")
  @segment("versions")
  @key("version")
  @visibility(Lifecycle.Read)
  name: testSmallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
@@extension(TestEdgeActionVersion.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
@@extension(TestEdgeActionVersion.properties,
  "x-ms-mutability",
  #["read", "create"]
);

@parentResource(TestEdgeAction)
model TestEdgeActionExecutionFilter
  is TrackedResource<TestEdgeActionExecutionFilterProperties> {
  @path
  @doc("The name of the execution filter")
  @segment("executionFilters")
  @key("executionFilter")
  @visibility(Lifecycle.Read)
  name: testSmallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
@@extension(TestEdgeActionExecutionFilter.properties,
  "x-ms-client-flatten",
  true
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
@@extension(TestEdgeActionExecutionFilter.properties,
  "x-ms-mutability",
  #["read", "create"]
);

@armResourceOperations
interface TestEdgeActions {
  get is ArmResourceRead<TestEdgeAction>;
  create is ArmResourceCreateOrUpdateAsync<TestEdgeAction>;
  update is ArmCustomPatchAsync<TestEdgeAction, TestEdgeActionUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<TestEdgeAction>;
  listByResourceGroup is ArmResourceListByParent<TestEdgeAction>;
  listBySubscription is ArmListBySubscription<TestEdgeAction>;

  addAttachment is ArmResourceActionAsync<
    TestEdgeAction,
    TestEdgeActionAttachment,
    TestEdgeActionAttachmentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Operation matches baseline with 200, 202 responses"
  deleteAttachment is ArmResourceActionNoContentAsync<
    TestEdgeAction,
    TestEdgeActionAttachment
  >;
}

@armResourceOperations
interface TestEdgeActionVersions {
  get is ArmResourceRead<TestEdgeActionVersion>;
  create is ArmResourceCreateOrUpdateAsync<TestEdgeActionVersion>;
  update is ArmCustomPatchAsync<
    TestEdgeActionVersion,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      TestEdgeActionVersion,
      TestEdgeActionVersionProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<TestEdgeActionVersion>;
  listByTestEdgeAction is ArmResourceListByParent<TestEdgeActionVersion>;
  deployVersionCode is ArmResourceActionAsync<
    TestEdgeActionVersion,
    TestVersionCode,
    TestEdgeActionVersionProperties
  >;

  /** Get the version code for the test edge action version. */
  getVersionCode is ArmResourceActionAsync<
    TestEdgeActionVersion,
    void,
    TestVersionCode
  >;

  /** Swap the default version for the test edge action. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Operation matches baseline with 200, 202 responses"
  swapDefault is ArmResourceActionNoContentAsync<TestEdgeActionVersion, void>;
}

@armResourceOperations
interface TestEdgeActionExecutionFilters {
  get is ArmResourceRead<TestEdgeActionExecutionFilter>;
  create is ArmResourceCreateOrUpdateAsync<TestEdgeActionExecutionFilter>;
  update is ArmCustomPatchAsync<
    TestEdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      TestEdgeActionExecutionFilter,
      TestEdgeActionExecutionFilterProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<TestEdgeActionExecutionFilter>;
  listByTestEdgeAction is ArmResourceListByParent<TestEdgeActionExecutionFilter>;
}
