load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

def mingw_toolchain_deps():
    http_archive(
        name = "mingw_toolchain",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-windows//toolchains:mingw.BUILD",
        sha256 = "03292fcd66b9fdb94b390f48599ff2eb9c024d053573ba9088347a9c4e161ecd",
        urls = [
            "https://github.com/mstorsjo/llvm-mingw/releases/download/20230517/llvm-mingw-20230517-ucrt-ubuntu-20.04-x86_64.tar.xz",
        ],
        strip_prefix = "llvm-mingw-20230517-ucrt-ubuntu-20.04-x86_64",
    )

def mingw_toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-windows//toolchains:toolchain",
    )
