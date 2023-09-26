import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./service.tsp";
import "./environments/routes.tsp";
import "./devcenter/routes.tsp";
import "./devbox/routes.tsp";

namespace DevCenter;