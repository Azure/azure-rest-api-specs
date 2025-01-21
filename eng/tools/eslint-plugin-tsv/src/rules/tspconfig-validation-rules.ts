import { emitters } from "../utils/constants.js";
import { createManagementClientRule } from "../utils/rule.js";

const args: [string, string, string, string | boolean | RegExp, string | boolean][] = [
  ["tspconfig-ts-mgmt-modular-generate-metadata-true", emitters.ts, "generateMetadata", true, true],
  [
    "tspconfig-ts-mgmt-modular-hierarchy-client-false",
    emitters.ts,
    "hierarchyClient",
    false,
    false,
  ],
  [
    "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
    emitters.ts,
    "experimentalExtensibleEnums",
    true,
    true,
  ],
  [
    "tspconfig-ts-mgmt-modular-enable-operation-group-true",
    emitters.ts,
    "enableOperationGroup",
    true,
    true,
  ],
  [
    "tspconfig-ts-mgmt-modular-package-dir-match-pattern",
    emitters.ts,
    "package-dir",
    /^arm(?:-[a-z]+)+$/,
    "arm-aaa-bbb",
  ],
  [
    "tspconfig-ts-mgmt-modular-package-name-match-pattern",
    emitters.ts,
    "packageDetails.name",
    /^\@azure\/arm(?:-[a-z]+)+$/,
    "@azure/arm-aaa-bbb",
  ],
];

export default args.map((a) => createManagementClientRule(...a));
