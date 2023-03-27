import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.Tags;

@route("/tags")
@doc("List a collection of tags.")
@get
op ListTags(...ListParams): ApiResponse<Collection<Tag>>;
