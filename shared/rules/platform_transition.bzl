def _platform_transition_impl(settings, attr):
    _ignore = settings

    target_platform = "@{}//{}:{}".format(
        attr._target_platform.workspace_name,
        attr._target_platform.package,
        attr._target_platform.name,
    )

    return {
        "//command_line_option:platforms": target_platform,
    }

platform_transition = transition(
    implementation = _platform_transition_impl,
    inputs = [
    ],
    outputs = [
        "//command_line_option:platforms",
    ],
)
