load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "ACTION_NAMES",
)
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
)
load(
    "@com_github_wpieterse-me_bazel-toolchain-shared-gnu//toolchains:features.bzl",
    _ALL_FEATURES = "ALL_FEATURES",
)
load(
    "@com_github_wpieterse-me_bazel-toolchain-shared-gnu//toolchains:action_configs.bzl",
    _generate_action_configs = "generate_action_configs",
)

def _cc_toolchain_config_impl(ctx):
    features = [
        feature(
            name = "supports_pic",
            enabled = False,
        ),
        feature(
            name = "supports_dynamic_linker",
            enabled = False,
        ),
        feature(
            name = "supports_start_end_lib",
            enabled = False,
        ),
        feature(
            name = "opt",
        ),
        feature(
            name = "dbg",
        ),
        feature(
            name = "gba_compiler_specific",
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.c_compile,
                    ],
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-mthumb-interwork",
                                "-mthumb",
                                "-fno-strict-aliasing",
                            ],
                        ),
                    ],
                ),
            ],
        ),
        feature(
            name = "gba_linker_specific",
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.cpp_link_executable,
                    ],
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-specs=gba.specs",
                            ],
                        ),
                    ],
                ),
            ],
        ),
    ] + _ALL_FEATURES

    action_configs = _generate_action_configs(
        wrapper_path = ctx.attr.target,
        c_compile_features = [
            "compiler_no_canonical_system_headers",
            "gba_compiler_specific",
        ],
        cpp_link_executable_features = [
            "gba_linker_specific",
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        action_configs = action_configs,
        toolchain_identifier = "fill_me",
        target_system_name = "fill_me",
        target_cpu = "fill_me",
        target_libc = "fill_me",
        compiler = "fill_me",
    )

cc_toolchain_config = rule(
    implementation = _cc_toolchain_config_impl,
    attrs = {
        "target": attr.string(
            mandatory = True,
        ),
    },
    provides = [
        CcToolchainConfigInfo,
    ],
)
