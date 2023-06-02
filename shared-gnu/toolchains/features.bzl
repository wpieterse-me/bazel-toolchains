load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "ACTION_NAMES",
)
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "variable_with_value",
)

_FEATURE_DISABLE_LEGACY = feature(
    name = "no_legacy_features",
    enabled = True,
)

_FEATURE_ARCHIVE_COMMON_OPTIONS = feature(
    name = "archive_common_options",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_static_library,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "rcsD",
                    ],
                ),
            ],
        ),
    ],
)

_FEATURE_ARCHIVE_OUTPUT = feature(
    name = "archive_output",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_static_library,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "%{output_execpath}",
                    ],
                    expand_if_available = "output_execpath",
                ),
            ],
        ),
    ],
)

_FEATURE_ARCHIVE_INPUT = feature(
    name = "archive_input",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_static_library,
            ],
            flag_groups = [
                flag_group(
                    iterate_over = "libraries_to_link",
                    flag_groups = [
                        flag_group(
                            flags = ["%{libraries_to_link.name}"],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "object_file",
                            ),
                        ),
                        flag_group(
                            flags = ["%{libraries_to_link.object_files}"],
                            iterate_over = "libraries_to_link.object_files",
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "object_file_group",
                            ),
                        ),
                    ],
                    expand_if_available = "libraries_to_link",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_INPUT = feature(
    name = "compiler_input",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-c",
                        "%{source_file}",
                    ],
                    expand_if_available = "source_file",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_OUTPUT = feature(
    name = "compiler_output",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-o",
                        "%{output_file}",
                    ],
                    expand_if_available = "output_file",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_DEPENDENCY_FILE = feature(
    name = "compiler_dependency_file",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-MD",
                        "-MF",
                        "%{dependency_file}",
                    ],
                    expand_if_available = "dependency_file",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_RANDOM_SEED = feature(
    name = "compiler_random_seed",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-frandom-seed=%{output_file}",
                    ],
                    expand_if_available = "output_file",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_NO_CANONICAL_PREFIXES = feature(
    name = "compiler_no_canonical_prefixes",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-no-canonical-prefixes",
                    ],
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_NO_CANONICAL_SYSTEM_HEADERS = feature(
    name = "compiler_no_canonical_system_headers",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-fno-canonical-system-headers",
                    ],
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_INCLUDE_PREPROCESSOR = feature(
    name = "compiler_include_preprocessor",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-include",
                        "%{includes}",
                    ],
                    iterate_over = "includes",
                    expand_if_available = "includes",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_INCLUDE_GENERAL = feature(
    name = "compiler_include_general",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-I%{include_paths}",
                    ],
                    iterate_over = "include_paths",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_INCLUDE_QUOTE = feature(
    name = "compiler_include_quote",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-iquote",
                        "%{quote_include_paths}",
                    ],
                    iterate_over = "quote_include_paths",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_INCLUDE_SYSTEM = feature(
    name = "compiler_include_system",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-isystem",
                        "%{system_include_paths}",
                    ],
                    iterate_over = "system_include_paths",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_DEFINES = feature(
    name = "compiler_defines",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-D%{preprocessor_defines}",
                    ],
                    iterate_over = "preprocessor_defines",
                ),
            ],
        ),
    ],
)

_FEATURE_COMPILER_USER_FLAGS = feature(
    name = "compiler_user_flags",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.c_compile,
            ],
            flag_groups = [
                flag_group(
                    flags = ["%{user_compile_flags}"],
                    iterate_over = "user_compile_flags",
                    expand_if_available = "user_compile_flags",
                ),
            ],
        ),
    ],
)

_FEATURE_LINKER_CONFIGURATION_FILE = feature(
    name = "linker_configuration_file",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_executable,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "@%{linker_param_file}",
                    ],
                    expand_if_available = "linker_param_file",
                ),
            ],
        ),
    ],
)

_FEATURE_LINKER_INPUT = feature(
    name = "linker_input",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_executable,
            ],
            flag_groups = [
                flag_group(
                    iterate_over = "libraries_to_link",
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-Wl,--start-lib",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "object_file_group",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "-Wl,-whole-archive",
                            ],
                            expand_if_true = "libraries_to_link.is_whole_archive",
                        ),
                        flag_group(
                            flags = [
                                "%{libraries_to_link.object_files}",
                            ],
                            iterate_over = "libraries_to_link.object_files",
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "object_file_group",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "%{libraries_to_link.name}",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "object_file",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "%{libraries_to_link.name}",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "interface_library",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "%{libraries_to_link.name}",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "static_library",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "-l%{libraries_to_link.name}",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "dynamic_library",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "-l:%{libraries_to_link.name}",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "versioned_dynamic_library",
                            ),
                        ),
                        flag_group(
                            flags = [
                                "-Wl,-no-whole-archive",
                            ],
                            expand_if_true = "libraries_to_link.is_whole_archive",
                        ),
                        flag_group(
                            flags = [
                                "-Wl,--end-lib",
                            ],
                            expand_if_equal = variable_with_value(
                                name = "libraries_to_link.type",
                                value = "object_file_group",
                            ),
                        ),
                    ],
                    expand_if_available = "libraries_to_link",
                ),
            ],
        ),
    ],
)

