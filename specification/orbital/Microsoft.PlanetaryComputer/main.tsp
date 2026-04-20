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

@server(
  "{endpoint}",
  "Microsoft Planetary Computer Pro",
  {
    @doc("GeoCatalog endpoint, e.g. https://contoso-catalog.gwhqfdeddydpareu.uksouth.geocatalog.spatio.azure.com")
    endpoint: url,
  }
)
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
