import { emitters } from "../utils/constants.js";
import { createManagementClientRule } from "../utils/rule.js";

const args: [string, string, string, string | boolean][] = [
  ["tspconfig-ts-mgmt-modular-generate-metadata-true", emitters.ts, "generateMetadata", true],
  ["tspconfig-ts-mgmt-modular-hierarchy-client-false", emitters.ts, "hierarchyClient", false],
  [
    "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
    emitters.ts,
    "experimentalExtensibleEnums",
    true,
  ],
  [
    "tspconfig-ts-mgmt-modular-enable-operation-group-true",
    emitters.ts,
    "enableOperationGroup",
    true,
  ],
];

export default args.map((a) => createManagementClientRule(...a));
