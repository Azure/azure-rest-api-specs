import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Tags;

@route("/users/{userId}/tags")
@doc("List a collection of tags.")
@get
op ListTags(...UserParams, ...ListParams): ApiResponse<Page<Tag>>;
