import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

@doc("Index asset resource definition.")
@parentResource(Workspace)
@resource("indexes")
model IndexResource {
  @key("indexName")
  @doc("Name of the index.")
  @visibility("external")
  indexName: string;
}

@doc("AssetVersion Definition")
@parentResource(IndexResource)
@resource("versions")
model AssetVersion {
  @key("indexVersion")
  @doc("Version of the index.")
  @visibility("external")
  indexVersionNum: string;

  @doc("Name of the index.")
  @visibility("read")
  name: string;

  @doc("Version of the index.")
  @visibility("read")
  version: string;

  @doc("Update stage to 'Archive' for soft delete. Default is Development, which means the asset is under development.")
  stage: string = "Development";

  @doc("Description information of the asset.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Asset's tags.")
  tags?: Record<string>;

  @doc("Asset's properties.")
  properties?: Record<string>;
}

@doc("Index resource Definition")
model Index is AssetVersion {
  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;
}

@doc("Paged collection of IndexVersion items.")
@pagedResult
model PagedIndex {
  @doc("The list of Indexes.")
  @extension("x-ms-identifiers", [])
  value: Index[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Index>;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = ResourceCreatedResponse<T> | (TypeSpec.Http.Response<200> &
  T);
