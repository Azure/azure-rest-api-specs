// @ts-ignore
import enforceFooBar from "./enforce-foo-bar.js";
import topLevelFolderLowercase from "./top-level-folder-lowercase.js";

export const plugin = {
  rules: {
    "enforce-foo-bar": enforceFooBar,
    "top-level-folder-lowercase": topLevelFolderLowercase,
  },
};
export default plugin;
