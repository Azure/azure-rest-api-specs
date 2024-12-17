// @ts-ignore
import enforceFooBar from "./enforce-foo-bar.js";
import kebabCaseFirstPathSegment from "./kebab-case-first-path-segment.js";

export const plugin = {
  rules: {
    "enforce-foo-bar": enforceFooBar,
    "kebab-case-first-path-segment": kebabCaseFirstPathSegment,
  },
};
export default plugin;
