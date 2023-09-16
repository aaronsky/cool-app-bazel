"""
wrapper macros to make writing rule targets for Apple things easier
"""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@build_bazel_rules_apple//apple:apple.bzl", "experimental_mixed_language_library")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

_CPP_FILE_TYPES = [".cc", ".cpp", ".mm", ".cxx", ".C"]

_NON_CPP_FILE_TYPES = [".m", ".c"]

_ASSEMBLY_FILE_TYPES = [".s", ".S", ".asm"]

_OBJECT_FILE_FILE_TYPES = [".o"]

_HEADERS_FILE_TYPES = [".h", ".hh", ".hpp", ".ipp", ".hxx", ".h++", ".inc", ".inl", ".tlh", ".tli", ".H", ".hmap"]

_OBJC_FILE_TYPES = _CPP_FILE_TYPES + \
                   _NON_CPP_FILE_TYPES + \
                   _ASSEMBLY_FILE_TYPES + \
                   _OBJECT_FILE_FILE_TYPES + \
                   _HEADERS_FILE_TYPES

_SWIFT_FILE_TYPES = [".swift"]

def dbx_apple_library(
        *,
        name,
        srcs,
        objc_copts = [],
        swift_copts = [],
        **kwargs):
    """
    Compiles and links Swift and/or Objective-C code into a static library.

    Args:
        name: A unique name for this target.
        srcs: The list of Swift and/or Objective-C source files to compile.
        objc_copts: Additional compiler options that should be passed to
            `clang`.
        swift_copts: Additional compiler options that should be passed to
            `swiftc`. These strings are subject to `$(location ...)` and "Make"
            variable expansion.
        **kwargs: Other arguments to pass through to the underlying library
            target.
    """
    if not srcs:
        fail("'srcs' must be non-empty")
    has_swift_srcs = False
    has_objc_srcs = False
    for x in srcs:
        _, extension = paths.split_extension(x)
        if extension in _SWIFT_FILE_TYPES:
            has_swift_srcs = True
        elif extension in _OBJC_FILE_TYPES:
            has_objc_srcs = True
        if has_swift_srcs and has_objc_srcs:
            break
    if has_swift_srcs and has_objc_srcs:
        experimental_mixed_language_library(
            name = name,
            objc_copts = objc_copts,
            srcs = srcs,
            swift_copts = swift_copts,
            **kwargs
        )
    elif has_swift_srcs:
        swift_library(
            name = name,
            copts = swift_copts + kwargs.pop("copts", []),
            srcs = srcs,
            **kwargs
        )
    elif has_objc_srcs:
        native.objc_library(
            name = name,
            copts = objc_copts + kwargs.pop("copts", []),
            srcs = srcs,
            **kwargs
        )
    else:
        fail("'srcs' must be contain either Swift or Objective-C source files")
