def toolchain_deps():
    native.new_local_repository(
        name = "com_github_wpieterse-me_bazel-toolchain-gba-archive",
        path = "/opt/devkitpro",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-gba//toolchains:archive.BUILD",
    )

def toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-gba//toolchains:arm-none-eabi-gcc-toolchain",
    )
