

### Required Setup:

Add required additional dependencies:

``` yaml
dependencies:
  build:

dev_dependencies:
  build_config:
  build_runner:
```

You also need to define a `build.yaml` file in the root of your project.

``` yaml
targets:
  <package_name>:<package_name>: <-- REPLACE WITH YOUR PACKAGE NAME
    builders:
      jtranslate_generator|jsonToCodeBuilder:
        generate_for:
          - <path to main translation file>
```


### Run the generator:

 ``` bat
 dart run build_runner build --delete-conflicting-outputs
 ```
