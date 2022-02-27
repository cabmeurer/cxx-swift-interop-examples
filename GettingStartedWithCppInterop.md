#  Getting started with C++ Interoperability

This document is desgined to get you started with bidirectional API-level interoperability between Swift and C++.

## Table of Contents

- [Creating a Module to contain your C++ source code](#creating-a-module-to-contain-your-c-source-code)
- [Adding C++ to an Xcode project](#adding-c-to-an-xcode-project)
- [Creating a Swift Package](#Creating-a-Swift-Package)
- [Building with CMake](#building-with-cmake)

## Creating a Module to contain your C++ source code

- Create a new C++ implementation and header file, and generate a bridging header when prompted
- For this example we will call the files Cxx, so we should have a Cxx.cpp and Cxx.hpp.
- Import your C++ header, into the bridging header 
```
//In ProjectName-Bridging-Header
#import "Cxx.hpp"
```
Create a module.modulemap file to expose your source code 
- In order to expose our C++ code we must designate a separate as the source.
- Create an empty file and call it `module.modulemap`
- In this file create the module for your source code, and define your C++ header
```
//In module.modulemap
module Cxx {
    header "Cxx.hpp"
}
```
- Move the newly created files (Cxx.cpp, Cxx.hpp, module.modulemap) into a separate directory (this should remain in your project directory)

<img width="252" alt="Screen Shot 2022-02-26 at 9 14 06 PM" src="https://user-images.githubusercontent.com/62521716/155867937-9d9d6c62-4418-414d-bc4e-5d12c2055022.png">

## Adding C++ to an Xcode project

Add the C++ module as a Swift Compiler flag in your project's directory
- Navigate to your project directory 
- In both the `Project` and `Targets`, navigate to `Build Settings` -> `Swift Compiler - Custom Flags`
- Under `Other Swift Flags` add your search path to the C++ module with the `-I` prefix to import.
```
//Add to Other Swift Flags
-I./ProjectName/Cxx
```

- This should now allow your to import your C++ Module into any `.swift` file
```
//In ViewController.swift
import UIKit
import Cxx

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let result = cxx_function(7)
        print(result)
    }
}
```

```
//In Cxx.cpp

#include "Cxx.hpp"
int cxx_function(int n);

```

```
//In Cxx.hpp

#ifndef Cxx_hpp
#define Cxx_hpp

int cxx_function(int n) {
    return n;
}

#endif

```


## Creating a Swift Package
- After creating your Swift package project, follow the steps [Creating a Module to contain your C++ source code](#creating-a-module-to-contain-your-c-source-code) in your `Source` directory
- In your Package Manifest, you need to configure the Swift target's dependencies and compiler flags
- In this example the name of the package is `Cxx_Interop`
- Swift code will be in `Sources/Cxx_Interop` called `main.swift`
- C++ source code follows the example shown in [Creating a Module to contain your C++ source code](#creating-a-module-to-contain-your-c-source-code)
- Under targets, add the name of your C++ module and the directory containing the Swift code as a target.
- In the target defining your Swift target, add a`dependencies` to the C++ Module, the `path`, `source`, and `swiftSettings` with `unsafeFlags` with the source to the C++ Module, and enable `-enable-cxx-interop`

```
//In Package Manifest

import PackageDescription

let package = Package(
    name: "Cxx_Interop",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Cxx",
            targets: ["Cxx"]),
        .library(
            name: "Cxx_Interop",
            targets: ["Cxx_Interop"]),
    ],
    targets: [
        .target(
            name: "Cxx",
            dependencies: []
        ),
        //Executable is only needed for using a main.swift, otherwise it can just be a .target
        .executableTarget(
            name: "Cxx_Interop",
            dependencies: ["Cxx"],
            path: "./Sources/Cxx_Interop",
            sources: [ "main.swift" ],
            swiftSettings: [.unsafeFlags([
                "-I", "Sources/Cxx",
                "-Xfrontend", "-enable-cxx-interop",
            ])]
        ),
    ]
)

```

- We are now able to import our C++ Module into our swift code, and import the package into existing projects

```
//In main.swift

import Foundation
import Cxx

public struct Cxx_Interop {
    
    public func callCxxFunction(n: Int32) -> Int32 {
        return callCxxFunction(n: n)
    }
}

```


## Building with CMake
- After creating your project follow the steps [Creating a Module to contain your C++ source code](#creating-a-module-to-contain-your-c-source-code)
- Create a `CMakeLists.txt` file and configure for your project
- In`add_library` invoke `cxx-support` with the path to the C++ implementation file
- Add the `target_include_directories` with `cxx-support` and path to the C++ Module `${CMAKE_SOURCE_DIR}/Sources/Cxx`
- Add the `add_executable` to the specific files/directory you would like to generate source, with`SHELL:-Xfrontend -enable-cxx-interop`.
- In the example below we will be following the file structure used in [Creating a Swift Package](#Creating-a-Swift-Package) 

```
//In CMakeLists.txt

cmake_minimum_required(VERSION 3.18)

project(Cxx_Interop LANGUAGES CXX Swift)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(cxx-support ./Sources/Cxx/Cxx.cpp)
target_compile_options(cxx-support PRIVATE
  -I${SWIFT_CXX_TOOLCHAIN}/usr/include/c++/v1
  -fno-exceptions
  -fignore-exceptions
  -nostdinc++)
target_include_directories(cxx-support PUBLIC
  ${CMAKE_SOURCE_DIR}/Sources/Cxx)

add_executable(Cxx_Interop ./Sources/Cxx_Interop/main.swift)
target_compile_options(Cxx_Interop PRIVATE
  "SHELL:-Xfrontend -enable-cxx-interop"
target_link_libraries(Cxx_Interop PRIVATE cxx-support)

```

```
//In main.swift

import Foundation
import Cxx

public struct Cxx_Interop {
    public static func main() {
        let result = cxx_function(7)
        print(result)
    }
}

Cxx_Interop.main()

```

- In your projects direcetoy, run `cmake` to generate the the systems build files

- To generate an Xcode project run `cmake -GXcode` 
- To generate with Ninja run `cmake -GNinja`

- For more information on `cmake` see the  'GettingStarted' documentation: (https://github.com/apple/swift/blob/main/docs/HowToGuides/GettingStarted.md)