_FEATURE_LINKER_OUTPUT = feature(
    name = "linker_output",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_executable,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "-o",
                        "%{output_execpath}",
                    ],
                    expand_if_available = "output_execpath",
                ),
            ],
        ),
    ],
)

_FEATURE_LINKER_LINK_STAMP = feature(
    name = "linker_link_stamp",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_executable,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "%{linkstamp_paths}",
                    ],
                    iterate_over = "linkstamp_paths",
                    expand_if_available = "linkstamp_paths",
                ),
            ],
        ),
    ],
)

_FEATURE_LINKER_USER_FLAGS = feature(
    name = "linker_user_flags",
    flag_sets = [
        flag_set(
            actions = [
                ACTION_NAMES.cpp_link_executable,
            ],
            flag_groups = [
                flag_group(
                    flags = [
                        "%{user_link_flags}",
                    ],
                    iterate_over = "user_link_flags",
                    expand_if_available = "user_link_flags",
                ),
            ],
        ),
    ],
)

SPECIFIC_FEATURES = struct(
    disable_legacy = _FEATURE_DISABLE_LEGACY,
    archive_common_options = _FEATURE_ARCHIVE_COMMON_OPTIONS,
    archive_input = _FEATURE_ARCHIVE_INPUT,
    archive_output = _FEATURE_ARCHIVE_OUTPUT,
    compiler_input = _FEATURE_COMPILER_INPUT,
    compiler_output = _FEATURE_COMPILER_OUTPUT,
    compiler_dependency_file = _FEATURE_COMPILER_DEPENDENCY_FILE,
    compiler_random_seed = _FEATURE_COMPILER_RANDOM_SEED,
    compiler_no_canonical_prefixes = _FEATURE_COMPILER_NO_CANONICAL_PREFIXES,
    compiler_no_canonical_system_headers = _FEATURE_COMPILER_NO_CANONICAL_SYSTEM_HEADERS,
    compiler_include_preprocessor = _FEATURE_COMPILER_INCLUDE_PREPROCESSOR,
    compiler_include_general = _FEATURE_COMPILER_INCLUDE_GENERAL,
    compiler_include_quote = _FEATURE_COMPILER_INCLUDE_QUOTE,
    compiler_include_system = _FEATURE_COMPILER_INCLUDE_SYSTEM,
    compiler_defines = _FEATURE_COMPILER_DEFINES,
    compiler_user_flags = _FEATURE_COMPILER_USER_FLAGS,
    linker_configuration_file = _FEATURE_LINKER_CONFIGURATION_FILE,
    linker_input = _FEATURE_LINKER_INPUT,
    linker_output = _FEATURE_LINKER_OUTPUT,
    linker_link_stamp = _FEATURE_LINKER_LINK_STAMP,
    linker_user_flags = _FEATURE_LINKER_USER_FLAGS,
)

ALL_FEATURES = [
    SPECIFIC_FEATURES.disable_legacy,
    SPECIFIC_FEATURES.compiler_input,
    SPECIFIC_FEATURES.compiler_output,
    SPECIFIC_FEATURES.compiler_dependency_file,
    SPECIFIC_FEATURES.compiler_random_seed,
    SPECIFIC_FEATURES.compiler_no_canonical_prefixes,
    SPECIFIC_FEATURES.compiler_no_canonical_system_headers,
    SPECIFIC_FEATURES.compiler_include_preprocessor,
    SPECIFIC_FEATURES.compiler_include_general,
    SPECIFIC_FEATURES.compiler_include_quote,
    SPECIFIC_FEATURES.compiler_include_system,
    SPECIFIC_FEATURES.compiler_defines,
    SPECIFIC_FEATURES.compiler_user_flags,
    SPECIFIC_FEATURES.archive_common_options,
    SPECIFIC_FEATURES.archive_output,
    SPECIFIC_FEATURES.archive_input,
    SPECIFIC_FEATURES.linker_configuration_file,
    SPECIFIC_FEATURES.linker_input,
    SPECIFIC_FEATURES.linker_output,
    SPECIFIC_FEATURES.linker_link_stamp,
    SPECIFIC_FEATURES.linker_user_flags,
]
