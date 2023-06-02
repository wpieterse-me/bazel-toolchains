load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
    "feature",
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
    ] + _ALL_FEATURES

    action_configs = _generate_action_configs(
        wrapper_path = "wrappers/i586-pc-msdosdjgpp",
        c_compile_features = [
            "compiler_no_canonical_system_headers",
        ],
    )

    artifact_name_patterns = [
        artifact_name_pattern(
            category_name = "executable",
            prefix = "",
            extension = ".exe",
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        action_configs = action_configs,
        artifact_name_patterns = artifact_name_patterns,
        toolchain_identifier = "fill_me",
        target_system_name = "fill_me",
        target_cpu = "fill_me",
        target_libc = "fill_me",
        compiler = "fill_me",
    )

cc_toolchain_config = rule(
    implementation = _cc_toolchain_config_impl,
    attrs = {
    },
    provides = [
        CcToolchainConfigInfo,
    ],
)
