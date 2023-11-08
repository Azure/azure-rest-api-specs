import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace DocumentTranslation;

@doc("Binary data format.")
@encode("binary")
scalar binary extends bytes;