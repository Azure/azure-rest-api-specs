import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAuthorizedAPI.Routes.Tags;

@route("/users/{userId}/tags")
@doc("List a collection of tags.")
@get
op ListTags(...UserParams, ...ListParams): ApiResponse<Collection<Tag>>;
