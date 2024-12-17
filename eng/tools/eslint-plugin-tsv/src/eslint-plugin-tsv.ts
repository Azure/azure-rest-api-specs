// @ts-ignore
import enforceFooBar from "./enforce-foo-bar.js";
import noUppercaseUnderSpecification from "./no-uppercase-under-specification.js";

export const plugin = {
  rules: {
    "enforce-foo-bar": enforceFooBar,
    "no-uppercase-under-specification": noUppercaseUnderSpecification,
  },
};
export default plugin;
