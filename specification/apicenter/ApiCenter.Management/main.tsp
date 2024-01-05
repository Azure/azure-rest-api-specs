import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./models.tsp";
import "./Service.tsp";
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
@armProviderNamespace
@service({
  title: "Azure API Center",
})
@versioned(Versions)
@doc("Azure API Center Resource Provider.")
namespace Microsoft.ApiCenter;

@doc("The available API versions.")
enum Versions {
  /** The initial service version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_03_01: "2024-03-01",
}

@@TypeSpec.OpenAPI.extension(Apis.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(Apis.createOrUpdate::parameters.resource, "json", "payload");
@@projectedName(Apis.createOrUpdate::parameters.resource, "client", "payload");

@@TypeSpec.OpenAPI.extension(ApiDefinitions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(ApiDefinitions.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(ApiDefinitions.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(ApiVersions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(ApiVersions.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(ApiVersions.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(Deployments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(Deployments.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(Deployments.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(Environments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(Environments.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(Environments.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(MetadataSchemas.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(MetadataSchemas.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(MetadataSchemas.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(Services.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(Services.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(Services.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(Workspaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@projectedName(Workspaces.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@projectedName(Workspaces.createOrUpdate::parameters.resource,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(ApiDefinitions.importSpecification::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@projectedName(ApiDefinitions.importSpecification::parameters.body,
  "json",
  "payload"
);
@@projectedName(ApiDefinitions.importSpecification::parameters.body,
  "client",
  "payload"
);

@@TypeSpec.OpenAPI.extension(Services.exportMetadataSchema::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@projectedName(Services.exportMetadataSchema::parameters.body,
  "json",
  "payload"
);
@@projectedName(Services.exportMetadataSchema::parameters.body,
  "client",
  "payload"
);
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
