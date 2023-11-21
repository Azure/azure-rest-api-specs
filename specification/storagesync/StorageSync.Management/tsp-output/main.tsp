import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Microsoft Storage Sync",
  version: "2022-06-01",
})
@server(
  "{$host}",
  "Microsoft Storage Sync Service API",
  {
    $host: string,
  }
)
@doc("Microsoft Storage Sync Service API")
namespace MicrosoftStorageSync;
