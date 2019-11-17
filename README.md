[![Build Status](https://travis-ci.com/cu-ecen-5013/unity-example.svg?branch=master)](https://travis-ci.com/cu-ecen-5013/unity-example)

# unity-example
An example project using the [Unity](https://github.com/ThrowTheSwitch/Unity) unit test environment

This example is built on top of the [cmake-example](https://github.com/cu-ecen-5013/cmake-example) project.  For changes made to the cmake-example project, see the pull request [here](https://github.com/cu-ecen-5013/cmake-example/pull/1).

The test/test_runners/Test_file1_Runner.c file was generated using the command:
```
ruby Unity/auto/generate_test_runner.rb \
      test/Test_file1.c  \
      test/test_runners/Test_file1_Runner.c
```

## Testing
Synchronize the Unity git submodule using
```
git submodule init
git submodule update
```
Then run ./test.sh to:
 * Build the project executable and test executable.
 * Run the standard cmake dependency tests from the [cmake-example](https://github.com/cu-ecen-5013/cmake-example) project.
 * Run the Unity tests built into the cmake-example-test executable.
