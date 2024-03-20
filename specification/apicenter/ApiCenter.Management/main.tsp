import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "./models.tsp";
import "./Service.tsp";
import "./DeletedService.tsp";
import "./MetadataSchema.tsp";
import "./Workspace.tsp";
import "./Api.tsp";
import "./ApiVersion.tsp";
import "./ApiDefinition.tsp";
import "./Deployment.tsp";
import "./Environment.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
@armProviderNamespace
@service({
  title: "Azure API Center",
})
@versioned(Versions)
@doc("Azure API Center Resource Provider.")
@Azure.ResourceManager.armCommonTypesVersion("v5")
namespace Microsoft.ApiCenter;

@doc("The available API versions.")
enum Versions {
  /** The initial service version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_03_01: "2024-03-01",

  @doc("Azure API Center 2024-03-15-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_03_15_preview: "2024-03-15-preview",
}

@@encodedName(Apis.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(Apis.createOrUpdate::parameters.resource, "payload");

@@encodedName(ApiDefinitions.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(ApiDefinitions.createOrUpdate::parameters.resource, "payload");

@@encodedName(ApiVersions.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(ApiVersions.createOrUpdate::parameters.resource, "payload");

@@encodedName(Deployments.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(Deployments.createOrUpdate::parameters.resource, "payload");

@@encodedName(Environments.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(Environments.createOrUpdate::parameters.resource, "payload");

@@encodedName(MetadataSchemas.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(MetadataSchemas.createOrUpdate::parameters.resource, "payload");

@@encodedName(Services.update::parameters.properties,
  "application/json",
  "payload"
);
@@clientName(Services.update::parameters.properties, "payload");

@@encodedName(Workspaces.createOrUpdate::parameters.resource,
  "application/json",
  "payload"
);
@@clientName(Workspaces.createOrUpdate::parameters.resource, "payload");

@@encodedName(ApiDefinitions.importSpecification::parameters.body,
  "application/json",
  "payload"
);

@@clientName(ApiDefinitions.importSpecification::parameters.body, "payload");

@@encodedName(ApiDefinitions.exportSpecification::parameters.body,
  "application/json",
  "payload"
);

@@clientName(ApiDefinitions.exportSpecification::parameters.body, "payload");

@@encodedName(Services.exportMetadataSchema::parameters.body,
  "application/json",
  "payload"
);

@@clientName(Services.exportMetadataSchema::parameters.body, "payload");

@@visibility(Azure.Core.Page.nextLink, "read");
@@visibility(Azure.Core.Page.value, "read");
/**
 * A resource list operation, at the scope of the resource's parent
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 * @template TParentName Optional. The name of the parent resource
 * @template TParentFriendlyName Optional. The friendly name of the parent resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "It is pascal case"
@get
@autoRoute
@listsResource(TResource)
@segmentOf(TResource)
@armResourceList(TResource)
op ArmResourceListByParent<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName extends valueof string = "",
  TParentFriendlyName extends valueof string = ""
>(
  ...ResourceParentParameters<TResource, TBaseParameters>,
  ...OdataFilterParameter,
): ArmResponse<ResourceListResult<TResource>> | ErrorResponse;

/**
 * A resource GET operation
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "It is pascal case"
@autoRoute
@doc("Get a {name}", TResource)
@get
@armResourceRead(TResource)
op ArmResourceRead<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponseWithEtag<TResource> | ErrorResponse;

/**
 * Synchronous PUT operation for ARM resources
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "It is pascal case"
@autoRoute
@doc("Create a {name}", TResource)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrReplaceSync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmResourceUpdatedResponseWithEtag<TResource> | ArmResourceCreatedSyncResponseWithEtag<TResource> | ErrorResponse;

@doc("Resource '{name}' create operation succeeded", TResource)
model ArmResourceCreatedSyncResponseWithEtag<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is Body<TResource> {
  ...CreatedResponse;
  ...Azure.Core.EtagResponseEnvelope;
}

@doc("Resource '{name}' update operation succeeded", TResource)
model ArmResourceUpdatedResponseWithEtag<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is ArmResponseWithEtag<TResource>;

@doc("Azure operation completed successfully.")
model ArmResponseWithEtag<T> {
  ...OkResponse;
  ...Azure.Core.EtagResponseEnvelope;
  ...Body<T>;
}
