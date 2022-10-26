# Batch Service CADL specification

Steps used to create this specification: 

1. Clone the repo and navigate to the `/cadl` subfolder under the Batch Service specification path.
2. Install npm packages specified in the `package.json`. From the same directory where the `package.json` exists, run: `npm install`.
3. To create a CADL specification from an existing swagger, run: `autorest --input-file=<swagger path> --cadl-init --use=https://aka.ms/autorest.cadl --output-folder=./`.
4. To compile and emit code based off of what's specified in `cadl-project.yaml`, run: `npx cadl compile .`.

The resulting code from the steps above is generated using tooling and the CADL files should be reviewed and corrected where necessary to create the desired outcome from the code emitters.