def mingw_toolchain_deps():
    native.new_local_repository(
        name = "mingw_toolchain",
        path = "/usr",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-windows//toolchain:mingw.BUILD",
    )

def mingw_toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-windows//toolchain",
    )
