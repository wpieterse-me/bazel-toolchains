load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "ACTION_NAMES",
)
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "tool",
)

def generate_action_configs(
        wrapper_path,
        assemble_features = [],
        preprocess_assemble_features = [],
        c_compile_features = [],
        cpp_compile_features = [],
        cpp_link_static_library_features = [],
        cpp_link_executable_features = [],
        strip_features = []):
    return [
        action_config(
            action_name = ACTION_NAMES.assemble,
            tools = [
                tool(
                    path = "{}/assemble.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = assemble_features,
        ),
        action_config(
            action_name = ACTION_NAMES.preprocess_assemble,
            tools = [
                tool(
                    path = "{}/preprocess_assemble.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = preprocess_assemble_features,
        ),
        action_config(
            action_name = ACTION_NAMES.c_compile,
            tools = [
                tool(
                    path = "{}/c_compile.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = [
                "compiler_dependency_file",
                "compiler_output",
                "compiler_input",
                "compiler_random_seed",
                "compiler_no_canonical_prefixes",
                "compiler_include_preprocessor",
                "compiler_include_general",
                "compiler_include_quote",
                "compiler_include_system",
                "compiler_defines",
                "compiler_user_flags",
            ] + c_compile_features,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_compile,
            tools = [
                tool(
                    path = "{}/cpp_compile.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = cpp_compile_features,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [
                tool(
                    path = "{}/cpp_link_static_library.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = [
                "archive_common_options",
                "archive_output",
                "archive_input",
            ] + cpp_link_static_library_features,
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [
                tool(
                    path = "{}/cpp_link_executable.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = [
                "linker_configuration_file",
                "linker_input",
                "linker_output",
                "linker_link_stamp",
                "linker_user_flags",
            ] + cpp_link_executable_features,
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [
                tool(
                    path = "{}/strip.sh".format(
                        wrapper_path,
                    ),
                ),
            ],
            implies = strip_features,
        ),
    ]
