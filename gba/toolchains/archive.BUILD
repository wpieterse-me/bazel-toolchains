exports_files(
    [
        "devkitARM/bin/arm-none-eabi-objcopy",
        "tools/bin/gbafix",
    ],
)

filegroup(
    name = "com_github_wpieterse-me_bazel-toolchain-gba-archive",
    srcs = glob(
        include = [
            "devkitARM/**",
        ],
    ),
    visibility = [
        "//visibility:public",
    ],
)
