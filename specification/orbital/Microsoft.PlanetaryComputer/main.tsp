import "@typespec/rest";
import "@typespec/http";

// Versioning
import "./models.common.versions.tsp";

// STAC
import "./routes.stac.spec.tsp";
import "./routes.stac.config.tsp";

// Tiler
import "./routes.tiler.image-exports.tsp";
import "./routes.tiler.items.tsp";
import "./routes.tiler.map-legends.tsp";
import "./routes.tiler.mosaics.tsp";
import "./routes.tiler.mosaic.collections.tsp";
import "./routes.tiler.mosaic.items.tsp";
import "./routes.tiler.mosaic.searches.tsp";
import "./routes.tiler.tile-matrix-sets.tsp";

// SAS
import "./sas.tsp";

// InMa
import "./inma.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

// Comment out to workaround AZC0006 and AZC0007 warnings in C# SDK
// @server("https://contoso-catalog.gwhqfdeddydpareu.uksouth.geocatalog.spatio.azure.com")
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://geocatalog.spatio.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft Planetary Computer Pro" })
@versioned(Versions)
namespace Microsoft.PlanetaryComputer;

// NOTE: The `api-version` query parameter is automatically injected as required
// by Azure.Core.Foundations.Operation via the VersionParameterTrait. This is an
// Azure API standard — the service accepts requests without it (required=false
// in the service OpenAPI spec), but published Azure specs must declare it as
// required per Azure API guidelines. See:
// @azure-tools/typespec-azure-core/lib/foundations.tsp — ApiVersionParameter model
