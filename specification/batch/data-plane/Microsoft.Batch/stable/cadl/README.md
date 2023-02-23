# Batch Service CADL specification

This project contains the unofficial Batch Service CADL specification files along with subdirectories representing the CADL project configuration for a particular language along with its generated SDK.

For now, it is best to keep each SDK language generation and configuration separate that way there will not be any peer dependency issues when installing the various language specific CADL packages.

When making changes to the CADL specification files (under the root directory), be sure to run the **copycadl\*** commands from the root of the repo. This will copy the CADL specification files into the subsequent SDK language subdirectories (which will be ignored by git). Be sure that when you are making CADL changes, you rerun the **copycadl\*** commands to copy the updated spec files into the subdirectories. Also be sure to run the SDK generation for all languages to verify there is no regression or unintended side affects.

Steps to generate the SDK:

1. Navigate to a particular language subdirectory i.e. `typescript-proj`.
2. From a language subdirectory, install the npm packages specified in the `package.json` by running: `npm install`.
3. To compile and emit code based off of what's specified in the local `cadl-project.yaml`, run: `npx cadl compile .`.
